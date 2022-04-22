# TODO: move this to the `pampa_deployer` repo.
module BlackStack
    module Deployer
      @@database_installation_files = []
      @@database_initialization_files = []
  
      # getter
      def self.database_installation_files
        @@database_installation_files
      end

      # getter
      def self.database_initialization_files
        @@database_initialization_files
      end

      # Return `true` if the name of the file matches with `/\.tsql\./`, and it doesn't match with `/\.sentences\./`, and the matches with `/\.tsql\./` are no more than one.
      # Othersie, return `false`.
      # This method should not be called directly by user code.
      def self.is_tsql_file?(filename)
        filename =~ /\.tsql\./ && filename !~ /\.sentences\./ && filename.scan(/\.tsql\./).size == 1
      end
  
      # Return `true` if the name of the file matches with `/\.sentences\./`, and it doesn't match with `/\.tsql\./`, and the matches with `/\.sentences\./` are no more than one.
      # Othersie, return `false`.
      # This method should not be called directly by user code.
      def self.is_sentences_file?(filename)
        filename =~ /\.sentences\./ && filename !~ /\.tsql\./ && filename.scan(/\.sentences\./).size == 1
      end
  
      # Extract the name of the file from the full path stored in the `filename` parameter.
      # Return `true` if the name of the file matches with `/^0\./`.
      # Othersie, return `false`.
      # This method should not be called directly by user code.
      def self.is_database_installation_file?(filename)
        # extract the name fo the file form the filename variable
        file_name = File.basename(filename)
        return true if file_name =~ /^0\./ 
        return false
      end
  
      # Extract the name of the file from the full path stored in the `filename` parameter.
      # Return `true` if the name of the file matches with `/^1\./`.
      # Othersie, return `false`.
      # This method should not be called directly by user code.
      def self.is_database_initialization_file?(filename)
        # extract the name fo the file form the filename variable
        file_name = File.basename(filename)
        return true if file_name =~ /^1\./ 
        return false
      end
  
      # Setup the configuration of the deployer.
      def self.set(h)
        errors = []
  
        # Validate: h[:database_installation_files] exists
        errors << "The parameter `database_installation_files` is mandatory." if h[:database_installation_files].nil?
  
        # Validate: h[:database_initialization_files] exists
        errors << "The parameter `database_initialization_files` is mandatory." if h[:database_initialization_files].nil?
  
        # Validate: h[:database_initialization_files] is an array
        errors << "The parameter `database_installation_files` must be an array." if h[:database_installation_files].class != Array
  
        # Validate: h[:database_initialization_files] is an array
        errors << "The parameter `database_initialization_files` must be an array." if h[:database_initialization_files].class != Array
  
        # Validate: By convention, filenames for installation must match with `/^0./`. Raise an exception if not. Call the method `is_database_installation_file?`.
        h[:database_installation_files].each { |i|
          errors << "The file #{i} is not a database installation file." unless is_database_installation_file?(i[:filename])
        }
  
        # Validate: By convention, filenames for initialization must match with `/^1./`. Raise an exception if not. Call the method `is_database_initialization_file?`.
        h[:database_initialization_files].each { |i|
          errors << "The file #{i} is not a database installation file." unless is_database_initialization_file?(i[:filename])
        }  
    
        # Raise an exception if there are errors.
        raise errors.join("\n") if errors.length > 0
  
        @@database_installation_files = h[:database_installation_files].class == Array ? h[:database_installation_files] : []
        @@database_initialization_files = h[:database_initialization_files].class == Array ? h[:database_initialization_files] : []
      end # def self.set(h)
  
      # Method to process an `.sql` file with transact-sql code, each one separated by a `GO` statement.
      # Reference: https://stackoverflow.com/questions/64066344/import-large-sql-files-with-ruby-sequel-gem
      # This method is called by `BlackStack::Deployer::db_execute_file` if the filename matches with `/\.tsql\./`. 
      # This method should not be called directly by user code.
      def self.db_execute_tsql_file(sql, tlogger=nil, db_name=nil, path=nil, size=nil)
        tlogger = BlackStack::DummyLogger.new(nil) if tlogger.nil?
  
        tlogger.logs 'Executing script (may take time)... '
        sql.split(/^GO$/i).each { |statement|
            #print '.'
            #statement.gsub!(/\n$/i, '')
            begin
                DB.execute(statement)
            rescue => e
              tlogger.logf 'error' 
              raise "Error executing statement: #{statement}\n#{e.message}"
            end
        }
        tlogger.done
      end # def db_execute_tsql
      
      # Method to process an `.sql` file with one sql sentence by line.
      # Reference: https://stackoverflow.com/questions/64066344/import-large-sql-files-with-ruby-sequel-gem
      # This method is called by `BlackStack::Deployer::db_execute_file` if the filename matches with `/\.sentences\./`. 
      # This method should not be called directly by user code.
      def self.db_execute_sql_sentences_file(sql, tlogger=nil, db_name=nil, path=nil, size=nil)      
        tlogger = BlackStack::DummyLogger.new(nil) if tlogger.nil?
              
        tlogger.logs 'Executing script (may take time)... '
        sql.split(/\n/i).each { |statement|
            #print '.'
            #statement.gsub!(/\n$/i, '')
            begin
                DB.execute(statement.to_s.strip) #if statement.to_s.strip.size > 0
            rescue => e
              tlogger.logf 'error' 
              raise "Error executing statement: #{statement}\n#{e.message}"
            end
        }
        tlogger.done
      end # def db_execute_sql_sentences_file
      
      # Load the content of a file into a variable `sql`.
      # Use UTF-8 encoding. Reference: https://www.honeybadger.io/blog/the-rubyist-guide-to-unicode-utf8/
      # Execute the script in the file, by calling either `db_execute_tsql_file` or `db_execute_sql_sentences_file`.
      def self.db_execute_file(filename, tlogger=nil, db_name=nil, path=nil, size=nil)
        errors = []
        tlogger = BlackStack::DummyLogger.new(nil) if tlogger.nil?
        
        tlogger.logs "Loading #{filename}... "
        encoding = 'UTF-8' # 'ISO-8859-1'
        sql = File.read(filename, :encoding => encoding).encode(encoding, invalid: :replace, undef: :replace, replace: '') #'UTF-8')
        tlogger.done
      
        # Validate: the `filename` must be either a `.tsql` file or a `.sentences` file.
        errors << "The file #{filename} is not a .tsql or .sentences file." unless is_tsql_file?(filename) || is_sentences_file?(filename)
  
        # Validate: if the `sql` code contains %database_name% wildcard, the `db_name` parameter must be defined.
        errors << "The parameter `db_name` is mandatory, because the `%database_name%` wildcard is present in the `#{filename}`." if sql.include?('%database_name%') && db_name.nil?
  
        # Validate: if the `sql` code contains %path% wildcard, the `path` parameter must be defined.
        errors << "The parameter `path` is mandatory, because the `%path%` wildcard is present in the `#{filename}`." if sql.include?('%path%') && path.nil?
  
        # Validate: if the `sql` code contains %size% wildcard, the `size` parameter must be defined.
        errors << "The parameter `size` is mandatory, because the `%size%` wildcard is present in the `#{filename}`." if sql.include?('%size%') && size.nil?
  
        # Raise an exception if there are errors.
        raise errors.join("\n") if errors.length > 0
  
        # Resolve the "string contains null byte" exception.
        # Reference: https://stackoverflow.com/questions/29320369/coping-with-string-contains-null-byte-sent-from-users
        sql.gsub!("\u0000", '')

        tlogger.logs 'Replacing wildcards... '
        sql.gsub!(/%database_name%/, db_name) unless db_name.nil?
        sql.gsub!(/%path%/, path) unless path.nil?
        sql.gsub!(/%size%/, size) unless size.nil?
        tlogger.done
  
        if is_tsql_file?(filename)
          db_execute_tsql_file(sql, tlogger, db_name, path, size) 
        elsif is_sentences_file?(filename)
          db_execute_sql_sentences_file(sql, tlogger, db_name, path, size) 
        end
      end # def db_execute_sql_sentences_file

      # Process all the file-descriptors in the array `filedescriptors`.
      # Call to `db_execute_file` for each file.
      # If a file processing fails and the `:critical` parameter is `false`, the exception is caught and the file is skipped.
      # If a file processing fails and the `:critical` parameter is `true`, the exception is raised.
      # This method is called by `BlackStack::Deployer::db_install` and `BlackStack::Deployer::db_initialize`.
      # This method should not be called directly by user code.
      def self.db_execute_files(filedescriptors, tlogger=nil, db_name=nil, path=nil, size=nil)
        tlogger = BlackStack::DummyLogger.new(nil) if tlogger.nil?

        filedescriptors.each { |h|
          begin
            tlogger.logs "Running file #{h[:filename]}... "
            BlackStack::Deployer::db_execute_file(h[:filename], tlogger, db_name, path, size)
            tlogger.done
          rescue => e
            if h[:critical]
              tlogger.logf "fatal error: #{e.to_console}"
              raise e
            else
              tlogger.logf "error: #{e.to_console}"
            end
          end
        }
      end

      # Process all the file-descriptors in the array `database_installation_files`.
      # Call to `db_execute_file` for each file.
      # If a file processing fails and the `:critical` parameter is `false`, the exception is caught and the file is skipped.
      # If a file processing fails and the `:critical` parameter is `true`, the exception is raised.
      def self.db_install(tlogger=nil, db_name=nil, path=nil, size=nil)
        errors = []

        # VALIDATE: the value `:filename` of every element passes the `is_database_installation_file?` method.
        @@database_installation_files.each { |h|
                errors << "#{h[:filename]} is not a valid name for a database installation file." unless self.is_database_installation_file?(h[:filename])
        }

        # raise if any error is found.
        raise errors.join("\n") if errors.length > 0

        # call the method `db_execute_file` for each file descriptor in the array `database_installation_files`
        BlackStack::Deployer::db_execute_files(@@database_installation_files, tlogger, db_name, path, size)
      end

      # Process all the file-descriptors in the array `database_initialization_files`.
      # Call to `db_execute_file` for each file.
      # If a file processing fails and the `:critical` parameter is `false`, the exception is caught and the file is skipped.
      # If a file processing fails and the `:critical` parameter is `true`, the exception is raised.
      def self.db_initialize(tlogger=nil, db_name=nil, path=nil, size=nil)
        errors = []

        # VALIDATE: the value `:filename` of every element passes the `is_database_initialization_file?` method.
        @@database_initialization_files.each { |h|
                errors << "#{h[:filename]} is not a valid name for a database initialization file." unless self.is_database_initialization_file?(h[:filename])
        }

        # raise if any error is found.
        raise errors.join("\n") if errors.length > 0

        # call the method `db_execute_file` for each file descriptor in the array `database_initialization_files`
        BlackStack::Deployer::db_execute_files(@@database_initialization_files, tlogger, db_name, path, size)
      end

      # Run a series of `.sql` files with updates to the database.
      # All files are considered as critical. If any file fails, the exception is raised.
      # 
      # **Parameters:**
      # 1. **path:** The location where find the `.sql` files to run. They will be executed one by one, in alphabetical order.
      # 2. **last_filename:** The name of the last file processed, so your process can resume from where it finished in the last job.
      #
      def self.db_update(tlogger=nil, db_name=nil, sql_path=nil, last_filename='1', path=nil, size=nil)
        # VALIDATE: `last_filename` must be higher than `'2'``.
        raise "The parameter `last_filename` must be higher than `'2'`." if last_filename.to_i < 2

        file_descriptors = []

        # get list of `.sql` files in the directory `sql_path`, with a name higher than `last_filename`, sorted by name.
        files = Dir.glob("#{sql_path}/*.sql").select { |filename| 
          filename > last_filename 
        }.sort { |filename| 
          filename 
        }.each { |filename|
          file_descriptors << {
            :filename => filename,
            :critical => true,
            :description => '',
          }
        }

        # call the method `db_execute_file` for each file descriptor in the array `database_initialization_files`
        BlackStack::Deployer::db_execute_files(file_descriptors, tlogger, db_name, path, size)
      end

    end # module Deployer
  end # module BlackStack
  
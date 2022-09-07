require 'blackstack-nodes'
require 'sequel'

module BlackStack
  # Deployer is a library that can be used to deploy a cluster of nodes.
  module Deployer
    @@logger = BlackStack::BaseLogger.new(nil)
    @@show_output = false
    @@nodes = []
    @@routines = []

    # set show_output
    def self.set_show_output(value)
      @@show_output = value
    end

    # set the logger
    def self.set_logger(i_logger)
      @@logger = i_logger
    end

    # get show_output
    def self.show_output
      @@show_output
    end

    # get the logger assigned to the module
    def self.logger
      @@logger
    end # def self.errors

    # get the array of nodes assigned to the module
    def self.nodes
      @@nodes
    end # def self.nodes

    # get the array of routines assigned to the module
    def self.routines
      @@routines
    end # def self.routines

    # inherit BlackStack::Infrastructure::NodeModule, including features of deployer.
    module NodeModule
      attr_accessor :deployment_routine, :parameters

      include BlackStack::Infrastructure::NodeModule

      def self.eth0_ip(insterface)
        ret = nil
        a = `ip addr show dev #{insterface}`.scan(/inet [0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}/)
        if a.size > 0
          ret = a.last.to_s.gsub(/inet /, '')           
        else
          raise "Cannot get ip address of the interface #{insterface}"
        end
        ret
      end

      # get the IP address for an interface using the ip addr command.
      # this is a helper method for installing cockroachdb nodes.
      def eth0_ip()
        ret = nil
        a = self.ssh.exec!("ip addr show dev #{parameters[:laninterface]}").scan(/inet [0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}/)
        if a.size > 0
          ret = a.last.to_s.gsub(/inet /, '')           
        else
          raise "Cannot get ip address of the interface #{parameters[:laninterface]}"
        end
        ret
      end

      def self.descriptor_errors(h)
        errors = BlackStack::Infrastructure::NodeModule.descriptor_errors(h)
 
        # validate: does not exist any other element in @@nodes with the same value for the parameter h[:name]
        errors << "The parameter h[:name] is not unique" if BlackStack::Deployer.nodes.select{|n| n.name == h[:name]}.length > 0 

        # validate: h[:deployment_routine] is not nil
        errors << "The parameter h[:deployment_routine] is required" if h[:deployment_routine].nil?

        # validate: h[:deployment_routine] is a string
        errors << "The parameter h[:deployment_routine] is not a string" unless h[:deployment_routine].is_a?(String)
        
        # return list of errors
        errors.uniq
      end

      def initialize(h, i_logger=nil)
        self.parameters = h
        errors = BlackStack::Deployer::NodeModule.descriptor_errors(h)
        raise "The node descriptor is not valid: #{errors.uniq.join(".\n")}" if errors.length > 0
        super(h, i_logger)
        self.deployment_routine = h[:deployment_routine]
      end # def self.create(h)

      def to_hash
        h = super
        h[:deployment_routine] = self.deployment_routine
        h
      end # def to_hash

      def deploy()
        BlackStack::Deployer::run_routine(self.name, self.deployment_routine);
      end
    end # module NodeModule

    # define attributes and methods of a deployer routine
    module RoutineModule
      attr_accessor :name, :commands

      def self.descriptor_errors(h)
        errors = []

        # validate: the parameter h is a hash
        errors << "The parameter h is not a hash" unless h.is_a?(Hash)
  
        # validate: the paramerer h has a key :name
        errors << "The parameter h does not have a key :name" unless h.has_key?(:name)
  
        # validate: the paramerer h has a key :command
        errors << "The parameter h does not have a key :commands" unless h.has_key?(:commands)
  
        # validate: the parameter h[:name] is a string or a symbol
        errors << "The parameter h[:name] is not a string" unless h[:name].is_a?(String)
  
        # validate: the parameter h[:name] is not 'reboot' because it is a reserved name
        errors << "The parameter h[:name] is a reserved name (#{h[:name].to_s})" if h[:name] == 'reboot'
  
        # validate: the parameter h[:commands] is required
        errors << "The parameter h[:commands] is required" if h[:commands].nil?

        # validate: the parametrer h[:commands] is an array
        errors << "The parameter h[:commands] is not an array" unless h[:commands].is_a?(Array)
  
        # validate: the parameter h[:commands] has at least one element
        errors << "The parameter h[:commands] does not have at least one element" unless h[:commands].size > 0
  
        # validate: each element of the array h[:commands] is a hash
        h[:commands].each do |c|
          errors += BlackStack::Deployer::CommandModule.descriptor_errors(c)
        end # h[:commands].each do |c|
    
        errors.uniq
      end # def self.descriptor_error(h)

      def initialize(h)
        errors = BlackStack::Deployer::RoutineModule.descriptor_errors(h)
        raise "The node descriptor is not valid: #{errors.uniq.join(".\n")}" if errors.length > 0
        self.name = h[:name]
        self.commands = []
        h[:commands].each do |c|
          self.commands << BlackStack::Deployer::Command.new(c)
        end
      end

      def to_hash
        h = {}
        h[:name] = self.name
        h[:commands] = []
        self.commands.each do |c|
          h[:commands] << c.to_hash
        end
        h
      end

      def run(node)
        ret = []
        self.commands.each do |c|
          #BlackStack::Deployer.logger.logs "Running command: #{c.command.to_s}... "
          h = c.run(node)
          ret << h

          #BlackStack::Deployer.logger.logs "Result: "
          #BlackStack::Deployer.logger.logf h.to_s

          if h[:errors].size == 0
            #BlackStack::Deployer.logger.done
          else
            #BlackStack::Deployer.logger.logf('error: ' + h.to_s)
            raise "Error running command:\n#{h[:errors].uniq.join("\n")}"
          end
        end
        ret
      end # def run(node)
    end # module RoutineModule

    # define attributes and methods of a routine's command
    module CommandModule
      attr_accessor :command, :matches, :nomatches, :sudo, :background

      def self.descriptor_errors(c)
        errors = []

        # validate: h is a hash
        errors << "The command descriptor is not a hash" unless c.is_a?(Hash)

        # validate: the hash c has a key :command
        errors << "The command descriptor does not have a key :command" unless c.has_key?(:command)

        # validate: the value of c[:command] is a string or symbol
        errors << "The value of c[:command] is not a string and is not a symbol" unless c[:command].is_a?(String) || c[:command].is_a?(Symbol)

        # validate: if the key :sudo exists, then its value is a boolean
        if c.has_key?(:sudo)
          errors << "The value of c[:sudo] is not a boolean" unless c[:sudo].is_a?(TrueClass) || c[:sudo].is_a?(FalseClass)
        end

        # if the parameter h[:name] is a symbol
        if c[:command].is_a?(Symbol)
          if c[:command] == :reboot
            # :reboot is a reserved word, so it is fine to call :reboot
          else
            # validate: existis a routine with a the value c[:command].to_s on its :name key
            errors << "The routine with the name #{c[:command].to_s} does not exist" unless BlackStack::Deployer::deployment_routines.select { |r| r.name == c[:command].to_s }.size > 0
          end
        else
          # validate: each line of the :command value must finish with ;
          #errors << "Each line in the :command value must finish with `;`.\nCommand: #{c[:command]}.\nRefer https://github.com/leandrosardi/blackstack-deployer#67-running-commands-in-background for more details." unless c[:command].strip.split("\n").select { |l| l.strip.strip[-1,1] != ';' }.size == 0
          c[:command].strip.split("\n").each { |l| 
            l.strip!
            if l.strip[-1,1] != ';'
              errors << "Each line in the :command value must finish with `;`.\nCommand: #{l}.\nRefer https://github.com/leandrosardi/blackstack-deployer#67-running-commands-in-background for more details."
            end
          }
        end

        # if c[:matches] exists
        if c.has_key?(:matches)
          # validate: the value of c[:matches] must by a regex or an array
          errors << "The value of the key :matches is not a regex nor an array" unless c[:matches].is_a?(Regexp) || c[:matches].is_a?(Array)
          # if c[:matches] is a array
          if c[:matches].is_a?(Array)
            # validate: each element in the the array c[:matches] is a regex
            c[:matches].each do |m|
              errors += BlackStack::Deployer::MatchModule.descriptor_errors(m)
            end # each
          end # if c[:matches].is_a?(Array)
        end # if :matches exists

        # if c[:nomatches] exists
        if c.has_key?(:nomatches)
          # validate: the value of c[:nomatches] must by a regex or an array
          errors << "The value of the key :nomatches is not a regex nor an array" unless c[:nomatches].is_a?(Regexp) || c[:nomatches].is_a?(Array)
          # if c[:nomatches] is a array
          if c[:nomatches].is_a?(Array)
            # validate: each element in the the array c[:nomatches] is a hash
            c[:nomatches].each do |m|
              errors += BlackStack::Deployer::NoMatchModule.descriptor_errors(m)
            end # each
          end # if c[:matches].is_a?(Array)
        end # if :matches exists

        # if c[:background] exists, it must be a boolean
        if c.has_key?(:background)
          errors << "The value of the key :background is not a boolean" unless c[:background].is_a?(TrueClass) || c[:background].is_a?(FalseClass)
        end

        # 
        errors.uniq
      end # def self.descriptor_error(h)

      def initialize(h)
        errors = BlackStack::Deployer::CommandModule.descriptor_errors(h)
        raise "The node descriptor is not valid: #{errors.uniq.join(".\n")}" if errors.length > 0
        self.command = h[:command]
        self.sudo = h[:sudo].nil? ? true : h[:sudo]
        self.matches = []
        self.nomatches = []
        if h.has_key?(:matches)
          if h[:matches].is_a?(Regexp)
            self.matches << BlackStack::Deployer::Match.new(h[:matches])
          else
            h[:matches].each do |m|
              self.matches << BlackStack::Deployer::Match.new(m)
            end
          end
        end
        if h.has_key?(:nomatches)
          if h[:nomatches].is_a?(Regexp)
            self.nomatches << BlackStack::Deployer::NoMatch.new(h[:nomatches])
          else
            h[:nomatches].each do |m|
              self.nomatches << BlackStack::Deployer::NoMatch.new(m)
            end
          end
        end
        if h.has_key?(:background)
          self.background = h[:background]
        else
          self.background = false
        end                                                                                                            
      end # def initialize(h)

      def to_hash
        h = {}
        h[:command] = self.command
        h[:sudo] = self.sudo
        h[:matches] = []
        h[:nomatches] = []
        self.matches.each do |m|
          h[:matches] << m.to_hash
        end
        self.nomatches.each do |m|
          h[:nomatches] << m.to_hash
        end
        h
      end # def to_hash

      # return the code to exectute the command, 
      # after applying modifications requested by 
      # some parameters like `:show_outut` or `:background`.
      def code(node)
          ret = self.command
#puts
#puts
#puts "self.command: #{self.command}"
          # replacing parameters
          ret.scan(/%[a-zA-Z0-9\_]+%/).each do |p|
            if p == '%eth0_ip%' # reserved parameter
              # TODO: move the method eth0_ip to the blackstack-nodes library
              ret.gsub!(p, node.eth0_ip) 
            elsif p == '%timestamp%' # reserved parameter
              # TODO: move this to a timestamp function on blackstack-core
              ret.gsub!(p, Time.now.to_s.gsub(/\D/, '')) 
            else
#puts
#puts
#puts "p: #{p}"
              if node.parameters.has_key?(p.gsub(/%/, '').to_sym)
                ret.gsub!(p, node.parameters[p.gsub(/%/, '').to_sym].to_s)
              else
                raise "The parameter #{p} does not exist in the node descriptor #{node.parameters.to_s}"
              end
#puts
#puts
#puts "ret: #{ret}"
            end
          end
          # if the command is configured to run in background, and the flag show_ouput is off, then modify the ret to run in background
          if self.background && !BlackStack::Deployer.show_output
            lines = ret.strip.lines
            total = lines.size
            i = 0
            lines.each { |l| 
              i += 1
              if i == total
                l.gsub!(/;$/, ' > /dev/null 2>&1 &')
              else
                l.gsub!(/;$/, ' > /dev/null 2>&1;')
              end
            }
            ret = lines.join("\n")
          end
          # apply modifications due the sudo flag
          # return the code
          ret = node.code(ret, self.sudo)
#puts
#puts
#puts 'lalala'
#puts ret
=begin
          if self.sudo
            if node.using_password?
              ret = "echo '#{node.ssh_password.gsub(/'/, "\\\\'")}' | sudo -S su root -c '#{ret}'"
            elsif node.using_private_key_file?
              ret = "sudo -S su root -c '#{ret}'"
            end
          end  
=end
          # return
          ret
        end

      def run(node)
        l = BlackStack::Deployer.logger
        errors = []
        output = nil
        s = self.code(node)

        # if self.command is a symbol
        if self.command.is_a?(Symbol)

          # if self.command is equel than :reboot
          if self.command == :reboot
            # call the node reboot method
            node.reboot
          else
            # look for a routine with this name
            r = BlackStack::Deployer.routines.select { |r| r.name == self.command.to_s }.first
            if !r.nil?
              r.run(node)
            else
              raise "The routine #{self.command.to_s} does not exist"
            end
          end

        # if self.command is a string
        elsif self.command.is_a?(String)

          # running the command
          l.logs "Show command output... " if BlackStack::Deployer.show_output
          l.log "\n\nCommand:\n--------\n\n#{s} " if BlackStack::Deployer.show_output
          output = node.ssh.exec!(s) 
          l.log "\n\nOutput:\n-------\n\n#{output}" if BlackStack::Deployer.show_output
          l.logf('done tracing.') if BlackStack::Deployer.show_output

          # validation: at least one of the matches should happen
          if self.matches.size > 0 && !self.background
            i = 0
            self.matches.each do |m|
              if m.validate(output).size == 0 # no errors 
                i += 1
              end
            end
            errors << "Command output doesn't match with any of the :matches" if i == 0
          end # if self.matches.size > 0 
          
          # validation: no one of the nomatches should happen
          self.nomatches.each do |m|
            errors += m.validate(output)
          end
        end # elsif code.is_a?(String)

        # return a hash descriptor of the command result 
        {
          :command => self.command,
          :code => s,
          :output => output,
          :errors => errors,
        }
      end # def run(node)
    end # module CommandModule

    # define attributes and methods of a command's match
    module MatchModule
      attr_accessor :match

      def self.descriptor_errors(m)
        errors = []
        # validate the match is a regular expresion
        errors << "The match is not a regex" unless m.is_a?(Regexp)
        # 
        errors.uniq
      end # def self.descriptor_error(h)

      def initialize(h)
        errors = BlackStack::Deployer::MatchModule.descriptor_errors(h)
        raise "The node descriptor is not valid: #{errors.uniq.join(".\n")}" if errors.length > 0
        self.match = h
      end

      def to_hash
        h = {}
        h[:match] = self.match
        h
      end

      def validate(output)
        errors = []
        errors << "The output of the command does not match the regular expression #{self.match.inspect}" unless output.match(self.match)
        errors
      end
    end # module MatchModule

    # define attributes and methods of a command's nomatch
    module NoMatchModule
      attr_accessor :nomatch, :error_description

      def self.descriptor_errors(m)
        errors = []
        # validate the nomatch is a regular expresion
        errors << "Each nomatch is not a regex nor a hash" unless m.is_a?(Hash) || m.is_a?(Regexp)
        # if m is a hash
        if m.is_a?(Hash)
          # validate: the hash m has a key :nomatch
          errors << "The hash descriptor of the nomatch does not have a key :nomatch" unless m.has_key?(:nomatch)
          # validate: the value of m[:nomatch] is a string
          errors << "The value of the key :nomatch is not a regex" unless m[:nomatch].is_a?(Regexp)
          # validate: the hash m has a key :error_description
          errors << "The hash descriptor of the nomatch does not have a key :error_description" unless m.has_key?(:error_description)
          # validate: the value of m[:error_description] is a string
          errors << "The value of the key :error_description is not a string" unless m[:error_description].is_a?(String)
        end # if m.is_a?(Hash)
        # 
        errors.uniq
      end # def self.descriptor_error(h)

      def initialize(h)
        errors = BlackStack::Deployer::NoMatchModule.descriptor_errors(h)
        raise "The node descriptor is not valid: #{errors.uniq.join(".\n")}" if errors.length > 0
        self.nomatch = h[:nomatch]
        self.error_description = h[:error_description]
      end

      def to_hash
        h = {}
        h[:nomatch] = self.nomatch
        h[:error_description] = self.error_description
        h
      end

      def validate(output)
        errors = []
        if !self.error_description.nil?
          errors << self.error_description if output.match(self.nomatch)
        else
          errors << "The output of the command matches the regular expression #{self.nomatch.inspect}" if output.match(self.nomatch)
        end
        errors
      end

    end # module NoMatchModule


    # TODO: declare these classes (stub and skeleton) using blackstack-rpc
    #
    # Stub Classes
    # These classes represents a node, without using connection to the database.
    # Use this class at the client side.
    class Node
      include BlackStack::Deployer::NodeModule
    end # class Node

    class Command
      include BlackStack::Deployer::CommandModule
    end # class Command

    class Routine
      include BlackStack::Deployer::RoutineModule
    end # class Routine

    class Match
      include BlackStack::Deployer::MatchModule
    end # class Match

    class NoMatch
      include BlackStack::Deployer::NoMatchModule
    end # class NoMatch
  
    # add a node to the list of nodes.
    def self.add_node(h)
      errors = BlackStack::Deployer::NodeModule.descriptor_errors(h)
      raise errors.join(".\n") unless errors.empty?
      @@nodes << BlackStack::Deployer::Node.new(h, @@logger)
    end # def

    # add an array of nodes to the list of nodes.
    def self.add_nodes(a)
      # validate: the parameter a is an array
      raise "The parameter a is not an array" unless a.is_a?(Array)
      a.each { |h| BlackStack::Deployer.add_node(h) }
    end # def

    # remove all exisiting nodes in he list of nodes.
    # then, add the nodes in the parameter a to the list of nodes.
    def self.set_nodes(a)
      @@nodes.clear
      BlackStack::Deployer.add_nodes(a)
    end # def

    # add a routine to the list of routines.
    def self.add_routine(h)
      errors = BlackStack::Deployer::RoutineModule.descriptor_errors(h)
      raise errors.join(".\n") unless errors.empty?
      @@routines << BlackStack::Deployer::Routine.new(h)
    end # def

    # add an array of routines to the list of routines.
    def self.add_routines(a)
      # validate: the parameter a is an array
      raise "The parameter a is not an array" unless a.is_a?(Array)
      a.each { |h| BlackStack::Deployer.add_routine(h) }
    end # def

    # remove all exisiting routines in he list of routines.
    # then, add the routines in the parameter a to the list of routines.
    def self.set_routines(a)
      @@routines.clear
      BlackStack::Deployer.add_routines(a)
    end # def
      
    # running a routine on a node
    def self.run_routine(node_name, routine_name)
      errors = []

      # find the node with the value node_name in the key :name
      n = @@nodes.select { |n| n.name == node_name }.first

      # find the routine with the value routine_name in the key :name
      r = @@routines.select { |r| r.name == routine_name }.first

      # validate: the node n exists
      errors << "Node #{node_name} not found" unless n

      # validate: the routine r exists
      errors << "Routine #{routine_name} not found" unless r

      # raise exception if any error has been found
      raise "The routine #{routine_name} cannot be run on the node #{node_name}: #{errors.uniq.join(".\n")}" if errors.length > 0
        
      # connect the node
      #self.logger.logs "Connecting to node #{n.name}... "
      n.connect
      #self.logger.done

      # run the routine
      #self.logger.logs "Running routine #{r.name}... "
      r.run(n)
      #self.logger.done
        
      # disconnect the node
      #self.logger.logs "Disconnecting from node #{n.name}... "
      n.disconnect
      #self.logger.done
        
    end # def
      
    module DB
      LOCKFILE = './blackstack-deployer.lock'
      @@checkpoint = nil
      @@superhuser = nil
      @@ndb = nil
      @@folder = nil

      def self.set_checkpoint(s)
        @@checkpoint = s
      end

      def self.checkpoint
        @@checkpoint
      end

      def self.save_checkpoint(lockfilename=BlackStack::Deployer::DB::LOCKFILE)
        File.new(lockfilename, "w").write(@@checkpoint)
      end

      def self.load_checkpoint(lockfilename=BlackStack::Deployer::DB::LOCKFILE)
        if File.exists?(lockfilename)
          @@checkpoint = File.new(lockfilename, "r").read
        else
          @@checkpoint = nil
        end
        @@checkpoint
      end

      def self.connect(s)
        @@db = Sequel::connect(s)
      end # def
    
      def self.set_folder(s)
        @@folder = s
      end # def


      # Return `true` if the name of the file matches with `/\.transactions\./`, and it doesn't match with `/\.sentences\./`, and the matches with `/\.transactions\./` are no more than one.
      # Otherwise, return `false`.
      # This method should not be called directly by user code.
      def self.is_transactions_file?(filename)
        filename =~ /\.transactions\./ && filename !~ /\.sentences\./ && filename.scan(/\.transactions\./).size == 1
      end
  
      # Return `true` if the name of the file matches with `/\.sentences\./`, and it doesn't match with `/\.transactions\./`, and the matches with `/\.sentences\./` are no more than one.
      # Otherwise({, return `false`.
      # This method should not be called directly by user code.
      def self.is_sentences_file?(filename)
        filename =~ /\.sentences\./ && filename !~ /\.transactions\./ && filename.scan(/\.sentences\./).size == 1
      end

      # Method to process an `.sql` file with transactions code, separated by `BEGIN;` and `COMMIT;` statements.
      # Reference: https://stackoverflow.com/questions/64066344/import-large-sql-files-with-ruby-sequel-gem
      # This method is called by `BlackStack::Deployer::db_execute_file` if the filename matches with `/\.tsql\./`. 
      # This method should not be called directly by user code.
      def self.execute_transactions(sql)  
        # TODO: Code Me!
      end # def db_execute_tsql
      
      # Method to process an `.sql` file with one sql sentence by line.
      # Reference: https://stackoverflow.com/questions/64066344/import-large-sql-files-with-ruby-sequel-gem
      # This method is called by `BlackStack::Deployer::db_execute_file` if the filename matches with `/\.sentences\./`. 
      # This method should not be called directly by user code.
      def self.execute_sentences(sql, chunk_size=200)      
        tlogger = BlackStack::Deployer::logger

        # Fix issue: Ruby `split': invalid byte sequence in UTF-8 (ArgumentError)
        # Reference: https://stackoverflow.com/questions/11065962/ruby-split-invalid-byte-sequence-in-utf-8-argumenterror
        #
        # Fix issue: `PG::SyntaxError: ERROR:  at or near "��truncate": syntax error`
        #
        sql.encode!('UTF-8', :invalid => :replace, :replace => '')

        # Remove null bytes to avoid error: `String contains null byte`
        # Reference: https://stackoverflow.com/questions/29320369/coping-with-string-contains-null-byte-sent-from-users
        sql.gsub!("\u0000", "")

        # Get the array of sentences
        tlogger.logs "Splitting the sql sentences... "
        sentences = sql.split(/;/i) 
        tlogger.logf "done (#{sentences.size})"

        # Chunk the array into parts of chunk_size elements
        # Reference: https://stackoverflow.com/questions/2699584/how-to-split-chunk-a-ruby-array-into-parts-of-x-elements
        tlogger.logs "Bunlding the array of sentences into chunks of #{chunk_size} each... "
        chunks = sentences.each_slice(chunk_size).to_a
        tlogger.logf "done (#{chunks.size})"

        chunk_number = -1
        chunks.each { |chunk|
          chunk_number += 1
          statement = chunk.join(";\n").to_s.strip
          tlogger.logs "lines #{chunk_size*chunk_number+1} to #{chunk_size*chunk_number+chunk.size} of #{sentences.size}... "
          begin
            @@db.execute(statement) #if statement.to_s.strip.size > 0
            tlogger.done
          rescue => e
            tlogger.logf e.to_s 
            raise "Error executing statement: #{statement}\n#{e.message}"
          end
        }
        tlogger.done
      end # def db_execute_sql_sentences_file

      # Run a series of `.sql` files with updates to the database.
      #
      def self.deploy(save_checkpoints=false, lockfilename=BlackStack::Deployer::DB::LOCKFILE)
        tlogger = BlackStack::Deployer::logger
        # get list of `.sql` files in the directory `sql_path`, with a name higher than `last_filename`, sorted by name.
        Dir.entries(@@folder).select { 
          |filename| filename =~ /\.sql$/ && filename > @@checkpoint.to_s
        }.uniq.sort.each { |filename|
          fullfilename = "#{@@folder}/#{filename}"

          tlogger.logs "#{fullfilename}... "
          BlackStack::Deployer::DB::execute_sentences( File.open(fullfilename).read )
          tlogger.done

          tlogger.logs "Updating checkpoint... "
          BlackStack::Deployer::DB::set_checkpoint filename
          tlogger.done

          tlogger.logs 'Saving checkpoint... '
          if save_checkpoints
            BlackStack::Deployer::DB::save_checkpoint(lockfilename)
            tlogger.done
          else
            tlogger.logf 'disabled'
          end
        }
      end # def
    end # module DB

    # deploying all db-updates and run all routines on all nodes
    def self.deploy()
      tlogger = BlackStack::Deployer::logger

      @@nodes.each { |n|
        tlogger.logs "Node #{n.name}... "
        n.deploy()
        tlogger.done
      }
    end # def

  end # module Deployer

end # module BlackStack
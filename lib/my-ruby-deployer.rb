require 'blackstack-nodes'
require 'pg'
require 'sequel'
require 'colorize'
require 'simple_cloud_logging'

module BlackStack
  # Deployer is a library that can be used to deploy a cluster of nodes.
  module Deployer
    @@nodes = []
    @@routines = []

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

      include Infrastructure::NodeModule

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
        # This value is no longer mandatory
        #errors << "The parameter h[:deployment_routine] is not a string" unless h[:deployment_routine].is_a?(String)
        
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

      def deploy(routine_name=nil, l=nil)
        l = BlackStack::DummyLogger.new(nil) if l.nil?
        s = routine_name || self.deployment_routine
        BlackStack::Deployer::run_routine(self.name, s, l);
      end

      # stop all the processes who run in this node
      def stop(output_file='~/deployment.log')
        s = '
          echo "" >>'+output_file+' 2>&1
          echo "-------------------------------------------------------------------------" >>'+output_file+' 2>&1
          echo "Stopping at: `date`" >>'+output_file+' 2>&1

          # Activate RVM
          echo ""
          echo "Killing processes '+self.parameters[:code_folder]+'..." >>'+output_file+' 2>&1      
          ps ax | grep "'+self.parameters[:code_folder]+'" | grep -v postgres | grep -v grep | cut -b1-7 | xargs -t kill -9 >>'+output_file+' 2>&1
        '
        self.ssh.exec!(s)
      end

      # execute all the processes who run in this node
      def start(output_file='~/deployment.log')
        s = '
          echo "" >>'+output_file+' 2>&1
          echo "-------------------------------------------------------------------------" >>'+output_file+' 2>&1
          echo "Starting at: `date`" >>'+output_file+' 2>&1

          # Activate RVM
          echo ""
          echo "Activating RVM..." >>'+output_file+' 2>&1      
          source /etc/profile.d/rvm.sh >>'+output_file+' 2>&1
    
          # Activate Ruby 3.1.2
          echo ""
          echo "Activate Ruby 3.1.2..." >>'+output_file+' 2>&1       
          rvm --default use 3.1.2 >>'+output_file+' 2>&1
          
          # Set RUBYLIB
          echo ""
          echo "Set RUBYLIB..." >>'+output_file+' 2>&1     
          export RUBYLIB='+self.parameters[:rubylib]+' >>'+output_file+' 2>&1
          
          # Change directory to RUBYLIB
          echo ""
          echo "Change directory to RUBYLIB..." >>'+output_file+' 2>&1      
          cd $RUBYLIB >>'+output_file+' 2>&1'

        self.parameters[:processes].each { |p|
          s += '
          # Change directory to RUBYLIB
          echo ""
          echo "Run '+p+'..." >>'+output_file+' 2>&1       
          ruby $RUBYLIB/'+p+' 2>>'+output_file+' 1>>/dev/null &
        '
        }
        
        self.ssh.exec!(s)
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
          self.commands <<  Deployer::Command.new(c)
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

      def run(node, l=nil, params={})
        l = BlackStack::DummyLogger.new(nil) if l.nil?
        l.logs "Running routine #{self.name.blue} on node #{node.name.blue}... "
        i = 0
        self.commands.each do |c|
          i += 1
          l.logs "Command #{i.to_s.blue}... "
          c.run(node, l, params)
          l.logf 'done'.green
        end
        l.logf 'done'.green
      end # def run(node)
    end # module RoutineModule

    # define attributes and methods of a routine's command
    module CommandModule
      attr_accessor :command

      def self.descriptor_errors(c)
        errors = []

        # validate: h is a hash
        errors << "The command descriptor is not a hash" unless c.is_a?(Hash)

        # validate: the hash c has a key :command
        errors << "The command descriptor does not have a key :command" unless c.has_key?(:command)

        # validate: the value of c[:command] is a string or symbol
        errors << "The value of c[:command] is not a string and is not a symbol" unless c[:command].is_a?(String) || c[:command].is_a?(Symbol)

        # if the parameter h[:name] is a symbol
        if c[:command].is_a?(Symbol)
          if c[:command] == :reboot
            # :reboot is a reserved word, so it is fine to call :reboot
          else
            # validate: existis a routine with a the value c[:command].to_s on its :name key
            errors << "The routine with the name #{c[:command].to_s} does not exist" unless BlackStack::Deployer::routines.select { |r| r.name == c[:command].to_s }.size > 0
          end
        else
          c[:command].strip.split("\n").each { |l| 
            l.strip!
          }
        end

        # 
        errors.uniq
      end # def self.descriptor_error(h)

      def initialize(h)
        errors = BlackStack::Deployer::CommandModule.descriptor_errors(h)
        raise "The node descriptor is not valid: #{errors.uniq.join(".\n")}" if errors.length > 0
        self.command = h[:command]
      end # def initialize(h)

      def to_hash
        h = {}
        h[:command] = self.command
        h
      end # def to_hash

      # running pre-defined commands: :root
      # calling to other routines: :'change-name'
      # calling 
      def run(n, l=nil, params={})
        l = BlackStack::DummyLogger.new(nil) if l.nil?

        # if self.command is a symbol
        if self.command.is_a?(Symbol)

          # if self.command is equel than :reboot
          if self.command == :reboot
            # call the n reboot method
            n.reboot
          else
            # look for a routine with this name
            r = BlackStack::Deployer.routines.select { |r| r.name == self.command.to_s }.first
            if !r.nil?
              r.run(n, l, params)
            else
              raise "The routine #{self.command.to_s} does not exist"
            end
          end

        # if self.command is a string
        elsif self.command.is_a?(String)      
          s = self.command.dup
      
          #l.logs "Replacing merge-tags... "
          s.scan(/%[a-zA-Z0-9\_]+%/).uniq.each do |p|
            #l.logs "Replacing #{p.blue}... "
            if p == '%timestamp%' # reserved parameter
              # TODO: move this to a timestamp function on blackstack-core
              s.gsub!(p, Time.now.to_s.gsub(/\D/, '')) 
            else
              # replace node parameters
              if n.parameters.has_key?(p.gsub(/%/, '').to_sym)
                s.gsub!(p, n.parameters[p.gsub(/%/, '').to_sym].to_s)
              # replace routine-call parameters
              elsif params.has_key?(p.gsub(/%/, '').to_sym)
                s.gsub!(p, params[p.gsub(/%/, '').to_sym].to_s)
              else
                raise "The parameter #{p} does not exist in the node descriptor #{n.parameters.to_s}"
              end
            end
            #l.logf 'done'.green
          end      
          #l.logf 'done'.green
      
          l.logs "Running command... "
          n.ssh.exec!(s)
          l.logf 'done'.green
        end # elsif code.is_a?(String)
      end # def run(n)
    end # module CommandModule

    # TODO: declare these classes (stub and skeleton) using blackstack-rpc
    #
    # Stub Classes
    # These classes represents a node, without using connection to the database.
    # Use this class at the client side.
    class Node
      include Deployer::NodeModule
    end # class Node

    class Command
      include Deployer::CommandModule
    end # class Command

    class Routine
      include Deployer::RoutineModule
    end # class Routine
  
    # add a node to the list of nodes.
    def self.add_node(h)
      errors = BlackStack::Deployer::NodeModule.descriptor_errors(h)
      raise errors.join(".\n") unless errors.empty?
      @@nodes <<  Deployer::Node.new(h)
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
      @@routines <<  Deployer::Routine.new(h)
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
    def self.run_routine(node_name, routine_name, l=nil, params={})
      l = BlackStack::DummyLogger.new(nil) if l.nil?
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
      l.logs "Connecting to node #{n.name}... "
      n.connect
      l.done

      # run the routine
      l.logs "Running routine #{r.name}... "
      r.run(n, l, params)
      l.done

      # disconnect the node
      l.logs "Disconnecting from node #{n.name}... "
      n.disconnect
      l.done        
    end # def self.run_routine

    module DB
      LOCKFILE = './my-ruby-deployer.lock'
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
      def self.execute_sentences(sql, chunk_size=200, l=nil)      
        l = BlackStack::DummyLogger.new(nil) if l.nil?
        
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
        l.logs "Splitting the sql sentences... "
        sentences = sql.split(/;/i) 
        l.logf "done (#{sentences.size})"

        # Chunk the array into parts of chunk_size elements
        # Reference: https://stackoverflow.com/questions/2699584/how-to-split-chunk-a-ruby-array-into-parts-of-x-elements
        l.logs "Bunlding the array of sentences into chunks of #{chunk_size} each... "
        chunks = sentences.each_slice(chunk_size).to_a
        l.logf "done (#{chunks.size})"

        chunk_number = -1
        chunks.each { |chunk|
          chunk_number += 1
          statement = chunk.join(";\n").to_s.strip
          l.logs "lines #{chunk_size*chunk_number+1} to #{chunk_size*chunk_number+chunk.size} of #{sentences.size}... "
          begin
            @@db.execute(statement) #if statement.to_s.strip.size > 0
            l.done
          rescue => e
            l.logf e.to_s 
            raise "Error executing statement: #{statement}\n#{e.message}"
          end
        }
        l.done
      end # def db_execute_sql_sentences_file

      # Run a series of `.sql` files with updates to the database.
      #
      def self.deploy(save_checkpoints=false, lockfilename=BlackStack::Deployer::DB::LOCKFILE, l=nil)
        l = BlackStack::DummyLogger.new(nil) if l.nil?
        # get list of `.sql` files in the directory `sql_path`, with a name higher than `last_filename`, sorted by name.

        Dir.entries(@@folder).select { 
          |filename| filename =~ /\.sql$/ && filename > @@checkpoint.to_s
        }.uniq.sort.each { |filename|
          fullfilename = "#{@@folder}/#{filename}"

          l.logs "#{fullfilename}... "
          BlackStack::Deployer::DB::execute_sentences( File.open(fullfilename).read )
          l.done

          l.logs "Updating checkpoint... "
          BlackStack::Deployer::DB::set_checkpoint filename
          l.done

          l.logs 'Saving checkpoint... '
          if save_checkpoints
            BlackStack::Deployer::DB::save_checkpoint(lockfilename)
            l.done
          else
            l.logf 'disabled'
          end
        }
      end # def
    end # module DB

    # deploying all db-updates and run all routines on all nodes
    def self.deploy(routine_name=nil, l=nil)
      l = BlackStack::DummyLogger.new(nil) if l.nil?

      @@nodes.each { |n|
        l.logs "Node #{n.name}... "
        n.deploy(routine_name, l)
        l.done
      }
    end # def

  end # module Deployer

end # module BlackStack
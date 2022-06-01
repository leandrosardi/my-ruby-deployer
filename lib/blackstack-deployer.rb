require 'blackstack-nodes'

module BlackStack
  # Deployer is a library that can be used to deploy a cluster of nodes.
  module Deployer
    @@logger = BlackStack::BaseLogger.new(nil)
    @@nodes = []
    @@routines = []

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

      # get the IP address for an interface using the ip addr command.
      # this is a helper method for installing cockroachdb nodes.
      def eth0_ip(interface='eth0')
        a = self.ssh.exec!('ip addr show dev eth0').scan(/inet [0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}/)
        return nil if a.size == 0
        return a.last.to_s.gsub(/inet /, '')
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
          BlackStack::Deployer.logger.logs "Running command: #{c.command.to_s}... "
          h = c.run(node)
          ret << h

          BlackStack::Deployer.logger.logs "Result: "
          BlackStack::Deployer.logger.logf h.to_s

          if h[:errors].size == 0
            BlackStack::Deployer.logger.done
          else
            BlackStack::Deployer.logger.logf('error: ' + h.to_s)
            raise "Error running command: #{h.to_s}"
          end
        end
        ret
      end # def run(node)
    end # module RoutineModule

    # define attributes and methods of a routine's command
    module CommandModule
      attr_accessor :command, :matches, :nomatches, :sudo

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
            errors << "The routine with the name #{c[:command].to_s} does not exist" unless BlackStack::Deployer::routines.select { |r| r.name == c[:command].to_s }.size > 0
          end
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

      def run(node)
        errors = []
        code = self.command
        output = nil

        # if code is a symbol
        if code.is_a?(Symbol)

          # if code is equel than :reboot
          if code == :reboot
            # call the node reboot method
            node.reboot
          else
            # look for a routine with this name
            r = BlackStack::Deployer.routines.select { |r| r.name == code.to_s }.first
            if !r.nil?
              r.run(node)
            else
              raise "The routine #{code.to_s} does not exist"
            end
          end

        # if code is a string
        elsif code.is_a?(String)
          # replacing parameters
          code.scan(/%[a-zA-Z0-9\_]+%/).each do |p|
            if p == '%eth0_ip%' # reserved parameter
              # TODO: move the method eth0_ip to the blackstack-nodes library
              code.gsub!(p, node.eth0_ip) 
            elsif p == '%timestamp%' # reserved parameter
              # TODO: move this to a timestamp function on blackstack-core
              code.gsub!(p, Time.now.to_s.gsub(/\D/, '')) 
            else
              if node.parameters.has_key?(p.gsub(/%/, '').to_sym)
                code.gsub!(p, node.parameters[p.gsub(/%/, '').to_sym].to_s)
              else
                raise "The parameter #{p} does not exist in the node descriptor #{node.parameters.to_s}"
              end
            end
          end

          # running the command
          if self.sudo
            # escale the single quotes in the code variable
            code.gsub!(/'/, "\\\\'")

            if node.ssh_private_key_file.nil?
              code = "echo '#{node.ssh_password.to_s.gsub("'", "\\\\'")}' | sudo -S su root -c '#{code.to_s}'"
            else
              code = "sudo -S su root -c '#{code.to_s}'"
            end
          else
            code = code.to_s
          end
#puts
#puts code
#exit(0)
          output = node.ssh.exec!(code)

          # validation: at least one of the matches should happen
          if self.matches.size > 0
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
          :code => code,
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
      self.logger.logs "Connecting to node #{n.name}... "
      n.connect
      self.logger.done

      # run the routine
      self.logger.logs "Running routine #{r.name}... "
      r.run(n)
      self.logger.done
        
      # disconnect the node
      self.logger.logs "Disconnecting from node #{n.name}... "
      n.disconnect
      self.logger.done
        
    end # def
      
    module DB
      @@remember_checkpoint = false
      @@superhuser = nil
      @@new_db = nil
      @@folder = nil

      def self.enable_checkpoints(b)
      end
    
      def self.connect_db(s)
      end # def
    
      def self.set_folder(s)
      end # def
    
      def self.deploy(last_filename_processed=nil)
      end # def
    end # module DB

    # deploying all db-updates and run all routines on all nodes
    def self.deploy()
      # TODO: Code Me!
    end # def

  end # module Deployer

end # module BlackStack
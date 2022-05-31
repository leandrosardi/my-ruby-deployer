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
      attr_accessor :deployment_routine

      include BlackStack::Infrastructure::NodeModule

      def self.descriptor_errors(h)
        errors = BlackStack::Infrastructure::NodeModule.descriptor_errors(h)
 
        # validate: does not exist any other element in @@nodes with the same value for the parameter h[:name]
        errors << "The parameter h[:name] is not unique" if BlackStack::Deployer.nodes.select{|n| n[:name] == h[:name]}.length > 0 

        # validate: h[:deployment_routine] is not nil
        errors << "The parameter h[:deployment_routine] is required" if h[:deployment_routine].nil?

        # validate: h[:deployment_routine] is a string
        errors << "The parameter h[:deployment_routine] is not a string" unless h[:deployment_routine].is_a?(String)
        
        # return list of errors
        errors.uniq
      end

      def initialize(h)
        super(h)
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
    end # module RoutineModule

    # define attributes and methods of a routine's command
    module CommandModule
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
          # validate: existis a routine with a the value c[:command].to_s on its :name key
          errors << "The routine with the name #{c[:command].to_s} does not exist" unless BlackStack::Deployer::Routines.select { |r| r[:name] == c[:command].to_s }.size > 0
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
    end # module CommandModule

    # define attributes and methods of a command's match
    module MatchModule
      def self.descriptor_errors(m)
        errors = []
        # validate the match is a regular expresion
        errors << "The match is not a regex" unless m.is_a?(Regexp)
        # 
        errors.uniq
      end # def self.descriptor_error(h)
    end # module MatchModule

    # define attributes and methods of a command's nomatch
    module NoMatchModule
      def self.descriptor_errors(h)
        errors = []
        # validate the nomatch is a regular expresion
        errors << "Each nomatch is not a regex nor a hash" unless m.is_a?(Hash) || m.is_a?(Regexp)
        # if m is a hash
        if m.is_a?(Hash)
          # validate: the hash m has a key :nomatch
          errors << "The hash descriptor of the nomatch does not have a key :nomatch" unless m.has_key?(:nomatch)
          # validate: the value of m[:nomatch] is a string
          errors << "The value of the key :nomatch is not a string" unless m[:nomatch].is_a?(String)
          # validate: the hash m has a key :error_description
          errors << "The hash descriptor of the nomatch does not have a key :error_description" unless m.has_key?(:error_description)
          # validate: the value of m[:error_description] is a string
          errors << "The value of the key :error_description is not a string" unless m[:error_description].is_a?(String)
        end # if m.is_a?(Hash)
        # 
        errors.uniq
      end # def self.descriptor_error(h)
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
      @@nodes << BlackStack::Deployer::Node.new(h)
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
      @@routines << h
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
    def self.run(node_name, routine_name)
      errors = []

      # find the node with the value node_name in the key :name
      n = @@nodes.select { |n| n[:name] == node_name }.first

      # find the routine with the value routine_name in the key :name
      r = @@routines.select { |r| r[:name] == routine_name }.first

      # validate: the node n exists
      errors << "The node with the name #{node_name} does not exist" unless n

      # validate: the routine r exists
      errors << "The routine with the name #{routine_name} does not exist" unless r

      # raise exception if any error has been found
      raise "The routine #{routine_name} cannot be run on the node #{node_name}: #{errors.uniq.join(".\n")}" if errors.length > 0
        
      # getting a node object
      o = BlackStack::Infrastructure::Node.new(
        :net_remote_ip => n[:net_remote_ip],  
        :ssh_username => n[:ssh_username],
        :ssh_port => n[:ssh_port],
        :ssh_password => n[:ssh_password],
        :ssh_private_key_file => n[:ssh_private_key_file],
      )

      # connect the node
      o.connect
        
      # run the routine
      r[:commands].each do |c|
        self.logger.logs "Running command #{c[:command]} on the node #{node_name}... "
        self.exec(c[:command])
        self.logger.logf "Done.\nOutput:#{s}"
      end 
        
      # disconnect the node
      o.disconnect
        
    end # def
      
=begin
    module DB
      @@remember_checkpoint = false
      @@superhuser = nil
      @@new_db = nil
      @@folder = nil

      def self.enable_checkpoints(b)
      end

      def self.set_superuser(h)
      end # def
    
      def self.set_new_db(h)
      end # def
    
      def self.create
      end # def
    
      def self.connect_new_db(s)
      end # def
    
      def self.set_folder(s)
      end # def
    
      def self.deploy(last_filename_processed=nil)
      end # def
    end # module DB
=end

    # deploying all db-updates and run all routines on all nodes
    def self.deploy()
      # TODO: Code Me!
    end # def

  end # module Deployer

end # module BlackStack
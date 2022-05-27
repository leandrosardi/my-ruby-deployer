require 'net/ssh'
require 'simple_cloud_logging'

module BlackStack
  
  # TODO: move this to the blackstack-code library
  module Infrastructure

    # this module has attributes an methods used by both classes RemoteNode and Node.
    module BaseNode
      attr_accessor :ssh

      def self.descriptor_errors(h)
        errors = []

        # validate: the parameter h is a hash
        errors << "The parameter h is not a hash" unless h.is_a?(Hash)

        # validate: the paramerer h has a key :net_remote_ip
        errors << "The parameter h does not have a key :net_remote_ip" unless h.has_key?(:net_remote_ip)

        # validate: the paramerer h has a key :ssh_username
        errors << "The parameter h does not have a key :ssh_username" unless h.has_key?(:ssh_username)

        # validate: the parameter h[:ssh_username] is a string
        errors << "The parameter h[:ssh_username] is not a string" unless h[:ssh_username].is_a?(String)

        # if the parameter h has a key :ssh_private_key_file
        if h.has_key?(:ssh_private_key_file)
          # validate: the parameter h[:ssh_private_key_file] is a string
          errors << "The parameter h[:ssh_private_key_file] is not a string" unless h[:ssh_private_key_file].is_a?(String)

          # validate: the parameter h[:ssh_private_key_file] is a string
          errors << "The parameter h[:ssh_private_key_file] is not a string" unless h[:ssh_private_key_file].is_a?(String)
        else
          # validate: the parameter h has a key :ssh_password
          errors << "The parameter h does not have a key :ssh_password nor :ssh_private_key_file" unless h.has_key?(:ssh_password)

          # validate: the parameter h[:ssh_password] is a string
          errors << "The parameter h[:ssh_password] is not a string" unless h[:ssh_password].is_a?(String)
        end

        # return
        errors
      end # def self.descriptor_errors(h)

      def initialize(h)
        errors = BlackStack::Infrastructure::BaseNode.descriptor_errors(h)
        # raise an exception if any error happneed
        raise "The node descriptor is not valid: #{errors.uniq.join(".\n")}" if errors.length > 0
        # map attributes
        self.name = h[:name]
        self.net_remote_ip = h[:net_remote_ip]
        self.ssh_username = h[:ssh_username]
        self.ssh_password = h[:ssh_password] 
        self.ssh_port = h[:ssh_port]
        self.ssh_private_key_file = h[:ssh_private_key_file]
      end # def self.create(h)

      def to_hash
        {
          :name => self.name,
          :net_remote_ip => self.net_remote_ip,
          :ssh_username => self.ssh_username,
          :ssh_password => self.ssh_password, 
          :ssh_port => self.ssh_port,
          :ssh_private_key_file => self.ssh_private_key_file,
        }
      end # def to_hash


      # return true if the node is all set to connect using ssh user and password.
      def using_password?
        !self.net_remote_ip.nil? && !self.ssh_username.nil? && !self.ssh_password.nil?
      end

      # return true if the node is all set to connect using a private key file.
      def using_private_key_file?
        !self.net_remote_ip.nil? && !self.ssh_username.nil? && !self.ssh_private_key_file.nil?
      end

      def connect
        # connect
        if self.using_password?
          self.ssh = Net::SSH.start(self.net_remote_ip, self.ssh_username, :password => self.ssh_password, :port => self.ssh_port)
        elsif self.using_private_key_file?
          self.ssh = Net::SSH.start(self.net_remote_ip, self.ssh_username, :keys => self.ssh_private_key_file, :port => self.ssh_port)
        else
          raise "No ssh credentials available"
        end
        self.ssh
      end # def connect

      def disconnect
        self.ssh.close
      end
    end # module BaseNode

    # this class represents a node, without using connection to the database.
    # use this class to create a node descriptor, remotely, when you have no connection to the database. 
    class RemoteNode
      attr_accessor :name # this is just a descriptive name for the node. It is not the host name, nor the domain, nor any ip. 
      attr_accessor :net_remote_ip, :ssh_username, :ssh_password, :ssh_port, :ssh_private_key_file
      include BaseNode
    end # class RemoteNode
  end # module Infrastructure


  module Deployer
    module Nodes
      @@logger = BlackStack::BaseLogger.new(nil)
      @@nodes = []
      @@routines = []
      @@profiles = []

      # get the logger assigned to the module
      def self.logger
        @@logger
      end # def self.errors
  
      # validate the configuration of a node descritor.
      # this method should be called by the final user.
      def self.validate_node_descritor(h)
        errors = BlackStack::Infrastructure::BaseNode.descriptor_errors(h)

        # validate: the parameter h has a key :name
        errors << "The parameter h does not have a key :name" unless h.has_key?(:name)

        # validate: the parameter h[:name] is a string
        errors << "The parameter h[:name] is not a string" unless h[:name].is_a?(String)

        # validate: does not exist any other element in @@nodes with the same value for the parameter h[:name]
        errors << "The parameter h[:name] is not unique" if @@nodes.select{|n| n[:name] == h[:name]}.length > 0 

        # validate: the parameter h has a key :deployment_routine
        #errors << "The parameter h does not have a key :deployment_routine" unless h.has_key?(:deployment_routine)

        # validate: the parameter h[:deployment_routine] is a string
        #errors << "The parameter h[:deployment_routine] is not a string" unless h[:deployment_routine].is_a?(String)

        # validate: exists a routine with the name h[:deployment_routine]
        #errors << "The parameter h[:deployment_routine] does not exist in the routines list" unless @@routines.select { |r| r.name == h[:deployment_routine] }.size > 0

        # raise an exception if any error happneed
        raise "The node descriptor is not valid: #{errors.uniq.join(".\n")}" if errors.length > 0
      end

      # add a node to the list of nodes.
      def self.add_node(h)
        BlackStack::Deployer::Nodes.validate_node_descritor(h)
        @@nodes << h
      end # def

      # add an array of nodes to the list of nodes.
      def self.add_nodes(a)
        # validate: the parameter a is an array
        raise "The parameter a is not an array" unless a.is_a?(Array)
        a.each { |h| BlackStack::Deployer::Nodes.add_node(h) }
      end # def

      # remove all exisiting nodes in he list of nodes.
      # then, add the nodes in the parameter a to the list of nodes.
      def self.set_nodes(a)
        @@nodes.clear
        BlackStack::Deployer::Nodes.add_nodes(a)
      end # def

      # validate the configuration of a routine descritor.
      # this method should be called by the final user.
      def self.validate_routine_descritor(h)
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

        # validate: the parametrer h[:commands] is an array
        errors << "The parameter h[:commands] is not an array" unless h[:commands].is_a?(Array)

        # validate: the parameter h[:commands] has at least one element
        errors << "The parameter h[:commands] does not have at least one element" unless h[:commands].size > 0

        # validate: each element of the array h[:commands] is a hash
        h[:commands].each do |c|
          errors << "Each element of the array h[:commands] is not a hash" unless c.is_a?(Hash)

          # validate: the hash c has a key :command
          errors << "The hash in the array :commands does not have a key :command" unless c.has_key?(:command)

          # validate: the value of c[:command] is a string or symbol
          errors << "The value of c[:command] is not a string and is not a symbol" unless c[:command].is_a?(String) || c[:command].is_a?(Symbol)

          # if the parameter h[:name] is a symbol
          if c[:command].is_a?(Symbol)
            # validate: existis a routine with a the value c[:command].to_s on its :name key
            errors << "The routine with the name #{c[:command].to_s} does not exist" unless BlackStack::Deployer::Nodes.select { |r| r[:name] == c[:command].to_s }.size > 0
          end

          # if c[:matches] exists
          if c.has_key?(:matches)
            # validate: the value of c[:matches] must by a regex or an array
            errors << "The value of the key :matches is not a regex or an array" unless c[:matches].is_a?(Regexp) || c[:matches].is_a?(Array)
            # if c[:matches] is a array
            if c[:matches].is_a?(Array)
              # validate: each element in the the array c[:matches] is a regex
              c[:matches].each do |m|
                errors << "Each element in the array c[:matches] is not a regex" unless m.is_a?(Regexp)
              end # each
            end # if c[:matches].is_a?(Array)
          end # if :matches exists

          # if c[:nomatches] exists
          if c.has_key?(:nomatches)
            # validate: the value of c[:nomatches] must by a regex or an array
            errors << "The value of the key :nomatches is not an array" unless c[:nomatches].is_a?(Array)
            # if c[:nomatches] is a array
            if c[:nomatches].is_a?(Array)
              # validate: each element in the the array c[:nomatches] is a hash
              c[:nomatches].each do |m|
                errors << "Each element in the array c[:nomatches] is not a regex" unless m.is_a?(Hash)
                # if m is a hash
                if m.is_a?(Hash)
                  # validate: the hash m has a key :nomatch
                  errors << "The hash in the array c[:nomatches] does not have a key :nomatch" unless m.has_key?(:nomatch)
                  # validate: the value of m[:nomatch] is a string
                  errors << "The value of the key :nomatch is not a string" unless m[:nomatch].is_a?(String)
                  # validate: the hash m has a key :error_description
                  errors << "The hash in the array c[:nomatches] does not have a key :error_description" unless m.has_key?(:error_description)
                  # validate: the value of m[:error_description] is a string
                  errors << "The value of the key :error_description is not a string" unless m[:error_description].is_a?(String)
                end # if m.is_a?(Hash)
              end # each
            end # if c[:matches].is_a?(Array)
          end # if :matches exists
        end # h[:commands].each do |c|

        # raise exception if any error has been found
        raise "The routine descriptor is not valid: #{errors.uniq.join(".\n")}" if errors.length > 0
      end # end

      # add a routine to the list of routines.
      def self.add_routine(h)
        BlackStack::Deployer::Nodes.validate_routine_descritor(h)
        @@routines << h
      end # def

      # add an array of routines to the list of routines.
      def self.add_routines(a)
        # validate: the parameter a is an array
        raise "The parameter a is not an array" unless a.is_a?(Array)
        a.each { |h| BlackStack::Deployer::Nodes.add_routine(h) }
      end # def

      # remove all exisiting routines in he list of routines.
      # then, add the routines in the parameter a to the list of routines.
      def self.set_routines(a)
        @@routines.clear
        BlackStack::Deployer::Nodes.add_routines(a)
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
        o = BlackStack::Infrastructure::RemoteNode.new(
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
          if o.using_password?
            s = o.ssh.exec!("echo '#{o.ssh_password.gsub("'", "\\'")}' | sudo -S su root -c '#{c[:command].gsub("'", "\\'")}'")
          elsif o.using_private_key_file?
            s = o.ssh.exec!("sudo -S su root -c '#{c[:command].gsub("'", "\\'")}'")
          end
          self.logger.logf "Done.\nOutput:#{s}"
        end 
        
        # disconnect the node
        o.disconnect
        
      end # def
      
      # deploying all routines on all nodes
      def self.deploy()
      end # def
    end # module Nodes

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

    # 
    def self.deploy()    
    end # def
  end # module Deployer

end # module BlackStack
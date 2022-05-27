module BlackStack
  
  # TODO: move this to the blackstack-code library
  module Infrastructure
    class NodeStub
      def self.validate_descriptor(h)
        errors = []

        # validate: the parameter h is a hash
        errors << "The parameter h is not a hash" unless h.is_a?(Hash)

        # validate: the paramerer h has a key :net_remote_id
        errors << "The parameter h does not have a key :net_remote_id" unless h.has_key?(:net_remote_id)

        # if the parameter h has a key :ssh_private_key_file
        if h.has_key?(:ssh_private_key_file)
          # validate: the parameter h[:ssh_private_key_file] is a string
          errors << "The parameter h[:ssh_private_key_file] is not a string" unless h[:ssh_private_key_file].is_a?(String)
        else
          # validate: the paramerer h has a key :ssh_username
          errors << "The parameter h does not have a key :ssh_username. You can also setup the key :ssh_private_key_file" unless h.has_key?(:ssh_username)

          # validate: the parameter h[:ssh_username] is a string
          errors << "The parameter h[:ssh_username] is not a string" unless h[:ssh_username].is_a?(String)

          # validate: the parameter h has a key :ssh_password
          errors << "The parameter h does not have a key :ssh_password. You can also setup the key :ssh_private_key_file" unless h.has_key?(:ssh_password)

          # validate: the parameter h[:ssh_password] is a string
          errors << "The parameter h[:ssh_password] is not a string" unless h[:ssh_password].is_a?(String)
        end

        # return
        errors
      end # def self.validate_descriptor(h)
    end # class Node
  end # module Infrastructure


  module Deployer
    module Nodes
      @@nodes = []
      @@routines = []
      @@profiles = []

      def self.errors()
        @@errors
      end # def self.errors
  
      # validate the configuration of a node descritor.
      # this method should be called by the final user.
      def self.validate_node_descritor(h)
        errors = BlackStack::Infrastructure::Node.validate_descriptor(h)
        
        # validate: the parameter h has a key :deployment_routine
        errors << "The parameter h does not have a key :deployment_routine" unless h.has_key?(:deployment_routine)

        # validate: the parameter h[:deployment_routine] is a string
        errors << "The parameter h[:deployment_routine] is not a string" unless h[:deployment_routine].is_a?(String)

        # validate: exists a routine with the name h[:deployment_routine]
        errors << "The parameter h[:deployment_routine] does not exist in the routines list" unless @@routines.select { |r| r.name == h[:deployment_routine] }.size > 0

        # raise an exception if any error happneed
        raise "The node descriptor is not valid: #{errors.uniq.join(', ')}" if errors.length > 0
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
        @@nodes.remove_all
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
        errors << "The parameter h does not have a key :command" unless h.has_key?(:command)

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
            errors << "The routine with the name #{c[:command].to_s} does not exist" unless BlackStack::Deployer::Routines.select { |r| r[:name] == c[:command].to_s }.size > 0
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
        raise "The routine descriptor is not valid: #{errors.uniq.join(', ')}" if errors.length > 0
      end # end

      # add a routine to the list of routines.
      def self.add_routine(h)
        BlackStack::Deployer::Routines.validate_routine_descritor(h)
        @@routines << h
      end # def

      # add an array of routines to the list of routines.
      def self.add_routines(a)
        # validate: the parameter a is an array
        raise "The parameter a is not an array" unless a.is_a?(Array)
        a.each { |h| BlackStack::Deployer::Routines.add_routine(h) }
      end # def

      # remove all exisiting routines in he list of routines.
      # then, add the routines in the parameter a to the list of routines.
      def self.set_routines(a)
        @@routines.remove_all
        BlackStack::Deployer::Routines.add_routines(a)
      end # def
      
      # running a routine on a node
      def self.run(node_name, routine_name)
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
    BlackStack::Deployer.deploy()    
    end # def
  end # module Deployer
end # module BlackStack
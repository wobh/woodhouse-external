module Woodhouse
  module External

    class << self
      
      def install_extension(*)
        # No setup needed
      end

      def connect(server_changes = {}, keyw = {})
        base = keyw[:base] || Woodhouse
        server_changes = server_changes || {}

        external = Module.new do
          extend Woodhouse::GlobalMethods
          extend Woodhouse::External
        end

        external.layout do

        end

        external.configure do |config|
          config.server_info = base.global_configuration.server_info.merge(server_changes)
          config.dispatcher_type = default_dispatcher
        end

        external
      end

      def default_dispatcher
        @default_dispatcher ||= guess_dispatcher
      end
      
      def guess_dispatcher
        if defined? ::Rails and (::Rails.env.test? or ::Rails.env.development?)
          :test
        else
          :amqp
        end
      end

    end

    def const_missing(name)
      worker_proxy(name)
    end

    def worker_proxy(name)
      WorkerProxy.new(self, name)
    end

    class WorkerProxy
      
      def initialize(external, worker_name)
        @external    = external
        @worker_name = worker_name
      end

      def method_missing(method, *args, &block)
        if method.to_s =~ /^asynch?_(.*)/
          @external.dispatch(@worker_name, $1, args.first)
        else
          super
        end
      end
        
    end

  end
end

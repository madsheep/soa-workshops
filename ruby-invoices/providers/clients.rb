module Providers

  class Clients

    QUEUE_NAME = "backend.clients"

    def initialize(ch)
      @ch = ch
    end

    def start    
      @q = @ch.queue(QUEUE_NAME)
      @x = @ch.default_exchange

      @q.subscribe(:block => true) do |delivery_info, properties, _payload|  
        r = JSON.generate(self.class.clients)
        @x.publish(r.to_s, :routing_key => properties.reply_to, :correlation_id => properties.correlation_id)
      end
    end

    def self.clients
      ["google", "facebook", "yahoo", "twitter"]
    end
  end 
end


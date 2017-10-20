class ProviderBase

  def initialize(ch)
    @ch = ch
  end

  def setup(queue_name)
    puts "Starting provider for queue #{queue_name}"
    q = @ch.queue(queue_name)
    x = @ch.default_exchange

    q.subscribe(:block => true) do |delivery_info, properties, payload| 
      puts "#{queue_name}: Replying to request: #{payload}"
      response = begin
        params = JSON.parse(payload.to_s.empty? ? "{}" : payload)
        reply(params)
      rescue JSON::ParseError => e
        { error: "Invalid json sent!"}
      end
      
      generated_response = JSON.generate(response)
      puts "#{queue_name}: reply is #{generated_response}"
      
      x.publish(generated_response, :routing_key => properties.reply_to, :correlation_id => properties.correlation_id)
    end
  end

  def reply
    raise "Unimplmented reply method!"
  end

end 
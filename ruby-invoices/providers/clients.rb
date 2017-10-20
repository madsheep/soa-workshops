require_relative "../lib/provider_base"

module Providers
  class Clients < ::ProviderBase 

    def start    
      setup("backend.clients")
    end

    def reply(_params)
      {clients: self.class.clients}
    end

    def self.clients
      ["google", "facebook", "yahoo", "twitter"]
    end

  end 
end

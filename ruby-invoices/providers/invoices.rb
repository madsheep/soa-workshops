require_relative "../lib/provider_base"

module Providers

  class Invoices < ::ProviderBase 

    def start    
      setup("backend.invoices")
    end 

    def reply(params)
      client_invoices = self.class.invoices[params["client_id"]] || []
      { invoices: client_invoices }
    end

    def self.invoices
      {
        "google" => [
          {"total" => "200000000 USD", "services" => "Providing users data to the fbi", "customer" => "Federal Bureau of Investigation"},
          {"total" => "4000 USD", "services" => "Selling out users emails to ad companies", "customer" => "Big Bad Corporations"}
        ],
        "facebook" => [
          {"total" => "899229199 USD", "services" => "Selling out signed users photos", "customer" => "NSA"},
          {"total" => "9123 USD", "services" => "", "customer" => "Big Bad Corporation"}
        ],
        "yahoo" => [
          {"total" => "121223 USD", "services" => "Selling out the few emails they got", "customer" => "Big Bad Corporations"}
        ],
        "twitter" => [
          {"total" => "12 USD", "services" => "Telling everybody its hard to add edit button", "customer" => "Who cares"}
        ]
      }
    end
  
  end 
end


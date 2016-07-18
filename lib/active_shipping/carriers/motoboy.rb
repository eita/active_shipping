# -*- encoding utf-8 -*-

module ActiveShipping
  class Motoboy < Carrier

    cattr_reader :name
    @@name = "Motoboy"

    def find_rates(origin, destination, packages, options = {})
      options = @options.merge(options)
      if (destination.postal_code.to_i >= 59000001 && destination.postal_code.to_i <= 59161999) || (destination.postal_code.to_i >= 59290000 && destination.postal_code.to_i <= 59290999)
        success = true
        item = {total_price: 0, currency: "BRL", delivery_range: [Date.tomorrow], shipping_date: Date.tomorrow, service_code: 1}
        estimate = RateEstimate.new(origin, destination, Motoboy.name, "Normal", item)
        estimate.service_code = 1
        rates = [estimate]
      else
        success = false
        rates = {}
        message = "Não entregamos neste endereço"
      end
      response = RateResponse.new(success, message, {}, {rates: rates})
    end

    def self.available_services
      AVAILABLE_SERVICES
    end

    protected
    DEFAULT_SERVICES = [1, 2]
    AVAILABLE_SERVICES = {
      1 => 'Normal',
      2 => 'Expresso',
    }.freeze

  end
end

# This service class selects the correct Transformer that will be
# injected to the TransformAndLoad class

module Reservations
  class TransformerSelector
    def self.transformer(payload:)
      # To scale this service, just add a Validator and a Transformer
      if PayloadValidators::AirbnbPayloadValidator.new(payload: payload).validate
        return Transformers::Airbnb
      elsif PayloadValidators::BookingcomPayloadValidator.new(payload: payload).validate
        return Transformers::Bookingcom
      else
        # TODO: Throw an error here
      end
    end
  end
end

# This service class is responsible for transforming and loading (persisting)
# the request payload. It is injected with the corresponding Transformer
# to properly transform the payload into the uniform format.

module Reservations
  class TransformAndLoad
    attr_reader :payload, :transformer, :transformed_payload

    def initialize(payload:)
      @payload = payload
      @transformer = TransformerSelector.transformer(payload: payload)
      # NOTE: This is the transform phase.
      @transformed_payload = transformer.new(payload: payload).execute
    end

    def execute
      # NOTE: This is load phase. Code can still
      # be improved for this part
      guest
      guest_phone_numbers
      reservation
    end

    def guest
      @guest ||= Guest.find_or_create_by(transformed_payload[:guest].except(:phone_numbers))
    end

    def guest_phone_numbers
      transformed_payload[:guest][:phone_numbers].each do |number|
        guest.guest_phone_numbers.find_or_create_by(number: number)
      end
    end

    def reservation
      guest.reservations.create(transformed_payload[:reservation])
    end
  end
end

# This Transformer will transform the Airbnb request payload
# into the uniform format for persistence.
module Reservations
  module Transformers
    class Airbnb
      attr_reader :payload

      def initialize(payload:)
        @payload = payload.with_indifferent_access
      end

      def execute
        {
          reservation: {
            start_date: payload[:start_date],
            end_date: payload[:end_date],
            adults: payload[:adults].to_i,
            children: payload[:children].to_i,
            infants: payload[:infants].to_i,
            guest_external_id: payload[:guest][:id].to_s,
            status: payload[:status],
            security_price: payload[:security_price].to_d,
            total_price: payload[:total_price].to_d,
            payout_price: payload[:payout_price].to_d,
            currency: payload[:currency],
          },
          guest: {
            email: payload[:guest][:email],
            first_name: payload[:guest][:first_name],
            last_name: payload[:guest][:last_name],
            phone_numbers: [payload[:guest][:phone]],
          },
        }
      end
    end
  end
end

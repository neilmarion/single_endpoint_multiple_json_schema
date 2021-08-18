# This Transformer will transform the Booking.com request payload
# into the uniform format for persistence.

module Reservations
  module Transformers
    class Bookingcom
      attr_reader :payload

      def initialize(payload:)
        @payload = payload.with_indifferent_access[:reservation]
      end

      def execute
        {
          reservation: {
            start_date: payload[:start_date],
            end_date: payload[:end_date],
            adults: payload[:guest_details][:number_of_adults].to_i,
            children: payload[:guest_details][:number_of_children].to_i,
            infants: payload[:guest_details][:number_of_infants].to_i,
            guest_external_id: payload[:guest_id].to_s,
            status: payload[:status_type],
            security_price: payload[:listing_security_price_accurate].to_d,
            total_price: payload[:total_paid_amount_accurate].to_d,
            payout_price: payload[:expected_payout_amount].to_d,
            currency: payload[:host_currency],
          },
          guest: {
            email: payload[:guest_email],
            first_name: payload[:guest_first_name],
            last_name: payload[:guest_last_name],
            phone_numbers: payload[:guest_phone_numbers].uniq,
          },
        }
      end
    end
  end
end

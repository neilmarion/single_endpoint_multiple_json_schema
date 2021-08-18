# This service objects will validate a payload
# to determine if it's a Booking.com request payload

module Reservations
  module PayloadValidators
    class BookingcomPayloadValidator
      SCHEMA = {
        "type" => "object",
        "properties" => {
          "reservation" => {
            "type" => "object",
            "properties" => {
              "start_date" => {
                "type" => "string",
              },
              "end_date" => {
                "type" => "string",
              },
              "expected_payout_amount" => {
                "type" => "string",
              },
              "guest_details" => {
                "type" => "object",
                "properties" => {
                  "localized_description" => {
                    "type" => "string"
                  },
                  "number_of_adults" => { "type" => "integer" },
                  "number_of_children" => { "type" => "integer" },
                  "number_of_infants" => { "type" => "integer" },
                }
              },
              "guest_email" => {
                "type" => "string",
              },
              "guest_first_name" => {
                "type" => "string",
              },
              "guest_id" => {
                "type" => "integer",
              },
              "guest_last_name" => {
                "type" => "string",
              },
              "guest_phone_numbers" => {
                "type" => "array",
                "items" => { "type" => "string" },
              },
              "listing_security_price_accurate" => {
                "type" => "string",
              },
              "host_currency" => {
                "type" => "string",
              },
              "nights" => {
                "type" => "integer",
              },
              "number_of_guests" => {
                "type" => "integer",
              },
              "status_type" => {
                "type" => "string",
              },
              "total_paid_amount_accurate" => {
                "type" => "string",
              },
            }
          }
        }
      }

      attr_reader :payload

      def initialize(payload:)
        @payload = payload
      end

      def validate
        JSON::Validator.validate(SCHEMA, payload, strict: true)
      end
    end
  end
end

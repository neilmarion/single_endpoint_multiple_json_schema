# This service objects will validate a payload
# to determine if it's an Airbnb request payload

module Reservations
  module PayloadValidators
    class AirbnbPayloadValidator
      SCHEMA = {
        "type" => "object",
        "properties" => {
          "start_date" => {
            "type" => "string",
          },
          "end_date" => {
            "type" => "string",
          },
          "nights" => {
            "type" => "integer",
          },
          "guests" => {
            "type" => "integer",
          },
          "adults" => {
            "type" => "integer",
          },
          "children" => {
            "type" => "integer",
          },
          "infants" => {
            "type" => "integer",
          },
          "status" => {
            "type" => "string",
          },
          "guest" => {
            "type" => "object",
            "properties" => {
              "id" => {
                "type" => "integer",
              },
              "first_name" => {
                "type" => "string"
              },
              "last_name" => {
                "type" => "string"
              },
              "phone" => {
                "type" => "string"
              },
              "email" => {
                "type" => "string"
              },
            },
          },
          "currency" => {
            "type" => "string",
          },
          "payout_price" => {
            "type" => "string",
          },
          "security_price" => {
            "type" => "string",
          },
          "total_price" => {
            "type" => "string",
          },
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

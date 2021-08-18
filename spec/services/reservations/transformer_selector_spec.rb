require 'rails_helper'

describe Reservations::TransformerSelector do
  context 'Payload is from Airbnb' do
    before(:each) do
      allow_any_instance_of(Reservations::PayloadValidators::AirbnbPayloadValidator).
        to receive(:validate).and_return(true)
      allow_any_instance_of(Reservations::PayloadValidators::BookingcomPayloadValidator).
        to receive(:validate).and_return(false)
    end

    specify do
      klass = described_class.transformer(payload: {})
      expect(klass).to eq Reservations::Transformers::Airbnb
    end
  end

  context 'Payload is from Booking.com' do
    before(:each) do
      allow_any_instance_of(Reservations::PayloadValidators::AirbnbPayloadValidator).
        to receive(:validate).and_return(false)
      allow_any_instance_of(Reservations::PayloadValidators::BookingcomPayloadValidator).
        to receive(:validate).and_return(true)
    end

    specify do
      klass = described_class.transformer(payload: {})
      expect(klass).to eq Reservations::Transformers::Bookingcom
    end
  end
end

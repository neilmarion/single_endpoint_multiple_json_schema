require 'rails_helper'

describe Reservations::TransformAndLoad do
  let(:airbnb_payload) do
    {
      "start_date": "2021-03-12",
      "end_date": "2021-03-16",
      "nights": 4,
      "guests": 4,
      "adults": 2,
      "children": 2,
      "infants": 0,
      "status": "accepted",
      "guest": {
        "id": 1,
        "first_name": "Wayne",
        "last_name": "Woodbridge",
        "phone": "639123456789",
        "email": "wayne_woodbridge@bnb.com"
        },
      "currency": "AUD",
      "payout_price": "3800.00",
      "security_price": "500",
      "total_price": "4500.00"
    }
  end

  let(:bookingcom_payload) do
    {
      "reservation": {
        "start_date": "2021-03-12",
        "end_date": "2021-03-16",
        "expected_payout_amount": "3800.00",
        "guest_details": {
          "localized_description": "4 guests",
          "number_of_adults": 2,
          "number_of_children": 2,
          "number_of_infants": 0,
        },
        "guest_email": "wayne_woodbridge@bnb.com",
        "guest_first_name": "Wayne",
        "guest_id": 1,
        "guest_last_name": "Woodbridge",
        "guest_phone_numbers": [
          "639123456789",
          "639123456780"
        ],
        "listing_security_price_accurate": "500.00",
        "host_currency": "AUD",
        "nights": 4,
        "number_of_guests": 4,
        "status_type": "accepted",
        "total_paid_amount_accurate": "4500.00"
      }
    }
  end

  specify do
    [bookingcom_payload, airbnb_payload].each do |payload|
      described_class.new(payload: payload).execute
      guest = Guest.first
      expect(guest.first_name).to eq 'Wayne'
      expect(guest.last_name).to eq 'Woodbridge'
      expect(guest.email).to eq 'wayne_woodbridge@bnb.com'
      reservation = Reservation.first
      expect(reservation.start_date).to eq '2021-03-12'.to_date
      expect(reservation.end_date).to eq '2021-03-16'.to_date
      expect(reservation.adults).to eq 2
      expect(reservation.children).to eq 2
      expect(reservation.infants).to eq 0
      expect(reservation.guest_external_id).to eq '1'
      expect(reservation.status).to eq 'accepted'
      expect(reservation.security_price).to eq 500.to_d
      expect(reservation.total_price).to eq 4500.to_d
      expect(reservation.payout_price).to eq 3800.to_d
      expect(reservation.currency).to eq 'AUD'
    end
  end
end

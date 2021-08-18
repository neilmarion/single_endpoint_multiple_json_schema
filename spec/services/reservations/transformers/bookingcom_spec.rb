require 'rails_helper'

describe Reservations::Transformers::Bookingcom do
  let(:payload) do
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
          "639123456710"
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
    transformed_params = described_class.new(payload: payload).execute
    expect(transformed_params).to include(
      {
        reservation: {
          start_date: '2021-03-12',
          end_date: '2021-03-16',
          adults: 2,
          children: 2,
          infants: 0,
          guest_external_id: '1',
          status: 'accepted',
          security_price: 500.to_d,
          total_price: 4500.to_d,
          payout_price: 3800.to_d,
          currency: 'AUD',
        },
        guest: {
          email: 'wayne_woodbridge@bnb.com',
          first_name: 'Wayne',
          last_name: 'Woodbridge',
          phone_numbers: ['639123456789', '639123456710'],
        },
      }
    )
  end
end

require 'rails_helper'

describe Reservations::Transformers::Airbnb do
  let(:payload) do
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
          phone_numbers: ['639123456789'],
        },
      }
    )
  end
end

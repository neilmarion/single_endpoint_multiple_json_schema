# NOTE: A better practice would be is that the post reservations endpoint
# will be scoped under the guests. However, I would assume that since external
# service do not have a reference to our internal system identifiers then we do not
# scope 'reservations' under 'guests'.

require 'rails_helper'

describe ReservationsController, type: :request do
  context 'reservation is authorized' do
    let(:guest) { create(:guest) }

    describe '#create' do
      let(:params) do
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

      before do
        post "/reservations", params: params, as: :json
      end

      it { expect(response).to have_http_status(:ok) }
    end
  end

  context 'reservation is not authorized' do
    # TODO: Not in the scope of this exam
  end
end

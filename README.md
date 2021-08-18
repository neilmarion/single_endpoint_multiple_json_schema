# Single Endpoint Multiple Json Schema

This rails app is a demonstration on how to implement a single endpoint which can easily scale to an infinite number of json payload formats coming from external services.

## To install in your local machine

```
git clone https://github.com/neilmarion/single_endpoint_multiple_json_schema
bundle
bundle exec rake db:create db:migrate
bin/rails s -p 3000
```

## The Design

The main idea behind the scalability of this design is that, depending on the payload format, a corresponding Transformer service object is going to be used for the payload to be transformed into the uniform persistable form. The TransformerSelector will inspect the payload format by comparing it to the JSON schemas currently supported by the API endpoint with the use of JSON::Validator. If the payload matches one of the schemas then it will return the corresponding Transformer class that will be injected into the TransformAndLoad service. The service will then instantiate the Transformer class and will be used to finally transform the payload into a persistable form of Reservations, Guests and GuestPhoneNumbers.

In order to scale to other payload formats, a new PayloadValidator and Transformer only needs to be created.

![https://i.imgur.com/meyy5R1.png](https://i.imgur.com/meyy5R1.png)

## Sample

Airbnb
```
curl -X POST -H "Content-Type: application/json" -d '{"start_date": "2021-03-12", "end_date": "2021-03-16", "nights": 4, "guests": 4, "adults": 2, "children": 2, "infants": 0, "status": "accepted", "guest": { "id": 1, "first_name": "Wayne", "last_name": "Woodbridge", "phone": "639123456789", "email": "wayne_woodbridge@bnb.com" }, "currency": "AUD", "payout_price": "3800.00", "security_price": "500", "total_price": "4500.00" }' localhost:3000/reservations
```

Booking.com
```
curl -X POST -H "Content-Type: application/json" -d '{ "reservation": { "start_date": "2021-03-12", "end_date": "2021-03-16", "expected_payout_amount": "3800.00", "guest_details": { "localized_description": "4 guests", "number_of_adults": 2, "number_of_children": 2, "number_of_infants": 0 }, "guest_email": "wayne_woodbridge@bnb.com", "guest_first_name": "Wayne", "guest_id": 1, "guest_last_name": "Woodbridge", "guest_phone_numbers": [ "639123456789", "639123456789" ], "listing_security_price_accurate": "500.00", "host_currency": "AUD", "nights": 4, "number_of_guests": 4, "status_type": "accepted", "total_paid_amount_accurate": "4500.00" } }' localhost:3000/reservations
```

## Notes

1. I have related the two sample endpoints to Airbnb and Booking.com only for the purpose of naming classes.
2. Due to the limited time that I have for this exercise, I have created the 'respond_with_error' in the ApplicationController that will catch all of the errors especially mis-formatted payloads.
3. Also, due to the limited time, I have only created Rspec tests for the "happy-path."

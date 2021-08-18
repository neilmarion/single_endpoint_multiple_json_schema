# NOTE: Due to the limited time that I have for this exercise,
# I have created the 'respond_with_error' in the ApplicationController
# that will catch all of the errors especially mis-formatted payloads.

class ReservationsController < ApplicationController
  def create
    respond_with_error do
      Reservations::TransformAndLoad.new(payload: transformed_params).execute
      render json: {}, status: :ok
    end
  end

  def transformed_params
    JSON.parse(request.raw_post)
  end
end

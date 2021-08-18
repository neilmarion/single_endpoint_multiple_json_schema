class ApplicationController < ActionController::API
  def respond_with_error
    yield
  rescue StandardError => e
    render json: { error: 'SOMETHING WENT WRONG' }, status: :internal_server_error
  end
end

Rails.application.routes.draw do
  post 'reservations', action: :create, controller: 'reservations'
end

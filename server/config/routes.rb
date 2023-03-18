Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :commissioning_reports, only: [:create]
    end
  end
end

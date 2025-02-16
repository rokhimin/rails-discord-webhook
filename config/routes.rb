Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  
  root 'main#index'
  get 'discord-webhook-test.rb', to: 'discord#index'
  post 'discord-webhook-test.rb', to: 'discord#post'
end

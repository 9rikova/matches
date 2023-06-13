Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get "players", to: "players#index"
  get "players/:player_id/check_indicator", to: "players#check_indicator"
  post "matches/:match_id/players/:player_id/indicator_performances", to: "indicator_performances#create"
end

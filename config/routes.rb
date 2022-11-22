Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'game#play_game'
  get '/game/result', to: "game#curb_response"
end

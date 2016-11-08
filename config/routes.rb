Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :puzzles
  get '/solve/:puzzle_id' => 'puzzles#solve'
end

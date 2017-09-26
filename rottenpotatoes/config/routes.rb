Rottenpotatoes::Application.routes.draw do
  resources :movies
  get "movies/:id/search_directors", to: "movies#search_directors", as: "search_directors"
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
end

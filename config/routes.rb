Rails.application.routes.draw do

  get 'new', to: 'games#new', as: :new
  get 'score', to: 'games#contact', as: :score
  post 'score', to: 'games#score'

  root to: 'games#new'
end

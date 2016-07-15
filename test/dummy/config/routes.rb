Rails.application.routes.draw do
  mount BetterFrame::Engine => "/better_frame"

  root "products#index"
  get 'foreign_website' => 'foreign_website#show'
  resources :products
end

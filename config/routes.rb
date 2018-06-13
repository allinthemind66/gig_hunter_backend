Rails.application.routes.draw do
  resources :friend_requests
  namespace :api do
    namespace :v1 do
      resources :users
      post "/login", to: "auth#create"
      delete "/signout", to: 'auth#destroy'
      get "/current_user", to: "auth#show"
      post "/add_img", to: 'users#add_img'
      post "/signup", to: "users#create"
      resources :gigs
      get "/gigs/:id/applicants", to: "gigs#all_applicants"
      post '/gigs/signedInGigs', to: "gigs#signed_in_user_gigs"
      resources :instruments
      resources :user_gigs, :except => [:destroy]
      delete '/userGig/delete', to: "user_gigs#destroy"
      resources :gig_applications, :except => [:destroy]
      delete '/gig_applications/deleteGigApplication', to: 'gig_applications#delete_gig_application'
      resources :friendships
      resources :friend_requests
    end
  end
end

Rails.application.routes.draw do
	
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html



post "mycomments/:comment_id"=> "comments#mycomment", as:"mycomment"
  resources :posts do
  	resources :comments

  end


 resources :comments do
  	resources :comments

  end


  root "posts#index"
  get '/about', to: 'pages#about'
  get 'tags/:tag', to: 'posts#index', as: "tag"
end

Codefather::Application.routes.draw do
  root to: "index#home"
  # get "/post" => "index#post", as: :post
  resources :posts, only: [:show]
  get "/archives" => "index#archives", as: :archives
  
  get "/admin" => "admin/index#home"
  namespace :admin do
    resources :posts, only: [:new, :create, :edit, :update]
  end
end

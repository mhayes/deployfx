Deployfx::Application.routes.draw do
  root to: "index#home"
  resources :posts, only: [:show]
  get "/archives" => "index#archives", as: :archives
  
  get "/admin" => "admin/posts#index"
  namespace :admin do
    resources :posts, only: [:index, :new, :create, :edit, :update]
  end
end

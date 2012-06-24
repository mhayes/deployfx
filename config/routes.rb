Deployfx::Application.routes.draw do
  root to: "index#home"
  get "/auth/twitter/callback" => "sessions#create"
  resources :posts, only: [:show] do
    collection do
      get "/tagged/:name" => "posts#tagged", as: :tagged
    end
  end
  get "/archives" => "posts#archives", as: :archives
  
  get "/admin" => "admin/posts#index"
  namespace :admin do
    resources :posts, only: [:index, :new, :create, :edit, :update]
  end
end

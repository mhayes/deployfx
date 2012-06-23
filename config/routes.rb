Codefather::Application.routes.draw do
  root to: "index#home"
  get "/post" => "index#post"
  get "/archive" => "index#archive"
end

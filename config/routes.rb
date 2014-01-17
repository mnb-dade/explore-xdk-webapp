ExploreXdkWebapp::Application.routes.draw do
  
  resources :pictures
  
  get '/stream', to: 'streams#stream', as: 'stream'

  root to: "pictures#index"
end

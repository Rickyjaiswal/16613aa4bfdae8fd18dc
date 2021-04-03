Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
constraints format: :json do
  namespace 'api' do
    get 'test' => 'robot#test'
    post 'create' => 'robot#create'
  end
end
end

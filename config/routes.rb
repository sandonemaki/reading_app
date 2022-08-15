Rails.application.routes.draw do
  # get 'pageimages/show' => 'pageimages#show'
  get 'voicetexts/new' => 'voicetexts#new'
  post 'voicetexts/create' => 'voicetexts#create'
  root to: 'pageimages#show'
end

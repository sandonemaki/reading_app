Rails.application.routes.draw do
  # get 'pageimages/show' => 'pageimages#show'
  post 'voicetexts/new' => 'voicetexts#new'
  get 'voicetexts/new' => 'voicetexts#new'
  root to: 'pageimages#show'
end

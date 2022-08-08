Rails.application.routes.draw do
  # get 'pageimages/show' => 'pageimages#show'
  get 'voicetexts/new' => 'voicetexts#new'

  root to: 'pageimages#show'
end

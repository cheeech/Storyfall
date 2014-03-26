App::Application.routes.draw do
  root 'story#next_title'

  get     'login'  => 'session#new'
  post    'login'  => 'session#create'
  delete  'logout' => 'session#destroy'

  get 'privacy' => 'site#privacy'
  get 'terms' => 'site#terms'

  get 'reset/:code' => 'password#edit', as: :reset
  put 'reset/:code' => 'password#update'
  patch 'reset/:code' => 'password#update'

  get 'wdi' => 'site#wdi'

  get 'nextstory' => 'story#next_title'

  get 'createstory' => 'story#new'
  post 'createstory' => 'story#create_story'
  get 'story/:code' => 'story#show', as: :story
  # post 'story/:code' => 'story#contribute', as: :story

  get 'createmessage' => 'message#new_message'


end

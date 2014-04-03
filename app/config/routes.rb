App::Application.routes.draw do
  root 'story#next_title'

  #Session & login
  get     'login'  => 'session#new'
  post    'login'  => 'session#create'
  delete  'logout' => 'session#destroy'

  get     'reset/:code' => 'password#edit', as: :reset
  put     'reset/:code' => 'password#update'
  patch   'reset/:code' => 'password#update'

  #View stories & make a message submission
  get     'next_story'   => 'story#next_title'
  get     'story/:code' => 'story#show', as: :story
  post    'story/:code' => 'message#submit'

  #Create a new story
  get   'create_story' => 'story#new'
  post  'create_story' => 'story#create'

  #View & approve pending messages
  get   'pending_messages' => 'story#pending_messages'
  patch 'pending_messages' => 'story#approve_message'

  #View all my contributions
  get   'my_stories' => 'story#my_stories'

  # post 'stories' => 'stories#create'
  # post 'messages' => 'messages#create'

  # Static Pages
  get     'privacy' => 'site#privacy'
  get     'terms'   => 'site#terms'
  get     'wdi'     => 'site#wdi'
end

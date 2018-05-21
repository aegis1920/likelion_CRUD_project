Rails.application.routes.draw do
  
#Note
  #Create
  get '/notes/new' => 'notes#new'
  post '/notes/create' => 'notes#create'
  
  #Read
  get '/' => 'notes#index' # 전체 목록
  get '/notes/:id' => 'notes#show'
  
  #Update
  get '/notes/:id/edit' => 'notes#edit'
  patch '/notes/:id' => 'notes#update'

  #Destory                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
  delete '/notes/:id' => 'notes#destroy'
  
#Comment
  #Create
  post '/comments' => 'comments#create'
  
  #Destroy
  delete '/comments/:id' => 'comments#destroy'
end

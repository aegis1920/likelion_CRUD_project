Rails.application.routes.draw do

  # 처음 '/'의 의미는 URL에서 맨 오른쪽의 생략되어있는 최상위 root를 의미한다. 예를 들면, https://wjfijilasdj.io 에서 맨 오른쪽.
  
  #Create
  # get '/' => 는 root와 같다. 예를 들면 root 'bamboo#new'가 get '/' => 'bamboo#new'와 같다. 
  get '/secrets/new' => 'secrets#new' # 입력 페이지
  
  # /bamboo/create는 /bamboo/create => bamboo/create와 같다.
  # URL에 https://wjfijilasdj.io/bamboo/create를 치면 bamboo_controller.rb라는 파일인 컨트롤러에서 create라는 action을 찾는다.
  
  post '/secrets/create' => 'secrets#create' # 저장 페이지
  
  #Read
  #그냥 root('/')이면 secrets controller에 있는 index file을 찾아서 보여준다.
  get '/' => 'secrets#index' # 전체 목록 보기
  get '/secrets/:id' => 'secrets#show'
  
  #Update
  get '/secrets/:id/edit' => 'secrets#edit'
  patch '/secrets/:id' => 'secrets#update'

  #Destory
  delete '/secrets/:id' => 'secrets#destroy'
  
end

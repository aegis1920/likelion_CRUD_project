class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # CSRF를 방어하기 위한 token 생성기라고 보면 쉽다.아래 줄을 주석처리하면 token을 생성시키지 않아도 된다. 
  protect_from_forgery with: :exception
end

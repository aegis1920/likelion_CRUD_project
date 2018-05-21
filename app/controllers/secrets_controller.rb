class SecretsController < ApplicationController

# Create
  def new
    @token = form_authenticity_token #token을 주지 않으면 에러가 난다.
    #application_controller.rb에 있는 protect 때문에.
  end

  def create # 생성 / 데이터를 테이블에 저장
  secret = Secret.new # 테이블에 데이터를 한 줄 추가
  secret.title = params[:input_title] # 전달받은 데이터가 param에 담겨옴
  secret.content = params[:input_content]
  secret.save #만들어진 데이터를 테이블에 저장
  redirect_to "/"
  end
  
# Read
  def index # 전체 글 조회
  @secrets = Secret.all
  end

  def show
    @secret = Secret.find params[:id]
  end

# Update
  def edit # 사용자가 데이터를 수정할 화면
  @secret = Secret.find params[:id]
  @token = form_authenticity_token
  end

  def update
    secret = Secret.find params[:id]
    secret.title = params[:input_title]
    secret.content = params[:input_content]
    secret.save
    redirect_to "/secrets/#{secret.id}"
  end

# Destroy
  def destroy
    @secret = Secret.find params[:id]
    @secret.destroy
    #위 문장을 실행하고 나면 보여줄 페이지가 없으니까 당연히 에러가 뜬다. redirect로 실행된 후 보여줄 페이지를 적어야 한다.
    redirect_to "/"
  end


end

# Simple CRUD Project

'멋쟁이 사자처럼'에서 진행한 것을 공부한 것입니다. 자세한 정보는 인터넷에서 찾아주시고 전체적인 흐름만 본다고 생각해주세요. 

### Terminal input
1. bundle install
	* for rails_db and rails version in gemfile
2. rails g controller secrets edit index new show
	* controller는 소문자 + 복수
	* secrets는 컨트롤러 이름
	* 그 뒤부터 action의 이름
3. rails g model Secret title content
	* model은 대문자 + 단수
	* Secret은 model의 이름
	* 그 뒤부터는 model에 들어갈 칼럼의 이름 
4. rails db:migrate  
	* db에서 scheme이 변경된 걸 적용해줍니다.

## Data Flow(index action, create action)
1. 사용자가 URL에 https://abcdefghijk.io 를 입력합니다. (위 URL은 임의로 정한 URL로 자신의 웹 서버을 뜻합니다)
2. https://abcdefghijk.io 는 https://abcdefghijk.io/ 와 같으므로 config/route.rb의 루트('/')를 의미합니다. 그래서  get '/' 으로 가게 됩니다. 
3. `get '/' => 'secrets#index'`는 루트('/')를 받으면 app/concerns/screts_controller.rb라는 루비 파일이 있습니다. 즉, 이 루비 파일(secrets 라는 컨테이너)로 가서 index라는 action(메소드)을 실행합니다
4. index라는 action은 `@secrets = Secret.all`로 정의가 되어있습니다. 인스턴스 변수(@secrets) 안에 테이블 객체(Secret)의 모든걸(.all) 할당해줍니다(=).
5. app/views/secrets에 가보면 index의 view 파일(index.html.erb)도 있으므로 실행합니다. (redirect가 없이 view 페이지가 없다면 오류가 뜹니다.)
6.  HTML이 렌더링되어 화면에 페이지(index.html.erb)가 뜹니다.
7. 사용자가 input 태그와 textarea 태그에 정보를 입력합니다.
8. input 태그에 입력한 것은 input_title라는 이름으로 매개변수가 되고, textarea 태그에 입력한 것은 input_content라는 이름으로 매개변수가 됩니다. 
9. 사용자가 type 속성이 submit인 input 태그를 클릭합니다.
10. input태그와 textarea 태그는 form으로 싸여져 POST의 방식으로 action 속성에 있는대로 https://abcdefghijk.io/secrets/create 로 보내지게 됩니다. 
11. 아까 한대로 URL이니 route.rb를 보면 secrets라는 컨트롤러의 create action으로 가게 됩니다. 
12. secret_controller.rb에 create action 은 아래와 같이 구성되어 있습니다. 
```ruby
def create 
  secret = Secret.new 
  secret.title = params[:input_title] 
  secret.content = params[:input_content]
  secret.save
  redirect_to "/"
end
```
13. secret이라는 변수에 Secret 객체의 한 줄(table의 row)을 추가해줍니다.  
14. 그 객체의 한 줄에서 title 부분에는 input_title이라는 심볼을 넣어주고
15. 그 객체의 한줄에서 content 부분에는 input_content라는 심볼을 넣어줍니다. 
16. 확정해주기 위해서 save를 해줍니다. 
17. create라는 view 파일을 찾지만 없으니 redirect를 해줍니다. '/'로 되어있으니 URL이 /로 가게 됩니다. 
18. 즉, 사용자가 입력한 title과 content가 db라고 할 수 있는 table로 가게됩니다. 


## CSRF의 방어
* CSRF(Cross-site Request Forgery)
	* 우리가 배웠던 걸 기준으로 알아봅시다.
	* 유명한 사이트의 URL과 유사하게 만들어서 이쪽 내가 만든 서버로 들어오게 합니다.  
	* 아이디와 패스워드를 입력하는 곳까지 완벽하게 똑같이 만들어서 사용자가 입력하게 합니다. 
	* 우리가 만든 secrets 컨트롤러 안에 있는 Create action처럼 params를 통해 아이디와 패스워드를 빼옵니다.
	* action을 통해서 본래 있었던 정상적인 유명한 사이트의 URL로 가게 해서 정상적으로 작동한 것 처럼 보이게 합니다.  
* 비밀번호를 쓸 때 GET 방식의 경우 URL에 나타나니까 보안의 우려로 쓰지않습니다. 그래서 POST를 쓰게 됩니다.
* 그러나 위에 말한 것과 같이 CSRF같은 공격이 있으니 POST를 무작위로 생성되는 token과 함께 포함해서 줘서 방어합니다. 

**그래서 controller 파일에  token을 생성해주고 그에 따라 view 파일의 form에도 넣어줍니다.**

## Restful 하다.
* REST(Representational State Transfer)
* 웹의 장점을 최대한 활용할 수 있는 아키텍쳐.
* routes.rb에 보면 HTTP 메소드의 방식으로 GET을 쓰고 있습니다.
* GET만 쓰게 되면 /members/delete/1 처럼 삭제면 삭제, 업데이트면 업데이트라고 다 써줘야 합니다. 
* CRUD는 POST, GET, PUT/PASTE, DELETE 메소드를 이용해 표현할 수 있습니다. 
* 그래서 GET을 이용해 CREATE을 했던 부분에 POST를 쓰고, UPDATE에는 PATCH, Destroy에는 DELETE를 씁니다.

## Model Association
게시판에 Comment를 남기고 싶다면? 어떻게 하면 comment를 남길 수 있을까?
* comment라는 컬럼을 추가하면? -> 컬럼을 추가하게 되면 그 내용에 댓글을 100개를 달았을 때 100개의 칼럼이 되버립니다.
* 결론은 Notes Table, Comment Table. 테이블을 두 개를 만듭니다.
* Comment 테이블에는 댓글을 쭉 쓰고 memo_id라는 걸 추가해서  그에 해당하는 것에 맞도록 합니다.

### Terminal input
1. rails g model Owner name
2. rails db:migrate
3. rails g model Item name
4. Item Migrate.rb에 t.string :name과 t.belongs_to :owner 을 적습니다.
5. rails db:migrate
6. models  폴더 안에 각각 item.rb, owner.rb에서  #여러 개의 Items를 가지고 있어요.(belongs_to :owner)와 #Owner에게 속해 있어요.(has_many :items) 를 써줍니다. 그러면 이제 연결이 된 겁니다.
7. rails c 에서 여러 가지 명령어를 쳐보세요. 
8. o = Owner.find 1, o.items, item = Item.find 1, item.owner, o = Owner.find 3, o.items, o.item, i = Item.find 2, i.owner 등...

9. rails g model Hobby name:string owner:belongs_to
10. rails db:migrate
11. 한 꺼번에 다 쓰면 foreign key가 생깁니다. 
12. foreign_key: true는 이게 외래 키라고 그냥 명시적으로 알려주는 역할입니다.
13. Hobby에는 자동으로 쓰이지만 owner.rb에 들어가서 has_many :hobbies를 써줘야 합니다.
14. rails c 에서 여러 가지 명령어를 쳐보세요
15. Owner.all, Item.all, h = Hobby.new, h.name = '미식', h.save, h.owner_id = 2, h.save, o = Owner.find 1
쇼핑', owner_id: 2, Hobby.create name:'요가', owner: Owner.find(3), Hobby.create! name: '운동', owner: Owner.find(1) Owner.find(1).items, Item.all.first, neo.items<span></span>.first.name, neo.hobbies<span></span>.last.name, neo.items<span></span>.name, neo.items<span></span>.first.id, Owner.find(1).items.first.owner.id, Owner.find(3).items.last.owner.name, Item.find(2).owner.name, Item.find(2).owner.hobbies.last.name

!를 쓰고 안 쓰고의 차이
* !를 쓰면 에러 로그로 더 자세히 왜 틀렸는지 알려줍니다. !를 안 쓰면 에러 로그를 별로 안 써줍니다.



**reference**
* http://meetup.toast.com/posts/92


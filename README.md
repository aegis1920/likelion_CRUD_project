
# Simple CRUD Project

'멋쟁이 사자처럼'에서 진행한 것을 공부한 것입니다. 자세한 정보는 인터넷에서 찾아주시고 전체적인 흐름만 본다고 생각해주세요. 

IDE : C9
Language : ruby, HTML
Framework : ruby on rails

### Terminal Input
1. `bundle install`
	* for rails_db and rails version in gemfile
2. `rails g controller notes edit index new show`
	* controller는 소문자 + 복수
	* notes는 컨트롤러 이름
	* 그 뒤부터는 action들의 이름
3. `rails g model Note title content`
	* model은 대문자 + 단수
	* Note은 model의 이름
	* 그 뒤부터는 model에 들어갈 칼럼들의 이름 
4. `rails db:migrate`
	* db에서 scheme이 변경된 걸 적용해줍니다.

## Simple Data Flow(index action, create action)
1. 사용자가 URL에 https://abcdefghijk.io 를 입력합니다. (위 URL은 임의로 정한 URL로 자신의 웹 서버을 뜻합니다)
2. https://abcdefghijk.io 는 https://abcdefghijk.io/ 와 같으므로 config/route.rb의 루트(`'/'`)를 의미합니다. 그래서  `get '/'` 으로 가게 됩니다. (여담으로 보통 URL 맨 뒤에 '/'를 써주지 않는 이유는 써주지 않는 게 REST의 Convention이기 때문입니다.)
3. **`get '/' => 'notes#index'`의 의미는 URL로 루트('/')를 받으면 app/concerns/notes_controller.rb라는 루비 파일(notes 라는 컨테이너)에 가서 index라는 action(메소드)을 실행한다는 뜻입니다.** (참고로 루트로 가는 `get '/' =>`은 root라고 써도 동일한 의미입니다. 그래서 위의 코드는 `root 'notes#index'`의 의미와 같습니다. 또한 그냥 `get 'notes/create'`은 `get 'notes/create' => 'notes#create'`와 같습니다. 즉, 동일한 컨트롤러와 동일한 액션으로 가는 것은 뒷 부분(`=> 'notes#create'`)을 생략해도 됩니다. 는 )
4. index라는 action은 아래와 같이 정의(definition, def)되어 있습니다.  
```ruby
def index
	#이 의미는 인스턴스 변수(@notes) 안에 테이블 객체(Note)의 모든걸(.all) 할당해준다(=)는 의미입니다.
	@notes = Note.all
end
```
5. **컨테이너에서의 action이 끝나면 view 파일이 있는지 확인합니다. app/views/notes에 가보면 index의 view 파일(index.html.erb)도 있으므로 실행합니다. (redirect가 없이 view 페이지가 없다면 오류가 뜹니다.)**
6.  HTML이 렌더링되어 화면에 페이지(index.html.erb)가 뜹니다.
7. 사용자가 input 태그와 textarea 태그에 정보를 입력합니다.
8. input 태그에 입력한 것은 input_title라는 이름으로 매개변수가 되고, textarea 태그에 입력한 것은 input_content라는 이름으로 매개변수가 됩니다. 
9. 사용자가 type 속성이 submit인 input 태그를 클릭합니다.
10. **input태그와 textarea 태그는 form으로 싸여져 POST의 방식으로 action 속성에 있는대로 https://abcdefghijk.io/notes/create 로 보내지게 됩니다.**
11. 아까 한대로 URL이니 route.rb를 보면 notes라는 컨트롤러의 create action으로 가게 됩니다. 
12. note_controller.rb에 create action 은 아래와 같이 구성되어 있습니다. 
```ruby
def create 
  note = Note.new 
  note.title = params[:input_title] 
  note.content = params[:input_content]
  note.save
  redirect_to "/"
end
```
13. note이라는 변수에 Note 객체의 한 줄(table의 row)을 추가해줍니다.  
14. 그 객체의 한 줄에서 title 부분에는 input_title이라는 심볼(:)을 넣어주고
15. 그 객체의 한줄에서 content 부분에는 input_content라는 심볼(:)을 넣어줍니다. 
16. 확정해주기 위해서 save를 해줍니다. 
17. create라는 view 파일을 찾지만 없으니 redirect를 해줍니다. `'/'`로 되어있으니 URL이 /로 가게 됩니다. 
18. 즉, 사용자가 입력한 title과 content가 db라고 할 수 있는 table로 가게됩니다. 


## CSRF의 방어
* CSRF(Cross-site Request Forgery)
	* 유명한 사이트의 URL과 유사하게 만들어서 이쪽 내가 만든 서버로 들어오게 합니다.  
	* 아이디와 패스워드를 입력하는 곳까지 완벽하게 똑같이 만들어서 사용자가 입력하게 합니다. 
	* 우리가 만든 notes 컨트롤러 안에 있는 Create action처럼 params를 통해 아이디와 패스워드를 빼옵니다.
	* action을 통해서 본래 있었던 정상적인 유명한 사이트의 URL로 가게 해서 정상적으로 작동한 것 처럼 보이게 합니다.  
* 비밀번호를 쓸 때 GET 방식의 경우 URL에 나타나니까 보안의 우려로 쓰지않습니다. 그래서 POST를 쓰게 됩니다.
* 그러나 위에 말한 것과 같이 CSRF같은 공격이 있으니 POST의 방식을 쓸 때 무작위로 생성되는 token과 함께 포함해서 줘서 방어합니다. 
* rails는 POST 방식일 경우, 기본값으로 token을 사용하도록 되어있습니다. app/controllers/application_controller.rb 파일에서 `protect_from_forgery with: :exception` 이 부분이 rails에서 token을 쓸지 안 쓸지 정해줍니다. 이 부분을 주석처리하면 token을 안 써줘도 됩니다. 
* **그래서 controller 파일에  token을 생성해주고 그에 따라 view 파일의 form에도 넣어줍니다.**

## Restful
* REST(Representational State Transfer)
* 웹의 장점을 최대한 활용할 수 있는 아키텍쳐입니다.
* routes.rb에 보면 HTTP 메소드의 방식으로 GET을 쓰고 있습니다.
* GET만 쓰게 되면 `/members/delete/1` 처럼 delete면 delete, update면 update라고 URL에 다 써줘야 합니다. 
* CRUD는 POST, GET, PUT/PASTE, DELETE라는 HTTP 메소드를 이용해 표현할 수 있습니다. 
* 그래서 GET을 이용해 CREATE을 했던 부분에 POST를 쓰고, READ는 GET, UPDATE에는 PATCH, DESTROY에는 DELETE를 씁니다.

## Comment(댓글 기능 만들기)
게시판에 Comment를 남기고 싶다면? 어떻게 하면 comment를 남길 수 있을까요?
* comment라는 컬럼을 추가하면? -> 컬럼을 추가하게 되면 그 내용에 댓글을 100개를 달았을 때 100개의 칼럼이 되버립니다.
* 결론은 Notes Table, Comment Table. 테이블을 두 개를 만드는 것입니다.

### Terminal input

1. `rails g model Comment content:string note:belongs_to`
	* Comment라는 model을 새로 생성합니다. 
	* content라는 이름의 칼럼과 전에 만들었던 note라는 model에 속하도록 합니다.
2. `rails db:migrate`
3. comment.rb에는 `belongs_to :note`가 적혀져 있고 note.rb에는 `has_many :comments` 를 따로 써줘야 합니다.
	* comment는 Owner(note)에게 속해있고 note는 여러 개의 items(comments)를 가지고 있습니다.  1:N의 관계가 성립됐습니다. 
	* `foreign_key: true`는 이게 외래 키라고 그냥 명시적으로 알려주는 역할입니다.
4. `rails c` (Note와 Comment에 데이터베이스를 여러 개 추가해줍니다.)
	4. `n = Note.new`
	5. `n.title = 'memo1'`
	6. `n.content = 'hello world1'`
	7. `n.save`
		* 위의 4줄과 동일한 의미
		* `Note.create! title: 'memo1', content: 'hello world1'`
			* !를 쓰면 error log로 더 자세히 왜 틀렸는지 알려줍니다. !를 안 쓰면 error log를 별로 안 써줍니다.
		* `n = Note.new title: 'memo1', content: 'hello world1' 한 후, n.save`
		* `Comment.create content: 'Comment1', note_id: 2` 등등...
	8. 데이터베이스는 여러 가지 명령어로 접근할 수 있습니다. 
		* 데이터베이스를 수정하려면 -> `c = Comment.find 5`로 찾아서 `c.content = '2*5 = 10'`로 수정해주고 `c.save`
		* (가장 최근의) 데이터 베이스를 삭제하려면 -> `c = Comment.last`로 접근해서 `c.destroy`
		* Note.find(1).comments
		* Comment.find(1).id
		* Comment.all.first.note_id
5. `rails g controller Comments` 

### .html.erb 파일과 .rb 파일에 코드를 추가
1. comment_controller.rb에 create action과 destory action을 만듭니다. 댓글은 show.html.erb 파일에서 보여지기 때문에 view 페이지가 필요없습니다.
2. show.html.erb -> note의 id에 접근하기 위해서 type 속성을 hidden으로 줍니다. 그리고 a 태그는 http get 메소드만 지원하기 때문에 data-method로 따로 속성을 지정해줍니다.
```html
<input type='hidden' name='note_id' value=<%= @note.id %>></input>
...
<% @note.comments.each do |comment| %>
	<p>
	    <%= comment.content %> | 
	    <!--a tag is just support get HTTP method. so, we used data-mathod attribute-->
	    <a href='/comments/<%= comment.id %>' data-confirm='댓글을 입력하세요' data-method='DELETE'>x</a>
	</p>
<% end %>
```
 3. routes.rb에는 댓글 생성과 삭제에 해당하는 곳에 HTTP 메소드을 추가합니다. 
```ruby
#Comment
  #Create
  post '/comments' => 'comments#create'
  #Destroy
  delete '/comments/:id' => 'comments#destroy'
```
4. debugger를 코드 안에 적어주면 실행되다가 debugger 코드가 있는 곳에서 실행이 멈춥니다. 그 때의 db들을 확인할 수 있습니다. 

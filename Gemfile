#모든 gem들은 이 주소에 있다. Gemfile에 원하는 gem들을 써주고 터미널에서 bundle install을 해주면 gem들을 모두 설치해준다. 
source 'https://rubygems.org'

# bundle install과 bundle update의 차이
# 둘 다 없었던 gem을 설치해주지만, bundle update는 gem에 버전이 없으면(gem rails_db같이) 최신버전으로 업그레이드 헤준다. 또한 gem에 ~>로 제어되는 경우, 그 범위 내에서 최신 버전으로 업데이트 된다.
# 예를 들어, 최신 버전이 2.1.5인 'foo_gem', '~> 2.1.0'이라는 gem을 쓰고 bundle update를 쓰면 2.1.5가 설치됩니다. 그러나 2.2.6이 최신 버전이이면 아무 것도 하지 않습니다.

# rails_db라는 gem을 설치
gem 'rails_db'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
# rails의 버전을 적어준다. ~>의 의미는 마지막 자리와 같거나 더 큰 것을 의미한다. 
# 예를 들어, ~> 2.3은 2.3 이상 3.0 미만, ~> 2.3.0은 2.3.0 이상 2.4.0미만을 나타낸다.
# 출처 : https://stackoverflow.com/questions/5170547/what-does-tilde-greater-than-mean-in-ruby-gem-dependencies#comment12551998_5170547
gem 'rails', '~> 5.0.6'

# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end


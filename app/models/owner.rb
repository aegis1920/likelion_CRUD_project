class Owner < ApplicationRecord
    #여러 개의 Items를 가지고 있어요    
    has_many :items
    has_many :hobbies
end

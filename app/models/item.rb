class Item < ApplicationRecord
    #Owner에게 속해있어요.
    belongs_to :owner
end

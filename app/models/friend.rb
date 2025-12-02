class Friend < ApplicationRecord
  belongs_to :user_main, class_name: "User"
  belongs_to :user_friend, class_name: "User"
end

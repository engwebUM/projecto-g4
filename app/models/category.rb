class Category < ActiveRecord::Base
  belongs_to :expense
  belongs_to :revenue
end

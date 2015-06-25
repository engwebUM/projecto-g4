class User < ActiveRecord::Base
  devise :invitable, :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true

  belongs_to :expense
  belongs_to :revenue
end

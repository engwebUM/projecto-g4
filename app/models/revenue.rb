class Revenue < ActiveRecord::Base
  belongs_to :category
  accepts_nested_attributes_for :category

  belongs_to :user
  accepts_nested_attributes_for :user

  has_attached_file :document
  validates_attachment_content_type :document, content_type: ['application/pdf', 'image/jpeg', 'image/png']

  scope :like, (lambda do |param| 
    where("description like '%#{args}%' OR amount like '%#{args}%' OR created_at like '%#{args}%'")
  end)

  scope :joinuser, (lambda do |param|
  	joins(:user).where("email like '%#{args}%'")	
  )
end

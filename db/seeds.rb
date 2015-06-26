# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
def adduser(name, email, password)
  user = User.invite!(email: email) do |u|
    u.skip_invitation = true
  end
  token = user.instance_variable_get(:@raw_invitation_token)
  User.accept_invitation!(invitation_token: token, password: password, password_confirmation: password, name: name)
end

adduser("admi3n", "admi3n@admin.com", "12345678")

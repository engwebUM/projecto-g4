class UserMailer < ApplicationMailer
  default from: 'guterres25@gmail.com'

  def welcome_email(user)
    @user = user

    mail(to: @user, subject: 'test subject')
  end
end

module UserHelper
  def user_status(user)
    if user.invitation_accepted?
      content_tag(:span, '', class: 'glyphicon glyphicon-ok color-success')
    else
      'Invitation Pending'
    end
  end
end

module UserHelper
  def user_status(user)
    if user.invitation_accepted?
      content_tag(:span, '', class: 'glyphicon glyphicon-ok')
    else
      content_tag(:span, '', class: 'glyphicon glyphicon-time')
    end
  end
end

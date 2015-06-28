class UserRevenues
  include StatsHelper

  def data(_, revenues)
    user_revenues = revenues.joins(:user).group(:email).sum(:amount).to_a
    draw_pie(user_revenues, 'Revenues by User')
  end
end

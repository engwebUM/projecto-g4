class UserExpenses
  include StatsHelper

  def data(expenses, _)
    user_expenses = expenses.joins(:user).group(:email).sum(:amount).to_a
    draw_pie(user_expenses, 'Expenses by User')
  end
end

require 'total_expenses_revenues'
require 'user_expenses'
require 'user_revenues'
require 'combination_category_exp_rev'
require 'category_expenses'

class Chart
  CHARTS = {
    totalExpRev: TotalExpensesRevenues,
    userExp: UserExpenses,
    userRev: UserRevenues,
    combCatExpRev: CombinationCategoryExpRev,
    catExpRev: CategoryExpenses
  }
  private_constant :CHARTS
  
  def initialize(expenses, revenues)
    @expenses = expenses
    @revenues = revenues
  end
  
  def data_for(chart_identifier)
    CHARTS[chart_identifier].new.data(@expenses, @revenues)
  end
end

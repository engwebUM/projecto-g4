class StatsController < ApplicationController

  def index
    @expenses = Expense.all
    @revenues = Revenue.all
    @chart = Chart.new(@expenses, @revenues)
  end
end

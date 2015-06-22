class StatsController < ApplicationController
  include StatsHelper

  def index
    @expenses = Expense.all
    @revenues = Revenue.all
    create_charts(@expenses, @revenues)
  end
end

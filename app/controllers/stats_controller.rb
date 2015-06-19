class StatsController < ApplicationController
  include StatsHelper

  def index
    @expenses = Expense.all
    @revenues = Revenue.all
    @chart = create_charts(@expenses,@revenues)
  end
end

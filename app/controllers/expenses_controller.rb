class ExpensesController < ApplicationController
  before_action :set_expense, only: [:show, :edit, :update, :destroy]

  def index
    expenses_scope = Expense.all
    @expenses = smart_listing_create :expenses, list_create(expenses_scope, params[:filter]), partial: 'expenses/expense', page_sizes: [5, 7, 13, 26]
  end

  def show
  end

  def new
    @expense = Expense.new
    @categories = Category.all
  end

  def edit
    @categories = Category.all
  end

  def create
    @expense = Expense.new(expense_params)
    create_rev_exp(@expense)
  end

  def update
    if @expense.update(expense_params)
      render :show
      msg_success
    else
      render :edit
      msg_error
    end
  end

  def destroy
    if @expense.destroy
      msg_success
      redirect_to expenses_url
    else
      redirect_to :back
      msg_error
    end
  end

  private

  def set_expense
    @expense = Expense.find(params[:id])
  end

  def expense_params
    params.require(:expense).permit(:date, :user_id, :category_id, :description, :amount, :document)
  end
end

class ExpensesController < ApplicationController
  before_action :set_expense, only: [:show, :edit, :update, :destroy]

  def index
    @expenses = Expense.all
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
    @expense.user_id = current_user.id
    if @expense.save
      flash[:notice] = 'Expense was successfully created'
      redirect_to @expense
    else
      redirect_to :new
      flash[:error] = 'Please try again!'
    end
  end

  def update
    if @expense.update(expense_params)
      render :show
      flash[:notice] = 'Expense was successfully updated'
    else
      render :edit
      flash[:error] = 'Please try again!'
    end
  end

  def destroy
    if @expense.destroy
      flash[:notice] = 'Expense was successfully destroyed'
      redirect_to expenses_url
    else
      redirect_to :back
      flash[:error] = 'Please try again!'
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

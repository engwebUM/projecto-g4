class ExpensesController < ApplicationController
  include SmartListing::Helper::ControllerExtensions
  helper  SmartListing::Helper
  before_action :set_expense, only: [:show, :edit, :update, :destroy]
   
  def index
    expenses_scope = Expense.all
    expenses_scope = expenses_scope.joinuser(params[:filter]) if params[:filter]
    @expenses = smart_listing_create :expenses, expenses_scope, partial: "expenses/expense", page_sizes: [5, 7, 13, 26]
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
      msg_error
    end
  end

  def update
    if @expense.update(expense_params)
      render :show
      flash[:notice] = 'Expense was successfully updated'
    else
      render :edit
      msg_error
    end
  end

  def destroy
    if @expense.destroy
      flash[:notice] = 'Expense was successfully destroyed'
      redirect_to expenses_url
    else
      redirect_to :back
      msg_error
    end
  end

  private

  def msg_error
    flash[:error] = 'Please try again!'
  end

  def set_expense
    @expense = Expense.find(params[:id])
  end

  def expense_params
    params.require(:expense).permit(:date, :user_id, :category_id, :description, :amount, :document)
  end
end

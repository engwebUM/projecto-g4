class ExpensesController < ApplicationController
  before_action :set_expense, only: [:show, :edit, :update, :destroy]

  def index
    @expenses = Expense.all
    @expenses_user = @expenses.select("user_id", "amount")

    @expenses_user_total = []
    @expenses_user.each do |e|
      if (!@expenses_user_total.find(e.user_id))
        user = e.user_id
        total = 0
        expenses_user.each do |ee|
          total = total + ee.amount
        end
        @expenses_user_total << [user, total]
      end
    end

    @total_expenses = @expenses_user_total.sum(:total)

    @expenses_user_total.each do |et|
      et.total = et.total.to_f / @total_expenses
    end
    

    @chart = LazyHighCharts::HighChart.new('pie') do |f|
      f.chart({:defaultSeriesType=>"pie" , :margin=> [50, 200, 60, 170]} )
      series = {
               :type=> 'pie',
               :name=> 'Users expenses',
               :data=>  @expenses_user
      }
      f.series(series)
      f.options[:title][:text] = "Expenses by User"
      f.legend(:layout=> 'vertical',:style=> {:left=> 'auto', :bottom=> 'auto',:right=> '50px',:top=> '100px'}) 
      f.plot_options(:pie=>{
        :allowPointSelect=>true, 
        :cursor=>"pointer" , 
        :dataLabels=>{
          :enabled=>true,
          :color=>"black",
          :style=>{
            :font=>"13px Trebuchet MS, Verdana, sans-serif"
          }
        }
      })
    end

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

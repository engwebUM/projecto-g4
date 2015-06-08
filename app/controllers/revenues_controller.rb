class RevenuesController < ApplicationController
  include RevenuesHelper
  before_action :set_revenue, only: [:show, :edit, :update, :destroy]

  def index
    @revenues = Revenue.all
    @name_rev = Revenue.pluck('user_id', 'amount')
    @chart = pie_chart(@name_rev)
  end

  def show
  end

  def new
    @revenue = Revenue.new
    @categories = Category.all
  end

  def edit
    @categories = Category.all
  end

  def create
    @revenue = Revenue.new(revenue_params)
    @revenue.user_id = current_user.id
    if @revenue.save
      flash[:notice] = 'Revenue was successfully created'
      redirect_to @revenue
    else
      redirect_to :new
      msg_error
    end
  end

  def update
    if @revenue.update(revenue_params)
      render :show
      flash[:notice] = 'Revenue was successfully updated'
    else
      render :edit
      msg_error
    end
  end

  def destroy
    if @revenue.destroy
      flash[:notice] = 'Revenue was successfully destroyed'
      redirect_to revenues_url
    else
      redirect_to :back
      msg_error
    end
  end

  private

  def msg_error
    flash[:error] = 'Please try again!'
  end

  def set_revenue
    @revenue = Revenue.find(params[:id])
  end

  def revenue_params
    params.require(:revenue).permit(:date, :user_id, :category_id, :description, :amount, :document)
  end
end

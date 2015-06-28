class RevenuesController < ApplicationController
  before_action :set_revenue, only: [:show, :edit, :update, :destroy]

  def index
    revenues_scope = Revenue.all
    revenues_scope = revenues_scope.joinuser.like(params[:filter]) if params[:filter]
    @revenues = smart_listing_create :revenues, revenues_scope, partial: 'revenues/revenue', page_sizes: [5, 7, 13, 26]
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

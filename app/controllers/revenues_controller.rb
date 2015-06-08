class RevenuesController < ApplicationController
  before_action :set_revenue, only: [:show, :edit, :update, :destroy]

  def index
    @revenues = Revenue.all
  
    @name_rev = Revenue.pluck("user_id", "amount")
    @name_rev.each do |r|
      r[0] = User.find(r[0]).email
    end


    @chart = LazyHighCharts::HighChart.new('pie') do |f|
      f.chart({:defaultSeriesType=>"pie" , :margin=> [50, 200, 60, 170]} )
      series = {
               :type=> 'pie',
               :name=> 'Users revenue',
               :data=>  @name_rev.each  
      }
      f.series(series)
      f.options[:title][:text] = "Revenue by User"
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

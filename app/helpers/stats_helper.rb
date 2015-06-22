module StatsHelper
  def create_charts(expenses, revenues)
    chart_data1 = expenses.group(:user_id).sum(:amount).to_a
    chart_data1.each do |ex|
      ex[0] = User.find(ex[0]).email
    end
    
    chart_data2 = revenues.group(:user_id).sum(:amount).to_a
    chart_data2.each do |ex|
      ex[0] = User.find(ex[0]).email
    end



    aux4 = Expense.all.group(:category_id).sum(:amount)
    aux5 = Revenue.all.group(:category_id).sum(:amount)
    
    keys = [aux4,aux5].flat_map(&:keys).uniq
    
    keys.map do |k| 
      {k => [{value1: aux4[k] || "0"},
            {value2: aux5[k] || "0"}]} 
    end
    
    chaves = keys.reduce(&:merge)

    chaves = []
    keys.each do |k,value|
      chaves << k
    end

    @chart1 = draw_pie(chart_data1,'Expenses by User')
    @chart2 = draw_pie(chart_data2,'Revenues by User')
    @chart3 = draw_pie(chart_data1,'Expenses by User')
    @chart4 = draw_combination(keys,chaves,'Revenues by User')
  end


#keys tem [{1=>[{:value1=>50},{:value2=>87}]},{2=>[{:value1=>50},{:value2=>99}]}]

  def draw_combination(hash_data,chaves,title)
    chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title({ :text=>"Combination chart"})
      f.options[:xAxis][:categories] = chaves
      f.labels(:items=>[:html=>"Total fruit consumption", :style=>{:left=>"40px", :top=>"8px", :color=>"black"} ])      
      hash_data.each do |fds|
        y = fds.to_a
        key = y[0][0]
        value = y[0][1]
        a = value[0][:value1]
        b = value[1][:value2]
        f.series(:type=> 'column',:name=> key,:data=> [a,b])
      end
    end
  end

  def draw_pie(chart_data,title)
    chart = LazyHighCharts::HighChart.new('pie') do |f|
      f.chart defaultSeriesType: 'pie', margin: [50, 200, 60, 170]
      series = {
        type: 'pie',
        name: title,
        data: chart_data.each
      }
      f.series(series)
      f.options[:title][:text] = title
      f.legend(layout: 'vertical', style: { left: 'auto', bottom: 'auto', right: '50px', top: '100px' })
      f.plot_options(
        pie: {
          allowPointSelect: true,
          cursor: 'pointer',
          dataLabels: {
            enabled: true,
            color: 'black',
            style: {
              font: '13px Trebuchet MS, Verdana, sans-serif'
            }
          }
        }
      )
    end
  end
end

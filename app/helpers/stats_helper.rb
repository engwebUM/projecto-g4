module StatsHelper
  def create_charts(expenses, revenues)
    chart_data1 = expenses.pluck('user_id', 'amount')
    chart_data1.each do |ex|
      ex[0] = User.find(ex[0]).email
    end
    chart_data2 = revenues.pluck('user_id', 'amount')
    chart_data2.each do |ex|
      ex[0] = User.find(ex[0]).email
    end
    chart_data3 = expenses.pluck('user_id', 'amount')
    chart_data3.each do |ex|
      ex[0] = User.find(ex[0]).email
    end
    chart_data4 = expenses.pluck('user_id', 'amount')
    chart_data4.each do |ex|
      ex[0] = User.find(ex[0]).email
    end

    @chart1 = draw(chart_data1,'Expenses by User')
    @chart2 = draw(chart_data2,'Revenues by User')
    @chart3 = draw(chart_data1,'Expenses by User')
    @chart4 = draw(chart_data2,'Revenues by User')
  end

  def draw (chart_data,title)
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

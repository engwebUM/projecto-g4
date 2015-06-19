module StatsHelper
  def create_charts(expenses, revenues)
    chart_data = revenues.pluck('user_id', 'amount')
    chart_data.each do |ex|
      ex[0] = User.find(ex[0]).email
    end
    chart = LazyHighCharts::HighChart.new('pie') do |f|
      f.chart defaultSeriesType: 'pie', margin: [50, 200, 60, 170]
      series = {
        type: 'pie',
        name: 'Users expenses',
        data: chart_data.each
      }
      f.series(series)
      f.options[:title][:text] = 'Expenses by User'
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
    chart
  end
end

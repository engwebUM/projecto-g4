module RevenuesHelper
  def  revenues_pie_chart revenues
    name_rev = revenues.pluck('user_id', 'amount')
    name_rev.each do |r|
      r[0] = User.find(r[0]).email
    end
    draw(name_rev)
  end

  def draw name_rev
    chart = LazyHighCharts::HighChart.new('pie') do |f|
      f.chart defaultSeriesType: 'pie', margin: [50, 200, 60, 170]
      series = {
        type: 'pie',
        name: 'Users revenue',
        data: name_rev.each
      }
      f.series(series)
      f.options[:title][:text] = 'Revenue by User'
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

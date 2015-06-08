module RevenuesHelper


  def  pie_chart ()
  
    @chart = LazyHighCharts::HighChart.new('pie') do |f|
      f.chart defaultSeriesType: 'pie', margin: [50, 200, 60, 170]
      series = {
        type: 'pie',
        name: 'Users revenue',
        data: @name_rev.each
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
  end

end

class UserRevenues
  def data(expenses, revenues)
    user_revenues = revenues.joins(:user).group(:email).sum(:amount).to_a
    draw_pie(user_revenues)
  end

  def draw_pie(chart_data)
    LazyHighCharts::HighChart.new('pie') do |f|
      f.chart defaultSeriesType: 'pie', margin: [50, 200, 60, 170]
      series = { type: 'pie', name: 'Revenues by User', data: chart_data.each }
      f.series(series)
      f.options[:title][:text] = 'Revenues by User'
      f.legend(layout: 'vertical', style: { left: 'auto', bottom: 'auto', right: '50px', top: '100px' })
      f.plot_options(pie: { allowPointSelect: true, cursor: 'pointer', dataLabels: { enabled: true, color: 'black', style: { font: '13px Trebuchet MS, Verdana, sans-serif' } } })
    end
  end
end

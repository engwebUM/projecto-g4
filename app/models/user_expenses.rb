class UserExpenses
  def data(expenses, _)
    user_expenses = expenses.joins(:user).group(:email).sum(:amount).to_a
    draw_pie(user_expenses)
  end

  def draw_pie(chart_data)
    LazyHighCharts::HighChart.new('pie') do |f|
      f.chart defaultSeriesType: 'pie', margin: [50, 200, 60, 170]
      series = { type: 'pie', name: 'Expenses by User', data: chart_data.each }
      f.series(series)
      f.options[:title][:text] = 'Expenses by User'
      f.legend(layout: 'vertical', style: { left: 'auto', bottom: 'auto', right: '50px', top: '100px' })
      f.plot_options(pie: { allowPointSelect: true, cursor: 'pointer', dataLabels: { enabled: true, color: 'black', style: { font: '13px Trebuchet MS, Verdana, sans-serif' } } })
    end
  end
end

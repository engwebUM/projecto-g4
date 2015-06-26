class TotalExpensesRevenues
  def data(expenses, revenues)
    total_expenses = expenses.all.sum(:amount)
    total_revenues = revenues.all.sum(:amount)
    total_bar_chart(total_expenses, total_revenues)
  end

  def total_bar_chart(total_expenses, total_revenues)
    LazyHighCharts::HighChart.new('column') do |f|
      f.chart defaultSeriesType: 'column', margin: [50, 200, 60, 170]
      series = { type: 'column', name: 'Total Expenses and Revenues', data: [total_expenses, total_revenues] }
      f.series(series)
      f.options[:title][:text] = 'Total Expenses and Revenues'
      f.legend(layout: 'vertical', style: { left: 'auto', bottom: 'auto', right: '50px', top: '100px' })
      f.plot_options(pie: { allowPointSelect: true, cursor: 'pointer', dataLabels: { enabled: true, color: 'black', style: { font: '13px Trebuchet MS, Verdana, sans-serif' } } })
    end
  end
end
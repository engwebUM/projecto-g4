module ExpensesHelper
  def  expenses_pie_chart(expenses)
    name_exp = expenses.pluck('user_id', 'amount')
    name_exp.each do |ex|
      ex[0] = User.find(ex[0]).email
    end
    draw(name_exp)
  end

  def draw(name_exp)
    chart = LazyHighCharts::HighChart.new('pie') do |f|
      f.chart defaultSeriesType: 'pie', margin: [50, 200, 60, 170]
      series = {
        type: 'pie',
        name: 'Users expenses',
        data: name_exp.each
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

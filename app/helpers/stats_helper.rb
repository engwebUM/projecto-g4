module StatsHelper
  def draw_pie(chart_data, title)
    LazyHighCharts::HighChart.new('pie') do |f|
      f.chart defaultSeriesType: 'pie', margin: [50, 200, 60, 170]
      series = { type: 'pie', name: title, data: chart_data.each }
      f.series(series)
      f.options[:title][:text] = title
      f.legend(layout: 'vertical', style: { left: 'auto', bottom: 'auto', right: '50px', top: '100px' })
      f.plot
    end
  end

  def exp_rev_by_category(expenses, revenues)
    category_exp = expenses.all.group(:category_id).sum(:amount)
    category_rev = revenues.all.group(:category_id).sum(:amount)
    keys = [category_exp, category_rev].flat_map(&:keys).uniq
    category_exp_rev = (keys.map do |k|
      { Category.find(k).name => [
        {  value1: category_exp[k] || 0  },
        {  value2: category_rev[k] || 0  }] }
    end)
    category_exp_rev
  end

  def plot
    plot_options(pie: { allowPointSelect: true, cursor: 'pointer', dataLabels: { enabled: true, color: 'black', style: { font: '13px Trebuchet MS, Verdana, sans-serif' } } })
  end
end

module StatsHelper
  def create_charts
    chart_data1 = expenses_by_user
    chart_data2 = revenues_by_user
    category_exp_rev = exp_rev_by_category

    @chart1 = draw_pie(chart_data1, 'Expenses by User')
    @chart2 = draw_pie(chart_data2, 'Revenues by User')
    @chart3 = draw_bars(category_exp_rev)
    @chart4 = draw_combination(category_exp_rev)
  end

  def expenses_by_user
    chart_data1 = Expense.all.group(:user_id).sum(:amount).to_a
    chart_data1.each do |ex|
      ex[0] = User.find(ex[0]).email
    end
    chart_data1
  end

  def revenues_by_user
    chart_data2 = Revenue.all.group(:user_id).sum(:amount).to_a
    chart_data2.each do |ex|
      ex[0] = User.find(ex[0]).email
    end
    chart_data2
  end

  def exp_rev_by_category
    aux1 = Expense.all.group(:category_id).sum(:amount)
    aux2 = Revenue.all.group(:category_id).sum(:amount)
    keys = [aux1, aux2].flat_map(&:keys).uniq
    novo = (keys.map do |k|
      { Category.find(k).name => [
        {  value1: aux1[k] || 0  },
        {  value2: aux2[k] || 0  }] }
    end)
    novo
  end

  def draw_bars(hash_data)
    chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: 'Expenses and Revenues by Category')
      f.options[:xAxis][:categories] = hash_data.reduce(&:merge).keys
      f.labels(items: [html: 'Expenses and Revenues by Category', style: { left: '20px', top: '0px', color: 'black' }])
      expenses_list = []
      revenues_list = []
      id_exp_amount = []
      id_rev_amount = []
      hash_data.each do |hash|
        values = hash.to_a
        expenses_list << values[0][1][0][:value1]
        revenues_list << values[0][1][1][:value2]
        a = values[0][1][0][:value1]
        b = values[0][1][1][:value2]
        key = values[0][0]
        id_exp_amount << { name: key, y: a }
        id_rev_amount << { name: key, y: b }
      end
      f.series(type: 'column', name: 'Expenses', data: expenses_list)
      f.series(type: 'column', name: 'Revenues', data: revenues_list)
      f.series(
        type: 'pie', name: 'Total Expenses', data: id_exp_amount, center: [25, 50], size: 100, showInLegend: false,
        dataLabels: {
          enabled: false
        }
      )
      f.series(
        type: 'pie', name: 'Total Revenues', data: id_rev_amount, center: [175, 50], size: 100, showInLegend: false,
        dataLabels: {
          enabled: false
        }
      )
    end
    chart
  end

  def draw_combination(hash_data)
    LazyHighCharts::HighChart.new('graph') do |f|
      f.title(text: 'Expenses and Revenues by Category')
      f.options[:xAxis][:categories] = %w(Exp Rev)
      hash_data.each do |hash|
        values = hash.to_a
        value = values[0]
        f.series(type: 'column', name: value[0], data: [value[1][0][:value1], value[1][1][:value2]])
      end
    end
  end

  def draw_pie(chart_data, title)
    LazyHighCharts::HighChart.new('pie') do |f|
      f.chart defaultSeriesType: 'pie', margin: [50, 200, 60, 170]
      series = { type: 'pie', name: title, data: chart_data.each }
      f.series(series)
      f.options[:title][:text] = title
      f.legend(layout: 'vertical', style: { left: 'auto', bottom: 'auto', right: '50px', top: '100px' })
      f.plot_options(pie: { allowPointSelect: true, cursor: 'pointer', dataLabels: { enabled: true, color: 'black', style: { font: '13px Trebuchet MS, Verdana, sans-serif' } } })
    end
  end
end

class CategoryExpenses
  include StatsHelper
  
  def data(expenses, revenues)
    category_exp_rev = exp_rev_by_category(expenses, revenues)
    draw_two_bar(category_exp_rev)
  end

  def draw_two_bar(hash_data)
    LazyHighCharts::HighChart.new('graph') do |f|
      two_bar_options f
      hash_data.each do |hash|
        hash_element = hash.to_a
        element = hash_element[0]
        element_value = element[1]
        two_bar_series(f, element[0], [element_value[0][:value1], element_value[1][:value2]])
      end
    end
  end

  def two_bar_options(f)
    f.title(text: 'Expenses and Revenues by Category')
    f.options[:xAxis][:categories] = %w(Expenses Revenues)
  end

  def two_bar_series(f, name, data)
    f.series(type: 'column', name: name, data: data)
  end
end

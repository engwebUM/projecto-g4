class CombinationCategoryExpRev
  include StatsHelper

  def initialize
    @expenses_list = []
    @revenues_list = []
    @cat_id_exp_amount = []
    @cat_id_rev_amount = []
  end

  def data(expenses, revenues)
    category_exp_rev = exp_rev_by_category(expenses, revenues)
    draw_combination(category_exp_rev)
  end

  def draw_combination(hash_data)
    LazyHighCharts::HighChart.new('graph') do |f|
      combination_options(f, hash_data)
      hash_data.each do |hash|
        pass_value(hash.to_a.first)
      end
      combination_series(f,  @expenses_list, @revenues_list, @cat_id_exp_amount, @cat_id_rev_amount)
    end
  end

  # rubocop:enable Metrics/MethodLength, Metrics/AbcSize

  def combination_options(f, hash_data)
    f.title(text: 'Expenses and Revenues by Category')
    f.options[:xAxis][:categories] = hash_data.reduce(&:merge).keys
    f.labels(items: [html: 'Expenses and Revenues by Category', style: { left: '20px', top: '0px', color: 'black' }])
  end

  def combination_series(f, expenses_list, revenues_list, cat_id_exp_amount, cat_id_rev_amount)
    f.series(type: 'column', name: 'Expenses', data: expenses_list)
    f.series(type: 'column', name: 'Revenues', data: revenues_list)
    f.series(type: 'pie', name: 'Total Expenses', data: cat_id_exp_amount, center: [25, 50], size: 100, showInLegend: false, dataLabels: { enabled: false })
    f.series(type: 'pie', name: 'Total Revenues', data: cat_id_rev_amount, center: [175, 50], size: 100, showInLegend: false, dataLabels: { enabled: false })
  end

  private

  def pass_value(element)
    value1 = element[1][0]
    value2 = element[1][1]
    @expenses_list << value1[:value1]
    @revenues_list << value2[:value2]
    @cat_id_exp_amount << { name: element[0], y: value1[:value1] }
    @cat_id_rev_amount << { name: element[0], y: value2[:value2] }
  end
end

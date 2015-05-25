class RemoveIntegerFromExpense < ActiveRecord::Migration
  def change
    remove_column :expenses, :integer
    remove_column :expenses, :user_id
    add_column :expenses, :user_id, :integer
  end
end

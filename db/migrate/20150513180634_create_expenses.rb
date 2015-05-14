class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.date :date
      t.string :user_id
      t.string :integer
      t.integer :category_id
      t.string :description
      t.float :amount

      t.timestamps null: false
    end
  end
end

class CreateRevenues < ActiveRecord::Migration
  def change
    create_table :revenues do |t|
      t.integer :user_id
      t.date :date
      t.integer :category_id
      t.string :description
      t.float :amount

      t.timestamps null: false
    end
  end
end

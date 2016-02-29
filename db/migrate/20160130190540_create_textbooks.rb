class CreateTextbooks < ActiveRecord::Migration
  def change
    create_table :textbooks do |t|
      t.string :title, :author, :isbn
      t.decimal :price, precision: 6, scale: 2

      t.timestamps null: false
    end
  end
end

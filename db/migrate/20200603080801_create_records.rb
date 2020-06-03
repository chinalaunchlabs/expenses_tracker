class CreateRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :records do |t|
      t.references :user, foreign_key: true
      t.references :category, foreign_key: true
      t.integer :type
      t.float :amount
      t.text :notes
      t.datetime :date

      t.timestamps
    end
  end
end

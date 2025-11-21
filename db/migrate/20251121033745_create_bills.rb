class CreateBills < ActiveRecord::Migration[7.0]
  def change
    create_table :bills do |t|
      t.decimal :amount, precision: 10, scale: 2, null: false
      t.string  :bill_type, null: false
      t.string  :status, default: "pending"
      t.references :submitted_by, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end

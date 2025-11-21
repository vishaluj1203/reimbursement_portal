class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :role
      t.string :designation
      t.references :department, null: false, foreign_key: true

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end

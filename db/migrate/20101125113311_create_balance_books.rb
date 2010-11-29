class CreateBalanceBooks < ActiveRecord::Migration
  def self.up
    create_table :balance_books do |t|
      t.integer :income_id
      t.integer :expense_id
      t.integer :credit_amount
      t.integer :debit_amount
      t.integer :balance_amount

      t.timestamps
    end
  end

  def self.down
    drop_table :balance_books
  end
end

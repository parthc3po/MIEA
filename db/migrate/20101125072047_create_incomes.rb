class CreateIncomes < ActiveRecord::Migration
  def self.up
    create_table :incomes do |t|
      t.string :particular
      t.text :description
      t.integer :amount

      t.timestamps
    end
  end

  def self.down
    drop_table :incomes
  end
end

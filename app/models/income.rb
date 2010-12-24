class Income < ActiveRecord::Base

  validates_presence_of :particular, :amount, :created_at
  has_one :BalanceBook
  
end

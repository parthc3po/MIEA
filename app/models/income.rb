class Income < ActiveRecord::Base

  validates_presence_of :particular, :amount
end

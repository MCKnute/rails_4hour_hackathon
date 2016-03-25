class Transfer < ActiveRecord::Base
	has_many :lenders,  :class_name => 'User', :foreign_key => :lender_id
	has_many :borrowers, :class_name => 'User', :foreign_key => :borrower_id
end

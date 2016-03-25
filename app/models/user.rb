class User < ActiveRecord::Base
  email_regex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  has_secure_password
  validates :first_name, :last_name, :account_type, presence: true
  validates :money, presence: true, numericality: { greater_than_or_equal_to: 0.00 }
  validates :borrow_reason, :borrow_description, presence: true, if: 'account_type == 2'
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: email_regex }

end

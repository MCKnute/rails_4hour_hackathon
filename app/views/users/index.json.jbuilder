json.array!(@users) do |user|
  json.extract! user, :id, :first_name, :last_name, :email, :borrow_reason, :borrow_description, :money, :account_type
  json.url user_url(user, format: :json)
end

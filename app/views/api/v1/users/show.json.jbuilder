json.user do
  json.partial! 'indentifier_user_data', user: @user
  json.partial! 'basic_data', user: @user
end
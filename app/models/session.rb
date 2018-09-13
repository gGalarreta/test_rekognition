class Session < ApplicationRecord
  include Tokenable
  
  belongs_to :user
end

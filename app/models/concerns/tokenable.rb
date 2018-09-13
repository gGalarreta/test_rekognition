 module Tokenable

  extend ActiveSupport::Concern

  included do
    before_create :generate_access_token
  end

  protected

  def generate_access_token
    self.access_token = loop do
      random_token = SecureRandom.urlsafe_base64(32, false)
      break random_token unless self.class.exists?(access_token: random_token)
    end
  end


end
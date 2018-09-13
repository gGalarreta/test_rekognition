class User < ApplicationRecord

  #include FaceRecognition

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :sessions, dependent: :destroy


  def self.identify_user_by_image current_user
    
  end

end

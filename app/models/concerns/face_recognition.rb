module FaceRecognition

  require 'bucket'
  require 'recognition'

  extend ActiveSupport::Concern

  def recognize_user image_name
    response = Recognition.new(bucket: Bucket.new()).recognize(image_name)
  end

  #STEPS
  # 1. Create Bucket (AWS console)
  # 2. Create your AIM (AWS console)
  # 3. Create your collection
  # 4. Index images(faces) from yout aws bucket to your collection
  # 5. recognize :D

end
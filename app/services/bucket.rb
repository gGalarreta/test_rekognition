class Bucket
  attr_reader :name, :client

  def initialize(args = {})
    @client = Aws::S3::Client.new(region: ENV.fetch('AWS_REGION'))
    @name   = ENV.fetch('S3_BUCKET_NAME')
  end

  def get_objects
    client.list_objects_v2({
      bucket: name,
    })
  end
end
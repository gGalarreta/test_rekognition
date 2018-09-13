class RecognitionProcessor
  
  attr_reader :client, :collection_id

  def initialize(args = {})
    @collection_id = ENV.fetch('COLLECTION_ID')
    @client        = Aws::Rekognition::Client.new
  end

  def compare_faces_with_file(file_name)
    client.search_faces_by_image({
      collection_id: collection_id,
      face_match_threshold: 85,
      image: { 
        s3_object: {
            bucket: ENV.fetch('S3_BUCKET_NAME'), 
            name: get_name_from(file_name), 
          },
        },
      max_faces: 3,
    })
  end

  def create_collection
    client.create_collection({collection_id: collection_id}) unless collection_exists?
  end

  def collection_exists?
    client.list_collections.collection_ids.include? collection_id
  end

  def index_faces_from(bucket_objects)
    bucket_objects.contents.each do |object|
      if is_user_model(object.key)
        index_faces(object_file_name: object.key, bucket_name: bucket_objects.name)
      end
    end
  end

  private

    def index_faces(args = {})
      client.index_faces({
        collection_id: collection_id,
        detection_attributes: [
        ],
        external_image_id: get_name_from(args[:object_file_name]),
        image: {
          s3_object: {
            bucket: args[:bucket_name],
            name: args[:object_file_name],
          },
        },
      })
    end

    def is_user_model file_name
      model = file_name.split("/")[0]
      model == "users"
    end

    def get_name_from file_name
      #image_structure = Model/field/###/###/###/size/name
      file_name = file_name.split("/")[6]
      file_name.gsub(/\.(.*)/, '')
    end

end
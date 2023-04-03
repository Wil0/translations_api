module ResponseHandler
  OK_STATUS = :ok

  def serialize_object(object:, serializer:, status: OK_STATUS)
    render json: object, status:, serializer:
  end

  def serialize_collection(collection:, serializer:, status: OK_STATUS)
    render json: collection, status:, each_serializer: serializer
  end
end

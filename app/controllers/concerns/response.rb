module Response
  def json_response(object, status = :ok,message)
    render json: { status: status, message: message, data: object }
  end
end

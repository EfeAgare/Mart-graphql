module ErrorMessage
  private

  def unprocessable_entity(e = nil)
    raise GraphQL::ExecutionError.new(
      "Unprocessable entity", options: { status: :unprocessable_entity, 
      code: 422, message: e })
  end

  def unauthorized(e = nil)
    raise GraphQL::ExecutionError.new(
      "Unauthorized", options: { status: :unauthorized, 
      code: 401, message: e })
  end

  def conflict(e = nil)
    raise GraphQL::ExecutionError.new(
      "Conflict", options: {status: :conflict, 
      code: 409, message: e })
  end

  def bad_request(e = nil)
    raise GraphQL::ExecutionError.new(
      "Bad Request", options: { status: :bad_request,
      code: 400, message: e })
  end

  def not_found(e = nil)
    raise GraphQL::ExecutionError.new(
      "Not Found", options: { status: :not_found,
       code: 404, message: e })
  end
end

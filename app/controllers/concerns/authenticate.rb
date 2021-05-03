module Authenticate
  def current_user
    return @current_user if @current_user
    header = request.headers['Authorization']
    return nil if header.nil?
    decoded = JsonWebToken.decode(header)

    @current_user = User.find(decoded[:user_id]) rescue
      ActiveRecord::RecordNotFound
    # custome error
  rescue JWT::ExpiredSignature
    raise ExceptionHandler::ExpiredSignature
  end

  private
  def authenticate_user
    render json: {message: "Not authenticated"}, status: :forbidden unless self.current_user
  end

end
class AuthorizeApiRequest
  prepend SimpleCommand

  def initialize(headers = {})
    @headers = headers
  end

  def call
    # returns the user at the end if successful
    user
  end

  private

  # Enables the @headers instance variable to be accessed as `headers` below
  attr_reader :headers

  def user
    # Gets the user from the decoded payload (containing user_id)
    @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
    @user || errors.add(:token, "Invalid token") && nil
  end

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  def http_auth_header
    if headers["Authorization"].present?
      return headers["Authorization"].split(" ").last
    else
      errors.add(:token, "Missing token")
    end
  end
end

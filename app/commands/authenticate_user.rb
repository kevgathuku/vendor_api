class AuthenticateUser
  prepend SimpleCommand

  def initialize(email, password)
    # Takes in the user supplied credentials here...
    @email = email
    @password = password
  end

  def call
    # ... and returns a token if successful
    JsonWebToken.encode(user_id: user.id) if user
  end

  private

  attr_accessor :email, :password

  def user
    user = User.find_by_email(email)
    # Checks the provided password
    return user if user && user.authenticate(password)

    errors.add :user_authentication, "invalid credentials"
    nil
  end
end

module Authenticable

  # Devise methods overwrites
  def current_user
    @current_user ||= User.find_by(auth_token: request.headers["Authorization"])
  end

  def authenticate_with_token!
    render json: { errors: "Not authenticated" },
      status: :unauthorized unless current_user.present?
  end

  def user_signed_in?
    current_user.present?
  end

  def admin_user
    render json: { errors: "Unathorized" },
      status: :unauthorized unless current_user.admin?
  end

  def generate_confirmation_token!
    begin
      self.confirmation_token = Devise.friendly_token
    end while self.class.exists?(confirmation_token: confirmation_token)
  end
end

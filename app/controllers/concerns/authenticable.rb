# app/controllers/concerns/authenticable.rb
module Authenticable
  # Devise methods overwrites
  def current_user
    @current_user ||= User.find_by(auth_token: request.headers['Authorization'])
  end

  def authenticate_with_token!
    unless current_user.present?
      render json: { errors: 'Not authenticated' },
             status: :unauthorized
    end
  end
end

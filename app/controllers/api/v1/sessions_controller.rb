class Api::V1::SessionsController < ApiController
  skip_before_action :validate_credentials, only: [:login]
  
  # POST /api/v1/sessions/login.json
  def login
    email    = params[:email]
    password = params[:password]
    @user = User.find_by_email(email)
    
    if @user.nil?
      render json: { message: 'El usuario no existe' }, status: :not_found
    else
      if @user.valid_password?(password)
        @user.update_attribute(:authentication_token, Devise.friendly_token)
        render 'api/v1/users/user'
      else
        render json: { message: 'Credenciales inválidas' }, status: :not_found
      end
    end
  end

  # DELETE /api/v1/sessions/logout.json
  def logout
    current_user.update_attribute(:authentication_token, nil)
    render json: { message: 'Sesión terminada'}, status: :ok
  end
end

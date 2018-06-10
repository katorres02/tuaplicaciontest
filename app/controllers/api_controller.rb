class ApiController < ApplicationController
  # El método protect_from_forgery del ApplicationController
  # se usa para prevenir ataques de cookieas pero en una API,
  # no es tan relevante ya qu eno estamos usando cookies
  #
  # Entonces se elimina el llamado a ese métdo solo para los controladores
  # que hereden del ApiController
  skip_before_action :verify_authenticity_token

  # indicamos que todos los controladores que hereden del ApiController
  # funcionen con autenticación de token, si algún endpoint
  # no requiera esta actualización se hace un skip del método específico
  before_action :validate_credentials

  # retorna el usuario autenticado de la peticion de la api
  def current_user
    @current_user
  end

  private

  # valida las credenciales y retorna el usuario que esta haciendo el request
  def validate_credentials
    email = request.headers['X-User-Email'] || params[:user_email]
    token = request.headers['X-User-Token'] || params[:user_token]
    
    @current_user = User.find_by(email: email, authentication_token: token)
    
    if @current_user.nil?
      return render json: { message: 'Credenciales inválidas' }, status: :not_found
    end
  end
end

class Api::V1::UsersController < ApiController
	skip_before_action :validate_credentials, only: [:create]
  
  # GET /api/v1/users/1.json
  def show
  	@user = current_user
  	render 'user' # renderizar el json usando RABL
  end

  # POST /api/v1/users.json
  def create
    @user = User.new(user_params)
    if @user.save
      render 'user' # renderizar el json usando RABL
    else
      render json: { message: 'Error creando usuario', 
        causes: @user.errors.full_messages }, status: :not_found
    end
  end

  # PATCH/PUT /api/v1/users/1.json
  def update
  	if @user.update(user_params)
      render 'user' # renderizar el json usando RABL
    else
      render json: { message: 'Error al editar',
        causes: @user.errors.full_messages }, status: :not_found
    end
  end

  # PATCH/PUT /api/v1/users.json
  def destroy
  	@user.destroy
  	render json: { message: 'Registro eliminado' }, status: :ok
  end

  private

	  # parámetros fuertes
	  def user_params
	  	params.require(:user).permit(:id, :first_name, :second_name,
	  	:last_name, :maiden_name, :email, :password)
	  end

	  # setear el usuario
	  def set_user
	  	@user = User.find(params[:id])
      if @user.nil?
        return render json: { message: 'No existe ese usuario' }, status: :not_found
      end
	  end
end

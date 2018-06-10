class Api::V1::InterestsController < ApiController
  before_action :set_user, only: :index
  before_action :set_interest, only: [:show, :update, :destroy]

  # GET /api/v1/users/{ID}/interests.json
  def index
    @interest = @user.interests
    render 'interest'
  end

  # GET /api/v1/users/{ID}/interests/1.json
  def show
  	render 'interest'
  end

  # POST /api/v1/users/{ID}/interests.json
  def create
  	@interest = @user.interests.new(interest_params)
  	if @interest.save
  		render 'interest' # renderizar el json usando RABL
  	else
  		render json: { message: 'Error creando registro', 
  			causes: @interest.errors.full_messages }, status: :not_found
  	end
  end

  # PATCH/PUT /api/v1/users/{ID}/interests/1.json
  def update
    if @interest.update(interest_params)
      render 'interest'
    else
      render json: { message: 'Error al editar',
        causes: @interest.errors.full_messages }, status: :not_found
    end
  end

  # DELETE /api/v1/users/{ID}/interests/1.json
  def destroy
    @interest.destroy
    render json: { message: 'Registro eliminado' }, status: :ok
  end

  private

    # setear el usuario dueño de los registros
    def set_user
      @user = User.find(params[:user_id])
      if @user.nil?
        return render json: { message: 'No existe ese usuario' }, status: :not_found
      end
    end

    # setear el interes específico a usar
    def set_interest
      @interest = Interest.find(params[:id])
      if @interest.nil?
        return render json: { message: 'No existe ese registro' }, status: :not_found
      end
    end

    # parámetros fuertes
    def interest_params
    	params.require(:interest).permit(:id, :name)
    end
end

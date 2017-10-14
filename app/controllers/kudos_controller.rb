class KudosController < ApplicationController
  # GET /kudos
  def index
    if params["user"].present?
      @chosen_user = User.where(id: params["user"]["id"]).take
      @receiving_users = User.where.not(id: @chosen_user.id)
      @received_kudos = @chosen_user.kudos_received.paginate(:page => params[:page], :per_page => 6)
    end

    @users = User.all
    respond_to do |format|
      format.html
    end
  end

  def show
    @user = User.find(params[:id])
    @kudos = @user.kudos_received
    render json: @kudos, status: :ok
  end

  # POST /kudos
  def create
    @kudo = Kudo.create!(kudo_params)
    redirect_back fallback_location: root_path, notice: 'Kudo sent. Thanks!'
  end

  # DELETE /kudos/:id
  def destroy
    Kudo.find(params[:id]).destroy
    head :no_content
  end

  private

  def kudo_params
    params.require(:kudo).permit(:text, :giver_id, :receiver_id)
  end
end

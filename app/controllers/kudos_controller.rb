class KudosController < ApplicationController
  # GET /kudos
  def index
    @receiving_users = User.where.not(id: current_user.id)
    @received_kudos = current_user.kudos_received.paginate(:page => params[:received_page], :per_page => 3)
    @given_kudos = current_user.kudos_given.paginate(:page => params[:given_page], :per_page => 3)

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
  rescue ActiveRecord::RecordInvalid => e
    redirect_to kudos_path, :alert => "Sorry...unable to give a kudo: #{e.message}"
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

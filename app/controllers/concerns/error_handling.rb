module ErrorHandling
  extend ActiveSupport::Concern

  included do 
    rescue_from ActiveRecord::RecordNotFound do |e|
      render json: { message: e.message }, status: :not_found
    end

    rescue_from ActiveRecord::RecordInvalid, ActiveRecord::StatementInvalid do |e|
      render json: { message: e.message }, status: :unprocessable_entity
    end
  end
end
class ApplicationController < ActionController::API
  def not_found(exception)
    render json: { errors: "#{exception.model} record not found with the attributes provided" }, status: 422
  end

  def show_record_errors(exception)
    render json: { errors: exception.record.errors.full_messages.to_sentence }, status: 422
  end
end

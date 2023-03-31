class ApplicationController < ActionController::API
  def not_found(_exception)
    render json: { errors: 'Record not found' }, status: 422
  end

  def show_record_errors(exception)
    render json: { errors: exception.record.errors.full_messages.to_sentence }, status: 422
  end
end

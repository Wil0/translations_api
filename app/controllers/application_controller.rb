class ApplicationController < ActionController::API
  include ResponseHandler
  include ExceptionsHandler

  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActiveRecord::RecordInvalid, with: :show_record_errors
end

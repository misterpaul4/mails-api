class ApplicationController < ActionController::API
  def not_found
    render json: { error: 'not_found' }
  end

  # def current_user
  #   @current_user = User.find_by_username!(params[:_username])
  # end
end

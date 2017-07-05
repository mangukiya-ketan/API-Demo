class Api::ApplicationController < ActionController::API
  include Response

  # before_action :authenticate_user
  #
  # def authenticate_user
  #   if request.headers["Authorization"].blank?
  #     json_response({},401,'no_token')
  #   else
  #     json_response({},401,'unauthorized')
  #   end
  # end
  def csrf_required?
    params[:api_key].blank?
  end
end

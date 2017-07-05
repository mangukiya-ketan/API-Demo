class Api::V1::UsersController < Api::ApplicationController
before_action :set_user, only: [:show, :edit, :update, :destroy]

  api :GET, 'users', "Shows list of User"
  error :code => 200, :desc => "Success"
  error :code => 401, :desc => "Unauthorized"
  error :code => 404, :desc => "Not Found"

  def index
    begin
      @users = User.all
      render json: @users
    rescue Exception => e
      json_response({}, 400, 'something_went_wrong')
    end
  end

  api :GET, 'users/:id', "Show user"
  error :code => 200, :desc => "Success"
  error :code => 401, :desc => "Unauthorized"
  error :code => 404, :desc => "Not Found"

  def show
    begin
      json_response(@user, 200, "user #{params[:id]}")
    rescue Exception => e
      json_response({}, 400, 'something_went_wrong')
    end
  end

  api :POST, 'users', "Creating User"
  param :user, Hash do
    param :name, String, desc: "user Namw"
    param :email, String, desc: "user email"
  end
  error :code => 200, :desc => "Success"
  error :code => 401, :desc => "Unauthorized"
  error :code => 404, :desc => "Not Found"
  def create
    begin
        @user = User.create(user_params)
        json_response(@user, 201, 'add_user')
    rescue Exception => e
        json_response({}, 400, t('something_went_wrong'))
    end
  end

  def edit
  end
  api :PATCH, 'users/:id', "Editing User"
  param :user, Hash do
    param :name, String, desc: "User Name"
    param :email, String, desc: "User Email"
  end
  error :code => 201, :desc => "Created"
  error :code => 401, :desc => "Unauthorized"
  error :code => 404, :desc => "Not Found"

  def update
    begin
      @user.update(user_params)
      json_response(@user, 201, 'User Updated Successfully')
    rescue Exception => e
      json_response({}, 400, t('something_went_wrong'))
    end
  end

api :DELETE, "users/:id", "Deleting User"
error :code => 200, :desc => "Success"
  error :code => 401, :desc => "Unauthorized"
  error :code => 404, :desc => "Not Found"
  def destroy
    begin
      @user.destroy
      json_response({},200, "User Deleted Successfully")
    rescue Exception => e
      json_response({},400, "something_went_wrong")

    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find_by(id: params[:id])
    end
  def user_params
    params.require(:user).permit(:name, :email)
  end
end

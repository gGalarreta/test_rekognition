class Api::V1::UsersController < Api::ApiV1Controller

  skip_before_action :verify_current_user, only: [:create]

  def create
    begin
      @user = User.new user_params
      if @user.save
        render :user
      else
        response_error(title: 'Could not register', reasons: @user.errors.messages, description: "There are invalid values", status_code: 422)
      end
    rescue Exception => e
      render json: { message: e}
    end
  end

  def me
    begin
      @user = current_user
      render :me
    rescue Exception => e
      render json: { message: e}
    end
  end

  def update
    begin
      @user = current_user
      if @user.update_attributes user_data_params
        render :show
      else
        response_error(title: 'Could not update', reasons: @user.errors.messages, description: "There are invalid values", status_code: 422)
      end
    rescue Exception => e
      render json: { message: e}
    end
  end

  def recognition
    begin
      @user = User.identify_user_by_image(current_user)
      if @user
        render :recognition
      else
        render json: { message: 'You are not in our database'}
      end
    rescue Exception => e
      render json: { message: e}
    end
  end

  private

    def user_params
      params.require(:user).permit(:email, :password)
    end

    def user_data_params
      params.require(:user).permit(:first_name, :last_name, :email)
    end


end

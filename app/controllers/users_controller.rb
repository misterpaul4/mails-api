class UsersController < ApplicationController
  before_action :set_user, only: %i[show update destroy messages received_messages unread_messages inbox]

  def index
    @users = User.all

    render json: @users
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: @user
  end

  # most recent messages (sent or received)
  def inbox
    allMessages = @user.messages + @user.received_message
    sortedMessages = allMessages.sort_by {|msg| msg[:updated_at]}.reverse
    messages = sortedMessages.uniq {|msg| msg[:creator_id]}

    render json: messages
  end

  # sent messages  
  def messages
    @messages = @user.messages

    render json: @messages
  end

  # received messages
  def received_messages
    @messages = @user.received_message

    render json: @messages
  end

  # unread messages count
  def unread_messages
    @messages = @user.unread_messages.count

    render json: @messages
  end

  # PATCH/PUT /users/username
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/username
  def destroy
    @user.destroy
  end

  private

  def set_user
    @user = User.find_by_username!(params[:_username])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'User not found' }, status: :not_found
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.permit(:username)
  end
end

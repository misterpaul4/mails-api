class MessagesController < ApplicationController
  before_action :set_message, only: %i[show update destroy]
  before_action :find_creator, only: %i[create]
  before_action :find_receiver, only: %i[create]

  def index
    @messages = Message.all

    render json: @messages
  end

   # POST /messages
   def create
    @message = Message.new(creator_id: @creator.id, subject: message_params[:subject], read: false, content: message_params[:content])

    if @message.save
      Receiver.create(received_message_id: @message.id, receiver_id: @receiver.id)
      render json: @message, status: :created, location: @message
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  # GET /messages/1
  def show
    @message.read = true
    @message.save
    render json: @message
  end

  # PATCH/PUT /messages/1
  def update
    if @message.update(message_params)
      render json: @message
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

    # DELETE /messages/1
    def destroy
      @message.destroy
    end

    private

    def set_message
      @message = Message.find(params[:id])
    end

    def find_receiver
      @receiver = User.find_by_username!(params[:recipient]);
      rescue ActiveRecord::RecordNotFound
        render json: { errors: 'recipient not found' }, status: :not_found
    end

    def find_creator
      @creator = User.find_by_username!(params[:sender]);
      rescue ActiveRecord::RecordNotFound
        render json: { errors: 'sender not found' }, status: :not_found
    end
  
    # Only allow a list of trusted parameters through.
    def message_params
      params.permit(:subject, :content, :read, :sender, :recipient)
    end
end

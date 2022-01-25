class MessagesController < ApplicationController
  before_action :set_message, only: %i[show update destroy]

  def index
    @messages = Message.all

    render json: @messages
  end

   # POST /messages
   def create
    @message = Message.new(message_params)

    if @message.save
      render json: @message, status: :created, location: @message
    else
      render json: @message.errors, status: :unprocessable_entity
    end
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
  
    # Only allow a list of trusted parameters through.
    def message_params
      params.permit(:subject, :content, :flag)
    end
end

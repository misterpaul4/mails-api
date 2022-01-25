class ReceiversController < ApplicationController
  before_action :set_receiver, only: %i[show update destroy]

  def index
    @receivers = Receiver.all

    render json: @receivers
  end

  def show;
    render json: @receiver
  end

  def create
    @receiver = Receiver.new(receiver_params)

    if @receiver.save
      render json: @receiver, status: :created, location: @receiver
    else
      render json: @receiver.errors, status: :unprocessable_entity
    end
  end

  def update
    if @receiver.update(receiver_params)
      render json: @receiver
    else
      format.html { render :edit }
      render json: @receiver.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @receiver.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_receiver
    @receiver = Receiver.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def attendance_params
    params.permit(:receiver, :received_message)
  end
end

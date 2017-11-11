class MessagesController < ApplicationController
  def show
    @message = message_id
    render layout: false
  end

  private
  def message_id
    MessagePresenter.new(Message.find(params[:id]))
  end
end

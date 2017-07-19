class ConversationsController < ApplicationController
  def index
    @conversations = current_user.mailbox.conversations
    @profile = current_user.profile
  end

  def show
    @conversation = current_user.mailbox.conversations.find(params[:id])
  end

  def new
    @recipients = current_user.friends
  end

  def create
    @recipient = User.find(params[:user_id])
    receipt = current_user.send_message(@recipient, params[:body], params[:subject])
    redirect_to conversation_path(receipt.conversation)
  end
end

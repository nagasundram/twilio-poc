class MessagesController < ApplicationController
skip_before_action :verify_authenticity_token
  def send_sms
    @from = Rails.application.secrets.twilio_number
    @to = params[:to]
    @body = params[:message]
    $twilio.account.messages.create({:from => @from, :to => @to, :body => @body})
    Message.create({from: @from, to: @to, body: @body})
    flash[:notice] = "Message Sent"
    redirect_to root_path
  end

  def reply
    @reply = params["Body"]
    @from = params["From"]
    @twilio = Rails.application.secrets.twilio_number
    @body = "Hello there, thanks for texting me. Your number is #{@from}."
    $twilio.messages.create({from: @twilio, to: "+#{@from}", body: @body})
    Message.create({from: "+#{@from}", to: @twilio, body: @reply})
  end

end
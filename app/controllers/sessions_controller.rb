require "twilio-ruby"
class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(username: params[:session][:username])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      redirect_to menu_path
      send_text_message
      flash[:success] = "YeeHaw! #{@user.username} is signed in!"
    else
      redirect_to login_path
      flash[:danger] = "Sorry m'friend. You go HUNGRY!"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def send_text_message
    # number_to_send_to = params[:number_to_send_to]
    send_to = "+17203817045"
    # twilio_phone_number = ENV['TWILIO_NUMBER']

    # twilio_sid = ENV["ACb2541d8ffb09ffa80ce1d20942c2f7e5"]
    # twilio_token = "a28b9f64e660c48aeca21792cccb2ace"
    twilio_phone_number = "7205063562"

    @twilio_client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token

    @twilio_client.account.sms.messages.create(
      :from => "+1#{twilio_phone_number}",
      :to => send_to,
      :body => "Hello yo"
    )
  end
end

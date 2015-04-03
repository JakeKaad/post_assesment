class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts
  has_many :comments

  def send_message(body)
    response = RestClient::Request.new(
      method: :post,
      url: "https://api.twilio.com/2010-04-01/Accounts/#{ENV['TWILIO_ACCOUNT_SID']}/SMS/Messages.json",
      user: ENV['TWILIO_ACCOUNT_SID'],
      password: ENV['TWILIO_AUTH_TOKEN'],
      payload: {
        Body: body,
        To: self.phone_number,
        From: '(971) 717-2870'
      }
    ).execute
  end
end

# frozen_string_literal: true

class TwilioClient
  attr_reader :client

  def initialize
    @client = Twilio::REST::Client.new 'AC676d05fc0c6fa39fa329706c688a53ed', '22f0fb73b30f173d6630385be589a4ee'
  end

  def send_text(user, token)
    @client.messages.create(
      from: '+13308594745',
      to: user.contact,
      body: "Hey there! #{user.first_name} #{user.last_name} Your confirmation code is #{token}"
    )
  end
end

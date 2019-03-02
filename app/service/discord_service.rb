# frozen_string_literal: true
require 'net/http'

# This class processes messages from discord
class DiscordService
  class << self
    def send_message(chan, msg)
      port = 3000
      host = ENV['DISCORD_HOSTNAME']
      path = '/messages'

      http = Net::HTTP.new(host, port)
      data = { message: msg, channel_id: chan.to_s }
      response = http.send_request(
        'PUT',
        path,
        JSON.dump(data),
        'Content-Type' => 'application/json'
      )
      response.code.to_s == '200'
    end

    def id
      548797370725433344
    end
  end
end

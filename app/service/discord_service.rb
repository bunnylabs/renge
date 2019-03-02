# frozen_string_literal: true

require 'net/http'

# This class processes messages from discord
class DiscordService
  class << self
    def send_message(chan, msg)
      response = call_bot('PUT', '/messages',
                          message: msg,
                          channel_id: chan.to_s)
      response.code.to_s == '200'
    end

    def id
      @id ||= request_id.to_s
    end

    private

    def request_id
      response = call_bot('GET', '/id')
      parsed = JSON.parse(response.body)
      parsed['id']
    end

    def call_bot(method, path, data = {})
      port = 3000
      host = ENV['DISCORD_HOSTNAME']

      http = Net::HTTP.new(host, port)
      response = http.send_request(
        method,
        path,
        JSON.dump(data),
        'Content-Type' => 'application/json'
      )
      response
    end
  end
end

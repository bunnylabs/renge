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
      @id ||= request(:id).to_s
    end

    def username
      @username ||= request(:username).to_s
    end

    private

    def request(thing)
      response = call_bot('GET', "/#{thing}")
      parsed = JSON.parse(response.body)
      parsed[thing.to_s]
    end

    def call_bot(method, path, data = {})
      port = 3000
      host = ENV['DISCORD_HOSTNAME']

      http = Net::HTTP.new(host, port)
      response = http.send_request(
        method,
        path,
        data.to_json,
        'Content-Type' => 'application/json'
      )
      response
    end
  end
end

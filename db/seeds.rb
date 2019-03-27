# frozen_string_literal: true

Admin.create(
  email: 'admin@example.com',
  password: 'asdasd'
)

GodPlayer.create(
  player: Player.create(
    chat_source: 'discord',
    user_key: '122908555178147840'
  ),
  god: God.create(
    active: true
  )
)

GodPlayer.create(
  player: Player.create(
    chat_source: 'slack',
    user_key: 'U1V26HDRD'
  ),
  god: God.create(
    active: true
  )
)

BotPlayer.create(
  player: Player.create(
    chat_source: 'discord',
    user_key: '446630531124428801'
  ),
  bot: Bot.create(
    bot_password: 'discordbot',
    active: true,
    response_auth_document: {
      host: ENV['DISCORD_HOSTNAME'],
      port: 3000
    }
  )
)

BotPlayer.create(
  player: Player.create(
    chat_source: 'slack',
    user_key: 'UGR11AJ4V'
  ),
  bot: Bot.create(
    bot_password: 'slackbot',
    active: true,
    response_auth_document: {
      token: ENV['SLACK_TOKEN']
    }
  )
)

%w[
  Takumi
  Mizuki
  Amy
  Brian
  Joanna
  Matthew
  Kendra
  Joey
  Kimberly
  Justin
  Salli
].each { |x| Seiyuu.create(name: x) }

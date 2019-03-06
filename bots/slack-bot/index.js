const { RTMClient, WebClient } = require('@slack/client');
const { URL } = require('url');
const proto = {
  'http:': require('http'),
  'https:': require('https')
}
// The initialization code shown above is skipped for brevity

// An access token (from your Slack app or custom integration - usually xoxb)
const SLACK_TOKEN = process.env.SLACK_TOKEN;
const RAILS_ENDPOINT = process.env.RAILS_ENDPOINT || "http://rails:3000/api/v1/slack"

// The client is initialized and then started to get an active connection to the platform
const rtm = new RTMClient(SLACK_TOKEN);
const web = new WebClient(SLACK_TOKEN);

rtm.start();

rtm.on('message', async (message) => {
  // For structure of `message`, see https://api.slack.com/events/message

  // Skip messages that are from a bot or my own user ID
  //if ( (message.subtype && message.subtype === 'bot_message') ||
  //     (!message.subtype && message.user === rtm.activeUserId) ) {
  //  return;
  //}

  if (message.type !== 'message')
  {
  	return;
  }

  var user = await web.users.info({user: message.user});
  var conversation = await web.conversations.info({channel: message.channel});
  var team = await web.team.info();

  var files = [];
  if (message.files)
  {
  	files = message.files.map(function(attachment)
    {
      return {
        id:            attachment.id,
        filename:      attachment.name,
        filesize:      attachment.size,
        url:           attachment.url_private_download,
        proxy_url:     attachment.url_private_download,
        is_image:      attachment.mimetype.indexOf('image') != -1
      };
    });
  }

  var message_info = {
    author_id:       message.user,
    author_username: user.user.name,
    author_is_bot:   message.subtype === 'bot_message',

    room_type:       conversation.channel.is_channel ? 'room' : 'dm',
    room_id:         message.channel,
    room_name:       conversation.channel.name,

    created_at:      message.event_ts,
    edited_at:       message.event_ts,

    server_id:       message.team,
    server_name:     team.team.name,

    attachments:     files,

    message:         message.text
  }

  var url = new URL(RAILS_ENDPOINT);

  var post_data = JSON.stringify(message_info);

  var post_options = {
      host: url.hostname,
      port: url.port,
      path: url.pathname,
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Content-Length': Buffer.byteLength(post_data)
      }
  };

  // console.log("[MSG]", post_options);
  
  const req = proto['http:'].request(post_options, function(res) {
    res.setEncoding('utf8');
    res.on('data', function (chunk) {
      console.log('[RES]', chunk);
    });
  });

  req.write(post_data);
  req.end();

  req.on('error', (e) => {
    console.error("[ERR]", `problem with request: ${e.message}`);
  });

  console.log("[MSG]", message_info);
});

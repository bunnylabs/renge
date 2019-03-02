const Discord = require('discord.js');
const Icy = require('icy');
const client = new Discord.Client();
const WebSocket = require('ws');
const express = require('express');
const fs = require('fs');
const bodyParser = require('body-parser');
const ytdl = require('ytdl-core');
const XMLHttpRequest = require("xmlhttprequest").XMLHttpRequest;
const { URL } = require('url');
const proto = {
  'http:': require('http'),
  'https:': require('https')
}
const fileType = require('file-type');
var jsmediatags = require("jsmediatags");

const BOT_TOKEN = process.env.BOT_TOKEN
const RAILS_ENDPOINT = process.env.RAILS_ENDPOINT || "http://rails:3000/api/v1/discord"
const API_PORT = process.env.API_PORT || 3000;

// Send message to channel
function send(channel /*... and arguments*/)
{
  try
  {
    var message = "[" + new Date() + "]";
    for (var idx in arguments)
    {
      if (idx == 0) { continue; }
      message += " "
      message += arguments[idx]
    }
    channel.send(message);
  }
  catch (e)
  {
    console.log("[ERR]", "Sending message to channel:", e)
    setTimeout(() => {
      process.exit();
    }, 100);
  }
}

function find_channel(client, chan_id, on_success, on_failure)
{
  var channels = [];

  client.guilds.map( (g) => {
    g.channels.
      filter( (c) => { return chan_id.indexOf(c.id) != -1; } ).
      map ( (c) => { channels.push(c) } );
  });

  if (channels.length == 1)
  {
    on_success(channels[0]);
  }
  else
  {
    setTimeout( function(){ find_channel(client, chan_id, on_success, on_failure); }, 10);
  }
}

function not_find_chan(chan)
{
  console.log("[ERR]", "Could not find channel", chan_id)
}

function start_html_server(client) {
  const app = express();

  app.use(bodyParser.json());

  app.put('/messages', (req, res) => {
    console.log('[INF]', 'Send message:', '<#'+req.body.channel_id+'>', req.body.message);
    client.channels.get(req.body.channel_id).send(req.body.message);
    res.send(JSON.stringify({result: 'ok'}))
  });

  app.get('/id', (req, res) =>{
    res.send(JSON.stringify({result: 'ok', id: client.user.id}))
  });
  
  app.get('/username', (req, res) =>{
    res.send(JSON.stringify({result: 'ok', username: client.user.username}))
  });

  app.all('/public/*', (req, res) => {
    var reply = "somereply";
    console.log('[INF]', 'API Called');
    res.send(reply)
  });

  app.listen(API_PORT, () => {
    console.log('[INF]', 'API listening on port', API_PORT);
  })
}

client.on('ready', () => {
  console.log("[INF]", "Bot connected");
  start_html_server(client);
});


client.on('message', message => {
  var message_info = {
    author_id:       message.author.id,
    author_username: message.author.username,
    author_is_bot:   message.author.bot,

    room_type:       message.channel.type,
    room_id:         message.channel.id,
    room_name:       message.channel.name,

    created_at:      message.createdTimestamp,
    edited_at:       message.editedTimestamp,

    attachments:     message.attachments.map(function(attachment)
    {
      return {
        id:            attachment.id,
        filename:      attachment.filename,
        filesize:      attachment.filesize,
        url:           attachment.url,
        proxy_url:     attachment.proxyURL,
        is_image:      attachment.height ? true : false
      };
    }),

    message:         message.content

  }

  if (message.member && message.member.guild)
  {
    message_info.server_id   = message.member.guild.id;
    message_info.server_name = message.member.guild.name; 
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

client.login(process.env.BOT_TOKEN);

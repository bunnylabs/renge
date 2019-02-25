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
const RAILS_ENDPOINT = process.env.RAILS_ENDPOINT || "http://rails/api/v1"
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
  console.log("could not find channel", chan_id)
}

function start_html_server() {
  const app = express();

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
  start_html_server();
});


client.on('message', message => {
  console.log("[MSG]", message.author, message.content);
});

client.login(process.env.BOT_TOKEN);

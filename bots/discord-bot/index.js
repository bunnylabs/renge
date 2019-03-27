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
const Kuroshiro = require("kuroshiro");
const KuromojiAnalyzer = require("kuroshiro-analyzer-kuromoji");


const AWS = require('aws-sdk');

const DISCORD_TOKEN = process.env.DISCORD_TOKEN
const RAILS_ENDPOINT = process.env.RAILS_ENDPOINT || "http://rails:3000/api/v1/chat/discord"
const API_PORT = process.env.API_PORT || 3000;

const Polly = new AWS.Polly({
  region: 'ap-northeast-1'
})

const heerargunner = {

  "きょう":"kyoh",
  "ぎょう":"gyoh",
  "ひょう":"he oh",
  "びょう":"be oh",
  "ぴょう":"pee oh",
  "みょう":"me oh",
  "にょう":"neo",
  "りょう":"leo",

  "ああ":"aah",
  "あい":"eye",
  "あう":"ow",
  "いあ":"ya",
  "いい":"yee",
  "いう":"you",
  "いえ":"yeh",
  "いお":"yo",
  "うあ":"wah",
  "うえ":"way",
  "うい":"we",
  "うう":"woo",
  "うお":"wow",
  "おあ":"oar",
  "おう":"oh",
  "おお":"oh",

  "かあ":"car",
  "かい":"khai",
  "かう":"cow",

  "こう":"co",

  "さあ":"saar",
  "さい":"sigh",
  "せい":"say",

  "しん":"shin",
  "シン":"shin",
  "じん":"jean",
  "ジン":"jean",

  "たあ":"tar",
  "たい":"thigh",
  "たう":"tau",
  "たお":"tao",

  "です":"days",

  "はあ":"haa",
  "はい":"high",
  "はう":"how",
  "はお":"how",

  "ばあ":"baa",
  "ばい":"bye",
  "ばう":"bow",
  "ばお":"bow",

  "ぱあ":"par",
  "ぱい":"pie",
  "ぱう":"pow",
  "ぱお":"pow",


  "きゃ":"kyuh",
  "きゅ":"kewl",
  "きょ":"kyoh",
  "ぎゃ":"gyuh",
  "ぎゅ":"giew",
  "ぎょ":"gyoh",
  "ちゃ":"chuh",
  "ちゅ":"chew",
  "ちょ":"chou",
  "しゃ":"shuh",
  "しゅ":"shew",
  "しょ":"show",
  "じゃ":"jar",
  "じゅ":"jew",
  "じょ":"joe",
  "みゃ":"me uh",
  "みゅ":"me you",
  "みょ":"me yo",
  "にゃ":"knee uh",
  "にゅ":"knew",
  "にょ":"knee yo",
  "ひゃ":"he arh",
  "ひゅ":"he you",
  "ひょ":"he your",
  "びゃ":"be arh",
  "びゅ":"bew",
  "びょ":"be oh",
  "ぴゃ":"peer",
  "ぴゅ":"pew",
  "ぴょ":"pee oh",
  "りゃ":"leah",
  "りゅ":"lew",
  "りょ":"lee yo",

  "キャ":"kyuh",
  "キュ":"kewl",
  "キョ":"kyoh",
  "ギャ":"gyuh",
  "ギュ":"giew",
  "ギョ":"gyoh",
  "チャ":"chuh",
  "チュ":"chew",
  "チョ":"chou",
  "シャ":"shuh",
  "シュ":"shew",
  "ショ":"show",
  "ジャ":"jar",
  "ジュ":"jew",
  "ジョ":"joe",
  "ミャ":"me uh",
  "ミュ":"me you",
  "ミョ":"me yo",
  "ニャ":"knee uh",
  "ニュ":"knew",
  "ニョ":"knee yo",
  "ヒャ":"he arh",
  "ヒュ":"he you",
  "ヒョ":"he your",
  "ビャ":"be arh",
  "ビュ":"bew",
  "ビョ":"be oh",
  "ピャ":"peer",
  "ピュ":"pew",
  "ピョ":"pee oh",
  "リャ":"leah",
  "リュ":"lew",
  "リョ":"lee yo",

  "てぃ":"tee",
  "でぃ":"dee",
  "とぅ":"too",
  "とゅ":"too",
  "すぃ":"see",
  "ティ":"tee",
  "ディ":"tee",
  "トゥ":"too",
  "トュ":"too",
  "スィ":"see",
  "ふぁ":"far",
  "ふぃ":"fee",
  "ふぉ":"for",
  "ファ":"far",
  "フィ":"fee",
  "フォ":"for",
  "ヴ":"view",
  "ヴぃ":"vee",
  "ヴァ":"var",
  "ヴォ":"vough",

  "じぇ":"jay",
  "ちぇ":"chay",
  "ジェ":"jay",
  "チェ":"chay",

  "あ":"uh",
  "い":"yi",
  "う":"oo",
  "え":"eh",
  "お":"oh",
  "か":"car",
  "き":"key",
  "く":"coo",
  "け":"kay",
  "こ":"ko",
  "が":"gah",
  "ぎ":"ghee",
  "ぐ":"goo",
  "げ":"gay",
  "ご":"go",
  "さ":"sar",
  "し":"she",
  "す":"soo",
  "せ":"say",
  "そ":"so",
  "ざ":"zar",
  "じ":"gee",
  "ず":"zoo",
  "ぜ":"zey",
  "ぞ":"zoe",
  "た":"tar",
  "ち":"chee",
  "つ":"tsu",
  "て":"tay",
  "と":"toe",
  "だ":"duh",
  "ぢ":"gee",
  "づ":"zoo",
  "で":"day",
  "ど":"dough",
  "な":"nar",
  "に":"knee",
  "ぬ":"new",
  "ね":"nay",
  "の":"no",
  "は":"ha",
  "ひ":"he",
  "ふ":"foo",
  "へ":"hey",
  "ほ":"ho",
  "ば":"bar",
  "び":"bee",
  "ぶ":"boo",
  "べ":"bay",
  "ぼ":"boar",
  "ぱ":"par",
  "ぴ":"pee",
  "ぷ":"poo",
  "ぺ":"pay",
  "ぽ":"poah",
  "ま":"ma",
  "み":"me",
  "む":"moo",
  "め":"may",
  "も":"mow",
  "や":"yar",
  "ゆ":"you",
  "よ":"yo",
  "ら":"la",
  "り":"lee",
  "る":"lew",
  "れ":"lay",
  "ろ":"low",
  "わ":"wha",
  "を":"woh",
  "ん":"n",
  "ア":"uh",
  "イ":"yi",
  "ウ":"oo",
  "エ":"eh",
  "オ":"oh",
  "カ":"car",
  "キ":"key",
  "ク":"coo",
  "ケ":"kay",
  "コ":"ko",
  "ガ":"gah",
  "ギ":"ghee",
  "グ":"goo",
  "ゲ":"gay",
  "ゴ":"go",
  "サ":"sar",
  "シ":"she",
  "ス":"soo",
  "セ":"say",
  "ソ":"so",
  "ザ":"zar",
  "ジ":"gee",
  "ズ":"zoo",
  "ゼ":"zey",
  "ゾ":"zoe",
  "タ":"tar",
  "チ":"chee",
  "ツ":"tsu",
  "テ":"tay",
  "ト":"toe",
  "ダ":"duh",
  "ヂ":"gee",
  "ヅ":"zoo",
  "デ":"day",
  "ド":"dough",
  "ナ":"nar",
  "ニ":"knee",
  "ヌ":"new",
  "ネ":"nay",
  "ノ":"no",
  "ハ":"ha",
  "ヒ":"he",
  "フ":"foo",
  "ヘ":"hey",
  "ホ":"ho",
  "バ":"bar",
  "ビ":"bee",
  "ブ":"boo",
  "ベ":"bay",
  "ボ":"boar",
  "パ":"par",
  "ピ":"pee",
  "プ":"poo",
  "ペ":"pay",
  "ポ":"poah",
  "マ":"ma",
  "ミ":"me",
  "ム":"moo",
  "メ":"may",
  "モ":"mow",
  "ヤ":"yar",
  "ユ":"you",
  "ヨ":"yo",
  "ラ":"la",
  "リ":"lee",
  "ル":"lew",
  "レ":"lay",
  "ロ":"low",
  "ワ":"wha",
  "ヲ":"woh",
  "ン":"n",
}

var playlist = [];
var playing = null;
var vc_connection = null;

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

function join_chan(channel_id)
{
  leave_chan();
  find_channel(client, channel_id, (c)=> {
    c.join()
     .then((connection) => {
      vc_connection = connection;
      console.log("[MSG]", 'Joined channel', channel_id)
    })
     .catch(console.error);
  }, function(){ setTimeout( function(){join_chan(channel_id);}, 10); } );
}

function leave_chan()
{
  if (vc_connection)
  {
    vc_connection.disconnect();
    vc_connection = null;
  }
}

function play_next()
{
  if (!playing)
  {
    var x = playlist.shift();
    if (x)
    {
      console.log("[SND]", "Playing: ", x[1], ";", playlist.length, "sentences left.")
      x[0](x[1], x[2], x[3], x[4], x[5]);
    }
    else
    {
      playing = false
      console.log("[SND]", "No more sentences")
    }
  }
}

function setup_events(current_stream, connection)
{
  current_stream.on("start", function() {
    console.log("[SND]", "Play started!");
  });

  current_stream.on("error", function(e) {
    console.log("[SND]", "errored!");
    console.log("[SND]", e);
    current_stream.end();
    playing = null;
    play_next();
  });

  current_stream.on("end", function(e) {
    console.log("[SND]", "ended!");
    playing = null;
    play_next();
  });
}

async function play_text(message, m, voiceid, on_success, on_failure)
{
  playlist.push(
    [
      async function(message, m, voiceid, on_success, on_failure)
      {
        message = message.replace(/\<@[0-9]+\>/g, function(x)
        {
          var userid = x.toString().replace("<@", "").replace(">","");
          var nick = m.channel.guild.members.get(userid).displayName;
          return nick;
        })

        message = message.replace(/\<#[0-9]+\>/g, function(x)
        {
          var chanid = x.toString().replace("<#", "").replace(">","");
          var channame = m.channel.guild.channels.get(chanid).name;
          return channame;
        })

        message = message.replace(/\<\a\:[^:]+\:[0-9]+\>/gi, function(x)
        {
          return "a fucking animated emoji";
        })

        message = message.replace(/\<\:[^:]+\:[0-9]+\>/gi, function(x)
        {
          var emoid = x.toString().replace("<:", "").replace(/\:[0-9]+\>/,"");
          return emoid;
        })

        message = message.replace(/onibe/gi, function(x)
        {
          return "on ebay";
        })

        if (voiceid !== "Takumi" && voiceid !== "Mizuki")
        {
          const ks = new Kuroshiro();
          await ks.init(new KuromojiAnalyzer());
          const result = await ks.convert(message, { to: "hiragana" });
          console.log(result);
          var newmessage = result
          for (var len = 2; len >= 0; len--)
          {
            var nm = ""
            var i=0;
            for (i = 0; i < newmessage.length - len; i++)
            {
              var tx = newmessage.substr(i, len+1);
              console.log(tx, i, len+1, newmessage.length)
              if (heerargunner[tx])
              {
                if (heerargunner[tx] !== 'n')
                {
                  nm += " " + heerargunner[tx] 
                }
                else
                {
                  nm += 'n'
                }
                i += len
              }
              else
              {
                nm += newmessage[i]
              }
            }
            nm += newmessage.substr(i);
            newmessage = nm;
            console.log(newmessage);
          }

          message = newmessage;
        }

        var params = {
          'Text': message,
          'OutputFormat': 'ogg_vorbis',
          'VoiceId': voiceid
        }

        Polly.synthesizeSpeech(params, (err, data) => {
          if (err)
          {
            console.log(err.code)
            if (on_failure)
            {
              on_failure();
            }
          }
          else if (data) 
          {
            if (data.AudioStream instanceof Buffer) {
              fs.writeFile("./speech.ogg", data.AudioStream, function(err) {
                if (err) {
                  return console.log(err);
                }

                playing = true;
                current_stream = vc_connection.play("./speech.ogg");
                setup_events(current_stream, vc_connection);
                if (on_success)
                {
                  on_success();
                }
              })

            }
          }
        });
      },
      message,
      m,
      voiceid,
      on_success,
      on_failure
    ]
  )
  play_next();
}

async function start_html_server(client) {
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

  app.post('/in_vc', (req, res) =>{
    if ( !vc_connection || !vc_connection.channel.members.get(req.body.user_id) )
    {
      return res.send(JSON.stringify({result: 'no'}));
    }
    return res.send(JSON.stringify({result: 'yes'}));
  });

  app.post('/join_vc', (req, res) =>{
    join_chan(req.body.channel_id)
    res.send(JSON.stringify({result: 'joining', channel_id: req.body.channel_id}))
  });

  app.post('/leave_vc', (req, res) =>{
    leave_chan();
    res.send(JSON.stringify({result: 'leave'}))
  });

  app.post('/say_vc', (req, res) =>{
    var message = req.body.message
    var m = {
      channel: client.channels.get(req.body.channel_id)
    }
    play_text(message, m, req.body.voice_id, ()=>{}, ()=>{});
    res.send(JSON.stringify({result: 'ok'}));
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


function send_message(message, extra_info) {
  var message_info = {

    bot_key:         client.user.id,
    bot_username:    client.user.username,

    author_key:      message.author.id,
    author_username: message.author.username,
    author_is_bot:   message.author.bot,

    room_type:       message.channel.type,
    room_key:        message.channel.id,
    room_name:       message.channel.name,

    created_at:      message.createdTimestamp,
    edited_at:       message.editedTimestamp,

    attachments:     message.attachments.map(function(attachment)
    {
      return {
        attachment_key: attachment.id,
        filename:       attachment.filename,
        filesize:       attachment.filesize,
        url:            attachment.url,
        proxy_url:      attachment.proxyURL,
        is_image:       attachment.height ? true : false
      };
    }),

    message:         message.content,
    message_key:     message.id

  }

  if (message.member && message.member.guild)
  {
    message_info.server_key   = message.member.guild.id;
    message_info.server_name = message.member.guild.name; 
  }

  if (extra_info)
  {
    message_info.extra_info = extra_info;
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
}

client.on('message', message =>
  send_message(message)
);

client.on('messageUpdate', (oldMessage, newMessage) =>
  send_message(newMessage, {old_message_key: oldMessage.id})
);

client.login(DISCORD_TOKEN);

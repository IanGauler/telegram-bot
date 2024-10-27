require 'spec_helper'
require 'web_mock'
# Uncomment to use VCR
# require 'vcr_helper'

require "#{File.dirname(__FILE__)}/../app/bot_client"

TOKEN = 'fake_token'.freeze

def when_i_send_text(token, message_text)
  body = { "ok": true, "result": [{ "update_id": 693_981_718,
                                    "message": { "message_id": 11,
                                                 "from": { "id": 141_733_544, "is_bot": false, "first_name": 'Emilio', "last_name": 'Gutter', "username": 'egutter', "language_code": 'en' },
                                                 "chat": { "id": 141_733_544, "first_name": 'Emilio', "last_name": 'Gutter', "username": 'egutter', "type": 'private' },
                                                 "date": 1_557_782_998, "text": message_text,
                                                 "entities": [{ "offset": 0, "length": 6, "type": 'bot_command' }] } }] }

  stub_request(:any, "https://api.telegram.org/bot#{token}/getUpdates")
    .to_return(body: body.to_json, status: 200, headers: { 'Content-Length' => 3 })
end

def when_i_send_keyboard_updates(token, message_text, inline_selection)
  body = {
    "ok": true, "result": [{
      "update_id": 866_033_907,
      "callback_query": { "id": '608740940475689651', "from": { "id": 141_733_544, "is_bot": false, "first_name": 'Emilio', "last_name": 'Gutter', "username": 'egutter', "language_code": 'en' },
                          "message": {
                            "message_id": 626,
                            "from": { "id": 715_612_264, "is_bot": true, "first_name": 'fiuba-memo2-prueba', "username": 'fiuba_memo2_bot' },
                            "chat": { "id": 141_733_544, "first_name": 'Emilio', "last_name": 'Gutter', "username": 'egutter', "type": 'private' },
                            "date": 1_595_282_006,
                            "text": message_text,
                            "reply_markup": {
                              "inline_keyboard": [
                                [{ "text": 'Jon Snow', "callback_data": '1' }],
                                [{ "text": 'Daenerys Targaryen', "callback_data": '2' }],
                                [{ "text": 'Ned Stark', "callback_data": '3' }]
                              ]
                            }
                          },
                          "chat_instance": '2671782303129352872',
                          "data": inline_selection }
    }]
  }

  stub_request(:any, "https://api.telegram.org/bot#{token}/getUpdates")
    .to_return(body: body.to_json, status: 200, headers: { 'Content-Length' => 3 })
end

def then_i_get_text(token, message_text)
  body = { "ok": true,
           "result": { "message_id": 12,
                       "from": { "id": 715_612_264, "is_bot": true, "first_name": 'fiuba-memo2-prueba', "username": 'fiuba_memo2_bot' },
                       "chat": { "id": 141_733_544, "first_name": 'Emilio', "last_name": 'Gutter', "username": 'egutter', "type": 'private' },
                       "date": 1_557_782_999, "text": message_text } }

  stub_request(:post, "https://api.telegram.org/bot#{token}/sendMessage")
    .with(
      body: { 'chat_id' => '141733544', 'text' => message_text }
    )
    .to_return(status: 200, body: body.to_json, headers: {})
end

def then_i_get_keyboard_message(token, message_text)
  body = { "ok": true,
           "result": { "message_id": 12,
                       "from": { "id": 715_612_264, "is_bot": true, "first_name": 'fiuba-memo2-prueba', "username": 'fiuba_memo2_bot' },
                       "chat": { "id": 141_733_544, "first_name": 'Emilio', "last_name": 'Gutter', "username": 'egutter', "type": 'private' },
                       "date": 1_557_782_999, "text": message_text } }

  stub_request(:post, "https://api.telegram.org/bot#{token}/sendMessage")
    .with(
      body: { 'chat_id' => '141733544',
              'reply_markup' => '{"inline_keyboard":[[{"text":"Jon Snow","callback_data":"1"},{"text":"Daenerys Targaryen","callback_data":"2"},{"text":"Ned Stark","callback_data":"3"}]]}',
              'text' => 'Quien se queda con el trono?' }
    )
    .to_return(status: 200, body: body.to_json, headers: {})
end

def stub_spotify_popularity_request(artist_name, popularity)
  api_spotify_response_body = {
    "artists": {
      "items": [
        {
          "popularity": popularity
        }
      ]
    }
  }
  artist_search_endpoint = "https://api.spotify.com/v1/search?q=#{artist_name}&type=artist&limit=1&market=AR"

  stub_request(:get, artist_search_endpoint)
    .with(
      headers: {
        'Accept' => '*/*',
        'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'User-Agent' => 'Faraday v2.7.4'
      }
    ).to_return(status: 200, body: api_spotify_response_body.to_json, headers: {})
end

describe 'BotClient' do
  it 'should get a /version message and respond with current version' do
    when_i_send_text(TOKEN, '/version')
    then_i_get_text(TOKEN, Version.current)

    app = BotClient.new(TOKEN)
    app.run_once
  end

  it 'should get a /say_hi message and respond with Hola Emilio' do
    when_i_send_text(TOKEN, '/say_hi Emilio')
    then_i_get_text(TOKEN, 'Hola, Emilio')

    app = BotClient.new(TOKEN)
    app.run_once
  end

  it 'should get a /start message and respond with Hola' do
    when_i_send_text(TOKEN, '/start')
    then_i_get_text(TOKEN, 'Hola, Emilio')

    app = BotClient.new(TOKEN)
    app.run_once
  end

  it 'should get a /stop message and respond with Chau' do
    when_i_send_text(TOKEN, '/stop')
    then_i_get_text(TOKEN, 'Chau, egutter')

    app = BotClient.new(TOKEN)
    app.run_once
  end

  it 'should get a /tv message and respond with an inline keyboard' do
    when_i_send_text(TOKEN, '/tv')
    then_i_get_keyboard_message(TOKEN, 'Quien se queda con el trono?')

    app = BotClient.new(TOKEN)
    app.run_once
  end

  it 'should get a "Quien se queda con el trono?" message and respond with' do
    when_i_send_keyboard_updates(TOKEN, 'Quien se queda con el trono?', '2')
    then_i_get_text(TOKEN, 'A mi también me encantan los dragones!')

    app = BotClient.new(TOKEN)
    app.run_once
  end

  it '/popularidad returns "el artista es muy popular" for a very popular artist' do
    artist_name = 'Lady Gaga'
    stub_spotify_popularity_request(artist_name, 92)
    when_i_send_text(TOKEN, "/popularidad #{artist_name}")
    then_i_get_text(TOKEN, 'El artista es muy popular')

    app = BotClient.new(TOKEN)
    app.run_once
  end

  it 'should get an unknown message message and respond with Do not understand' do
    when_i_send_text(TOKEN, '/unknown')
    then_i_get_text(TOKEN, 'Uh? No te entiendo! Me repetis la pregunta?')

    app = BotClient.new(TOKEN)
    app.run_once
  end
end

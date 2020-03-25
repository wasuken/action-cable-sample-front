require "faye/websocket"
require "eventmachine"
require "json"

EM.run {
  ws = Faye::WebSocket::Client.new('ws://localhost:3000/cable')
  ws.on :open do |event|
    p [:open]
    cmd = {command: "subscribe", identifier: {channel: "SampleChannel"}}
    ws.send(cmd.to_json)
    ws.send({command: "message", data: {}.to_json,
             identifier: {channel: "SampleChannel"}.to_json})
  end

  ws.on :close do |event|
    p [:close, event.code, event.reason]
    ws = nil
  end
}

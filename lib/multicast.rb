#! /usr/bin/env ruby -w

require 'socket'
require 'timeout'

class Multicast
  VERSION = '1.0.0'
  
  def self.server
    server = UDPSocket.new
    server.bind nil, 12321
    loop do
      text, sender = server.recvfrom(1)
      server.send("#{Time.now}\n",0,sender[3],sender[1])
    end
  end
  
  def self.client
    socket = UDPSocket.new 
    socket.connect('localhost', 12321) 
    socket.send('', 0) 
    timeout(10) do 
      time = socket.gets 
      puts time 
    end
  end
end
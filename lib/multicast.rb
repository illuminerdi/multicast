#! /usr/bin/env ruby -w
require 'socket'
ADDR = '224.0.0.1'
PORT = '7387'
def connect
  begin
    socket = UDPSocket.new
    socket.bind('', PORT)
    loop do
      Thread.new do
        loop do
          recvd, info = socket.recvfrom(1024)
          puts "Received: '#{recvd.strip}'" unless recvd.chomp.empty?
        end
      end
      text = gets
      socket.send("#{text}",0,ADDR,PORT)
      puts "You said: #{text}"
    end
  ensure
    socket.close
  end
end
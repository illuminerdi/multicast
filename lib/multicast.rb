#! /usr/bin/env ruby -w

require 'socket'
require 'timeout'

class Multicast
  VERSION = '1.0.0'
  ADDR = '224.0.0.1'
  PORT = '7387'
  def self.server
    begin
      server = UDPSocket.open
      loop do
        print "What to say: "
        text = gets.chomp
        server.send("#{text}\n",0, ADDR, PORT)
        puts "You said: #{text}"
      end
    ensure
      server.close
    end
  end
  def self.client
    begin
      socket = UDPSocket.new 
      socket.bind('', PORT)
      loop do 
        recvd, info = socket.recvfrom(1024) 
        puts "Received: '#{recvd.strip}' from [#{info[2]}]" unless recvd.chomp.empty?
      end
    ensure
      socket.close
    end
  end
end
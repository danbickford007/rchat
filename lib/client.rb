#!/usr/bin/env ruby -w
require "socket"
require 'colorize'
class Client

  @category = nil

  def initialize( server )
    @server = server
    @request = nil
    @response = nil
    listen
    send
    @request.join
    @response.join
  end

  def listen
    @response = Thread.new do
      loop {
        msg = @server.gets.chomp
        if msg.match(/:red:/) 
          puts "#{msg.split(/:red:/)[1]}".red
        elsif msg.match(/:yellow:/)
          puts "#{msg.split(/:yellow:/)[1]}".yellow
        elsif msg.match(/:blue:/)
          puts "#{msg.split(/:blue:/)[1]}".blue
        elsif msg.match(/:green:/)
          puts "#{msg.split(/:green:/)[1]}".green
        else
          puts msg
        end
      }
    end
  end

  def send
    @request = Thread.new do
      loop {
        begin
          msg = $stdin.gets.chomp
          @server.puts( msg )
        rescue
          puts "you have been disconnected, please login again"
          abort
        end
      }
    end
  end

  def self.start
    server = TCPSocket.open( "localhost", 3000 )
    #server = TCPSocket.open( "54.83.36.99", 3000 )
    Client.new( server )
  end

end

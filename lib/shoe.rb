# Shoes.setup do
#   gem 'colorize'
#   gem 'json'
# end

require "socket"

require 'gtk2'

require 'gtk2'


class RubyApp < Gtk::Window

    def initialize
        super
    
        set_title "Entry"
        signal_connect "destroy" do 
            Gtk.main_quit 
        end
        
        init_ui

        set_default_size 250, 200
        set_window_position Gtk::Window::POS_CENTER
        
        show_all
    end
    
    def init_ui

        vbox = Gtk::VBox.new false, 5
        
        valign = Gtk::Alignment.new 0, 0, 1, 1
        vbox.pack_start valign
        
        @scroll = Gtk::ScrolledWindow.new
        @label = Gtk::TextView.new 
        @label.editable = false
        @buffer = @label.buffer
        @scroll.add_with_viewport @label
        @entry = Gtk::Entry.new

 
        vbox.add @scroll
        vbox.add @entry
        
        @entry.grab_focus

        add vbox 

        #@server = TCPSocket.open( "54.83.36.99", 3000 )
        @server = TCPSocket.open( "localhost", 3000 )
        @entry.signal_connect "key-release-event" do |w, e|
            on_key_release(w, e, @label, @server, @entry)
        end
        @request = Thread.new do
          loop {
            iter = @buffer.get_iter_at_offset(10000)
            @msg = @server.gets.chomp.gsub(':red:', '').gsub(':green:', '').gsub(':blue:', '').gsub(':yellow:','')
            @buffer.insert iter, "#{@msg}\n"
            @scroll.vadjustment.value = @scroll.vadjustment.upper * 1000000000
          }
        end
        
    end  
    
    def on_key_release sender, event, label, server, entry
        if (event.keyval.to_s == '65293')
          server.puts( entry.text )
          entry.text = ''
        end
    end
end

Gtk.init
    window = RubyApp.new
Gtk.main





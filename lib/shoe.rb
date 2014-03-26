Shoes.setup do
  gem 'colorize'
  gem 'json'
end

require "socket"



Shoes.app height: 400, width: 500 do
  @server = TCPSocket.open( "54.83.36.99", 3000 )
  background rgb(240, 250, 208)
  @stack = stack margin: 10, height: '300px', scroll: true do
    @label = para "RCHAT GUI!\n\n"
    @request = Thread.new do
      loop {
        @msg = @server.gets.chomp
        @label.text += "#{@msg}\n"
        @stack.scroll_top = @stack.scroll_top() + 50 
      }
    end
  end
  @edit = edit_box "", width: 300, height: 50, left: '50px', bottom: '40px'
  button 'send', left: '50px', bottom: '5px' do
     @msg = @edit.text
     @server.puts( @msg )
     @edit.text = ''
  end

end



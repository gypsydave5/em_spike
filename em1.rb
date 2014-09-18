#!usr/bin/env ruby

require 'eventmachine'


module HttpHeaders
  def post_init
    send_data "GET /\r\n\r\n"
    @data = ""
  end


  def receive_data(data)
    @data << data
  end

  def unbind

    if @data =~/[\n][\r]*[\n]/m
      #p @data
      @data.each_line {|line| puts  ">>> #{line}"}
    end

    EventMachine::stop_event_loop
  end
end

EventMachine::run do
  EventMachine::connect ARGV[0], 80, HttpHeaders
end
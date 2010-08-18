require 'rubygems'
require 'eventmachine'
require 'stringio'
require 'readline'
require 'redis'


def halt!
  puts "Closing server"
  @redis.quit
  puts "..."
  exit
end

trap(:TERM) { halt! }
trap(:INT)  { halt! }

W = ARGV.join.empty? ? "TEST" :  ARGV.join

module MyKeyboardHandler
  include EM::Protocols::LineText2

  def receive_line l
    puts "Line > #{l}" if DEBUG

    CONN.send_data(l) unless l.empty?
  end
end

def readline_with_hist_management
  line = Readline.readline('> ', true)
  return nil if line.nil?
  if line =~ /^\s*$/ or Readline::HISTORY.to_a[-2] == line
    Readline::HISTORY.pop
  end
  line
end

EventMachine::run do
  @redis = Redis.new(:timeout => 0)

  stty_save = `stty -g`.chomp

  trap(:INT)  do
    system('stty', stty_save)
    halt!
  end

  # Thread.new do
    begin
      while line = readline_with_hist_management
        p line
        p @redis.publish('ard', line) unless line.empty?
      end
    rescue Interrupt => e
      system('stty', stty_save) # Restore
      exit
    end
#  end

  #  EM.open_keyboard(MyKeyboardHandler)
end


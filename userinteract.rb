require_relative 'logitem'
require_relative 'log'
require_relative 'chatlog'
require 'date'

class UserInteract 
  attr :chatlog

  def initialize
    @chatlog = ChatLog.new
  end
  def start
    loop do
      ('%s> ' % "Enter a command: (help for list)\n").display
      input = gets.chomp
      command, *params = input.split /\s/
        case command
        when /\Ahelp\z/i
          puts @chatlog.help_text
        when /\Ahistory\z/i
          puts "no history"
          @chatlog.print_log
        when /\Aminutes\z/i
          @chatlog.agg_items_by_time 'minute'
        when /\Aexit\z/i
          exit
        else
          puts 'Invalid command'
        end
    end
  end
end

prompt = UserInteract.new
prompt.start

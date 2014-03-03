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
          @chatlog.print_log
        when /\Aaggregate\z/i
          @chatlog.agg_items_by_time *params
          @chatlog.print_agg_items
        when /\Aminute\z/i
          @chatlog.agg_items_by_time 'minute'
          @chatlog.print_agg_items
        when /\Ahour\z/i
          @chatlog.agg_items_by_time 'hour'
          @chatlog.print_agg_items
        when /\Aday\z/i
          @chatlog.agg_items_by_time 'day'
          @chatlog.print_agg_items
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

require 'playhouse/console/command_builder'
require 'thor'

module Playhouse
  module Console
    class Interface

      # deprecated
      def self.build_from_play(play)
        console_class = Class.new(Thor)

        command_builder = Playhouse::Console::CommandBuilder.new(console_class)

        play.commands.each do |command|
          command_builder.build_command play, command
        end

        console_class
      end

      def self.build_from_application(app)
        console_class = Class.new(Thor)

        command_builder = Playhouse::Console::CommandBuilder.new(console_class)

        app.plays.each do |play|
          play.commands.each do |command|
            command_builder.build_command play, command
          end
        end

        console_class
      end
    end
  end
end
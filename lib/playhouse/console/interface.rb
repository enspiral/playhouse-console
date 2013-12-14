require 'playhouse/console/command_builder'
require 'thor'

module Playhouse
  module Console
    class Interface
      def self.build(production)
        self.new(production)
      end

      def initialize(production = nil)
        @console = Class.new(Thor)
        @command_builder = Playhouse::Console::CommandBuilder.new(@console)
        add_production(production) if production
      end

      def run(*args)
        @console.start(*args)
      end

      private

        def add_production(production)
          production.plays.each do |play|
            add_play play
          end
        end

        def add_play(play)
          play.commands.each do |command|
            @command_builder.build_command play, command
          end
        end
    end
  end
end
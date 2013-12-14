module Playhouse
  module Console
    class CommandBuilder
      def initialize(console_interface)
        @console_interface = console_interface
      end

      def build_command(play, command)
        @console_interface.desc command.method_name, ''

        command.parts.each do |part|
          build_command_option(part)
        end

        defined_command_handler(play, command)
      end

      private

        def build_command_option(part)
          @console_interface.method_option option_name(part), required: part.required
        end

        def option_name(part)
          part.repository ? "#{part.name}_id" : part.name
        end

        def defined_command_handler(play, command)
          @console_interface.send :define_method, command.method_name do
            result = play.send(command.method_name, options)
            puts result.inspect
          end
        end
    end
  end
end
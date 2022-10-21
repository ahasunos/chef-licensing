require "timeout" unless defined?(Timeout)
require "tty-prompt"
require "logger"

module ChefLicensing
  class TUIEngine
    class TUIPrompt
      attr_accessor :output, :input, :logger, :tty_prompt

      def initialize(opts = {})
        @output = opts[:output] || STDOUT
        @input = opts[:input] || STDIN
        @logger = opts[:logger] || Logger.new(opts.key?(:output) ? opts[:output] : STDERR)
        @tty_prompt = TTY::Prompt.new(track_history: false, active_color: :bold, interrupt: :exit, output: output, input: input)
      end

      # TBD: Add comments for each prompt type briefly.

      # yes prompts the user with a yes/no question and returns true if the user
      # answers yes and false if the user answers no.
      def yes(messages)
        message = messages.is_a?(Array) ? messages[0] : messages

        @tty_prompt.yes?(message, default: true)
      end

      # say prints the given message to the output stream.
      # default prompt_type is say.
      def say(messages)
        message = messages.is_a?(Array) ? messages[0] : messages
        @tty_prompt.say(message)
      end

      # ok prints the given message to the output stream in green color.
      def ok(messages)
        message = messages.is_a?(Array) ? messages[0] : messages
        @tty_prompt.ok(message)
      end

      # warn prints the given message to the output stream in yellow color.
      def warn(messages)
        message = messages.is_a?(Array) ? messages[0] : messages
        @tty_prompt.warn(message)
      end

      # error prints the given message to the output stream in red color.
      def error(messages)
        message = messages.is_a?(Array) ? messages[0] : messages
        @tty_prompt.error(message)
      end

      # select prompts the user to select an option from a list of options.
      def select(messages)
        header = messages[0]
        choices_list = messages[1]
        @tty_prompt.select(header, choices_list)
      end

      # enum_select prompts the user to select an option from a list of options.
      def enum_select(messages)
        @tty_prompt.enum_select(messages[0], messages[1])
      end

      # ask prompts the user to enter a value.
      def ask(messages)
        message = messages.is_a?(Array) ? messages[0] : messages
        @tty_prompt.ask(message)
      end
    end
  end
end
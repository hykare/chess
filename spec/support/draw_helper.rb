module Helpers
  module Draw
    def capture_stdout(&block)
      default_output = $stdout
      $stdout = StringIO.new
      block.call
      $stdout.string
    ensure
      $stdout = default_output
    end

    def remove_ansi_escapes(string)
      end_escape = /\e\[0m/
      start_escape_match = /\e\[\d{1,3};\d{1,3};\d{1,3}m/
      string.gsub(end_escape, '').gsub(start_escape_match, '')
    end

    # def checker_pattern?(string)
    # ignore the end sequence, it's always the same
    # find and save the matching occurences
    # should be alternating the same two things 8 times, then one repeat
    # end
  end
end

RSpec.configure do |config|
  config.include Helpers::Draw
end

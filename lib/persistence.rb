require 'yaml'

module Persistence
  def self.included(klass)
    klass.extend ClassMethods
  end

  def save
    puts 'Enter save name:'
    file_name = gets.chomp.split.join('_')
    save_file = File.new("#{file_name}.yaml", 'w')
    save_file.puts YAML.dump(self)
    puts "Game saved as '#{file_name}.yaml'"
  end

  module ClassMethods
    def load_saved_game
      available_files = Dir.glob('*.yaml')
      if available_files.empty?
        puts 'no available save files, starting a new game'
        return new
      end
      puts "available save files: #{available_files.join(', ')}"
      puts 'enter save name:'
      file_name = ''
      file_name = gets.chomp until available_files.include? file_name
      self.load file_name
    end

    def load(file_name)
      yaml_string = File.read file_name
      Psych.load_stream(yaml_string).first
    end
  end
end

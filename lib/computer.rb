class Computer
  def self.load_words
    file_path = File.expand_path('google-10000-english-no-swears.txt', __dir__)
    lines = File.readlines(file_path, encoding: "UTF-8").reject { |line| line.strip.length < 5 || line.strip.length > 12 }.map { |line| line.gsub(/[^a-zA-Z]/, '').strip }
    lines.map(&:strip)  # Strip any extra spaces or newline characters
  end

  def initialize
    @word = ""
    @lines = self.class.load_words
  end

  def generate_word
    @word = @lines.sample
    @word.chars
  end

  attr_reader :word
end
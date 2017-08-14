require 'yaml'
require 'thor'

MORSE_ME_NICELY_PATH = File.dirname(__FILE__) + "/morse_me_nicely/"

[
  "encoder",
  "obfuscator",
  "cli"
].each do |utility|
  require MORSE_ME_NICELY_PATH + utility
end

module MorseMeNicely
  class InvalidInputError < StandardError; end

  class Processor

    def self.encode(input_text, without_obfuscation=false)
      text = Encoder.new(input_text).encoded_input
      text = Obfuscator.new(text).obfuscated_input unless without_obfuscation
      text
    end

  end
end

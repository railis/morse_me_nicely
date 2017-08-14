module MorseMeNicely

  class Encoder

    ENCODING_REFERENCE_PATH = MORSE_ME_NICELY_PATH + "../../data/morse_reference.yml"

    def initialize(input_text)
      @input_text = input_text
      @encoding_reference = YAML::load_file(ENCODING_REFERENCE_PATH)
    end

    def encoded_input
      validate_input_text
      @input_text.split(/\n/).map do |line|
        line.scan(/\w+\.?\,?/).map do |word|
          translate_word(word)
        end.join(@encoding_reference["separators"]["word"])
      end.join("\n")
    end

    private

    def validate_input_text
      raise InvalidInputError, "No text input found" unless @input_text.is_a?(String)
      invalid_characters = get_input_invalid_characters
      unless invalid_characters.empty?
        raise InvalidInputError, "Input text contains invalid characters: #{invalid_characters.join(" ")}"
      end
    end

    def get_input_invalid_characters
      input_copy = @input_text.downcase.dup
      @encoding_reference["characters"].keys.each do |character|
        input_copy.gsub!(character, '')
      end
      input_copy.gsub(/\s+/, '').split('').uniq
    end

    def translate_word(word)
      word.split('').map do |character|
        translate_character(character)
      end.join(@encoding_reference["separators"]["character"])
    end

    def translate_character(character)
      @encoding_reference["characters"][character.downcase]
    end

  end

end

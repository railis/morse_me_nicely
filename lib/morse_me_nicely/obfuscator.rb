module MorseMeNicely

  class Obfuscator

    def initialize(input_text)
      @input_text = input_text
    end

    def obfuscated_input
      process_dashes(
        process_dots(
          @input_text
        )
      )
    end

    private

    def process_dots(text)
      text_copy = text.dup
      get_ordered_unique_consecutive_chars(text, :dot).each do |uniq_consecutive_dots|
        text_copy.gsub!(uniq_consecutive_dots, encode_consecutive_dots(uniq_consecutive_dots))
      end
      text_copy
    end

    def process_dashes(text)
      text_copy = text.dup
      get_ordered_unique_consecutive_chars(text, :dash).each do |uniq_consecutive_dashes|
        text_copy.gsub!(uniq_consecutive_dashes, encode_consecutuve_dashes(uniq_consecutive_dashes))
      end
      text_copy
    end

    def get_ordered_unique_consecutive_chars(text, character)
      regex = case character
              when :dot
                /\.+/
              when :dash
                /\-+/
              end
      text.scan(regex).uniq.sort do |v1, v2|
        v2.length <=> v1.length
      end
    end

    def encode_consecutive_dots(dots)
      length = dots.length
      if length > 9
        raise InvalidInputError, "Number of consecutive dots can't be greater than 9"
      else
        length.to_s
      end
    end

    def encode_consecutuve_dashes(dashes)
      ascii_idx_addition = ("A".ord - 1)
      ascii_nr = dashes.length + ascii_idx_addition
      if ascii_nr > "Z".ord
        raise InvalidInputError, "Number of consecutive dashes can't be greater than the size of alphabet"
      else
        ascii_nr.chr
      end
    end

  end

end

module MorseMeNicely

  class CLI < Thor

    desc "encode [--without-obfuscation] [--input-file=path/to/input_file] [--output-file=path/to/output_file]", "Encode message using obfuscated morse code"
    method_options :without_obfuscation => :boolean
    method_options :input_file => :string
    method_options :output_file => :string

    def encode
      if options[:input_file]
        input_text = File.read(options[:input_file])
      else
        input_text = ask(set_color("Write the message:", Thor::Shell::Color::GREEN))
      end
      puts input_text.chop
      encoded_text = MorseMeNicely::Processor::encode(input_text, options[:without_obfuscation])
      if options[:output_file]
        output_file = File.new(options[:output_file], "w+")
        output_file << encoded_text
        output_file.close
        say("Encoded message has been saved to selected file.", Thor::Shell::Color::GREEN)
      else
        say("Encoded message:", Thor::Shell::Color::GREEN)
        say(encoded_text)
      end
    end

  end

end

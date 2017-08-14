module MorseMeNicely

  class CLI < Thor

    desc "encode [--without-obfuscation] [--input-file=path/to/input_file] [--output-file=path/to/output_file]", "Encode message using obfuscated morse code"
    method_options :without_obfuscation => :boolean
    method_options :input_file => :string
    method_options :output_file => :string

    def encode
      begin
        if options[:input_file]
          input_text = File.read(options[:input_file])
        else
          input_text = ask(set_color("Write the message:", Thor::Shell::Color::GREEN))
        end
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
      rescue MorseMeNicely::InvalidInputError => e
        say_error(e)
      rescue Errno::ENOENT
        say_error("Input file '#{options[:input_file]}' does not exist")
      rescue Errno::EACCES
        say_error("You don't have permissions to read file '#{options[:input_file] || options[:output_file]}'")
      end
    end

    private

    def say_error(msg)
      say("Error: #{msg}", Thor::Shell::Color::RED)
    end

  end

end

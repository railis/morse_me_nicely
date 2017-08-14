require_relative '../spec_helper'

RSpec.describe MorseMeNicely::Encoder, "#encoded_input" do

  context "when input text is not valid" do

    context "when input is not a string" do

      subject do
        described_class.new(true)
      end

      it "raises InvalidInput error" do
        expect { subject.encoded_input }.to raise_error(MorseMeNicely::InvalidInputError, "No text input found")
      end

    end

    context "when input text contains ambiguous characters" do

      subject do
        described_class.new("I'm to stupid; 2 > 1")
      end

      it "raises InvalidInput error with invalid characters listed" do
        expect { subject.encoded_input }.to raise_error(MorseMeNicely::InvalidInputError, "Input text contains invalid characters: ' ; >")
      end

    end

  end

  context "when input text is valid" do

    context "translation of characters" do

      subject do
        described_class.new("l")
      end

      it "returns correct translation based on provided reference" do
        expect(subject.encoded_input).to eq ".-.."
      end

    end

    context "characters separation" do

      subject do
        described_class.new("l2")
      end

      it "returns translated characters separated by pipe '|'" do
        expect(subject.encoded_input).to eq ".-..|..---"
      end

    end

    context "words separation" do

      it "separates with forward slash '/'" do
        encoder = described_class.new("jm 13")
        expect(encoder.encoded_input).to eq ".---|--/.----|...--"
      end

      it "considers coma and full stop as part of the preceding word" do
        encoder = described_class.new("you, me and he.")
        expect(encoder.encoded_input).to eq "-.--|---|..-|--..--/--|./.-|-.|-../....|.|.-.-.-"
      end

    end

    context "case sensitivity" do

      it "does ignore character case" do
        encoder_downcase = described_class.new("dominik")
        encoder_uppercase = described_class.new("DOMINIK")
        expect(encoder_downcase.encoded_input).to eq encoder_uppercase.encoded_input
      end

    end

    context "whitespaces" do

      it "considers multiple spaces as one" do
        encoder_single_space = described_class.new("foo bar")
        encoder_multiple_spaces = described_class.new("foo    bar")
        expect(encoder_single_space.encoded_input).to eq encoder_multiple_spaces.encoded_input
      end

      it "respects new line characters" do
        encoder = described_class.new("a\nbc\nbc cd")
        expect(encoder.encoded_input).to eq ".-\n-...|-.-.\n-...|-.-./-.-.|-.."
      end

    end

  end

end

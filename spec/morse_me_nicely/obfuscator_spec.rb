require_relative '../spec_helper'

RSpec.describe MorseMeNicely::Obfuscator, "#obfuscated_input" do

  context "when input text is invalid" do

    context "when number of consecutive dots is greater than 9" do

      subject do
        described_class.new("...........")
      end

      it "raises InvalidInput error" do
        expect { subject.obfuscated_input }.to(
          raise_error(MorseMeNicely::InvalidInputError,
            "Number of consecutive dots can't be greater than 9")
        )
      end

    end

    context "when number of consecutive dashes is greater than size of alphabet" do

      subject do
        described_class.new("---------------------------")
      end

      it "raises InvalidInput error" do
        expect { subject.obfuscated_input }.to(
          raise_error(MorseMeNicely::InvalidInputError,
            "Number of consecutive dashes can't be greater than the size of alphabet")
        )
      end

    end

  end

  context "when input text is valid" do

    context "consecutive dots" do

      it "replaces number of consecutive dots with count number" do
        expect(described_class.new(".").obfuscated_input).to eq "1"
        expect(described_class.new("..").obfuscated_input).to eq "2"
        expect(described_class.new("...").obfuscated_input).to eq "3"
        expect(described_class.new("....").obfuscated_input).to eq "4"
        expect(described_class.new(".....").obfuscated_input).to eq "5"
      end

    end

    context "consecutive dashes" do

      it "replaces number of consecutive dashes with the uppercase letter of alphabet at that position" do
        expect(described_class.new("-").obfuscated_input).to eq "A"
        expect(described_class.new("--").obfuscated_input).to eq "B"
        expect(described_class.new("---").obfuscated_input).to eq "C"
        expect(described_class.new("----").obfuscated_input).to eq "D"
        expect(described_class.new("-----").obfuscated_input).to eq "E"
      end

    end

    context "misc" do

      it "replaces number of consecutive dots and dashes in text block based on rules above" do
        obfuscator = described_class.new("../.-|--/..|-./-|.-.|---|..-|-...|.-..|.")
        expect(obfuscator.obfuscated_input).to eq "2/1A|B/2|A1/A|1A1|C|2A|A3|1A2|1"
      end

    end

  end

end

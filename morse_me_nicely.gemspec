Gem::Specification.new do |s|
  s.authors = ["Dominik Sito"]
  s.email = "dominik.sito@gmail.com"
  s.homepage = "https://github.com/railis/morse_me_nicely"

  s.name = "morse_me_nicely"
  s.version = "0.1.2"
  s.date = '2017-08-11'
  s.summary = "Morse Me Nicely!"
  s.description = "A simple gem to encode and obfuscate text input using morse code"

  s.files = `git ls-files`.split($\)
  s.executables = s.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  s.test_files = s.files.grep(%r{^(test|spec|features)/})

  s.license = "MIT"

  s.add_dependency "thor", "~> 0.19"
  s.add_development_dependency "rspec", "~> 3.6"
  s.add_development_dependency "rake", "~> 12.0"
end

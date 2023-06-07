# frozen_string_literal: true

require 'securerandom'

LOWERCASE_LETTERS = ('a'..'z').to_a
UPPERCASE_LETTERS = ('A'..'Z').to_a
NUMBERS = (0..9).to_a
SPECIAL_CHARACTERS = %w[% ? @ + - _ € / \ . ; > <]

PASSWORD_REGEX = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d.*\d)(?=.*[%?@+\-_€\\\/?.;><].*[%?@+\-_€\\\/?.;><]).{12,}$/

def generate_password
  lowercase = LOWERCASE_LETTERS.sample(rand(1..3)).join
  uppercase = UPPERCASE_LETTERS.sample(rand(1..3)).join
  numbers = NUMBERS.sample(rand(2..4)).join
  special_characters = SPECIAL_CHARACTERS.sample(rand(2..4)).join
  remaining_characters = 12 - (lowercase.length + uppercase.length + numbers.length + special_characters.length)
  random_characters = SecureRandom.alphanumeric(remaining_characters)

  password = lowercase + uppercase + numbers + special_characters + random_characters
  password.split('').shuffle.join
end

def valid_password?(password)
  password.match?(PASSWORD_REGEX)
end

pw = generate_password
puts "Generated password #{pw} is #{valid_password?(pw) ? 'valid' : 'invalid'}"
invalid_passwords = ['HelloWorld@', 'HelloWorld@:', '11RandomPassword']

invalid_passwords.each do |password|
  puts "Random Password: #{password} is #{valid_password?(password) ? 'valid' : 'invalid'}"
end



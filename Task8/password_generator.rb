require 'securerandom'

def generate_password
  lowercase = ('a'..'z').to_a.sample(rand(1..3)).join
  uppercase = ('A'..'Z').to_a.sample(rand(1..3)).join
  numbers = (0..9).to_a.sample(rand(2..4)).join
  special_characters = %w[% ? @ + - _ € / \ . ; > <].sample(rand(2..4)).join
  remaining_characters = 12 - (lowercase.length + uppercase.length + numbers.length + special_characters.length)
  random_characters = SecureRandom.alphanumeric(remaining_characters)

  password = lowercase + uppercase + numbers + special_characters + random_characters
  password.split('').shuffle.join
end

def valid_password?(password)
  lowercase_letter = /[a-z]/
  uppercase_letter = /[A-Z]/
  number = /\d/
  special_characters = /[%?@+\-_€\/\\.;><]/
  
  password.length >= 12 && 
    password.match?(lowercase_letter) &&
    password.match?(uppercase_letter) &&
    password.match?(number) &&
    password.scan(number).count >= 2 &&
    password.scan(special_characters).count >= 2
end

pw = generate_password
puts "Generated password #{pw} is #{valid_password?(pw) ? 'valid' : 'invalid'}"


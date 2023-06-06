require 'base64'

base64_text = File.read('base64.txt')

# Remove the data URI scheme prefix if present
base64_text.sub!(/^data:image\/[a-z]+;base64,/, '')

# Decode the Base64 text into binary data
image_data = Base64.decode64(base64_text)

output_path = File.join(File.dirname(__FILE__), 'tmp', 'image.jpg')

File.open(output_path, 'wb') do |file|
  file.write(image_data)
end

puts "Image saved at #{output_path}"

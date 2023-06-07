# frozen_string_literal: true

require 'base64'

class Base64Decoder
  attr_reader :base64_text

  def initialize(file_path)
    @base64_text = read_file(file_path)
  end

  def convert
    return if base64_text.nil?

    # Remove the data URI scheme prefix if present and extract image format
    image_format = base64_text.match(/^data:image\/([a-z]+);base64,/)&.[](1) || 'jpg'

    # Remove the data URI scheme prefix
    base64_text.sub!(/^data:image\/[a-z]+;base64,/, '')

    image_data = Base64.decode64(base64_text)

    output_path = File.join(File.dirname(__FILE__), 'tmp', "image.#{image_format}")

    File.open(output_path, 'wb') do |file|
      file.write(image_data)
    end

    output_path
  end

  private

  def read_file(file_path)
    File.read(file_path)
  rescue Errno::ENOENT
    puts 'File not found'
    nil
  end
end

output_path = Base64Decoder.new('base64.txt').convert
puts "Image saved at: #{output_path}" if output_path

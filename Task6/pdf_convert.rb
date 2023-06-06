pdf_filename = 'lorem-ipsum.pdf'
pdf_path = File.join(__dir__, pdf_filename)

output_filename = 'output.pdf'
output_path = File.join(__dir__, output_filename)

puts "Output path: #{output_path}"
puts "PDF path: #{pdf_path}"

ghostscript_installed = system('command -v gs > /dev/null 2>&1')

unless ghostscript_installed
  puts "Ghostscript is not installed on your system."
  puts "Please install Ghostscript to proceed with the conversion."
  exit(1)
end

command = "gs -dPDFA=1 -dBATCH -dNOPAUSE -sProcessColorModel=DeviceRGB -sDEVICE=pdfwrite -sPDFACompatibilityPolicy=1 -sOutputFile=#{output_path} #{pdf_path}"

success = system(command)

if success
  puts "PDF converted to PDF/A-1b format successfully!"
else
  puts "Conversion failed. Please check your command and file paths."
end

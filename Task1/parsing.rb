require 'nokogiri'
require 'ostruct'

# Load the document
file_path = 'xml_compressed.xml'
doc = File.open(file_path) { |f| Nokogiri::XML(f) }

# Define the namespace
ns = {'ota' => 'http://www.opentravel.org/OTA/2003/05'}

# Find the reservation node
reservation = doc.at_css('ota|OTA_HotelResNotifRQ > ota|HotelReservations > ota|HotelReservation', ns)

id = reservation.at_css('ota|ResGlobalInfo > ota|HotelReservationIDs > ota|HotelReservationID[ResID_Type="10"]', ns)['ResID_Value']
external_id = reservation.at_css('ota|ResGlobalInfo > ota|HotelReservationIDs > ota|HotelReservationID[ResID_Type="16"]', ns)['ResID_Value']
state = reservation['ResStatus']
rate_plan = reservation.at_css('ota|RoomStays > ota|RoomStay > ota|RatePlans > ota|RatePlan', ns)['RatePlanCode']

# Get services as an array of trimmed strings
services = reservation.css('ota|RoomStays > ota|RoomStay > ota|Services > ota|Service', ns).map { |service| service.text.strip }

services = services.reject(&:empty?).join(', ')

# Create an OpenStruct with these values
reservation_details = OpenStruct.new(
  id: id,
  external_id: external_id,
  state: state,
  rate_plan: rate_plan,
  services: services
)

puts reservation_details


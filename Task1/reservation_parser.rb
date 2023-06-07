# frozen_string_literal: true

require 'nokogiri'
require 'ostruct'

class ReservationParser
  attr_reader :reservation, :ns

  def initialize(file_path)
    doc = File.open(file_path) { |f| Nokogiri::XML(f) }

    # Define the namespace, other option is to remove namespaces all together 
    # but it doesn't keep the integrity of the xml if we want to work on namespaces afterwards
    @ns = {'ota' => 'http://www.opentravel.org/OTA/2003/05'}

    @reservation = doc.at_css('ota|OTA_HotelResNotifRQ > ota|HotelReservations > ota|HotelReservation', ns)
  end

  def reservation_details
    OpenStruct.new(
      id: reservation_id(10),
      external_id: reservation_id(16),
      state: state,
      rate_plan: rate_plan,
      services: services
    )
  end

  private
  
  def reservation_id(type_id)
    reservation.at_css("ota|ResGlobalInfo > ota|HotelReservationIDs > ota|HotelReservationID[ResID_Type='#{type_id}']", ns)['ResID_Value']
  end

  def state
    reservation['ResStatus']
  end

  def rate_plan
    reservation.at_css('ota|RoomStays > ota|RoomStay > ota|RatePlans > ota|RatePlan', ns)['RatePlanCode']
  end

  def services
    reservation.css('ota|RoomStays > ota|RoomStay > ota|Services > ota|Service', ns).map { |service| service.text.strip }
  end
end

compressed_xml_details = ReservationParser.new('xml_compressed.xml').reservation_details
puts "Compressed file results: #{compressed_xml_details}"

uncompressed_xml_details = ReservationParser.new('xml_uncompressed.xml').reservation_details
puts "Uncompressed file results: #{uncompressed_xml_details}"

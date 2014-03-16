require 'mapquestsearch/version'
require 'rest_client'
require 'json'
require 'rexml/document'

class MapQuestSearch

  CITY = 'city'
  LAT_LONG = 'lat_long'
  ALLOWED_FORMATS = [:json, :xml, :html]
  RETRY_COUNT = 5
  @@_default_format = nil

  #----------------------------

  def self.default_format
    @@_default_format || :json
  end

  def self.default_format=(format)
    raise "Invalid format #{format.to_s}" unless ALLOWED_FORMATS.include?(format)
    @@_default_format = format
  end

  def self.raw(search, format=nil, options={})
    format ||= MapQuestSearch.default_format
    mapquest_exec_search search, format, options
  end

  def city_lat_long(term, format, options={})
    result = mapquest_exec_search search, format, options
    result.detect{ |hash| hash[0] == CITY  }[lat_long].split(',').map{ |l| l.to_f }
  end

  private

  def self.mapquest_endpoint
    "http://open.mapquestapi.com/nominatim/v1/search.php"
  end

  def self.validate_format(format)
    raise "Invalid format type: #{format.class.to_s}:#{format.to_s}" unless format.is_a? Symbol
    raise "Invalid format option: #{format}" unless ALLOWED_FORMATS.include?(format)
    true
  end

  def self.mapquest_exec_search(search, format, options={})
    validate_format format
    options[:format] = format.to_s
    options[:q] = search


    begin
      result = RestClient.get MapQuestSearch.mapquest_endpoint, { params: options }
    rescue
      try_count ||= 0
      try_count += 1
      try_count > RETRY_COUNT ? (return nil) : retry
    end

    case format
    when :json
      return JSON.parse(result.to_str)
    when :xml
      return REXML::Document.new result.to_str
    else
      result.to_str
    end
  end
end

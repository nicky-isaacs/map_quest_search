require "mapquestsearch/version"
require 'rest_client'
require 'json'
require 'rexml/document'

class MapQuestSearch
  
  CITY = 'city'
  LAT_LONG = 'lat_long'
  ALLOWED_FORMATS = [:json, :xml, :html]
  @@_default_format = nil
  
  #----------------------------
  
  def self.default_format
    @@_default_format ||= :json
    @@_default_format
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
  
  def self.mapquest_exec_search(search, format, options={})
    options[:format] = format.to_s
    options[:q] = search
    result = RestClient.get MapQuestSearch.mapquest_endpoint, { params: options }
    
    case format
    when :json
      JSON.parse(result.to_str)
    when :xml
      REXML::Document.new result.to_str
    else
      result.to_str
    end
  end
end
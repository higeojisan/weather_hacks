require 'open-uri'
require 'json'
require 'rest-client'
require "weather_hacks/version"
require "weather_hacks/weather"

module WeatherHacks
  AREA_DATA = {
    '東京'   => '130010',
    '大島'   => '130020',
    '八丈島' => '130030',
    '父島'   => '130040',
  }.freeze
  URL = 'http://weather.livedoor.com/forecast/webservice/json/v1'.freeze
end

require "test_helper"

class WeatherTest < Minitest::Test
  def setup
    @url = WeatherHacks::URL + "?city=130010" ## 130010 = 東京
  end

  def test_initialize_with_success
    stub_request(:get, @url).to_return({status: 200, body: "{\"test\":\"test\"}", headers: {}})
    weather = WeatherHacks::Weather.new("東京")
    assert_instance_of WeatherHacks::Weather, weather
    assert_equal '130010', weather.city_id
    assert_instance_of Hash, weather.weather_data
  end

  def test_initialize_with_non_exist_city_name
    assert_raises ArgumentError do
      WeatherHacks::Weather.new('ああああ')
    end
  end

  def test_initialize_with_not_string
    assert_raises ArgumentError do
      WeatherHacks::Weather.new(88888)
    end
  end

  def test_initialize_with_response_code_207
    stub_request(:get, @url).to_return({status: 207, body: "", headers: {}})
    assert_raises RuntimeError do
      WeatherHacks::Weather.new('東京')
    end
  end

  def test_initialize_with_response_code_301
    stub_request(:get, @url).to_return({status: 301, body: "", headers: {}})
    assert_raises RuntimeError do
      WeatherHacks::Weather.new('東京')
    end
  end

  def test_initialize_with_response_code_4xx
    stub_request(:get, @url).to_return({status: 404, body: "", headers: {}})
    assert_raises RestClient::ExceptionWithResponse do
      WeatherHacks::Weather.new('東京')
    end
  end

  def test_initialize_with_response_code_5xx
    stub_request(:get, @url).to_return({status: 500, body: "", headers: {}})
    assert_raises RestClient::ExceptionWithResponse do
      WeatherHacks::Weather.new('東京')
    end
  end
end

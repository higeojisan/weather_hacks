module WeatherHacks
  class Weather
    attr_reader :city_id, :weather_data

    def initialize(city_name)
      @city_id = get_city_id(city_name)
      @weather_data = get_weather_json(@city_id)
    end

    private

    def get_city_id(city_name)
      if WeatherHacks::AREA_DATA.has_key?(city_name)
        WeatherHacks::AREA_DATA[city_name]
      else
        raise ArgumentError
      end
    end

    def get_weather_json(city_id)
      res = RestClient::Request.execute(
        method: :get, 
        url: WeatherHacks::URL,
        headers: {params: {city: city_id}},
        max_redirects: 0
      )
      if res.code == 200
        JSON.parse(res.body)
      else
        raise
      end
    end
  end
end

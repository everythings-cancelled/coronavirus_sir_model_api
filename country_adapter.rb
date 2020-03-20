require "httparty"

class CountryAdapter
    BASE_URL = "https://restcountries.eu/rest/v2/name/"
    attr_reader :country_name

    def initialize(country_name)
        @country_name = country_name
    end

    def population
        response.first["population"]
    end

    def alpha_2_code
        response.first["alpha2Code"]
    end

    def alpha_3_code
        response.first["alpha3Code"]
    end

    private

    def response
        return @response unless @response.nil?
        query_url = "#{country_name.downcase}?fullText=true"
        url = BASE_URL + query_url

        @response = HTTParty.get(url)
        @response
    end
end
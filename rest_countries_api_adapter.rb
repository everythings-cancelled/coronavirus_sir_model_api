require "httparty"

class RestCountriesApiAdapter
    attr_reader :base_url

    def initialize(base_url)
        @base_url = base_url
    end

    def country_population(country)
        query_url = "#{country.downcase}?fullText=true"
        url = base_url + query_url

        response = HTTParty.get(url)
        response.first["population"]
    end
end
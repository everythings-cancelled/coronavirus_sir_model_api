require "httparty"

class RestCountriesApiAdapter
    attr_reader :base_url, :country

    def initialize(base_url, country)
        @base_url = base_url
        @country = country
    end

    def country_population
        response.first["population"]
    end

    def country_code
        response.first["alpha2Code"]
    end

    private

    def response
        return @response unless @response.nil?
        query_url = "#{country.downcase}?fullText=true"
        url = base_url + query_url

        @response = HTTParty.get(url)
        @response
    end
end


=begin

=end
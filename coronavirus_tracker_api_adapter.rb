# https://coronavirus-tracker-api.herokuapp.com/v2/
class CoronavirusTrackerApiAdapter
    attr_reader :base_url, :country_code

    def initialize(base_url, country_code)
        @base_url = base_url
        @country_code = country_code
    end

    def confirmed
        response["locations"].first["latest"]["confirmed"]
    end

    def deaths
        response["locations"].first["latest"]["deaths"]
    end

    def recovered
        response["locations"].first["latest"]["recovered"]
    end

    private

    def response
        return @response unless @response.nil?
        url = base_url + "locations?country_code=#{country_code}"
        @response ||= HTTParty.get(url)
    end
end
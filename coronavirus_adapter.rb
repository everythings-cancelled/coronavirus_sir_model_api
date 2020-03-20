class CoronavirusAdapter
    # todo: move this out into a constants file...?
    BASE_URL = "https://coronavirus-tracker-api.herokuapp.com/v2/"

    attr_reader :alpha_2_code

    def initialize(alpha_2_code)
        @alpha_2_code = alpha_2_code
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
        url = BASE_URL + "locations?country_code=#{alpha_2_code}"
        @response ||= HTTParty.get(url)
    end
end
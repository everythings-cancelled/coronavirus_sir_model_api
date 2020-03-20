class WhoApiAdapter
    BASE_URL = "https://apps.who.int/gho/athena/api/GHO/WHS6_102"
    attr_reader :country_code

    def initialize(country_code)
        @country_code = country_code
    end

    def hospital_beds_per_10000_people
        response["fact"].first["value"]["numeric"]
    end

    private

    def response
        return @response unless @response.nil?
        url = BASE_URL + "?filter=COUNTRY:#{country_code}&format=json"
        
        @response = HTTParty.get(url)
        @response
    end

    # def response
    #     return @response unless @response.nil?
        

    # end
end

# https://apps.who.int/gho/athena/api/GHO/WHS6_102
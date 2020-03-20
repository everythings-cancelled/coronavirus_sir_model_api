require "httparty"

class SirModelApiAdapter
    DEFAULT_BASE_URL = "https://sir-model-api.herokuapp.com/v1/sir_model"

    def initialize(base_url: nil)
        @base_url = base_url
    end

    def base_url
        @base_url || DEFAULT_BASE_URL
    end

    def build_model(eons:, susceptible:, infected:, resistant:, rate_si:, rate_ir:, population:)
        query_string = "?eons=#{eons}&susceptible=#{susceptible}&infected=#{infected}&resistant=#{resistant}&rate_si=#{rate_si}&rate_ir=#{rate_ir}"
        url = base_url + query_string

        HTTParty.get(url)    
    end
end
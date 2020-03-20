class SirModelApiAdapter

    def initialize(url)
        @url = url
    end

    def build_model(eons:, susceptible:, infected:, resistant:, rate_si:, rate_ir:, population:)
        query_string = "?eons=#{eons}&susceptible=#{susceptible}&infected=#{infected}&resistant=#{resistant}&rate_si=#{rate_si}&rate_ir=#{rate_ir}"
        
    end
end
class Country
    attr_reader :adapter

    def initialize(adapter)
        @adapter = adapter
    end

    def name
        adapter.country_name
    end

    def population
        adapter.population
    end

    def alpha_2_code
        adapter.alpha_2_code
    end

    def alpha_3_code
        adapter.alpha_3_code
    end
end
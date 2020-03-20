class Coronavirus
    attr_reader :adapter

    def initialize(adapter)
        @adapter = adapter
    end

    def infected
        adapter.confirmed
    end

    def resistant
        adapter.recovered + adapter.deaths
    end

    def non_susceptible
        resistant - adapter.confirmed
    end
end
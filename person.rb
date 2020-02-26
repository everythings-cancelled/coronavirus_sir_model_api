class Person
    attr_reader :name, :age, :gender, :health_condition

    def initialize(name:, age:, gender:, health_condition:)
        @name = name
        @age = age
        @gender = gender
        @health_condition = health_condition
    end

    def policy_price
    end
end
class Employee
    attr_reader :name, :title

    def initialize(name, title)
        @name, @title = name, title
        @earnings = 0
    end

    def pay(number)
        @earnings += number
    end
end


__END__
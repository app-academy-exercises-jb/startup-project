require "employee"

class Startup
    attr_reader :name, :funding, :salaries

    def initialize(name, funding, salaries)
        @name, @funding, @salaries = name, funding, salaries
        @employees = []
    end

    def employees
        @employees
    end

    def valid_title?(title)
        salaries.keys.any? { |k| k == title }
    end

    def >(startup)
        @funding > startup.funding
    end

    def hire(employee, title)
        unless valid_title?(title)
            raise "invalid job title"
        else
            @employees << Employee.new(employee, title)
            true
        end
    end

    def size
        @employees.length
    end

    def pay_employee(employee)
        if @funding - @salaries[employee.title] >= 0
            employee.pay(@salaries[employee.title])
            @funding -= @salaries[employee.title]
        else
            raise "not enough funding to pay the employee"
        end
    end

    def payday
        @employees.each { |employee| pay_employee(employee) }
    end

    def average_salary
        total_salary = @salaries.select { |k, v| 
            @employees.any? { |employee| employee.title == k }
        }.values.sum
        
        total_salary / @employees.length
    end

    def close
        @employees = []
        @funding = 0
    end

    def acquire(startup)
        @funding += startup.funding
        startup.employees.each { |employee| @employees << employee }
        startup.salaries.select { |k, v| !(@salaries.include?(k)) }.each { |k, v| 
            @salaries[k] = v
        }
        startup.close
    end
end


__END__

rspec ./spec/startup_spec.rb:242 # Startup PART 3 #acquire should add the given startup's salaries to our @salaries, without overwriting any of our existing @salaries
rspec ./spec/startup_spec.rb:265 # Startup PART 3 #acquire should call Startup#close on the given startup
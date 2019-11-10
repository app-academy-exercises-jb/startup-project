require "employee"

class Startup
    attr_reader :name, :funding, :salaries

    def initialize(name, funding, salaries)
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
            false
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
end


__END__

rspec ./spec/startup_spec.rb:209 # Startup PART 3 #average_salary should return a number representing the average employee salary
rspec ./spec/startup_spec.rb:219 # Startup PART 3 #close should set @employees to an empty array
rspec ./spec/startup_spec.rb:226 # Startup PART 3 #close should set @funding to 0
rspec ./spec/startup_spec.rb:233 # Startup PART 3 #acquire should accept another startup as an arg
rspec ./spec/startup_spec.rb:237 # Startup PART 3 #acquire should add the given startup's funding to our @funding
rspec ./spec/startup_spec.rb:242 # Startup PART 3 #acquire should add the given startup's salaries to our @salaries, without overwriting any of our existing @salaries
rspec ./spec/startup_spec.rb:256 # Startup PART 3 #acquire should add the given startup's employees to our @employees
rspec ./spec/startup_spec.rb:265 # Startup PART 3 #acquire should call Startup#close on the given startup
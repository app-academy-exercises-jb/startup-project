require "employee"
require "byebug"

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
        total_salary = 0

        @employees.each { |employee|
            total_salary += @salaries[employee.title]
        }
        
        return total_salary / @employees.length
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
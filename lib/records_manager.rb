require 'app/models/salary'
require 'app/models/employee'

class RecordsManager

  def add_employee(fields)
    new_employee = Employee.new(fields)
    if new_employee.valid? 
      new_employee.save
    else
      return error_message_for(new_employee)
    end
  end

  private

  def error_message_for(employee)
    employee.errors.full_messages.to_s  
  end
end

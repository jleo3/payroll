require 'app/models/salary'
require 'app/models/employee'

class RecordsManager

  def add_employee(fields)
    new_employee = Employee.new(fields)
    return if new_employee.save
    error_message_for new_employee
  end

  private

  def error_message_for(employee)
    employee.errors.full_messages.to_s  
  end
end

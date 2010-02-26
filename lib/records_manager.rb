require 'app/models/salary'
require 'app/models/employee'

class RecordsManager
  EMPLOYEE_NOT_FOUND_MESSAGE = "Employee not found.  Cancelling delete."
  def add_employee(fields)
    new_employee = Employee.new(fields)
    return if new_employee.save
    error_message_for new_employee
  end

  def delete_employee(emp_id)
    return if Employee.delete_by_emp_id(emp_id)
    EMPLOYEE_NOT_FOUND_MESSAGE
  end

  private

  def error_message_for(employee)
    employee.errors.full_messages.to_s  
  end
end

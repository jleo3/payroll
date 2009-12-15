require 'lib/employee'

class RecordsManager

  def add_employee(fields)
    Employee.create! fields
  end

end

require 'test/unit'
require 'lib/records_manager'

class RecordsManagerTest < Test::Unit::TestCase

  def setup
    @any_id = 100
    @any_name = "name"
    @any_address = "address"
    @new_employee_fields = { :emp_id => @any_id,
                             :name => @any_name,
                             :address => @any_address,
                           }
    @records_manager = RecordsManager.new
  end

  def teardown
    Employee.all.each { |e| e.destroy }
  end

  def test_add_employee_creates_employee_record
    @records_manager.add_employee(@new_employee_fields)

    assert_equal 1, Employee.count
    @new_employee = Employee.first
    assert_equal @any_id, @new_employee.emp_id
    assert_equal @any_name, @new_employee.name
    assert_equal @any_address, @new_employee.address
  end

end

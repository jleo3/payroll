require 'test/unit'
require 'lib/records_manager'

class RecordsManagerTest < Test::Unit::TestCase

  def test_add_employee_creates_employee_record
    @records_manager = RecordsManager.new
    new_employee_fields = { :emp_id => 100,
                            :name => "Joe Leo",
                            :address => "645 East 14th St",
                            :pay_rate => Object.new }
    @records_manager.add_employee(new_employee_fields)
    assert_equal 1, Employee.all.size
  end
end

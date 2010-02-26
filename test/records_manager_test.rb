require File.join(File.dirname(__FILE__) ,'/test_helper')
require 'lib/records_manager'

class RecordsManagerTest < Test::Unit::TestCase
  NON_EXISTENT_EMP_ID = 99

  def setup
    DataMapper.auto_migrate!
    @any_id = 100
    @any_name = "name"
    @any_address = "address"
    @new_employee_fields = { :emp_id => @any_id,
                             :name => @any_name,
                             :address => @any_address,
                             :salary => new_salary('monthly')
                           }
    @employee_commission = 3.0
    @records_manager = RecordsManager.new
  end

  def teardown
    Employee.all.each { |e| e.destroy }
    Salary.all.each { |e| e.destroy }
  end

  def test_add_employee_creates_employee_record
    @records_manager.add_employee(@new_employee_fields)

    assert_employee_was_created
    assert_equal @any_id, new_employee.emp_id
    assert_equal @any_name, new_employee.name
    assert_equal @any_address, new_employee.address
  end

  def test_delete_employee_deletes_employee_record
    @employee = create_one_employee

    assert_employee_was_deleted do
      @records_manager.delete_employee(@employee.emp_id)
    end
  end

  def test_delete_employee_emp_id_not_found
    assert_equal RecordsManager::EMPLOYEE_NOT_FOUND_MESSAGE, @records_manager.delete_employee(NON_EXISTENT_EMP_ID)    
  end

  def test_add_employee_creates_hourly_rate_employee
    hourly_salary = new_salary('hourly')
    assert_creation_of_employee_with hourly_salary
  end

  def test_add_employee_creates_monthly_rate_employee
    monthly_salary = new_salary('monthly')
    assert_creation_of_employee_with monthly_salary
  end

  def test_add_employee_creates_commission_employee
    commission_salary = new_salary('monthly', @employee_commission)
    assert_creation_of_employee_with commission_salary
  end

  def test_add_employee_fails_when_provided_no_emp_id
    assert_employee_not_created_with_nil :emp_id
  end

  def test_add_employee_fails_when_provided_no_name
    assert_employee_not_created_with_nil :name
  end

  def test_add_employee_fails_when_provided_no_ddress
    assert_employee_not_created_with_nil :address
  end


  private
  def create_one_employee
    @records_manager.add_employee(@new_employee_fields)
    assert_employee_was_created
    Employee.first
  end

  def assert_employee_was_created
    assert_equal 1, Employee.count
  end
    
  def assert_creation_of_employee_with(salary)
    @new_employee_fields[:salary] = salary
    
    @records_manager.add_employee(@new_employee_fields)
    assert_equal salary, new_employee.salary
  end

  def assert_employee_was_deleted
    new_employee_count = Employee.count - 1
    yield
    assert_equal new_employee_count, Employee.count
  end

  def assert_employee_not_created_with_nil(field)
    @new_employee_fields[field] = nil
    error_message = "must not be blank"
    assert_match error_message, @records_manager.add_employee(@new_employee_fields)
  end

  def new_salary(compensation, commission=nil)
    Salary.new :pay_rate => pay_rate(compensation),
               :compensation => compensation,
               :commission => commission
  end

  def pay_rate(type)
    return 5000 if type == 'monthly'
    return 12.50 if type == 'hourly'
  end
  
  def new_employee
    Employee.first
  end

end

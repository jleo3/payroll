require 'rubygems'
require 'dm-core'
require 'dm-aggregates'
require 'dm-validations'
require 'app/models/salary'

DataMapper.setup(:default, :adapter => 'mysql',
                  :username => 'root',
                  :password => 'even-fish',
                  :database => 'payroll')
class Employee
  include DataMapper::Resource

  property :id,       Serial
  property :emp_id,   Integer
  property :name,     String
  property :address,  Text

  has 1, :salary

  validates_present :emp_id, :name, :address
  validates_is_unique :emp_id

  def self.delete_by_emp_id(id)
    if emp = Employee.first(:emp_id => id)
      emp.destroy!
    else return false
    end
  end
end

require_relative('../db/sql_runner.rb')

class Customer

  attr_accessor(:name, :funds)
  attr_reader(:id)

  def initialize(options)
    @id = options['id'].to_i() if options['id']
    @name = options['name']
    @funds = options['funds'].to_i()
  end


  def save()
    sql = ("INSERT INTO customers (name, funds) VALUES ($1, $2) RETURNING id")
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values).first
    @id = customer['id'].to_i()
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def self.all()
    sql = "SELECT * FROM customers"
    customers = SqlRunner.run(sql)
    return Customers.map_customers(customers)
  end

  def self.map_customers(customers_data)
    return customers_data.map {|customer| Customer.new(customer)}
  end
end

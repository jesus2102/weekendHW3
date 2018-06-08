require_relative('../db/sql_runner.rb')
require_relative('./ticket.rb')
require_relative('./customer.rb')

class Film

  attr_accessor(:name, :price)
  attr_reader(:id)

  def initialize(options)
    @id = options['id'].to_i() if options['id']
    @title =  options['title']
    @price = options['price'].to_i()
  end

  def save()
    sql = ("INSERT INTO films (title, price) VALUES ($1, $2) RETURNING id")
    values = [@title, @price]
    film = SqlRunner.run(sql, values).first
    @id = film['id'].to_i()
  end

  def self.all()
    sql = "SELECT * FROM films"
    films = SqlRunner.run(sql)
    return Film.map_films(films)
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  def update()
    sql = "UPDATE films SET (title, price) = ($1, $2) where id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def self.map_films(films_data)
    return films_data.map {|film| Film.new(film)}
  end

  def customers()
    sql = "SELECT customers.*
    FROM customers
    INNER JOIN tickets
    ON customers.id = tickets.customer_id
    WHERE tickets.film_id = $1"
    values = [@id]
    show_customers = SqlRunner.run(sql, values)
    return Customer.map_customers(show_customers)
  end

end

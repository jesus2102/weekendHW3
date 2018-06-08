require_relative('../db/sql_runner.rb')
require_relative('./ticket.rb')
require_relative('./film.rb')

class Customer

  attr_accessor(:name, :funds)
  attr_reader(:id)

  def initialize(options)
    @id = options['id'].to_i() if options['id']
    @name = options['name']
    @funds = options['funds'].to_i()
  end


  def save()
    sql = "INSERT INTO customers (name, funds) VALUES ($1, $2) RETURNING id"
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
    return Customer.map_customers(customers)
  end

  def update()
    sql = "UPDATE customers SET (name, funds) = ($1, $2) where id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def self.map_customers(customers_data)
    return customers_data.map {|customer| Customer.new(customer)}
  end

  def get_tickets()
    sql = "SELECT films.*
    FROM films
    INNER JOIN tickets
    ON films.id = tickets.film_id
    WHERE tickets.customer_id = $1"
    values = [@id]
    show_movies = SqlRunner.run(sql, values)
    return Film.map_films(show_movies)
  end

  def self.get_tickets()
    sql = "SELECT customers.name, films.title
     FROM tickets
     INNER JOIN customers
     ON customers.id = tickets.customer_id
     INNER JOIN films
     ON tickets.film_id = films.id"
     values = SqlRunner.run(sql)
     return values.map {|value| {name:value['name'], title:value['title']}}
  end

  # def check_price(film)
  #   sql = "SELECT films.price
  #   FROM films
  #   WHERE films.id = $1"
  #   values = [film.id]
  #   movie_data = SqlRunner.run(sql, values).first()
  #   price_movie = movie_data['price'].to_i
  #   return price_movie / 100.0
  # end


  def buy_ticket(film)

    price = film.price()
    if price < @funds
      @funds -= price
      update()
      ticket = Ticket.new({'customer_id' => @id, 'film_id' => film.id})
      ticket.save()
      return ticket
    else
      return "Talk to you boss. Maybe you need an advance..."
    end

  end
end

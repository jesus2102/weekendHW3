require_relative('../db/sql_runner.rb')

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

  def self.map_films(films_data)
    return films_data.map {|film| Film.new(film)}
  end

end

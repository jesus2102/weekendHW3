require_relative('../db/sql_runner.rb')

attr_accessor(:name, :price)
attr_reader(:id)

class Film

  def initialize(options)
    @id = options['id'].to_i() if options['id']
    @title =  options['title']
    @price = options['price'].to_i()
  end


end

require_relative('../db/sql_runner.rb')

attr_accessor(:name)
attr_reader(:id)

class Customer

  def initialize(options)
    @id = options['id'].to_i() if options['id']
    @name = options['name']
    @funds = options['funds'].to_i()
  end

end

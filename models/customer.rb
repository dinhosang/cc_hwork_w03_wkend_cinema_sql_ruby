require_relative('../db/sql_runner')


class Customer



  def initialize(options_hash)
    @id = options_hash['id'].to_i if options_hash['id']
    @name = options_hash['name']
    @funds = options_hash['funds'].to_i
  end


  def save()
    sql = "
    INSERT INTO customers (name, funds)
    VALUES ($1, $2)
    "
    values = [@name, @funds]
    SqlRunner.run(sql, values)
  end


end

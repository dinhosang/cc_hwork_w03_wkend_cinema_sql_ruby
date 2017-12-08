require_relative('../db/sql_runner')


class Film



  def initialize(options_hash)
    @id = options_hash['id'].to_i if options_hash['id']
    @title = options_hash['title']
    @price = options_hash['price'].to_i
  end


  def save()
    sql = "
    INSERT INTO films (title, price)
    VALUES ($1, $2)
    "
    values = [@title, @price]
    SqlRunner.run(sql, values)
  end


end

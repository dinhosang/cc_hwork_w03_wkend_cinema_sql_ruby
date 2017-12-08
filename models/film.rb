require_relative('../db/sql_runner')


class Film

  attr_reader :id

  def initialize(options_hash)
    @id = options_hash['id'].to_i if options_hash['id']
    @title = options_hash['title']
    @price = options_hash['price'].to_i
  end


  def save()
    sql = "
    INSERT INTO films (title, price)
    VALUES ($1, $2)
    RETURNING id;
    "
    values = [@title, @price]
    id_hash = SqlRunner.run(sql, values).first
    @id = id_hash['id'].to_i
  end


end

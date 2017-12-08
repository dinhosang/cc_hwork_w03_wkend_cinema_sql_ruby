require_relative('../db/sql_runner')


class Film

  attr_reader :id
  attr_accessor :title, :price

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


  def update()
    sql = "
    UPDATE films
    SET (title, price) = ($1, $2)
    WHERE id = $3;
    "
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end


  def delete()
    sql = "DELETE FROM films WHERE id = $1;"
    SqlRunner.run(sql, [@id])
  end


  def Film.delete_all()
    sql = "DELETE FROM films;"
    SqlRunner.run(sql)
  end


end

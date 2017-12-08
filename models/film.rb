require_relative('../db/sql_runner')
require_relative('customer')


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


  def customers()
    sql = "
    SELECT customers.* FROM customers
    INNER JOIN tickets
    ON customers.id = tickets.customer_id
    INNER JOIN films
    ON tickets.film_id = films.id
    WHERE films.id = $1;
    "
    c_hashes = SqlRunner.run(sql, [@id])
    customer_objects = Customer.mapper(c_hashes)
    return customer_objects
  end


  def Film.mapper(f_hashes)
    films = f_hashes.map do |f_hash|
      Film.new(f_hash)
    end
    return films
  end


  def Film.delete_all()
    sql = "DELETE FROM films;"
    SqlRunner.run(sql)
  end


end

require_relative('../db/sql_runner')
require_relative('customer')


class Film

  attr_reader :id, :screen_limit
  attr_accessor :title, :price

  def initialize(options_hash)
    @id = options_hash['id'].to_i if options_hash['id']
    @title = options_hash['title']
    @price = options_hash['price'].to_i
    @times = options_hash['times']
    @screen_limit = 3
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
    save_times()
  end


  def availability?()
    sql = "
    SELECT COUNT(*) FROM tickets WHERE tickets.film_id = $1 GROUP BY tickets.film_id
    "
    bookings_hash = SqlRunner.run(sql, [@id]).first
    if bookings_hash == nil
      return true
    elsif bookings = bookings_hash['count'].to_i
      if bookings >= @screen_limit
        return false
      else
        return true
      end
    end
  end


  def save_times()
    for time in @times
      sql = "
      INSERT INTO screenings (film_id, film_time)
      VALUES ($1, $2);
      "
      values = [@id, time]
      SqlRunner.run(sql, values)
    end
  end

# need to rework to go with new times
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


  def customer_count()
    sql = "
    SELECT COUNT(*) FROM tickets
    WHERE tickets.film_id = $1;
    "
    count_hash = SqlRunner.run(sql, [@id])[0]
    return count_hash['count'].to_i
  end


  def busiest_time()
    sql = "
    SELECT screenings.film_time, count(*)
    FROM screenings
    INNER JOIN tickets
    ON tickets.screening_id = screenings.id
    WHERE screenings.film_id = $1 GROUP BY screenings.film_time
    ORDER BY count DESC;
    "
    count_of_times = SqlRunner.run(sql, [@id])
    most_popular_times = []
    current_most_popular_count = 0
    for count in count_of_times
      if current_most_popular_count == 0
        most_popular_times.push(count['film_time'])
        current_most_popular_count = count['count'].to_i
      elsif count['count'].to_i == current_most_popular_count
        most_popular_times.push(count['film_time'])
      elsif count['count'].to_i > current_most_popular_count
        most_popular_times = []
        most_popular_times.push(count['film_time'])
        current_most_popular_count = count['count'].to_i
      end
    end
    return most_popular_times
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

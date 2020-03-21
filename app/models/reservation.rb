class Reservation < Sequel::Model
  many_to_one :movie

  DAYS = %w(mon tue wed thu fri sat sun)

  def validate
    super
    errors.add(:movie_id, 'cannot be empty') if !movie_id
    errors.add(:movie, 'must exist in the system') if !Movie.get(movie_id)
    errors.add(:date, 'cannot be empty') if !date || date.empty?
    errors.add(:date, 'must match with movie days') if !valid_date(movie_id, date)
    errors.add(:total_seats, 'cannot be empty') if !total_seats || total_seats.empty?
  end

  def valid_date(movie_id, date)
    begin
      parsed_date = Date.parse(date).cwday
      formatted_date = Date::DAYNAMES[parsed_date].downcase[0..2]
      movie_days = Movie.get(movie_id).days
      movie_days.split(',').include?(formatted_date)
    rescue Date::Error
      nil
    end
  end
end

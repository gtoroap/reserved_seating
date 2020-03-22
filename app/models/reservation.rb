class Reservation < Sequel::Model
  many_to_one :movie

  AVAILABLE_SEATS = 10

  def validate
    super
    errors.add(:movie, 'cannot be empty') if !movie_id
    errors.add(:movie, 'must exist in the system') if !Movie.get(movie_id)
    errors.add(:date, 'cannot be empty') if !date || date.empty?
    errors.add(:date, 'must match with movie days') if !valid_date(movie_id, date)
    errors.add(:seats, 'cannot be empty') if !seats
    errors.add(:reservation, 'cannot be created because it exceeds available seats') if !available_seats(movie_id, date, seats)
  end

  def valid_date(movie_id, date)
    begin
      parsed_date = Date.parse(date).cwday
      formatted_date = Date::DAYNAMES[parsed_date].downcase[0..2]
      movie = Movie.get(movie_id)
      if movie
        movie_days = movie.days
        movie_days.split(',').include?(formatted_date)
      end
    rescue Date::Error
      nil
    end
  end

  def available_seats(movie_id, date, seats)
    reserved_seats = Reservation.where(movie_id: movie_id, date: date).all.map(&:seats)
    reserved_seats.sum + seats <= AVAILABLE_SEATS
  end
end

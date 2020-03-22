require 'dry-transaction'

class CreateReservation
  include Dry::Transaction

  step :validate
  step :persist

  def validate(data)
    reservation = Reservation.new(movie_id: data[:movie_id], client_fullname: data[:client_fullname], date: data[:date], seats: data[:seats])
    if reservation.valid?
      Success(reservation)
    else
      Failure(errors: reservation.errors)
    end
  end

  def persist(movie_id:, date:, client_fullname:, seats:)
    movie = Movie.get(movie_id)
    reservation = movie.add_reservation(date: date, client_fullname: client_fullname, seats: seats)
    Success(reservation)
  end
end
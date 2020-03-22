require 'dry-transaction'

class ListReservation
  include Dry::Transaction

  step :list

  def list(params)
    start_date = params[:start_date]
    end_date = params[:end_date]
    
    if valid_date_range(start_date, end_date)
      reservations = Reservation.where(date: Date.parse(start_date)..Date.parse(end_date)).all
      Success(reservations)
    else
      Failure(error: 'Date range is invalid')
    end
  end

  def valid_date_range(start_date, end_date)
    Date.parse(end_date) >= Date.parse(start_date)
  end
end
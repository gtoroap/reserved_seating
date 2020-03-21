class Reservation < Sequel::Model
  DAYS = %w(mon tue wed thu fri sat sun)

  def validate
    super
    errors.add(:date, 'cannot be empty') if !date || date.empty?
    errors.add(:total_seats, 'cannot be empty') if !total_seats || total_seats.empty?
  end
end
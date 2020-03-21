class Movie < Sequel::Model
  one_to_many :reservations

  DAYS = %w(mon tue wed thu fri sat sun)

  def validate
    super
    errors.add(:name, 'cannot be empty') if !name || name.empty?
    errors.add(:description, 'cannot be empty') if !description || description.empty?
    errors.add(:days, 'cannot be empty') if !days || days.empty?
    errors.add(:days, 'must have formatted valid days') unless valid_days(days)
  end

  def valid_days(days)
    (days.split(',') - DAYS).empty?
  end

  private

  def self.get(id)
    where(id: id).first
  end
end
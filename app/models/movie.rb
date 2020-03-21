class Movie < Sequel::Model
  def validate
    super
    errors.add(:name, 'cannot be empty') if !name || name.empty?
  end
end
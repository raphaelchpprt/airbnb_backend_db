class Reservation < ApplicationRecord
  validates :start_date, :end_date,
    presence: true
  validate :start_must_be_before_end_time
  validate :overlapping?

  belongs_to :listing
  belongs_to :guest, class_name: "User"

  def start_must_be_before_end_time
    errors.add(:start_date, "must be before end date") unless 
    start_date < end_date
  end

  def duration
    ((self.end_date.to_i - self.start_date.to_i) / 86400).to_s + " jours"
  end

  def overlapping?
    errors.add(:start_date, "cannot overlap") if
      listing.overlapping_reservation?(start_date, end_date)
    errors.add(:end_date, "cannot overlap") if
      listing.overlapping_reservation?(start_date, end_date)
  end
end

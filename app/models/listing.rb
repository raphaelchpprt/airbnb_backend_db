class Listing < ApplicationRecord
  belongs_to :city
  has_many :reservations
# has_many :guests, class_name: "User", through: :reservations
  belongs_to :admin, class_name: "User"
  
 validates :available_beds, :price,
   presence: true,
    numericality: { only_integer: true, greater_than: 0 }
  validates :description,
    presence: true,
    length: { minimum: 140 }
    
  after_create :welcome_message

  def overlapping_reservation?(datetime_beg, datetime_end)
    # vérifie dans toutes les réservations du listing s'il y a une réservation qui tombe sur le datetime en entrée
    self.reservations.each do |r|
      if (datetime_beg >= r.start_date && datetime_beg <= r.end_date) || (datetime_end >= r.start_date && datetime_end <= r.end_date)
        return true
      end
    end
    false
  end

end


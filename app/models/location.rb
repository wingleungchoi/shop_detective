class Location
  include ::Mongoid::Document
  include ::Mongoid::Timestamps

  embedded_in :company
  embedded_in :zip

  field :address, type: String
  field :longitude, type: BigDecimal
  field :latitude, type: BigDecimal

end
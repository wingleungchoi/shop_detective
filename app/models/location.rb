class Location
  include ::Mongoid::Document
  include ::Mongoid::Timestamps

  embedded_in :company

  field :address, type: String
  field :longitude, type: BigDecimal
  field :latitude, type: BigDecimal

end
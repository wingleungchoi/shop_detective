class Location
  include ::Mongoid::Document
  include ::Mongoid::Timestamps

  embedded_in :company
  embedded_in :state
  embedded_in :zip

  field :address, type: String
  field :longitude, type: BigDecimal
  field :latitude, type: BigDecimal

  before_validation :set_longitude_and_latitude

private
  def set_longitude_and_latitude
    if self.address.present? && self.address_changed?
      geokit = Geokit::Geocoders::GoogleGeocoder.geocode(self.address)
      longitude_and_latitude = geokit.ll.split(',')
      # FYI, that .ll method means "latitude longitude".
      self.latitude = longitude_and_latitude[0]
      self.longitude = longitude_and_latitude[1]
    end
  end
end
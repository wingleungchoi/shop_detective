class State
  include ::Mongoid::Document
  include ::Mongoid::Timestamps

  embedded_in :country
  embeds_many :zips
  embeds_many :locations

  field :name, type: String
  field :code, type: String

  before_validation :set_state_name

private
  def set_state_name
    if self.code.present? && self.code_changed?
      geokit = Geokit::Geocoders::GoogleGeocoder.geocode(self.code)
      self.name = geokit.state_name
    end
  end
end
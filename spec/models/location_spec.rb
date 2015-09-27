require 'spec_helper'
RSpec.describe Location do
  describe "#set_longitude_and_latitude" do
    it 'set longitudes and latitudes when address is present and changed' do
      location_1 = build(:location, address: 'Hong Kong University')
      location_1.save
      expect(location_1.latitude).to eq(22.2829989)
      expect(location_1.longitude).to eq(114.1370848)
    end
    it 'does nothing when address is blank or remains unchanged' do
      location_1 = build(:location, address: '')
      location_1.save
      expect(location_1.longitude).to eq(nil)
      expect(location_1.latitude).to eq(nil)
    end
  end
end
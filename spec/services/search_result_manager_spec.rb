require 'spec_helper'
RSpec.describe SearchResultManager do
  describe '#get_companies_json' do
    context 'when self_results is nil or an empty array' do
      it 'returns empty json' do
        search_result_manager = SearchResultManager.new
        expect(search_result_manager.get_companies_json).to eq([].to_json)
      end
    end
    context 'when self_results contains impurities i.e. not pure company instances' do
      it 'raises error' do
        company_1  = create(:company)
        industry_1 = create(:organization_kind)
        search_results_manager = SearchResultManager.new(results: [company_1, industry_1])
        expect{ search_results_manager.get_companies_json }.to raise_error('The search results are not purely company instances')
      end
    end # when self_results contains impurities i.e. not pure company instances

    context 'when self_results is of only company instances' do
      it 'returns json of array of companies for frontend' do
        company_1  = create(:company)
        location_1 = create(:location, company: company_1)
        company_2  = create(:company)
        location_2 = create(:location, company: company_2)
        search_results_manager = SearchResultManager.new(results: [company_1, company_2])
        expect_result = [
          {
            :company_name    => company_1.name,
            :latitude        => company_1.locations.first.latitude,
            :longitude       => company_1.locations.first.longitude,
            :subcategoy_name => company_1.subcategory.name,
            :zip_code        => company_1.locations.first.zip.code,
            :state_name      => company_1.locations.first.zip.state.name,
            :state_code      => company_1.locations.first.zip.state.code,
            :country_name    => company_1.locations.first.zip.state.country.name
          },
          {
            :company_name    => company_2.name,
            :latitude        => company_2.locations.first.latitude,
            :longitude       => company_2.locations.first.longitude,
            :subcategoy_name => company_2.subcategory.name,
            :zip_code        => company_2.locations.first.zip.code,
            :state_name      => company_2.locations.first.zip.state.name,
            :state_code      => company_2.locations.first.zip.state.code,
            :country_name    => company_2.locations.first.zip.state.country.name
          }
        ].to_json
        expect(search_results_manager.get_companies_json).to eq(expect_result)
      end
    end # when self_results is of only company instances
  end
end
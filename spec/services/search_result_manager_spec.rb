require 'spec_helper'
RSpec.describe SearchResultManager do
  describe '#get_companies_json' do
    context 'when self_results is nil or an empty array' do
      it 'returns empty json' do
        search_result_manager = SearchResultManager.new
        expect(search_result_manager.get_companies_json).to eq({}.to_json)
      end
    end
    context 'when self_results contains impurities i.e. not pure company instances' do
      it 'raises error' do
        company_1  = create(:company)
        industry_1 = create(:organization_kind)
        search_results_manager = SearchResultManager.new(result: [company_1, industry_1])
        expect{ search_results_manager.get_companies_json }.to raise_error('The search results are not purely company instances')
      end
    end
    context 'when self_results is of only company instances' do
      it 'returns json of array of companies for frontend'
    end
  end
end
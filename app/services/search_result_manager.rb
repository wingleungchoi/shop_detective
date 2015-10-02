class SearchResultManager
  attr_accessor :results 
  # results = an array of instances rather than ids
  # because loading from database is expenseive

  def initialize(attributes = {})
    @results = attributes[:results]
  end

  def get_companies_json
    return [].to_json if self.results.blank?
    raise StandardError.new('The search results are not purely company instances') if self.results.map { |r| r.class.name }.uniq != ['Company']

    company_data = []
    self.results.each do |company|
      company_data << {
        :company_name    => company.name,
        :latitude        => company.locations.last.latitude,
        :longitude       => company.locations.last.longitude,
        :subcategoy_name => company.subcategory.name,
        :zip_code        => (company.locations.last.zip.code if company.locations.last.zip != nil ),
        :state_name      => company.locations.last.state.name,
        :state_code      => company.locations.last.state.code,
        :country_name    => company.locations.last.state.country.name
      }
    end # self.results.each do |company|
    company_data.to_json
  end
end
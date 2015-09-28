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
        :latitude        => company.locations.first.latitude,
        :longitude       => company.locations.first.longitude,
        :subcategoy_name => company.subcategory.name,
        :zip_code        => company.locations.first.zip.code,
        :state_name      => company.locations.first.zip.state.name,
        :state_code      => company.locations.first.zip.state.code,
        :country_name    => company.locations.first.zip.state.country.name
      }
    end # self.results.each do |company|
    company_data.to_json
  end
end
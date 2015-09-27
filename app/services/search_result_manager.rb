class SearchResultManager
  attr_accessor :result 
  # result = an array of instances rather than ids
  # because loading from database is expenseive

  def initialize(attributes = {})
    @result = attributes[:result]
  end

  def get_companies_json
    return {}.to_json if self.result.blank?
    raise StandardError.new('The search results are not purely company instances') if self.result.map { |r| r.class.name }.uniq != ['Company']
  end
end
require 'nokogiri'
require 'open-uri'
require 'pry'
#Assumption: it is used at 'www.yelp.com'
class DataScrapper # class or module? which is better

  attr_accessor :document_url

  def initialize(attributes = {})
    @document_url = attributes[:document_url]
  end

  def surf_page
    Nokogiri::HTML(open(self.document_url, 
        "User-Agent" => "Ruby/#{RUBY_VERSION}",
        "From" => "foo@bar.invalid",
        "Referer" => "http://www.ruby-lang.org/"
      )
    ) # be a good citizen http://stackoverflow.com/questions/8628337/503-error-when-using-rubys-open-uri-to-access-a-specific-site
  end

  def search_by_css(doc, css)
    # Parse HTML. HTML is a Convenience method for Nokogiri::HTML::Document.parse
    results = []
    doc.css(css).each do |link|
      results << link.content
    end
    results
  end

  def search_companies(keyword, type)
    case type
    when 'state'
      self.search_companies_by_state(keyword)
    when 'zip'
      self.search_companies_by_zip(keyword)
    else
      raise StandardError.new("Someone trid to hack us")
    end
  end

  def search_companies_by_state(keyword)
    keyword = keyword.strip.gsub(/[\ ]/, '+')
    self.document_url += "/search?find_desc=&find_loc=#{keyword}"
    doc = self.surf_page
    results = []
    company_name = self.search_by_css(doc, 'li.regular-search-result div[data-key="1"] a.biz-name')[0]
    if company_name != nil
      business = OrganizationKind.find_or_create_by(name: "Business")
      subcatgory_name = self.search_by_css(doc, 'li.regular-search-result div[data-key="1"] div.price-category a')[0].strip
      subcatgory = business.subcategories.find_or_create_by(name: subcatgory_name)
      company = subcatgory.companies.find_or_create_by(name: company_name)
      country = Country.find_or_create_by(name: 'US')
      state_code = self.search_by_css(doc, 'div.search-header h1')[0].strip.match(/[A-Z]{2,3}/)[0]
      state = country.states.find_or_create_by(code: state_code)
      location_address = self.search_by_css(doc, 'li.regular-search-result div[data-key="1"] address')[0].strip
      zip_code = location_address.match(/[0-9]{5}/)[-1]
      zip = state.zips.find_or_create_by(code: zip_code) if zip_code != nil
      if zip_code == nil
        company.locations.find_or_create_by(address: location_address)       
      else
        company.locations.find_or_create_by(address: location_address, zip: zip)
      end
      results << company
    end
    binding.pry
    results
  end

  def search_companies_by_zip(keyword)
    
  end
end
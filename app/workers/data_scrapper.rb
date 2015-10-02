require 'nokogiri'
require 'open-uri'
#Assumption: it is used at 'www.yelp.com'
class DataScrapper # class or module? which is better

  attr_accessor :document_url

  def initialize(attributes = {})
    @document_url = attributes[:document_url]
  end

  def surf_page(url = nil)
    Nokogiri::HTML(open((url || self.document_url), 
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

  def search_companies(keyword, type, max_result_total = 200)
    case type
    when 'state'
      self.search_companies_by_state(keyword, max_result_total)
    when 'zip'
      self.search_companies_by_zip(keyword, max_result_total)
    else
      raise StandardError.new("Someone trid to hack us")
    end
  end

  def search_companies_by_state(keyword, max_result_total = 200)
    puts 'Come on, man, i expected max_result_total is multiples of 10' if (max_result_total % 10) != 0
    keyword = keyword.strip.gsub(/[\ ]/, '+')
    results = []
    (0..((max_result_total - 10)/10)).to_a.map { |e| e*10 }.each do |data_start|
      url = self.document_url + "/search?find_desc=&find_loc=#{keyword}#start=#{data_start}"
      doc = self.surf_page(url)
      resuslt_on_a_page = search_yelp_page(doc, page_index_start = data_start)
      results += resuslt_on_a_page
    end
    results
  end

  def search_companies_by_zip(keyword, max_result_total = 200)
    puts 'Come on, man, i expected max_result_total is multiples of 10' if (max_result_total % 10) != 0
    keyword = keyword.strip.gsub(/[\ ]/, '+')
    results = []
    (0..((max_result_total - 10)/10)).to_a.map { |e| e*10 }.each do |data_start|
      url = self.document_url + "/search?find_desc=&find_loc=#{keyword}#start=#{data_start}"
      doc = self.surf_page(url)
      resuslt_on_a_page = search_yelp_page(doc, page_index_start = data_start)
      results += resuslt_on_a_page
    end
    results
  end

  def search_yelp_page(doc, page_index_start = 0)
    results = []
    business = OrganizationKind.find_or_create_by(name: "Business")
    (1..10).to_a.map { |e| e += page_index_start }.each do |d_key|
      company_name = self.search_by_css(doc, "li.regular-search-result div[data-key=\"#{d_key}\"] a.biz-name")[0]
      if company_name != nil
        subcatgory_name = self.search_by_css(doc, "li.regular-search-result div[data-key=\"#{d_key}\"] div.price-category a")[0].strip
        subcatgory = business.subcategories.find_or_create_by(name: subcatgory_name)
        company = subcatgory.companies.find_or_create_by(name: company_name)
        country = Country.find_or_create_by(name: 'US')
        state_code = self.search_by_css(doc, 'div.search-header h1')[0].strip.match(/[A-Z]{2,3}/)[0]
        state = country.states.find_or_create_by(code: state_code)
        location_address = self.search_by_css(doc, "li.regular-search-result div[data-key=\"#{d_key}\"] address")[0].strip
        zip_code = location_address.match(/[0-9]{5}/).try(:[], -1)
        zip = state.zips.find_or_create_by(code: zip_code) if zip_code != nil
        if zip_code == nil
          company.locations.find_or_create_by(address: location_address, state: state)
        else
          company.locations.find_or_create_by(address: location_address, zip: zip, state: state)
        end
        results << company
      else
        return results # stop the loop because there is no following result
      end # end company_name != nil
    end
    results
  end # search_yelp_page
end
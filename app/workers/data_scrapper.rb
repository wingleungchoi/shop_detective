require 'nokogiri'
require 'open-uri'
require 'pry'
class DataScrapper # class or module? which is better

  attr_accessor :document_url

  def initialize(attributes = {})   
        @document_url = attributes[:document_url]
  end

  def search_by_css(css)
    # Parse HTML. HTML is a Convenience method for Nokogiri::HTML::Document.parse
    results = []
    doc = Nokogiri::HTML(open(self.document_url))
    doc.css(css).each do |link|
      results << link.content
    end
    results
  end
end
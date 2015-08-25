require File.expand_path '../spec_helper.rb', __FILE__
require File.expand_path '../../app/workers/data_scrapper.rb', __FILE__
require 'pry'
RSpec.describe DataScrapper do
  describe "#search_by_css" do
    let(:scrapper){ DataScrapper.new(document_url: 'http://wingleungchoi.github.io/')}
    it "will read the nodes which meet css" do 
      
    end
    it "will return nothing i.e. nil when no nodes match" do 
      expect(scrapper.search_by_css("div#content div.topText h6")).to eq([])
    end
    it "will return nodes which meets nodes" do 
      expect(scrapper.search_by_css("div#content div.topText h1")).to eq(["Hi! I am a fresh developer. This is a personal page about me. Hope you guys enjoy! :)"])
    end
  end 
end
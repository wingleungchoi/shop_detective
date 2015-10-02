require 'spec_helper'
RSpec.describe DataScrapper do
  describe "#search_by_css" do
    before(:all) do
      @scrapper = DataScrapper.new(document_url: 'http://www.yelp.com')
      @doc1 = @scrapper.surf_page
    end
    it "will read the nodes which meet css" do 
      # Yes, it is a redundant test.
    end

    it "will return nothing i.e. nil when no nodes match" do 
      expect(@scrapper.search_by_css(@doc1, "div#content div.topText h6")).to eq([])
    end

    it "will return nodes which meets nodes" do 
      expect(@scrapper.search_by_css(@doc1, "div#logo.main-header_logo a")).to eq(["Yelp"])
    end
  end

  describe "#search_companies(keyword, type)" do 
    before(:all) do
      @scrapper = DataScrapper.new(document_url: 'http://www.yelp.com')
      @doc1 = @scrapper.surf_page
    end
    context "when type is 'state'" do
      it 'will call search_companies_by_state' do
        expect(@scrapper).to receive(:search_companies_by_state).with('New York', 200)
        @scrapper.search_companies('New York', 'state')
      end # "when type is 'state'"
    end

    context "when type is 'zip'" do
      it 'will call search_companies_by_zip' do
        expect(@scrapper).to receive(:search_companies_by_zip).with('000032', 200)
        @scrapper.search_companies('000032', 'zip')
      end #when type is 'zip'"
    end

    context "when type is other " do
      it 'raise Error' do 
        expect{@scrapper.search_companies('hacker testing', 'HACK')}.to raise_error("Someone trid to hack us")
      end
    end
  end

  describe "search_companies_by_state(keyword)" do 
    it "returns array compaines which matchs" do 
      scrapper = DataScrapper.new(document_url: 'http://www.yelp.com')
      search_result = scrapper.search_companies_by_state('New York', 10)
      expect(search_result.count).to eq(10)
      expect(search_result.map { |e| e.class.name }.uniq).to eq(['Company'])
    end
    it "returns an empty array when no compaines matches" do 
      scrapper = DataScrapper.new(document_url: 'http://www.yelp.com')
      search_result = scrapper.search_companies_by_state('Nodafadsfa', 10)
      expect(search_result.count).to eq(0)
      expect(search_result).to eq([])
    end
  end

  describe "search_companies_by_zip(keyword)" do 
    it 'returns array compaines which matchs' do
      scrapper = DataScrapper.new(document_url: 'http://www.yelp.com')
      search_result = scrapper.search_companies_by_zip('11201', 10)
      expect(search_result.count).to eq(10)
      expect(search_result.map { |e| e.class.name }.uniq).to eq(['Company'])
      expect(search_result.map { |e| e.locations.last.zip.code }.uniq).to eq([11201])
    end
    it 'returns an empty array when no compaines matches' do
      scrapper = DataScrapper.new(document_url: 'http://www.yelp.com')
      search_result = scrapper.search_companies_by_state('123136', 10)
      expect(search_result.count).to eq(0)
      expect(search_result).to eq([])
    end
  end
end
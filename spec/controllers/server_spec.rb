require 'spec_helper'
RSpec.describe ShopDetective do
  describe "POST /yelp/search.json" do
    it "returns status 200" do
      post '/yelp/search.json', 'keyword' => 'New York', 'type' => 'state'
      expect(last_response).to be_ok
    end

    it "returns json body of company data" do
      post '/yelp/search.json', 'keyword' => 'New York', 'type' => 'state'
      expect(last_response.body).to eql "[{\"company_name\":\"Jane’s Carousel\",\"latitude\":\"40.7044264\",\"longitude\":\"-73.99246579999999\",\"subcategoy_name\":\"Venues \\u0026 Event Spaces\",\"zip_code\":11201,\"state_name\":\"New York\",\"state_code\":\"NY\",\"country_name\":\"US\"},{\"company_name\":\"Yelp’s 11th Burstday Aboard THE ZEPHYR\",\"latitude\":\"40.9232804\",\"longitude\":\"-73.9019264\",\"subcategoy_name\":\"Yelp Events\",\"zip_code\":null,\"state_name\":\"New York\",\"state_code\":\"NY\",\"country_name\":\"US\"},{\"company_name\":\"Brooklyn Bridge Park\",\"latitude\":\"40.703104\",\"longitude\":\"-73.99617959999999\",\"subcategoy_name\":\"Parks\",\"zip_code\":11201,\"state_name\":\"New York\",\"state_code\":\"NY\",\"country_name\":\"US\"},{\"company_name\":\"Brooklyn Bridge\",\"latitude\":\"40.6986772\",\"longitude\":\"-73.9859414\",\"subcategoy_name\":\"Landmarks \\u0026 Historical Buildings\",\"zip_code\":11201,\"state_name\":\"New York\",\"state_code\":\"NY\",\"country_name\":\"US\"},{\"company_name\":\"Brooklyn Heights Promenade\",\"latitude\":\"40.6990109\",\"longitude\":\"-73.996\",\"subcategoy_name\":\"Parks\",\"zip_code\":11201,\"state_name\":\"New York\",\"state_code\":\"NY\",\"country_name\":\"US\"},{\"company_name\":\"9/11 Memorial\",\"latitude\":\"40.7114147\",\"longitude\":\"-74.0124786\",\"subcategoy_name\":\"Landmarks \\u0026 Historical Buildings\",\"zip_code\":10007,\"state_name\":\"New York\",\"state_code\":\"NY\",\"country_name\":\"US\"},{\"company_name\":\"Crepes Canaveral From Brittany\",\"latitude\":\"40.727506\",\"longitude\":\"-73.98583909999999\",\"subcategoy_name\":\"Food Stands\",\"zip_code\":10003,\"state_name\":\"New York\",\"state_code\":\"NY\",\"country_name\":\"US\"},{\"company_name\":\"The High Line\",\"latitude\":\"40.7396079\",\"longitude\":\"-74.008443\",\"subcategoy_name\":\"Parks\",\"zip_code\":10014,\"state_name\":\"New York\",\"state_code\":\"NY\",\"country_name\":\"US\"},{\"company_name\":\"Pisillo Italian Panini\",\"latitude\":\"40.710546\",\"longitude\":\"-74.0076194\",\"subcategoy_name\":\"Italian\",\"zip_code\":10038,\"state_name\":\"New York\",\"state_code\":\"NY\",\"country_name\":\"US\"},{\"company_name\":\"Beyond Sushi\",\"latitude\":\"40.733009\",\"longitude\":\"-73.985798\",\"subcategoy_name\":\"Vegetarian\",\"zip_code\":10003,\"state_name\":\"New York\",\"state_code\":\"NY\",\"country_name\":\"US\"}]"
    end
  end
end

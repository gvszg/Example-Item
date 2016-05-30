require 'rails_helper'

RSpec.describe Api::V3::CountiesController, :type => :controller do
  describe "Get show" do
    before :each do
      @county = Fabricate(:county)
      @town = Fabricate(:town, county: @county)
      # let(:county) { Fabricate(:county) }
      get :show, id: @county.id
      @json = JSON.parse(response.body)
    end

    context "when send get request" do
      it "should return status code 200" do
        expect(response).to have_http_status(200)
      end

      it "should return JSON format" do
        expect(response.content_type).to eq("application/json")
      end

      it "returns an array of towns object" do
        # binding.pry
        expect(@json[0]['id']).to eq(@town.id)
      end
    end
  end
end
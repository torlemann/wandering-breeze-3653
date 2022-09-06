require 'rails_helper'

RSpec.describe 'project show' do
    
    before :each do
        @recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
        @furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000)

        @news_chic = recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")
        @boardfit = recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes")

        @upholstery_tux = furniture_challenge.projects.create(name: "Upholstery Tuxedo", material: "Couch")
        @lit_fit = furniture_challenge.projects.create(name: "Litfit", material: "Lamp")
    end

    it "shows project attributes" do
        visit "/projects/#{@lit_fit.id}"
        expect(page).to have_content(@lit_fit.name)
        expect(page).to have_content("Material: Lampshade")
        expect(page).to have_content("Challenge Theme: Apartment Furnishings")
        #save_and_open_page
    end
end
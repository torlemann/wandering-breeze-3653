require 'rails_helper'

RSpec.describe 'project show' do
    
    before :each do
        @recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
        @furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000)

        @news_chic = @recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")
        @boardfit = @recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes")

        @upholstery_tux = @furniture_challenge.projects.create(name: "Upholstery Tuxedo", material: "Couch")
        @lit_fit = @furniture_challenge.projects.create(name: "Litfit", material: "Lamp")
    end

    it "shows project attributes" do
        visit "/projects/#{@lit_fit.id}"
        expect(page).to have_content(@lit_fit.name)
        expect(page).to have_content("Material: Lamp")
        expect(page).to have_content("Challenge Theme: Apartment Furnishings")
       # save_and_open_page
    end

    it "shows number of contestants of project" do
        jay = Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
        gretchen = Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)
        kentaro = Contestant.create(name: "Kentaro Kameyama", age: 30, hometown: "Boston", years_of_experience: 8)
        erin = Contestant.create(name: "Erin Robertson", age: 44, hometown: "Denver", years_of_experience: 15)


        ContestantProject.create(contestant_id: jay.id, project_id: @news_chic.id)
        ContestantProject.create(contestant_id: gretchen.id, project_id: @news_chic.id)
        ContestantProject.create(contestant_id: gretchen.id, project_id: @upholstery_tux.id)
        ContestantProject.create(contestant_id: kentaro.id, project_id: @upholstery_tux.id)
        ContestantProject.create(contestant_id: kentaro.id, project_id: @boardfit.id)
        ContestantProject.create(contestant_id: erin.id, project_id: @boardfit.id)
        
        visit "/projects/#{@news_chic.id}"
        
        expect(page).to have_content(@news_chic.name)
        expect(page).to have_content("Number of Contestants: #{@news_chic.enrollment}")
        
       #save_and_open_page
    end

    it 'shows the average years of xp of the contestants' do
        jay = Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
        gretchen = Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)
        kentaro = Contestant.create(name: "Kentaro Kameyama", age: 30, hometown: "Boston", years_of_experience: 8)
        erin = Contestant.create(name: "Erin Robertson", age: 44, hometown: "Denver", years_of_experience: 15)


        ContestantProject.create(contestant_id: jay.id, project_id: @news_chic.id)
        ContestantProject.create(contestant_id: gretchen.id, project_id: @news_chic.id)
        ContestantProject.create(contestant_id: gretchen.id, project_id: @upholstery_tux.id)
        ContestantProject.create(contestant_id: kentaro.id, project_id: @upholstery_tux.id)
        ContestantProject.create(contestant_id: kentaro.id, project_id: @boardfit.id)
        ContestantProject.create(contestant_id: erin.id, project_id: @boardfit.id)
        
        visit "/projects/#{@news_chic.id}"

        expect(page).to have_content("Average Contestant Experience: #{@news_chic.contestants.average_xp} years")
        
    end

    xit 'can add a contestant to a project' do
        jay = Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
        gretchen = Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)
        kentaro = Contestant.create(name: "Kentaro Kameyama", age: 30, hometown: "Boston", years_of_experience: 8)
        erin = Contestant.create(name: "Erin Robertson", age: 44, hometown: "Denver", years_of_experience: 15)


        ContestantProject.create(contestant_id: jay.id, project_id: @news_chic.id)
        ContestantProject.create(contestant_id: gretchen.id, project_id: @news_chic.id)
        ContestantProject.create(contestant_id: gretchen.id, project_id: @upholstery_tux.id)
        ContestantProject.create(contestant_id: kentaro.id, project_id: @upholstery_tux.id)
        ContestantProject.create(contestant_id: kentaro.id, project_id: @boardfit.id)
        ContestantProject.create(contestant_id: erin.id, project_id: @boardfit.id)
        
        visit "/projects/#{@news_chic.id}"

        fill_in("Search", with: "#{kentaro.id}")
        click_on("Save")
        expect(current_path).to eq("/projects/#{@news_chic.id}")
        expect(page).to have_content("Number of Contestants: 3")
        visit "/contestants"
        within "#contestant-#{kentaro.id}" do
            expect(page).to have_content(kentaro.name)
            expect(page).to have_content("Projects: #{@news_chic.name}, #{@boardfit.name}, #{@upholstery_tux.name}")
        end
    end
end
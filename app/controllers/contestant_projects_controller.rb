class ContestantProjectsController < ApplicationController

    def create
        contestant = Contestant.find(params[:search])
        project = Project.find(params[:project_id])
        project.contestants << contestant
        redirect_to "/projects/#{project.id}"
    end

end
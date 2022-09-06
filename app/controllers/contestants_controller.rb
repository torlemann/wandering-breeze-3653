class ContestantsController < ApplicationController

    def index
        @contestants = Contestant.all
    end

    def show
        @contestant = Contestant.find(params[:id])
    end
end
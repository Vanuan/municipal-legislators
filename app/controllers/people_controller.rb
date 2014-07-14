class PeopleController < ApplicationController
  respond_to :json

  def index
    @people = Person.all
    render json: @people
  end

end

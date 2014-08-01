class PeopleController < ApplicationController

  def index
    @people = Person.all
    render "people/index"
  end

end

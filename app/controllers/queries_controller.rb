require 'HTTParty'

class QueriesController < ApplicationController
  def new
    @query = Query.new
  end

  def create
    @query = Query.create(params_access[:query])
    if @query.save
      redirect_to query_path(@query.id)
    else
      render new_query_path
    end
  end

  def show
    @query = Query.find(params[:id])
    @incidents = HTTParty.get("https://data.seattle.gov/resource/pu5n-trf4.json?$where=within_circle(incident_location, #{@query.latitude.to_s}, #{@query.longitude.to_s}, 5000)")
    #HTTParty will return an empty array if address is fake or out of Seattle
    if @incidents.empty?
        @error = "This address is out of Seattle"
    else
        @results = Query.count_incidents(@incidents)
        @final_results = Query.top_five(@results)
    end
  end


  private

  def params_access
    params.permit(query: [:address, :latitude, :longitude])
  end
end

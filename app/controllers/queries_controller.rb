class QueriesController < ApplicationController
  def new
    @query = Queries.new
  end

  def create
    @query = Queries.new(params_access[:query])

    if @query.save
      redirect_to query_path(@query.id)
    else
      render new_query_path
    end
  end



  private

  def params_access
    params.permit(query: [:address, :latitude, :longitude])
  end
end

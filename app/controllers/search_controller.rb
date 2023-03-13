class SearchController < ApplicationController
  before_action :authenticate
  def index
    @query = Glob.ransack(params[:q])
    @globs = @query.result(distinct: true)
  end
end

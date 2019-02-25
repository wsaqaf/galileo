class AffiliationsController < ApplicationController
  def index
    @affiliations = User.order(:affiliation).where("affiliation like ?","%#{params[:term]}%")
    render json: @affiliations.map(&:affiliation).uniq
  end
end

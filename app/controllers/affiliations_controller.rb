class AffiliationsController < ApplicationController
  before_action :check_if_signed_in

  def index
    @affiliations = User.order(:affiliation).where("affiliation like ?","%#{params[:term]}%")
    render json: @affiliations.map(&:affiliation).uniq
  end

    def check_if_signed_in
      if !user_signed_in?
        redirect_to "/"
      end
    end
end

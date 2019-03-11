class MediumReviewsController < ApplicationController
  before_action :find_medium
  before_action :check_if_signed_in


  def index
    if (params[:term].present?)
      @medium_reviews = MediumReview.where("medium_id="+@medium.id.to_s+" AND user_id="+current_user.id.to_s).first
      render json: @medium_reviews.map(&:name).uniq
    else
      @medium_reviews = MediumReview.all.order("created_at DESC").where("medium_id="+@medium.id.to_s+" AND (medium_review_sharing_mode=1 OR user_id="+current_user.id.to_s+")")
    end
  end

  def show
  end

  def new
  end

  def create
    @tmp = MediumReview.where(user_id: current_user.id, medium_id: @medium.id).select("id").first
    if (not @tmp.blank?)
      @medium_review=MediumReview.find(@tmp.id)
      redirect_to medium_medium_review_step_path(@medium,@medium_review, MediumReview.form_steps.first)
      return
    end
    @medium_review = MediumReview.new
    @medium_review.medium_id=@medium.id
    @medium_review.user_id=current_user.id
    @medium_review.save(validate: false)
    redirect_to medium_medium_review_step_path(@medium,@medium_review, MediumReview.form_steps.first)
  end

  def edit
  end

  def update
  end

  def destroy
    @tmp = MediumReview.where("medium_id="+@medium.id.to_s+" AND user_id="+current_user.id.to_s).first
    if (not @tmp.blank?)
      @medium_review=MediumReview.find(@tmp.id)
      @medium_review.destroy
    end
    redirect_to media_path
  end

  private

  def find_medium
    @medium = Medium.find(params[:medium_id])
  end

    def check_if_signed_in
      if !user_signed_in?
        redirect_to "/"
      end
    end
end

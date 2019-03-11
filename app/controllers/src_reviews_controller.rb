class SrcReviewsController < ApplicationController
  before_action :find_src
  before_action :check_if_signed_in

  def index
    if (params[:term].present?)
      @src_reviews = SrcReview.order(:id).where("name like ?", "%#{params[:term]}%")
      render json: @src_reviews.map(&:name).uniq
    else
      @src_reviews = SrcReview.all.order("created_at DESC").where("src_id="+@src.id.to_s+" AND (src_review_sharing_mode=1 OR user_id="+current_user.id.to_s+")")
    end
  end

  def show
  end

  def new
  end

  def create
    @tmp = SrcReview.where("src_id="+@src.id.to_s+" AND user_id="+current_user.id.to_s).first
    if (not @tmp.blank?)
      @src_review=SrcReview.find(@tmp.id)
      redirect_to src_src_review_step_path(@src,@src_review, SrcReview.form_steps.first)
      return
    end
    @src_review = SrcReview.new
    @src_review.src_id=@src.id
    @src_review.user_id=current_user.id

    @src_review.save(validate: false)
    redirect_to src_src_review_step_path(@src,@src_review, SrcReview.form_steps.first)
  end

  def edit
  end

  def update
  end

  def destroy
    @tmp = SrcReview.where("src_id="+@src.id.to_s+" AND user_id="+current_user.id.to_s).first
    if (not @tmp.blank?)
      @src_review=SrcReview.find(@tmp.id)
      @src_review.destroy
    end
    redirect_to srcs_path
  end

  private

  def find_src
    @src = Src.find(params[:src_id])
  end

    def check_if_signed_in
      if !user_signed_in?
        redirect_to "/"
      end
    end
end

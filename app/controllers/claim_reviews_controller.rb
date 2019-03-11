class ClaimReviewsController < ApplicationController
  before_action :find_claim
  before_action :check_if_signed_in

  def index
    if (params[:term].present?)
      @claim_reviews = ClaimReview.order(:id).where("name like ?", "%#{params[:term]}%")
      render json: @claim_reviews.map(&:name).uniq
    else
      @claim_reviews = ClaimReview.all.order("created_at DESC").where("claim_id="+@claim.id.to_s+" AND (review_sharing_mode=1 OR user_id="+current_user.id.to_s+")")
    end
  end

  def show
    @claim_review = ClaimReview.find(params[:id])
  end

  def new
  end

  def create
    @tmp = ClaimReview.where("claim_id="+@claim.id.to_s+" AND user_id="+current_user.id.to_s).first
    if (not @tmp.blank?)
      puts("\n\nEditing existing review: "+@tmp.id.to_s+"\n\n")
      @claim_review=ClaimReview.find(@tmp.id)
      redirect_to claim_claim_review_step_path(@claim,@claim_review, ClaimReview.form_steps.first)
      return
    end
    puts("\n\nCreating new review\n\n")
    @claim_review = ClaimReview.new
    @claim_review.claim_id=@claim.id
    @claim_review.user_id=current_user.id
    @claim_review.save(validate: false)
    redirect_to claim_claim_review_step_path(@claim,@claim_review, ClaimReview.form_steps.first)
  end

  def edit
  end

  def update
    if @claim_review.update()
      redirect_to claim_claim_path(@claim,@claim_review)
    else
      render 'edit'
    end
  end

  def destroy
    @tmp = ClaimReview.where("claim_id="+@claim.id.to_s+" AND user_id="+current_user.id.to_s).first
    if (not @tmp.blank?)
      @claim_review=ClaimReview.find(@tmp.id)
      @claim_review.destroy
    end
    redirect_to claims_path
  end

  private

  def find_claim
    @claim = Claim.find(params[:claim_id])
  end

  def check_if_signed_in
    if !user_signed_in?
      redirect_to "/"
    end
  end
end

class MediaController < ApplicationController
  before_action :check_if_signed_in
  before_action :find_medium, only: [:show, :edit, :update, :destroy]
  before_action :define_types


  def index
    if (params[:sort].present?)
      @sort_msg=sort_bar("Media",params[:sort])
    else
      @sort_msg=sort_bar("Media","td")
    end
    if (params[:term].present?)
      @media = Medium.order(:name).where("(media.sharing_mode=1 OR media.user_id="+current_user.id.to_s+") AND name like ?", "%#{params[:term]}%")
      render json: @media.map(&:name).uniq; return
    elsif (params[:filter]=="r")
      qry="(media.sharing_mode=1 OR media.user_id="+current_user.id.to_s+") AND media.id in (SELECT medium_id FROM medium_reviews WHERE medium_reviews.medium_review_sharing_mode=1 AND medium_reviews.medium_review_verdict!='')"
      @filter_msg=filter_bar("Media","r")
    elsif (params[:filter]=="m")
      qry="media.user_id="+current_user.id.to_s
      @filter_msg=filter_bar("Media","m")
    elsif (params[:filter]=="u")
      qry="(media.sharing_mode=1 OR media.user_id="+current_user.id.to_s+") AND media.id in (SELECT medium_id FROM medium_reviews WHERE medium_reviews.user_id="+current_user.id.to_s+")"
      @filter_msg=filter_bar("Media","u")
    elsif (params[:filter]=="n")
      qry="(media.sharing_mode=1 OR media.user_id="+current_user.id.to_s+") AND NOT EXISTS (SELECT medium_id FROM medium_reviews WHERE media.id=medium_reviews.medium_id AND ((medium_reviews.medium_review_sharing_mode=1 AND medium_reviews.medium_review_verdict!='') OR medium_reviews.user_id="+current_user.id.to_s+"))"
      @filter_msg=filter_bar("Media","n")
    elsif (params[:q].present?)
      @filter_msg=filter_bar("Media","a")
      qry="(media.sharing_mode=1 OR media.user_id="+current_user.id.to_s+") AND (lower(name) like lower('%"+params[:q]+"%') or lower(description) like lower('%"+params[:q]+"%') or lower(url_preview) like lower('%"+params[:q]+"%'))"
    else
      @filter_msg=filter_bar("Media","a")
      if (params[:sort]=="r" or params[:sort]=="rp" or params[:sort]=="rn")
        tmp=Medium.joins(:medium_reviews).where("(media.sharing_mode=1 OR media.user_id="+current_user.id.to_s+") AND media.id=medium_reviews.medium_id and medium_reviews.medium_review_sharing_mode=1 and medium_reviews.medium_review_verdict!=''").group("medium_reviews.medium_id").order(sort_statement("medium",params[:sort]))
        @total_count=tmp.count.length
      else
        if qry.nil? then qry="media.sharing_mode=1 OR media.user_id="+current_user.id.to_s; end
        tmp=Medium.where(qry).order("created_at DESC")
        @total_count=tmp.count
      end
       @pagy, @media = pagy(tmp, items: 10)
       return
     end
   if (params[:sort]=="r" or params[:sort]=="rp" or params[:sort]=="rn")
     tmp=Medium.joins(:medium_reviews).where("(media.sharing_mode=1 OR media.user_id="+current_user.id.to_s+") AND media.id=medium_reviews.medium_id and medium_reviews.medium_review_sharing_mode=1 and medium_reviews.medium_review_verdict!=''").group("medium_reviews.medium_id").order(sort_statement("medium",params[:sort]))
     @total_count=tmp.count.length
   else
     if qry.nil? then qry="media.sharing_mode=1 OR media.user_id="+current_user.id.to_s; end
     tmp=Medium.where(qry).order("created_at DESC")
     @total_count=tmp.count
   end
   @pagy, @media = pagy(tmp, items: 10)
  end

  def show
    begin
      @medium_type=@all_medium_types[@medium.medium_type.to_s]
    rescue
      redirect_to root_path
      return
    end
#    @preview = Thumbnail.new(@medium.url)
    @claims_msg=""
    @reviews_msg=""
    @warning_msg=""
#    dependent_claims=Claim.where("(claims.sharing_mode=1 OR claims.user_id="+current_user.id.to_s+") AND medium_id = ?",@medium.id).count("id")
    dependent_reviews=MediumReview.where("medium_id = ? and medium_id in (select id from media where (media.sharing_mode=1 OR media.user_id="+current_user.id.to_s+")) ",@medium.id).count("id")
    if (dependent_reviews>0)
#    if (dependent_claims>0 or dependent_reviews>0)
        @warning_msg="Deleting this record will also delete "
#        if (dependent_claims>0)
#          @warning_msg=@warning_msg+" "+dependent_claims.to_s+" dependent "+pl(dependent_claims,"claim")
#          if (dependent_reviews>0) then @warning_msg=@warning_msg+" and "+dependent_reviews.to_s+" dependent "+pl(dependent_reviews,"review") end
#          if (dependent_reviews>0) then
            @warning_msg=@warning_msg+" "+dependent_reviews.to_s+" dependent "+pl(dependent_reviews,"review")
            # end
#        else
#          @warning_msg=@warning_msg+" "+dependent_reviews.to_s+" dependent reviews"
#        end
        @warning_msg=@warning_msg+".\n"
    end
    @warning_msg=@warning_msg+"\nAre you sure you want to go ahead and delete this medium?"
  end

  def new
    @medium = current_user.media.build
  end

  def create
    @medium = current_user.media.build(medium_params)

    if @medium.save
        redirect_to media_path
    else
        render 'new'
    end
  end

  def edit
    if current_user.id!=@medium.user_id && current_user.id!=1
      redirect_to medium_path(@medium)
    end
  end

  def update
    if current_user.id!=@medium.user_id && current_user.id!=1
      redirect_to medium_path(@medium)
      return
    end
    if @medium.update(medium_params)
      redirect_to medium_path(@medium)
    else
      render 'edit'
    end
  end

  def destroy
#    dependent_claims = Claim.where("medium_id = ? and medium_id in (select id from media where (media.sharing_mode=1 OR media.user_id="+current_user.id.to_s+"))",@medium.id)
#    dependent_claims.each do |d_claim|
#        ClaimReview.where("claim_id = ?",d_claim.id).destroy_all
#    end
#    dependent_claims.destroy_all
    MediumReview.where("medium_id = ? and medium_id in (select id from media where (media.sharing_mode=1 OR media.user_id="+current_user.id.to_s+"))",@medium.id).destroy_all
    @medium.destroy
    redirect_to media_path
  end

  private

  def pl(nmbr,wrd)
    if nmbr>1 then return wrd+"s" end
    return wrd
  end

    def medium_params
      params.require(:medium).permit(:name, :url, :medium_type, :description, :sharing_mode, :url_preview)
    end

    def find_medium
        @medium = Medium.where("id=? AND (media.sharing_mode=1 OR media.user_id="+current_user.id.to_s+")",params[:id]).first
    end

    def define_types
      @all_medium_types={"1"=>'Social Media/network',"2"=>'News website',"3"=>'Instant Messaging/Chatting',"4"=>'Video Sharing Website',"5"=>'Blogging platform',"100"=>'Other'}
      @medium_types=[]
      @medium_types.push(['Select',''])
      @all_medium_types.each do |key, value|
        @medium_types.push([value,key])
      end
    end

      def check_if_signed_in
        if !user_signed_in?
          redirect_to "/"
          return
        end
      end
end

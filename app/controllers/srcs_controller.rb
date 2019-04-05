class SrcsController < ApplicationController
  before_action :find_src, only: [:show, :edit, :update, :destroy]
  before_action :define_types
  before_action :check_if_signed_in

  def index
    if (params[:sort].present?)
      @sort_msg=sort_bar("Srcs",params[:sort])
    else
      @sort_msg=sort_bar("Srcs","td")
    end
    if (params[:term].present?)
      @srcs = Src.order(:name).where("name like ?", "%#{params[:term]}%")
      render json: @srcs.map(&:name).uniq; return
    elsif (params[:filter]=="r")
      qry="srcs.id in (SELECT src_id FROM src_reviews WHERE src_reviews.src_review_sharing_mode=1 AND src_reviews.src_review_verdict!='')"
      @filter_msg=filter_bar("Srcs","r")
    elsif (params[:filter]=="u")
      qry="srcs.id in (SELECT src_id FROM src_reviews WHERE src_reviews.user_id="+current_user.id.to_s+")"
      @filter_msg=filter_bar("Srcs","u")
    elsif (params[:filter]=="n")
      qry="srcs.id not in (SELECT src_id FROM src_reviews WHERE src_reviews.src_review_sharing_mode=1 AND src_reviews.src_review_verdict!='')"
      @filter_msg=filter_bar("Srcs","n")
    elsif (params[:q].present?)
      @filter_msg=filter_bar("Srcs","a")
      qry="name like '%"+params[:q]+"%'"
    else
      @filter_msg=filter_bar("Srcs","a")
      if (params[:sort]=="r" or params[:sort]=="rp" or params[:sort]=="rn")
        tmp=Src.joins(:src_reviews).where("srcs.id=src_reviews.src_id and src_reviews.src_review_sharing_mode=1 and src_reviews.src_review_verdict!=''").group("src_reviews.src_id").order(sort_statement("src",params[:sort]))
        @total_count=tmp.count.length
      else
        tmp=Src.where(qry).order("created_at DESC")
        @total_count=tmp.count
      end
       @pagy, @srcs = pagy(tmp, items: 10)
       return
     end
   if (params[:sort]=="r" or params[:sort]=="rp" or params[:sort]=="rn")
     tmp=Src.joins(:src_reviews).where("srcs.id=src_reviews.src_id and src_reviews.src_review_sharing_mode=1 and src_reviews.src_review_verdict!=''").group("src_reviews.src_id").order(sort_statement("src",params[:sort]))
     @total_count=tmp.count.length
   else
     tmp=Src.where(qry).order("created_at DESC")
     @total_count=tmp.count
   end
     @pagy, @srcs = pagy(tmp, items: 10)
  end

  def show
    @src_type=@all_src_types[@src.src_type.to_s]
    @claims_msg=""
    @reviews_msg=""
    @warning_msg=""
    dependent_claims=Claim.where("src_id = ?",@src.id).count("id")
    dependent_reviews=SrcReview.where("src_id = ?",@src.id).count("id")
    if (dependent_claims>0 or dependent_reviews>0)
        @warning_msg="Deleting this record will also delete "
        if (dependent_claims>0)
          @warning_msg=@warning_msg+" "+dependent_claims.to_s+" dependent "+pl(dependent_claims,"claim")
          if (dependent_reviews>0) then @warning_msg=@warning_msg+" and "+dependent_reviews.to_s+" dependent "+pl(dependent_reviews,"review") end
        else
          @warning_msg=@warning_msg+" "+dependent_reviews.to_s+" dependent reviews"
        end
        @warning_msg=@warning_msg+".\n"
    end
    @warning_msg=@warning_msg+"\nAre you sure you want to go ahead and delete this source?"
#    @preview = Thumbnail.new(@src.url)
  end

  def new
    @src = current_user.srcs.build
  end

  def create
    @src = current_user.srcs.build(src_params)

    if @src.save
        redirect_to srcs_path
    else
        render 'new'
    end
  end

  def edit
    if current_user.id!=@src.user_id
      redirect_to src_path(@src)
    end
  end

  def update
    if current_user.id!=@src.user_id
      redirect_to src_path(@src)
      return
    end
    if @src.update(src_params)
      redirect_to src_path(@src)
    else
      render 'edit'
    end
  end

  def destroy
    dependent_claims = Claim.where("src_id = ?",@src.id)
    dependent_claims.each do |d_claim|
        ClaimReview.where("claim_id = ?",d_claim.id).destroy_all
    end
    dependent_claims.destroy_all
    SrcReview.where("src_id = ?",@src.id).destroy_all
    @src.destroy
    redirect_to srcs_path
  end

  private

    def pl(nmbr,wrd)
      if nmbr>1 then return wrd+"s" end
      return wrd
    end

    def src_params
      params.require(:src).permit(:name, :url, :src_type, :description, :url_preview)
    end

    def find_src
      @src = Src.find(params[:id])
    end

    def define_types
      @all_src_types={"1"=>'Person',"2"=>'Establishment/Entity',"3"=>'Website',"100"=>'Other',"0"=>"Not sure"}
      @src_types=[]
      @src_types.push(['Select',''])
      @all_src_types.each do |key, value|
        @src_types.push([value,key])
      end
    end

      def check_if_signed_in
        if !user_signed_in?
          redirect_to "/"
        end
      end

end

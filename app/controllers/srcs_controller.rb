class SrcsController < ApplicationController
  before_action :find_src, only: [:show, :edit, :update, :destroy]
  before_action :define_types
  before_action :check_if_signed_in

  def index
    if (params[:filter]=="r")
      @srcs = Src.where("srcs.id in (SELECT src_id FROM src_reviews WHERE src_reviews.src_review_sharing_mode=1)").order("created_at DESC")
      @filter_reviews ="<select id='filter_reviews'><option value='.'>All Sources</option><option value='?filter=r' selected>Sources with shared reviews</option><option value='?filter=u'>Sources you reviewed</option><option value='?filter=n'>Sources with no reviews yet</option></select>"+
                   "<script>$(function(){$('#filter_reviews').on('change',function(){{window.location=$(this).val();}return false;});});</script>"
    elsif (params[:filter]=="u")
      @srcs = Src.where("srcs.id in (SELECT src_id FROM src_reviews WHERE src_reviews.user_id="+current_user.id.to_s+")").order("created_at DESC")
      @filter_reviews ="<select id='filter_reviews'><option value='.'>All Sources</option><option value='?filter=r'>Sources with shared reviews</option><option value='?filter=u' selected>Sources you reviewed</option><option value='?filter=n'>Sources with no reviews yet</option></select>"+
                   "<script>$(function(){$('#filter_reviews').on('change',function(){{window.location=$(this).val();}return false;});});</script>"
    elsif (params[:filter]=="n")
      @srcs = Src.where("srcs.id not in (SELECT src_id FROM src_reviews WHERE (src_reviews.src_review_sharing_mode=1 OR src_reviews.user_id="+current_user.id.to_s+"))").order("created_at DESC")
      @filter_reviews ="<select id='filter_reviews'><option value='.'>All Sources</option><option value='?filter=r'>Sources with shared reviews</option><option value='?filter=u'>Sources you reviewed</option><option value='?filter=n' selected>Sources with no reviews yet</option></select>"+
                   "<script>$(function(){$('#filter_reviews').on('change',function(){{window.location=$(this).val();}return false;});});</script>"
    else
      @filter_reviews ="<select id='filter_reviews'><option value='.' selected>All Sources</option><option value='?filter=r'>Sources with shared reviews</option><option value='?filter=u'>Sources you reviewed</option><option value='?filter=n'>Sources with no reviews yet</option></select>"+
                   "<script>$(function(){$('#filter_reviews').on('change',function(){{window.location=$(this).val();}return false;});});</script>"
      @srcs = Src.all.order("created_at DESC")
    end
  end

  def show
    @src_type=@all_src_types[@src.src_type.to_s]
    @claims_msg=""
    @reviews_msg=""
    @warning_msg=""
    dependent_claims=Claim.where("src_id = "+@src.id.to_s).count("id")
    dependent_reviews=SrcReview.where("src_id = "+@src.id.to_s).count("id")
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
  end

  def update
    if @src.update(src_params)
      redirect_to src_path(@src)
    else
      render 'edit'
    end
  end

  def destroy
    dependent_claims = Claim.where("src_id = "+@src.id.to_s)
    dependent_claims.each do |d_claim|
        ClaimReview.where("claim_id = "+d_claim.id.to_s).destroy_all
    end
    dependent_claims.destroy_all
    SrcReview.where("src_id = "+@src.id.to_s).destroy_all
    @src.destroy
    redirect_to srcs_path
  end

  private

    def pl(nmbr,wrd)
      if nmbr>1 then return wrd+"s" end
      return wrd
    end

    def src_params
      params.require(:src).permit(:name, :url, :src_type, :description)
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

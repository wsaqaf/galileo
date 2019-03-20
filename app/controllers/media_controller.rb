class MediaController < ApplicationController
  before_action :check_if_signed_in
  before_action :find_medium, only: [:show, :edit, :update, :destroy]
  before_action :define_types


  def index
    if (params[:term].present?)
      @media = Medium.order(:name).where("name like ?", "%#{params[:term]}%")
      render json: @media.map(&:name).uniq; return
    elsif (params[:filter]=="r")
      qry="media.id in (SELECT medium_id FROM medium_reviews WHERE medium_reviews.medium_review_sharing_mode=1 AND medium_reviews.medium_review_verdict!='')"
      @filter_reviews ="<select id='filter_reviews'><option value='media'>All Media</option><option value='?filter=r' selected>Media with shared reviews</option><option value='?filter=u'>Media you reviewed</option><option value='?filter=n'>Media with no reviews yet</option></select>"+
                   "<script>$(function(){$('#filter_reviews').on('change',function(){{window.location=$(this).val();}return false;});});</script>"
    elsif (params[:filter]=="u")
      qry="media.id in (SELECT medium_id FROM medium_reviews WHERE medium_reviews.user_id="+current_user.id.to_s+")"
      @filter_reviews ="<select id='filter_reviews'><option value='media'>All Media</option><option value='?filter=r'>Media with shared reviews</option><option value='?filter=u' selected>Media you reviewed</option><option value='?filter=n'>Media with no reviews yet</option></select>"+
                   "<script>$(function(){$('#filter_reviews').on('change',function(){{window.location=$(this).val();}return false;});});</script>"
    elsif (params[:filter]=="n")
      qry="media.id not in (SELECT medium_id FROM medium_reviews WHERE medium_reviews.medium_review_sharing_mode=1 AND medium_reviews.medium_review_verdict!='')"
      @filter_reviews ="<select id='filter_reviews'><option value='media'>All Media</option><option value='?filter=r'>Media with shared reviews</option><option value='?filter=u'>Media you reviewed</option><option value='?filter=n' selected>Media with no reviews yet</option></select>"+
                   "<script>$(function(){$('#filter_reviews').on('change',function(){{window.location=$(this).val();}return false;});});</script>"
    elsif (params[:q].present?)
      @filter_reviews ="<select id='filter_reviews'><option value='media' selected>All Media</option><option value='?filter=r'>Media with shared reviews</option><option value='?filter=u'>Media you reviewed</option><option value='?filter=n'>Media with no reviews yet</option></select>"+
                   "<script>$(function(){$('#filter_reviews').on('change',function(){{window.location=$(this).val();}return false;});});</script>"
      qry="name like '%"+params[:q]+"%'"
    elsif (params[:url].present?)
      @filter_msg=""
      output=""
      preview = Thumbnail.new(params[:url])
      if not preview.blank?
        output='<br><a class="fragment" href="'+params[:url]+'" target=_blank>'
        if defined?(preview.images.first.src) then
            output=output+'  <img src ="'+preview.images.first.src.to_s+'" height=50 />'
        end
        output=output+"\n<h3>"+preview.title+"</h3><p class=\"text\">"+preview.description+"</p></a>"
      end
      render json: output;
      return
    else
      @filter_reviews ="<select id='filter_reviews'><option value='media' selected>All Media</option><option value='?filter=r'>Media with shared reviews</option><option value='?filter=u'>Media you reviewed</option><option value='?filter=n'>Media with no reviews yet</option></select>"+
                   "<script>$(function(){$('#filter_reviews').on('change',function(){{window.location=$(this).val();}return false;});});</script>"
       tmp=Medium.all.order("created_at DESC")
       @total_count=tmp.count
       @pagy, @media = pagy(tmp, items: 10)
       return
     end
     tmp=Medium.where(qry).order("created_at DESC")
     @total_count=tmp.count
     @pagy, @media = pagy(tmp, items: 10)
  end

  def show
    @medium_type=@all_medium_types[@medium.medium_type.to_s]
#    @preview = Thumbnail.new(@medium.url)
    @claims_msg=""
    @reviews_msg=""
    @warning_msg=""
    dependent_claims=Claim.where("medium_id = "+@medium.id.to_s).count("id")
    dependent_reviews=MediumReview.where("medium_id = "+@medium.id.to_s).count("id")
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
  end

  def update
    if @medium.update(medium_params)
      redirect_to medium_path(@medium)
    else
      render 'edit'
    end
  end

  def destroy
    dependent_claims = Claim.where("medium_id = "+@medium.id.to_s)
    dependent_claims.each do |d_claim|
        ClaimReview.where("claim_id = "+d_claim.id.to_s).destroy_all
    end
    dependent_claims.destroy_all
    MediumReview.where("medium_id = "+@medium.id.to_s).destroy_all
    @medium.destroy
    redirect_to media_path
  end

  private

  def pl(nmbr,wrd)
    if nmbr>1 then return wrd+"s" end
    return wrd
  end

    def medium_params
      params.require(:medium).permit(:name, :url, :medium_type, :description, :url_preview)
    end

    def find_medium
      @medium = Medium.find(params[:id])
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

class ClaimsController < ApplicationController
  before_action :check_if_signed_in, only: [:show, :edit, :update, :destroy, :new, :create]
  before_action :find_claim, only: [:show, :edit, :update, :destroy]

  def index
      if (params[:filter]=="r")
        qry="claims.id in (SELECT claim_id FROM claim_reviews WHERE claim_reviews.review_sharing_mode=1 AND review_verdict!='')"
        @filter_msg="<select id='filter'><option value='claims'>All Claims</option><option value='?filter=r' selected>Claims with shared reviews</option><option value='?filter=u'>Claims you reviewed</option><option value='?filter=n'>Claims with no reviews yet</option></select>"+
                     "<script>$(function(){$('#filter').on('change',function(){{window.location=$(this).val();}return false;});});</script>"
      elsif (params[:filter]=="u")
        qry="claims.id in (SELECT claim_id FROM claim_reviews WHERE claim_reviews.user_id="+current_user.id.to_s+")"
        @filter_msg="<select id='filter'><option value='claims'>All Claims</option><option value='?filter=r'>Claims with shared reviews</option><option value='?filter=u' selected>Claims you reviewed</option><option value='?filter=n'>Claims with no reviews yet</option></select>"+
                     "<script>$(function(){$('#filter').on('change',function(){{window.location=$(this).val();}return false;});});</script>"
      elsif (params[:filter]=="n")
        qry="claims.id not in (SELECT claim_id FROM claim_reviews WHERE claim_reviews.review_sharing_mode=1 AND review_verdict!='')"
        @filter_msg="<select id='filter'><option value='claims'>All Claims</option><option value='?filter=r'>Claims with shared reviews</option><option value='?filter=u'>Claims you reviewed</option><option value='?filter=n' selected>Claims with no reviews yet</option></select>"+
                     "<script>$(function(){$('#filter').on('change',function(){{window.location=$(this).val();}return false;});});</script>"
      elsif (params[:q].present?)
        @filter_msg ="<select id='filter'><option value='claims' selected>All Claims</option><option value='?filter=r'>Claims with shared reviews</option><option value='?filter=u'>Claims you reviewed</option><option value='?filter=n'>Claims with no reviews yet</option></select>"+
                     "<script>$(function(){$('#filter').on('change',function(){{window.location=$(this).val();}return false;});});</script>"
        qry="title like '%"+params[:q]+"%'"
      elsif (params[:m].present?)
        @filter_msg ="<select id='filter'><option value='claims' selected>All Claims</option><option value='?filter=r'>Claims with shared reviews</option><option value='?filter=u'>Claims you reviewed</option><option value='?filter=n'>Claims with no reviews yet</option></select>"+
                     "<script>$(function(){$('#filter').on('change',function(){{window.location=$(this).val();}return false;});});</script>"
        qry="medium_id="+params[:m].to_s
      elsif (params[:s].present?)
        @filter_msg ="<select id='filter'><option value='claims' selected>All Claims</option><option value='?filter=r'>Claims with shared reviews</option><option value='?filter=u'>Claims you reviewed</option><option value='?filter=n'>Claims with no reviews yet</option></select>"+
                     "<script>$(function(){$('#filter').on('change',function(){{window.location=$(this).val();}return false;});});</script>"
        qry="src_id="+params[:s].to_s
      elsif (params[:url].present?)
        @filter_msg=""
        output=""
        preview = Thumbnail.new(params[:url])
        imglist=""
        if !preview.blank?
          if !preview.title.nil? and !preview.description.nil?
            i=0
            imglist="var images= ["
            preview.images.each do |img|
              imglist=imglist+"'"+img.src.to_s+"',"
              i=i+1
            end
            if i>1
              imglist="<script>\nvar i=0;\n"+imglist.chomp(',')+"];\n"
              imglist=imglist+"prev.onclick=function(){if(i==0){i="+i.to_s+";};document.getElementById('cimg').src=images[--i];}</script>"
              output=output+"\n"+imglist
              output=output+'<br><a href="#" id="prev">Change thumbnail</a><br><div id="final_url_preview" class="fragment">'
              output=output+'<div style="text-align: left"><img src="'+preview.images.first.src.to_s+'" id="cimg" height=75 />'
            elsif i==1
              output=output+'<br><div id="final_url_preview" class="fragment"><div style="text-align: left"><img src="'+preview.images.first.src.to_s+'" id="cimg" height=75 /><br>'
            else
              output=output+'<br><div id="final_url_preview" class="fragment"><div style="text-align: left"><br>'
            end
            output=output+"\n<h3><a href=\""+params[:url]+"\" target=_blank>"+preview.title+"</a></h3><p class=\"text\">"+preview.description+"</p><br></div></div>"
          end
      end
        render json: output;
        return
      else
        @filter_msg ="<select id='filter'><option value='claims' selected>All Claims</option><option value='?filter=r'>Claims with shared reviews</option><option value='?filter=u'>Claims you reviewed</option><option value='?filter=n'>Claims with no reviews yet</option></select>"+
                     "<script>$(function(){$('#filter').on('change',function(){{window.location=$(this).val();}return false;});});</script>"
        tmp=Claim.all.order("created_at DESC")
        @total_count=tmp.count
        @pagy, @claims = pagy(tmp, items: 10)
        return
      end
      tmp=Claim.where(qry).order("created_at DESC")
      @total_count=tmp.count
      @pagy, @claims = pagy(tmp, items: 10)
  end

  def show
    @claims_msg=""
    @reviews_msg=""
    @warning_msg=""
    dependent_reviews=ClaimReview.where("claim_id = "+@claim.id.to_s).count("id")
    if (dependent_reviews>0)
      @warning_msg="Deleting this record will also delete "
      @warning_msg=@warning_msg+" "+dependent_reviews.to_s+" dependent "+pl(dependent_reviews,"review")+".\n"
    end
    @warning_msg=@warning_msg+"\nAre you sure you want to go ahead and delete this claim?"
  end

  def new
      @claim = current_user.claims.build
      @srcs = Src.all.map{ |c| [c.name, c.id]}
      @media = Medium.all.map{ |m| [m.name, m.id]}
  end

  def create
    @claim = current_user.claims.build(claim_params)
    if @claim.save
        redirect_to root_path
    else
        render 'new'
    end
  end

  def edit
  end

  def update
    if @claim.update(claim_params)
      redirect_to claim_path(@claim)
    else
      render 'edit'
    end
  end

  def destroy
    ClaimReview.where("claim_id = "+@claim.id.to_s).destroy_all
    @claim.destroy
    redirect_to root_path
  end

  private

    def pl(nmbr,wrd)
      if nmbr>1 then return wrd+"s" end
      return wrd
    end

    def claim_params
      params.require(:claim).permit(:id, :title, :medium_name, :src_name, :url, :description, :has_image, :has_video, :has_text, :url_preview)
    end

    def find_claim
      @claim = Claim.find(params[:id])
    end

    def check_if_signed_in
      if !user_signed_in?
        redirect_to "/"
        return
      end
    end

end

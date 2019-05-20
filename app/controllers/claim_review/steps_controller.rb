class ClaimReview::StepsController < ApplicationController
  include Wicked::Wizard
  autocomplete :claim_review, :claim_review_medium_name
  before_action :find_claim
  before_action :check_if_signed_in
  helper_method :is_visible

  steps *ClaimReview.form_steps

  def get_score(field,noun,adj)
    total=0
    score=0
    confidence=0
    result=""
    fields=[]
    if field=="content"
      if @claim.has_image and @claim_review.img_review_started
        fields=[@claim_review.img_forensic_discrepency,@claim_review.img_metadata_discrepency,@claim_review.img_logical_discrepency]
      end
      if @claim.has_video and @claim_review.vid_review_started
        fields=fields+[@claim_review.vid_old,@claim_review.vid_forensic_discrepency,@claim_review.vid_metadata_discrepency,@claim_review.vid_audio_discrepency,@claim_review.vid_logical_discrepency]
      end
      if @claim.has_text and @claim_review.txt_review_started
        fields=fields+[@claim_review.txt_unreliable_news_content,@claim_review.txt_insufficient_verifiable_srcs,@claim_review.txt_has_clickbait,@claim_review.txt_poor_language,@claim_review.txt_crowds_distance_discrepency,@claim_review.txt_author_offers_little_evidence,@claim_review.txt_reliable_sources_disapprove]
      end
      fields.each { |f| if (f.present? and not f.blank? and f!=0) then score=score+f.to_i; total=total+1; end }
    end
    max_total=fields.count
    confidence=(100*(total.to_f/max_total)).to_i
    relative_score="Score is "+score.to_s+" and max_tot is "+max_total.to_s
    if (score==-1*max_total)
      relative_score="Totally not "+adj
    elsif (score<=-0.5*max_total)
      relative_score="Mostly not "+adj
    elsif (score<=0)
      relative_score="Somewhat not "+adj
    elsif (score<=0.5*max_total)
      relative_score="Somewhat "+adj
    elsif (score<max_total)
      relative_score="Mostly "+adj
    elsif (score==max_total)
      relative_score="Totally "+adj
    end
    result="Based on your answers to "+total.to_s+" questions out of "+max_total.to_s+" (%"+confidence.to_s+"), the "+noun+" assessment of the "+field+" is found to be <b>("+relative_score+")</b> and falls on the barometer as shown below:<br><br>"
    if score==max_total then score=score-0.1 elsif score==-1*max_total then score=score+0.1 end
    result=result+"<p style='text-align:center;line-height:30px;font-size:20'><b>Least "+adj+"</b> <meter max="+max_total.to_s+" min=-"+max_total.to_s+" value="+score.to_s+" high="+(max_total*0.5).to_s+" low=0.00 optimum="+max_total.to_s+" style='width: 400px;height:15px;'></meter>"+" <b>Most "+adj+"</b><br>Assessment of "+field+": "+relative_score+"</b></p>"
    return result
  end

  def show
    @claim_review = ClaimReview.find(params[:claim_review_id])

    if current_user.id!=@claim_review.user_id then redirect_to claim_path(@claim); return end

    if @claim.has_image==1 then @first_step="s1"
    elsif @claim.has_video==1 then @first_step="s6"
    elsif @claim.has_text==1 then @first_step="s12"
    else  @first_step="s20"; end

    if step.tr('s', '').to_i.between?(1,5) and @claim.has_image!=1 then jump_to2(:s6,:s6); return
    elsif step.tr('s', '').to_i.between?(2,5) and @claim.has_image==1 and @claim_review.img_review_started!=1 then jump_to2(:s1,:s6); return
    elsif step.tr('s', '').to_i.between?(6,11) and @claim.has_video!=1 then jump_to2(:s5,:s12); return
    elsif step.tr('s', '').to_i.between?(7,11) and @claim.has_video==1 and @claim_review.vid_review_started!=1 then jump_to2(:s6,:s12); return
    elsif step.tr('s', '').to_i.between?(12,19) and @claim.has_text!=1 then jump_to2(:s11,:s20); return
    elsif step.tr('s', '').to_i.between?(13,19) and @claim.has_text==1 and @claim_review.txt_review_started!=1 then jump_to2(:s12,:s20); return
    elsif step=="s20" then @content_review_score=get_score("content","credibility","credible");
    end
    render_wizard
  end

  def update
      @claim_review = ClaimReview.find(params[:claim_review_id])
      if current_user.id!=@claim_review.user_id then redirect_to claim_path(@claim); return end

      begin
        @claim_review.update(claim_review_params(step).merge(user_id: current_user.id))
      rescue
        return
      end

      if (params['commit']=="Previous Step")
          redirect_to previous_wizard_path+'?s=prev'
          return
      elsif (params['commit']!="Next Step" && params['commit']!="Finish")
        all_steps_r=@all_steps.invert
        redirect_to wizard_path(all_steps_r[params['commit']])
        return
      end
      if step == "s1" and @claim_review.img_review_started!=1 then jump_to(:s6)
      elsif step == "s6" and @claim_review.vid_review_started!=1 then jump_to(:s12)
      elsif step == "s12" and @claim_review.txt_review_started!=1 then jump_to(:s20) end

      if step=="s19" then @content_review_score=get_score("content","credibility","credible") end
      if step=="s22" then redirect_to claims_path
      else render_wizard @claim_review end
###Step conditions###
  end

  def is_visible(st)
    if st.tr('s', '').to_i.between?(1,5) and @claim.has_image!=1
      return '<div class="divTableRow" style="display: none;">'
    elsif st.tr('s', '').to_i.between?(2,5) and @claim.has_image==1 and @claim_review.img_review_started!=1
      return '<div class="divTableRow" style="display: none;">'
    elsif st.tr('s', '').to_i.between?(6,11) and @claim.has_video!=1
      return '<div class="divTableRow" style="display: none;">'
    elsif st.tr('s', '').to_i.between?(7,11) and @claim.has_video==1 and @claim_review.vid_review_started!=1
      return '<div class="divTableRow" style="display: none;">'
    elsif st.tr('s', '').to_i.between?(12,19) and @claim.has_text!=1
      return '<div class="divTableRow" style="display: none;">'
    elsif st.tr('s', '').to_i.between?(13,19) and @claim.has_text==1 and @claim_review.txt_review_started!=1
      return '<div class="divTableRow" style="display: none;">'
    else
        return '<div class="divTableRow">'
    end
  end

  private

  def jump_to2(dest_p,dest_n)
    if !params[:s].blank?
      redirect_to claim_claim_review_step_path(@claim.id,@claim_review.id,dest_p)+"?s=prev"; return
    else
      redirect_to claim_claim_review_step_path(@claim.id,@claim_review.id,dest_n); return
    end
    render_wizard
  end

  def find_claim
    @all_steps={'s1'=>'Confirm image review','s2'=>'Misleading image context','s3'=>'Image manipulation','s4'=>'Metadata image discrepency','s5'=>'Suspicious attributes','s6'=>'Confirm video review','s7'=>'Misleading context','s8'=>'Video manipulation','s9'=>'Metadata video discrepency','s10'=>'Audio manipulation','s11'=>'Additional clues','s12'=>'Confirm text review','s13'=>'Confirm seriousness','s14'=>'Verifiable sources','s15'=>'Clickbait title','s16'=>'Language quality','s17'=>'Crowd/distance discrepency','s18'=>'Internal source confirmation','s19'=>'External source confirmation','s20'=>'Calculated score','s21'=>'Reviewer Assessment','s22'=>'Sharing setting'}

    @claim = Claim.find(params[:claim_id])
  end

    def claim_review_params(step)
      permitted_attributes = case step
########StepsToDo#########
when "s1"
  [:img_review_started]
when "s2"
  [:img_old, :note_img_old]
when "s3"
  [:img_forensic_discrepency, :note_img_forensic_discrepency]
when "s4"
  [:img_metadata_discrepency, :note_img_metadata_discrepency]
when "s5"
  [:img_logical_discrepency, :note_img_logical_discrepency]
when "s6"
  [:vid_review_started]
when "s7"
  [:vid_old, :note_vid_old]
when "s8"
  [:vid_forensic_discrepency, :note_vid_forensic_discrepency]
when "s9"
  [:vid_metadata_discrepency, :note_vid_metadata_discrepency]
when "s10"
  [:vid_audio_discrepency, :note_vid_audio_discrepency]
when "s11"
  [:vid_logical_discrepency, :note_vid_logical_discrepency]
when "s12"
  [:txt_review_started]
when "s13"
  [:txt_unreliable_news_content, :note_txt_unreliable_news_content]
when "s14"
  [:txt_insufficient_verifiable_srcs, :note_txt_insufficient_verifiable_srcs]
when "s15"
  [:txt_has_clickbait, :note_txt_has_clickbait]
when "s16"
  [:txt_poor_language, :note_txt_poor_language]
when "s17"
  [:txt_crowds_distance_discrepency, :note_txt_crowds_distance_discrepency]
when "s18"
  [:txt_author_offers_little_evidence, :note_txt_author_offers_little_evidence]
when "s19"
  [:txt_reliable_sources_disapprove, :note_txt_reliable_sources_disapprove]
when "s21"
  [:review_verdict, :review_description, :note_review_description]
when "s22"
  [:review_sharing_mode, :note_review_sharing_mode]

########StepsToDo#########
      end
      begin
        params.require(:claim_review).permit(permitted_attributes).merge(form_step: step)
      rescue
        render_wizard
        return
      end
    end

      def check_if_signed_in
        if !user_signed_in?
          redirect_to "/"
        end
      end
end

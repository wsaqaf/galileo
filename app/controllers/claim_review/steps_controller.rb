class ClaimReview::StepsController < ApplicationController
  include Wicked::Wizard
  autocomplete :claim_review, :claim_review_medium_name
  before_action :find_claim
  before_action :check_if_signed_in
  helper_method :is_visible

  steps *ClaimReview.form_steps

  def get_score(field)
    total=0
    score=0
    confidence=0
    result=""
    fields=[]

    if field=="medium"
      noun="reliability"
      adj1="reliable"
      adj2="unreliable"
    elsif field=="src"
      noun="trustworthiness"
      adj1="trustworthy"
      adj2="untrustworthy"
    else
      noun="validity"
      adj1="true"
      adj2="false"
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
    if (score==0 || total==0 || max_total==0)
        score=0; total=0; max_total=1;
    end;
    confidence=(100*(total.to_f/max_total)).to_i
    relative_score=t('score_is1')+score.to_s+t('score_is2')+max_total.to_s
#    puts("\n\nResult:"+relative_score+"\n\n")
    if (score==-1*max_total)
      relative_score=t('rate_totally_'+adj2)
    elsif (score<=-0.5*max_total)
      relative_score=t('rate_mostly_'+adj2)
    elsif (score<0)
      relative_score=t('rate_somewhat_'+adj2)
    elsif (score==0)
      relative_score=t('rate_somewhat_'+adj2)
    elsif (score<=0.5*max_total)
      relative_score=t('rate_not_measurable')
    elsif (score<max_total)
      relative_score=t('rate_mostly_'+adj1)
    elsif (score==max_total)
      relative_score=t('rate_totally_'+adj1)
    end
    result=t('score_result1')+total.to_s+t('score_result2')+max_total.to_s+" (%"+confidence.to_s+"),"+t('score_result3')+field+t('score_result4')+"<b>("+relative_score+")</b>"+t('score_result5')+"<br><br>"
    if score==max_total then score=score-0.1 elsif score==-1*max_total then score=score+0.1 end
    result=result+"<p style='text-align:center;line-height:30px;font-size:20'><b>"+t('least')+t(adj1)+"</b> <meter max="+max_total.to_s+" min=-"+max_total.to_s+" value="+score.to_s+" high="+(max_total*0.5).to_s+" low=0.00 optimum="+max_total.to_s+" style='width: 400px;height:15px;'></meter>"+" <b>"+t('most')+t(adj1)+"</b><br><br>"+t('assessment_of')+t('the_'+field)+": "+relative_score+"</b></p>"
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
    elsif step=="s20" then @claim_review_score=get_score("claim");
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

      if (params['commit']==t('previous_step'))
          redirect_to previous_wizard_path+'?s=prev'
          return
      elsif (params['commit']!=t('next_step') && params['commit']!=t('finish'))
        all_steps_r=@all_steps.invert
        redirect_to wizard_path(all_steps_r[params['commit']])
        return
      end
      if step == "s1" and @claim_review.img_review_started!=1 then jump_to(:s6)
      elsif step == "s6" and @claim_review.vid_review_started!=1 then jump_to(:s12)
      elsif step == "s12" and @claim_review.txt_review_started!=1 then jump_to(:s20) end

      if step=="s19" then @claim_review_score=get_score("claim") end
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
@all_steps={'s1'=>t('claim_img_review_started_q_short'),'s2'=>t('claim_img_old_q_short'),'s3'=>t('claim_img_forensic_discrepency_q_short'),'s4'=>t('claim_img_metadata_discrepency_q_short'),'s5'=>t('claim_img_logical_discrepency_q_short'),'s6'=>t('claim_vid_review_started_q_short'),'s7'=>t('claim_vid_old_q_short'),'s8'=>t('claim_vid_forensic_discrepency_q_short'),'s9'=>t('claim_vid_metadata_discrepency_q_short'),'s10'=>t('claim_vid_audio_discrepency_q_short'),'s11'=>t('claim_vid_logical_discrepency_q_short'),'s12'=>t('claim_txt_review_started_q_short'),'s13'=>t('claim_txt_unreliable_news_content_q_short'),'s14'=>t('claim_txt_insufficient_verifiable_srcs_q_short'),'s15'=>t('claim_txt_has_clickbait_q_short'),'s16'=>t('claim_txt_poor_language_q_short'),'s17'=>t('claim_txt_crowds_distance_discrepency_q_short'),'s18'=>t('claim_txt_author_offers_little_evidence_q_short'),'s19'=>t('claim_txt_reliable_sources_disapprove_q_short'),'s20'=>t('calculated_score_q_short'),'s21'=>t('review_verdict_q_short'),'s21'=>t('review_description_q_short'),'s22'=>t('share_setting_brief')}

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

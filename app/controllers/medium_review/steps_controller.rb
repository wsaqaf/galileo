class MediumReview::StepsController < ApplicationController
  include Wicked::Wizard
  before_action :find_medium
  before_action :check_if_signed_in


  steps *MediumReview.form_steps

  def get_score(field,noun,adj)
    total=0
    score=0
    confidence=0
    result=""
    if field=="medium"
      fields=[@medium_review.medium_is_blacklisted,@medium_review.medium_failed_factcheck_before,@medium_review.medium_has_poor_security,@medium_review.medium_whois_info_discrepency,@medium_review.medium_hosting_discrepency,@medium_review.medium_is_biased,@medium_review.medium_is_poorly_ranked,@medium_review.medium_is_not_liable,@medium_review.medium_lacks_flagging_means,@medium_review.medium_other_problems]
      fields.each { |f| if (f.present? and not f.blank? and f!=0) then score=score+f.to_i; total=total+1; end }
    end
    max_total=fields.count

    confidence=(100*(total.to_f/max_total)).to_i
    relative_score="Score is "+score.to_s+" and max_tot is "+max_total.to_s
#    puts("\n\nResult:"+relative_score+"\n\n")
    if (score==-1*max_total)
      relative_score="Totally un"+adj
    elsif (score<=-0.5*max_total)
      relative_score="Mostly un"+adj
    elsif (score<=0)
      relative_score="Somewhat un"+adj
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
    @medium_review = MediumReview.find(params[:medium_review_id])

    if step=="s11" then @medium_review_score=get_score("medium","reliability","reliable") end

    render_wizard

  end

  def update
      @medium_review = MediumReview.find(params[:medium_review_id])

      @medium_review.update(medium_review_params(step).merge(user_id: current_user.id))

      if step=="s10" then @medium_review_score=get_score("medium","reliability","reliable")  end

      if step=="s13"
         if !params[:medium_review_sharing_mode].blank? then redirect_to media_path
         else render_wizard @medium_review end
      else render_wizard @medium_review end
###Step conditions###
  end

  private
  def find_medium
    @medium = Medium.find(params[:medium_id])
  end

    def medium_review_params(step)
      permitted_attributes = case step
########StepsToDo#########
when "s1"
  [:medium_is_blacklisted, :note_medium_is_blacklisted]
when "s2"
  [:medium_failed_factcheck_before, :note_medium_failed_factcheck_before]
when "s3"
  [:medium_has_poor_security, :note_medium_has_poor_security]
when "s4"
  [:medium_whois_info_discrepency, :note_medium_whois_info_discrepency]
when "s5"
  [:medium_hosting_discrepency, :note_medium_hosting_discrepency]
when "s6"
  [:medium_is_biased, :note_medium_is_biased]
when "s7"
  [:medium_is_poorly_ranked, :note_medium_is_poorly_ranked]
when "s8"
  [:medium_is_not_liable, :note_medium_is_not_liable]
when "s9"
  [:medium_lacks_flagging_means, :note_medium_lacks_flagging_means]
when "s10"
  [:medium_other_problems, :note_medium_other_problems]
when "s12"
  [:medium_review_verdict, :medium_review_description, :note_medium_review_description]
when "s13"
  [:medium_review_sharing_mode, :note_medium_review_sharing_mode]

########StepsToDo#########
      end
      params.require(:medium_review).permit(permitted_attributes).merge(form_step: step)
    end

      def check_if_signed_in
        if !user_signed_in?
          redirect_to "/"
        end
      end
end

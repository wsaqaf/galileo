class SrcReview::StepsController < ApplicationController
  include Wicked::Wizard
  before_action :find_src

  steps *SrcReview.form_steps

  def get_score(field,noun,adj)
    total=0
    score=0
    confidence=0
    result=""
    if field=="source"
      fields=[@src_review.src_lacks_proper_credentials,@src_review.src_failed_factcheck_before,@src_review.src_has_poor_writing_history,@src_review.src_supported_by_trolls,@src_review.src_difficult_to_locate,@src_review.src_other_problems]
      fields.each { |f| if (f.present? and not f.blank? and f!=0) then score=score+f.to_i; total=total+1; end }
    end
    max_total=fields.count
    confidence=(100*(total.to_f/max_total)).to_i
    relative_score="Score is "+score.to_s+" and max_tot is "+max_total.to_s
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
    @src_review = SrcReview.find(params[:src_review_id])

    if step=="s7" then @src_review_score=get_score("source","trustworthiness","trustworthy") end

    render_wizard

  end

  def update
      @src_review = SrcReview.find(params[:src_review_id])

      @src_review.update(src_review_params(step).merge(user_id: current_user.id))

      if
         step=="s6" then @src_review_score=get_score("source","trustworthiness","trustworthy") end
        render_wizard @src_review
###Step conditions###
  end

  private
  def find_src
    @src = Src.find(params[:src_id])
  end

    def src_review_params(step)
      permitted_attributes = case step
########StepsToDo#########
when "s1"
  [:src_lacks_proper_credentials, :note_src_lacks_proper_credentials]
when "s2"
  [:src_failed_factcheck_before, :note_src_failed_factcheck_before]
when "s3"
  [:src_has_poor_writing_history, :note_src_has_poor_writing_history]
when "s4"
  [:src_supported_by_trolls, :note_src_supported_by_trolls]
when "s5"
  [:src_difficult_to_locate, :note_src_difficult_to_locate]
when "s6"
  [:src_other_problems, :note_src_other_problems]
when "s8"
  [:src_review_verdict, :note_src_review_verdict, :src_review_description, :note_src_review_description]
when "s9"
  [:src_review_sharing_mode, :note_src_review_sharing_mode]
########StepsToDo#########
      end
      params.require(:src_review).permit(permitted_attributes).merge(form_step: step)
    end
end

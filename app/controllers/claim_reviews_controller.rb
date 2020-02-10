class ClaimReviewsController < ApplicationController
  before_action :find_claim
  before_action :check_if_signed_in

  def index
      @claim_reviews = ClaimReview.all.order("created_at DESC").where("claim_id=? AND ((review_sharing_mode=1 AND review_verdict IS NOT NULL) OR user_id=?)",@claim.id,current_user.id)
  end

  def show
    @tmp = ClaimReview.where("id=? AND (review_sharing_mode=1 OR user_id=?)",params[:id],current_user.id).first
    if (not @tmp.blank?)
      @claim_review=ClaimReview.find(@tmp.id)
      @json_claim_review= {
          "@context": "http://schema.org",
          "@graph": [
              {
                  "itemReviewed": {
                      "@type": "CreativeWork",
                      "url": "<URL of claim>",
                      "datePublished": "2020-02-10",
                      "description": "<includes the medium,source and FCA type of org (social media, etc.) and additional information about the claim>",
                      "identifier": "http://0.0.0.0:3000/claims/9",
                      "accessMode": ["visual","audical","textual"],
                      "author": {
                          "@type": "Organization",
                          "name": "Södertörn University"
                      }
                  },
                  "author": {
                      "@type": "Organization",
                      "@id": "https://sh.se",
                      "name": "Walid Al-Saqaf",
                      "url": "https://sh.se/kontakt/forskare/walid-al-saqaf",
                      "sameAs": "https://www.linkedin.com/in/wsaqaf/",
                      "logo": {
                          "@type": "ImageObject",
                          "url": "https://res-2.cloudinary.com/crunchbase-production/image/upload/c_thumb,h_120,w_120,f_auto,g_faces,z_0.7,b_white,q_auto:eco/j1ahpibhygitpg5ksnqm",
                          "width": "120",
                          "height": "120"
                      }
                  },
                  "reviewRating": {
                      "@type": "Rating",
                      "ratingValue": "1",
                      "bestRating": "5",
                      "worstRating": "1",
                      "alternateName": "<label of the rating above e.g., False>"
                  },
                  "claimReviewed": "<title of the claim>",
                  "@type": "ClaimReview",
                  "name": "<rationale for assessment as per FCA>",
                  "datePublished": "2020-02-10",
                  "url": "https://faktaassistenten.sh.se"
              }
          ],
      "@type": "FCAClaimRecord",
      "fcaClaim":
        {
          "@type": "FCAClaim",
          "fcaClaimMedium": "some medium",
          "fcaClaimSource": "some source",
          "fcaTags": ["tag1","tag2","tag3"],
          "fcaClaimHasImage": "<1 or 0, or blank>",
          "fcaClaimHasVideo": "<1 or 0, or blank>",
          "fcaClaimHasText": "<1 or 0, or blank>",
          "fcaClaimCreatedBy": "<name of FCA member adding the claim>",
          "fcaClaimCreatedAt": "2020-02-10 10:00:00",
          "fcaClaimUpdatedAt": "2020-02-10 10:00:00",
          "fcaClaimReviews": [
              {
                "@type": "FCAClaimReview",
                "fcaClaimReviewCreatedBy": "<name of FCA member adding the claim review>",
                "fcaClaimReviewCreatedAt": "2020-02-10 10:00:00",
                "fcaClaimReviewUpdatedAt": "2020-02-10 10:00:00",
                "imageReview":
                {
                  "@type": "FCAImageReview",
                  "reviewed": "<1,0,blank>",
                  "misleadingImg": "<1,0,blank>",
                  "doctoredImg": "<1,0,blank>",
                  "metadataImg": "<1,0,blank>",
                  "otherProblemsImg": "<1,0,blank>",
                  "reviewedDetails": "Details explaining how this result for reviewedDetails was reached",
                  "misleadingImgDetails": "Details explaining how this result for misleadingImgDetails was reached",
                  "doctoredImgDetails": "Details explaining how this result for doctoredImgDetails was reached",
                  "metadataImgDetails": "Details explaining how this result for metadataImgDetails was reached",
                  "otherProblemsImgDetails": "Details explaining how this result for otherProblemsImgDetails was reached"
                },
              "videoReview":
                {
                  "@type": "FCAVideoReview",
                  "reviewed": "<1,0,blank>",
                  "misleadingVid": "<1,0,blank>",
                  "doctoredVid": "<1,0,blank>",
                  "metadataVid": "<1,0,blank>",
                  "audioIssuesVid": "<1,0,blank>",
                  "otherProblemsVid": "<1,0,blank>",
                  "misleadingVidDetails": "Details explaining how this result for misleadingVidDetails was reached",
                  "doctoredVidDetails": "Details explaining how this result for doctoredVidDetails was reached",
                  "metadataVidDetails": "Details explaining how this result for metadataVidDetails was reached",
                  "audioIssuesVidDetails": "Details explaining how this result for audioIssuesVidDetails was reached",
                  "otherProblemsVidDetails": "Details explaining how this result for otherProblemsVidDetails was reached"
                },
              "textReview":
                {
                  "@type": "FCATextReview",
                  "reviewed": "<1,0,blank>",
                  "notSeriousTxt": "<1,0,blank>",
                  "failedBeforeTxt": "<1,0,blank>",
                  "clickBaitTxt": "<1,0,blank>",
                  "languageIssuesTxt": "<1,0,blank>",
                  "inaccuraciesInTxt": "<1,0,blank>",
                  "insufficientEvidenceTxt": "<1,0,blank>",
                  "otherProblemsTxt": "<1,0,blank>",
                  "notSeriousTxtDetails": "Details explaining how this result for notSeriousTxtDetails was reached",
                  "failedBeforeTxtDetails": "Details explaining how this result for failedBeforeTxtDetails was reached",
                  "clickBaitTxtDetails": "Details explaining how this result for clickBaitTxtDetails was reached",
                  "languageIssuesTxtDetails": "Details explaining how this result for languageIssuesTxtDetails was reached",
                  "inaccuraciesInTxtDetails": "Details explaining how this result for inaccuraciesInTxtDetails was reached",
                  "insufficientEvidenceTxtDetails": "Details explaining how this result for insufficientEvidenceTxtDetails was reached",
                  "otherProblemsTxtDetails": "Details explaining how this result for otherProblemsTxtDetails was reached"
                }
              }]
          }
        }      
    else
      redirect_to claims_path
    end
   end

  def new
  end

  def create
    @tmp = ClaimReview.where("claim_id=? AND user_id=?",@claim.id,current_user.id).first
    if (not @tmp.blank?)
      @claim_review=ClaimReview.find(@tmp.id)
      redirect_to claim_claim_review_step_path(@claim,@claim_review, ClaimReview.form_steps.first)
      return
    end
    @claim_review = ClaimReview.new
    @claim_review.claim_id=@claim.id
    @claim_review.user_id=current_user.id
    @claim_review.save(validate: false)
    redirect_to claim_claim_review_step_path(@claim,@claim_review, ClaimReview.form_steps.first)
  end

  def edit
    @tmp = ClaimReview.where("claim_id=? AND user_id=?",@claim.id,current_user.id).first
    if (@tmp.blank?)
      @claim_review=ClaimReview.find(@tmp.id)
      if current_user.id!=@claim_review.user_id
        redirect_to claim_claim_review_path(@claim,@claim_review)
      end
    else
      redirect_to claim_path(@claim)
    end
  end

  def update
    if (!params.has_key?(:claim_review)) then redirect_to claims_path; return; end

    @tmp = ClaimReview.where("claim_id=? AND user_id=?",@claim.id,current_user.id).first
    if (not @tmp.blank?)
      @claim_review=ClaimReview.find(@tmp.id)
      @claim_review.update(claim_review_params)
    end
    redirect_to claims_path;
  end

  def destroy
    @tmp = ClaimReview.where("claim_id=? AND user_id=?",@claim.id,current_user.id).first
    if (not @tmp.blank?)
      @claim_review=ClaimReview.find(@tmp.id)
      @claim_review.destroy
    end
    redirect_to claims_path
  end

  private

  def check_ownership
  end

  def find_claim
    @claim = Claim.find(params[:claim_id])
  end

  def check_if_signed_in
    if !user_signed_in?
      redirect_to "/"
    end
  end

  def claim_review_params
        params.require(:claim_review).permit(:id, :img_review_started, :img_old, :note_img_old, :img_forensic_discrepency, :note_img_forensic_discrepency, :img_metadata_discrepency, :note_img_metadata_discrepency, :img_logical_discrepency, :note_img_logical_discrepency, :vid_review_started, :vid_old, :note_vid_old, :vid_forensic_discrepency, :note_vid_forensic_discrepency, :vid_metadata_discrepency, :note_vid_metadata_discrepency, :vid_audio_discrepency, :note_vid_audio_discrepency, :vid_logical_discrepency, :note_vid_logical_discrepency, :txt_review_started, :txt_unreliable_news_content, :note_txt_unreliable_news_content, :txt_insufficient_verifiable_srcs, :note_txt_insufficient_verifiable_srcs, :txt_has_clickbait, :note_txt_has_clickbait, :txt_poor_language, :note_txt_poor_language, :txt_crowds_distance_discrepency, :note_txt_crowds_distance_discrepency, :txt_author_offers_little_evidence, :note_txt_author_offers_little_evidence, :txt_reliable_sources_disapprove, :note_txt_reliable_sources_disapprove, :review_verdict, :review_description, :note_review_description, :review_sharing_mode, :note_review_sharing_mode)
    end

end

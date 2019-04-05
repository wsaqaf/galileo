class ApplicationController < ActionController::Base
    include Pagy::Backend

    protect_from_forgery with: :exception

    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :set_current_user

    autocomplete :user, :affiliation

    def set_current_user
      User.current_user = current_user
    end

    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :affiliation, :email, :password])
        devise_parameter_sanitizer.permit(:account_update, keys: [:name, :affiliation, :email, :password, :current_password])
    end


      def filter_bar(page,filter_option)
        f={"a"=>"","r"=>"","u"=>"","n"=>""}
        page1=page.downcase
        page2=page
        if (page=="Srcs") then page2="Sources"; end
        f.each do |key, value|
            if key==filter_option then f[key]="selected"; end
        end
        return "<select id='filter'><option value='"+page1+"' "+f['a']+">All "+page2+"</option><option value='?filter=r' "+f['r']+">"+page+" with shared reviews</option><option value='?filter=u' "+f['u']+">"+page+" you reviewed</option><option value='?filter=n' "+f['n']+">"+page+" with no reviews yet</option></select>\n<script>$(function(){$('#filter').on('change',function(){{window.location=$(this).val();}return false;});});</script>"
      end

      def sort_statement(page,sorting)
        if page=="claim"
           page2=""
        else
          page2=page+"_"
        end

        case sorting
        when "r"
          return "count("+page+"_reviews."+page2+"review_verdict) DESC"
        when "rp"
          return "sum("+page+"_reviews."+page2+"review_verdict)/(count("+page+"_reviews."+page2+"review_verdict)) DESC"
        when "rn"
          return "sum("+page+"_reviews."+page2+"review_verdict)/(count("+page+"_reviews."+page2+"review_verdict)) ASC"
        end
      end

      def sort_bar(page,sort_option)
        s={"td"=>"","r"=>"","rp"=>"","rn"=>""}
        page1=page.downcase
        page2=page
        if (page=="Srcs") then page2="Sources"; end
        s.each do |key, value|
            if key==sort_option then s[key]="selected"; end
        end
        return "Sort by: <select id='sort'><option value='?sort=td' "+s['td']+">"+page2+" sorted by time (newest first)</option><option value='?sort=r' "+s['r']+">"+page2+" sorted by reviews (most reviewed first)</option><option value='?sort=rp' "+s['rp']+">"+page2+" sorted by positive reviews</option><option value='?sort=rn' "+s['rn']+">"+page2+" sorted by negative reviews</option><select>\n<script>$(function(){$('#sort').on('change',function(){{window.location=$(this).val();}return false;});});</script>"
      end

    def linkpreview
        url = params[:url]
        preview = LinkPreviewParser.parse(url) # returns a Hash
        respond_to do |format|
            format.json { render :json => preview }
        end
    end

    class Thumbnail
      require 'link_thumbnailer'
      attr_reader :url
      def initialize(url)
        @url = url
      end
      def title
        thumbnailer.try(:title)
      end
      def description
        thumbnailer.try(:description)
      end
      def images
        thumbnailer.try(:images)
      end
      def videos
        thumbnailer.try(:images)
      end
      def favicon
        thumbnailer.try(:favicon)
      end

      private
      def thumbnailer
        @thumbnailer ||= LinkThumbnailer.generate(url, verify_ssl: false)
      rescue LinkThumbnailer::Exceptions
        nil
      end
    end

end

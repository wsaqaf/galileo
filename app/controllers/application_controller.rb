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

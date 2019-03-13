class ResourcesController < ApplicationController
  before_action :find_resource, only: [:show, :edit, :update, :destroy]
  before_action :check_if_signed_in


    def index
      if (params[:term].present?)
        @resources = Resource.order(:name).where("name like '%"+params[:term]+"%'")
        render json: @resources.map(&:name)
      elsif (params[:q].present?)
        @pagy, @resources = pagy(Resource.order(:name).where("name like ?'%"+params[:q]+"%'"), items: 10)
      else
        @pagy, @resources = pagy(Resource.all.order("created_at DESC"), items: 10)
      end
    end

    def show
    end

    def new
      @resource = current_user.resources.build
      @ref=""
      if (params[:ref].present?)
        @ref=params[:ref]
      end
    end

    def create
      @resource = current_user.resources.build(resource_params)

      if @resource.save
          redirect_to resources_path
      else
          render 'new'
      end
    end

    def edit
    end

    def update
      if @resource.update(resource_params)
        redirect_to resource_path(@resource)
      else
        render 'edit'
      end
    end

    def destroy
      @resource.destroy
      redirect_to resources_path
    end

    private
      def resource_params
        params.require(:resource).permit(:name, :url, :description, :tutorial, :icon, :used_for_qs, :ref)
      end

      def find_resource
        @resource = Resource.find(params[:id])
      end

        def check_if_signed_in
          if !user_signed_in?
            redirect_to "/"
          end
        end
  end

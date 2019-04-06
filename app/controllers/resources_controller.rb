class ResourcesController < ApplicationController
  before_action :find_resource, only: [:show, :edit, :update, :destroy]
  before_action :check_if_signed_in


    def index
      if (params[:term].present?)
        @resources = Resource.order(:name).where("name like ?","'%"+params[:term]+"%'")
        render json: @resources.map(&:name)
      elsif (params[:q].present?)
        tmp=Resource.order(:name).where("lower(name) like lower('%"+params[:q]+"%') or lower(description) like lower('%"+params[:q]+"%') or lower(url_preview) like lower('%"+params[:q]+"%')")
        @total_count=tmp.count
        @pagy, @resources = pagy(tmp, items: 10)
      else
        tmp=Resource.all.order("created_at DESC")
        @total_count=tmp.count
        @pagy, @resources = pagy(tmp, items: 10)
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
      if current_user.id!=@resource.user_id and current_user.id!=1
        redirect_to resource_path(@resource)
      end
    end

    def update
      if current_user.id!=@resource.user_id and current_user.id!=1
        redirect_to resource_path(@resource)
        return
      end
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
        params.require(:resource).permit(:name, :url, :description, :tutorial, :icon, :used_for_qs, :ref, :url_preview)
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

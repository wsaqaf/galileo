class QuestionController < ApplicationController
  before_action :find_question, only: [:show, :edit, :update, :destroy]
  before_action :check_if_signed_in

  def index
      @questions = question.all.order("created_at DESC")
  end

  def show
  end

  def new
      @question = current_user.questions.build
      @question_sources = questionSource.all.map{ |c| [c.name, c.id]}
      @media = Medium.all.map{ |m| [m.name, m.id]}
      category = Medium.find(params[:id])
  end

  def create
    @question = current_user.questions.build(question_params)

    if @question.save
        redirect_to root_path
    else
        render 'new'
    end
  end

  def edit
  end

  def update
    if @question.update(question_params)
      redirect_to question_path(@question)
    else
      render 'edit'
    end
  end

  def destroy
    @question.destroy
    redirect_to root_path
  end

  private

    def question_params
      params.require(:question).permit(:q_text, :description, :tags)
    end

    def find_question
      @question = question.find(params[:id])
    end

      def check_if_signed_in
        if !user_signed_in?
          redirect_to "/"
        end
      end
end

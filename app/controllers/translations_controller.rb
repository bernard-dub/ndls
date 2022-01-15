class TranslationsController < ApplicationController
  before_action :set_translation, only: %i[ show edit update destroy ]
  before_action :set_lesson, except: %i[ destroy ]

  # GET /translations or /translations.json
  def index
    @translations = Translation.all
  end

  # GET /translations/1 or /translations/1.json
  def show
  end

  # GET /translations/new
  def new
    @translation = Translation.new
  end

  # GET /translations/1/edit
  def edit
  end

  # POST /translations or /translations.json
  def create
    @lesson.translations.create! params.required(:translation).permit([:original, :translated])
    redirect_to @lesson
    # @translation = Translation.new(translation_params)

    # respond_to do |format|
#       if @translation.save
#         format.html { redirect_to translation_url(@translation), notice: "Translation was successfully created." }
#         format.json { render :show, status: :created, location: @translation }
#       else
#         format.html { render :new, status: :unprocessable_entity }
#         format.json { render json: @translation.errors, status: :unprocessable_entity }
#       end
#     end
  end

  # PATCH/PUT /translations/1 or /translations/1.json
  def update
    respond_to do |format|
      if @translation.update(translation_params)
        format.html { redirect_to translation_url(@translation), notice: "Translation was successfully updated." }
        format.json { render :show, status: :ok, location: @translation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @translation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /translations/1 or /translations/1.json
  def destroy
    @translation.destroy

    respond_to do |format|
      format.html { redirect_to @translation.lesson, notice: "Translation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_translation
      @translation = Translation.find(params[:id])
    end
    
    def set_lesson
      @lesson = Lesson.find(params[:lesson_id])
    end

    # Only allow a list of trusted parameters through.
    def translation_params
      params.require(:translation).permit(:original, :translated, :lesson_id)
    end
end

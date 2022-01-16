class LessonsController < ApplicationController
  
  before_action :authenticate_user!
  
  before_action :set_lesson, only: %i[ show edit update destroy play result stats reset]

  # GET /lessons or /lessons.json
  def index
    @lessons = Lesson.all
  end

  # GET /lessons/1 or /lessons/1.json
  def show
  end
  
  def play
    @test = Test.new(:lesson => @lesson)
    @test.reverse = true if params[:reverse] == 'reverse'
    @test.translations = @lesson.translations.shuffle
    render 'lessons/play/index'
  end
  
  def result
    @test = @lesson.tests.build(score: 0, user_id: current_user.id, reverse: params['test']['reverse'])
    @test.answers.build params['test']['answers_attributes'].as_json.values
    @test.answers.each do |a|
      unless @test.reverse?
        if a.content.parameterize == a.translation.translated.parameterize
          a.correct = true
          @test.score += 1
        end
      else
        if a.content.parameterize == a.translation.original.parameterize
          a.correct = true
          @test.score += 1
        end
      end
    end
    if @test.save
      render 'lessons/play/result'
    else
      flash[:notice] = "Oups. Une erreur s'est produite. #{@test.to_json}"
      render 'lessons/play/index'
    end
  end
  
  def stats
    tests = @lesson.tests.for_user(current_user)
    @history = tests.sort_by(&:created_at).reverse
    @words = Array.new
    answers = tests.map{|t|t.answers}.flatten
    answers.group_by(&:translation_id).each do |translation_id, answers|
      word = {}
      correct_answers = answers.select{|a|a.correct?}
      incorrect_answers = answers.select{|a|!a.correct?}
      translation = Translation.find(translation_id)
      word[:original] = translation.original
      word[:translated] = translation.translated
      word[:percentage_score] = (correct_answers.size.to_f / answers.size.to_f*100).round(0)
      word[:absolute_score] = "#{correct_answers.size} / #{answers.size}"
      word[:translated_errors] = incorrect_answers.select{|a|!a.test.reverse?}.map(&:content).uniq.join ", "
      word[:original_errors] = incorrect_answers.select{|a|a.test.reverse?}.map(&:content).uniq.join ", "
      @words << word
    end
  end
  
  def reset
    @lesson.tests.for_user(current_user).destroy_all
    redirect_to stats_lesson_path(@lesson)
  end
  
  
  # GET /lessons/new
  def new
    @lesson = current_user.lessons.build
  end

  # GET /lessons/1/edit
  def edit
  end

  # POST /lessons or /lessons.json
  def create
    @lesson = current_user.lessons.build(lesson_params)

    respond_to do |format|
      if @lesson.save
        format.html { redirect_to lesson_url(@lesson), notice: "Lesson was successfully created." }
        format.json { render :show, status: :created, location: @lesson }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lessons/1 or /lessons/1.json
  def update
    respond_to do |format|
      if @lesson.update(lesson_params)
        format.html { redirect_to lesson_url(@lesson), notice: "Lesson was successfully updated." }
        format.json { render :show, status: :ok, location: @lesson }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lessons/1 or /lessons/1.json
  def destroy
    @lesson.destroy

    respond_to do |format|
      format.html { redirect_to lessons_url, notice: "Lesson was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lesson
      @lesson = Lesson.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def lesson_params
      params.require(:lesson).permit(:title)
    end
end

class TranslationsController < ApplicationController
  before_action :set_translation, only: %i[show edit update destroy]

  def index
    @translations = Translation.all
  end

  def show
  end

  def new
    @translation = Translation.new
    @translation.build_conjugation
    @translation.build_language
  end

  def edit
  end

  def create
    @translation = Translation.new(translation_params)

    respond_to do |format|
      if @translation.save
        format.html { redirect_to translation_url(@translation), notice: "Translation was successfully created." }
        format.json { render :show, status: :created, location: @translation }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @translation.errors, status: :unprocessable_entity }
      end
    end
  end

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

  def destroy
    @translation.destroy

    respond_to do |format|
      format.html { redirect_to translations_url, notice: "Translation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_translation
    @translation = Translation.find(params[:id])
  end

  def translation_params
    params.require(:translation).permit(:word,
                                        :word_type,
                                        :example,
                                        :word_translation,
                                        language_attributes: %i[language_name],
                                        conjugation_attributes: %i[present_i present_you present_hesheit present_we present_youall present_they])
  end
end

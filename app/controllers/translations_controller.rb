class TranslationsController < ApplicationController
  before_action :set_translation, only: %i[show vote edit update destroy]
  before_action :authenticate_user!, except: %i[show index search]
  before_action :author?, only: %i[edit update destroy]

  def index
    if cookies[:language]
      return @translations = Translation.where(language: cookies[:language]) 
    else
      return @translations = Translation.where(language: "spanish")
    end
  end

  def show
    @comment = Comment.new
  end

  def change_language
    cookies[:language] = params[:language]
    redirect_to root_path
  end

  def vote
    @translation = Translation.find(params[:id])
    sql_select = "SELECT * FROM translations_users
    WHERE translation_id=#{@translation.id} AND user_id=#{current_user.id};"
    result = ActiveRecord::Base.connection.execute(sql_select)
    if result.any?
      sql_delete = "DELETE FROM translations_users
      WHERE translation_id=#{@translation.id} AND user_id=#{current_user.id};"
      ActiveRecord::Base.connection.execute(sql_delete)
      @translation.votes -= 1
    else
      sql_insert = "INSERT INTO translations_users (created_at, updated_at, translation_id, user_id)
      VALUES (#{Time.now.to_i}, #{Time.now.to_i}, #{@translation.id}, #{current_user.id});"
      ActiveRecord::Base.connection.execute(sql_insert)
      @translation.votes += 1
    end
    redirect_to translation_url(@translation)
    @translation.save
  end

  def search
    @translations = Translation.where("word LIKE ? and language == '#{cookies[:language]}'", "%#{params[:q]}%")
  end

  def new
    @translation = Translation.new
    @translation.build_conjugation
  end

  def edit
  end

  def create
    ## replace every odd newline in example with a hypen
    translation_params[:example].gsub!("\n").with_index(1) { |_, i| i.odd? ? " - " : "\n" }
    @translation = Translation.new(translation_params)
    @translation.user_id = current_user.id

    @translation.votes = 0

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
    sql_delete = "DELETE FROM translations_users
    WHERE translation_id=#{@translation.id}"
    ActiveRecord::Base.connection.execute(sql_delete)
    comments = Comment.where(:translation_id == @translation.id)
    comments.each do |comment|
      sql_delete = "DELETE FROM comments_users
      WHERE comment_id=#{comment.id} AND user_id=#{current_user.id};"
      ActiveRecord::Base.connection.execute(sql_delete)
      comment.destroy
    end
    @translation.destroy

    respond_to do |format|
      format.html { redirect_to translations_url, notice: "Translation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def merge(arr1, arr2)
    merged_arr = []
    while not arr1.empty?
      unless arr2.empty?
        if arr1.first < arr2.first
          merged_arr.append(arr1.first)
          arr1.shift
        else
          merged_arr.append(arr2.first)
          arr2.shift
        end
      else
        return merged_arr += arr1
      end
    end
    merged_arr + arr2
  end
  
  def merge_sort(arr)
    return arr if arr.length < 2
    arr = arr.each_slice((arr.length/2.0).round).to_a
    left = merge_sort(arr[0])
    right = merge_sort(arr[1])
    merge(left, right)
  end  

  def author?
    redirect_to root_path unless @translation.user_id == current_user.id
  end

  def set_translation
    @translation = Translation.find(params[:id])
  end

  def translation_params
    params.require(:translation).permit(:word,
                                        :word_type,
                                        :example,
                                        :word_translation,
                                        :language,
                                        conjugation_attributes: %i[present_i present_you present_hesheit present_we present_youall present_they])
  end
end

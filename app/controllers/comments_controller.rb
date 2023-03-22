class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: %i[show index]
  before_action :author?, only: %i[edit update destroy]

  # GET /comments
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  def show
  end

  def vote
    @comment = Comment.find(params[:id])
    sql_select = "SELECT * FROM comments_users
    WHERE comment_id=#{@comment.id} AND user_id=#{current_user.id};"
    result = ActiveRecord::Base.connection.execute(sql_select)
    if result.any?
      sql_delete = "DELETE FROM comments_users
      WHERE comment_id=#{@comment.id} AND user_id=#{current_user.id};"
      ActiveRecord::Base.connection.execute(sql_delete)
      @comment.votes -= 1
    else
      sql_insert = "INSERT INTO comments_users (created_at, updated_at, comment_id, user_id)
      VALUES (#{Time.now.to_i}, #{Time.now.to_i}, #{@comment.id}, #{current_user.id});"
      ActiveRecord::Base.connection.execute(sql_insert)
      @comment.votes += 1
    end
    redirect_to request.env['HTTP_REFERER']
    @comment.save
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.translation_id = params[:translation_id]
    @comment.votes = 0

    respond_to do |format|
      if @comment.save
        format.html { redirect_to translation_url(Translation.find(params[:translation_id])), notice: "comment was successfully created." }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { redirect_to translation_url(Translation.find(params[:translation_id])), status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to comment_url(@comment), notice: "comment was successfully updated." }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  def destroy
    sql_delete = "DELETE FROM comments_users
    WHERE comment_id=#{@comment.id} AND user_id=#{current_user.id};"
    ActiveRecord::Base.connection.execute(sql_delete)
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to request.env['HTTP_REFERER'], notice: "comment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def author?
      redirect_to root_path unless @comment.user_id == current_user.id
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:text_content)
    end
end

class CommentsController < ApplicationController
  before_action :load_glob
  before_action :load_comment, except: [:index, :new, :create]
  
  def index
  end
  def new
    @comment = Comment.new
  end 
  def create
    @comment = Comment.new comment_params
    if @glob.comments << @comment
      redirect_to glob_comment_path(@glob,@comment), notice: "New Comment" 
      # Possibly need to fix this
    else
      render :new, status: :unprocessable_entity
    end
  end
  def show
  end
  
  def edit
  end
  
  def update
    if @comment.update comment_params
      redirect_to glob_comment_path(@glob,@comment), notice: "Comment Updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    @comment.destroy
    redirect_to glob_comments_path(@glob), alert: "Comment Deleted"
  end
  
  private 
  
  def comment_params
    params.require(:comment).permit(:body,:contributor,:contact)
  end
  
  def load_comment
    @comment = @glob.comments.find params[:id]
  end
  
  def load_glob
    @glob = Glob.find params[:glob_id]
  end
end

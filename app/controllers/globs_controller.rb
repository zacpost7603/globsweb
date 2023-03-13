class GlobsController < ApplicationController
  before_action :authenticate
  before_action :load_glob, except: [:new, :index, :create]
  #GET all globs
  def index
    @globs = Glob.all
  end
  #GET glob
  def new
    @glob = Glob.new
  end
  #POST a new glob
  def create
  @glob = Glob.new glob_params
  @glob.user = current_user
  if @glob.save
    redirect_to globs_path, notice: "Glob Successfully Created"
  else
    render :new, status: :unprocessable_entity
  end
  end
  #GET glob
  def show
  end
  #GET glob
  def edit
    #add if logic for if the user is equal to current user else redirect to root
    if @glob.user != current_user
      redirect_to root_path, notice: "Invalid request"
    end
  end
  #PATCH/PUT glob
  def update
    if @glob.user == current_user
      if @glob.update glob_params
        redirect_to @glob, notice: "Glob Successfully Updated"
      else
        render :edit, status: :unprocessable_entity
      end
    else
      redirect_to root_path, alert: "Invalid request"
    end
  end
  #DELETE glob
  def destroy
    # add same if logic like above
    if @glob.user == current_user
      @glob.destroy
      redirect_to globs_path, alert: "Glob was Deleted!"
    else
       redirect_to root_path, alert: "Invalid request"
    end
  end
  
  private
  
  def load_glob
    @glob = Glob.find params[:id]
  end
  def glob_params
    params.require(:glob).permit(:title,:summary,:author)
  end
  
end

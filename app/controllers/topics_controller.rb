class TopicsController < ApplicationController
  
  before_filter :login_required
  before_filter :get_forum
  
  def index
    @topics = Topic.find(:all)

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def show
    @topic = Topic.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def new
    @topic = Topic.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def edit
    @topic = Topic.find(params[:id])
  end

  def create
    @topic = Topic.new(params[:topic])

    respond_to do |format|
      if @topic.save
        flash[:notice] = 'Topic was successfully created.'
        format.html { redirect_to forum_topics_url(@forum) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @topic = Topic.find(params[:id])

    respond_to do |format|
      if @topic.update_attributes(params[:topic])
        flash[:notice] = 'Topic was successfully updated.'
        format.html { redirect_to forum_topics_url(@forum) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy

    respond_to do |format|
      format.html { redirect_to(forum_topics_url(@forum)) }
    end
  end

  private
  
    def get_forum
      @forum = Forum.find(params[:forum_id])
    end
end

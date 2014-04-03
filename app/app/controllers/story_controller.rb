class StoryController < ApplicationController

  before_action :is_authenticated?

  def all_story
    @stories = Story.all.entries
  end


  def new
    render :create_story
  end


  def show
    @story = Story.find_by({:index => params[:code]})
    flash.now[:notice] = params[:notice]
  end


  def create
    if params[:story][:title].blank? || params[:story][:content].blank?
      flash.now[:notice] = "Please enter a title and message"
      render :create_story
    else
      story = Story.new
      story.set_title_and_index( story_params )
      story.set_keeper_to_user_email( user_params )

      message = Message.new
      message.set_owner_and_status( user_params )
      message.set_content( story_params )

      story.messages << message
      story.save

      notice = "Your Story has been created"
      redirect_to :controller => 'story', :action => 'show', :code => story.index, :notice => notice
    end
  end


  def next_title
    if Story.count < 1
      flash.now[:notice] = "There are no stories.  Please create one!"
      render :create_story
    else
    rand = rand(Story.count) + 1
    @story = Story.find_by({:index => rand})
    # render :story
    redirect_to :controller => 'story', :action => 'show', :code => @story.index
    end
  end


  def contribute
    story = Story.find_by({:index => params[:message][:index]})

    message = Message.new
    message.content = params[:message][:content]
    message.status = "pending"
    message.owner = current_user.email

    story.messages << message

    message.save
    story.save

    notice = "Your contribution has been submitted"
    redirect_to :controller => 'story', :action => 'show', :code => story.index, :notice => notice
  end

  def pending_messages
    @stories = Story.where({:keeper => current_user.email})
    render :pending
  end

  def approve_message
    approved_message = Message.find_by({:_id => params[:message][:msg_id]})
    approved_message.status = "approved"
    approved_message.save

    pending_messages = Message.where({
      :story_id => approved_message.story_id,
      :status => "pending",
      }).update_all({:status => "disapproved"})

    story = Story.find_by({:_id => approved_message.story_id})
    story.keeper = approved_message.owner
    story.push(contributors: approved_message.owner)
    story.save

    pending

  end

  def my_stories
    @my_stories = Story.where({
      :contributors => current_user.email})

    render :my_stories
  end

  private

  def story_params
    params.require(:story).permit(:title, :content)
  end

  def user_params
    current_user
  end

end




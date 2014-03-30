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


  def create_story
    if params[:story][:title].blank? || params[:story][:content].blank?
      flash.now[:notice] = "Please enter a title and message"
      render :create_story
    else
      notice = "Your Story has been created"
      story = Story.new
      story.title = params[:story][:title]
      story.index = Story.count + 1

      user = User.find_by({:email => current_user.email})

      story.keeper = user.email
      story.push(contributors: user.email)

      message = Message.new
      message.status = 'approved'
      message.content = params[:story][:content]
      message.owner = current_user.email
      story.messages << message

      message.save
      story.save

      redirect_to :controller => 'story', :action => 'show', :code => story.index, :notice => notice
    end
  end


  def next_title
    rand = rand(Story.count) + 1
    @story = Story.find_by({:index => rand})
    # render :story
    redirect_to :controller => 'story', :action => 'show', :code => @story.index
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

  def pending
    @stories = Story.where({:keeper => current_user.email})
    render :pending
  end

  def approve_message
    approved_message = Message.find_by({:_id => params[:message][:msg_id]})
    approved_message.status = "approved"
    approved_message.save

    # change all status of pending to dissa

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


end




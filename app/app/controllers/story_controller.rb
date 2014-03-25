class StoryController < ApplicationController

  before_action :is_authenticated?

  def all_story

    @stories = Story.all.entries

  end

  def new

    render :create_story

  end


  def create_story
    story = Story.new

    story.title = params[:story][:title]
    story.index = Story.count + 1
    story.save

    render text: "Your Story has been created"

  end

  def next_title

    rand = rand(Story.count) + 1
    @story = Story.find_by({:index => rand})
    render :story

  end

end
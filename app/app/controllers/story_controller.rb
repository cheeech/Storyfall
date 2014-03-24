class StoryController < ApplicationController

  before_action :is_authenticated?

  def all_story

    @stories = Story.all.entries

  end

  def create_story
    render :create_story

  end

  def next_title

    rand = rand(Story.count) + 1
    @story = Story.find_by({:index => rand})
    render :story

  end

end
# frozen_string_literal: true

class TopController < ApplicationController
  before_action :authenticate_user!, only: [:menu, :manager_menu]
  before_action :is_manager?, only: [:manager_menu]

  def index
    @events = Event
                .where(is_deleted: false)
                .where("event_date > ?", Time.zone.now)
                .order(:event_date)
                .limit(5)
    @blogs = Blog.blogs_index.order(created_at: :desc).limit(3)
    @learn_records = LearnRecord.publish.order(created_at: :desc).limit(3)
  end

  def menu
  end

  def lp
  end

  def manager_menu
    @event = Event.find(params[:event_id])
  end
end

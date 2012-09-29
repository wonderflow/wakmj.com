# coding: utf-8

class TvDramasController < ApplicationController
  layout 'tv_drama'
  before_filter :require_login, :except => [:show]
  before_filter :init_tv_drama, :except => [:create, :new]

  load_and_authorize_resource :only => [:edit, :update, :create, :new]

  def show
    @topics = @tv_drama.topics.desc('created_at')
  end

  def edit
  end

  def update
    params[:drama].delete_if { |k, v| k == 'cover' && v.blank? }
    if @tv_drama.update_attributes(params[:drama])
      redirect_to tv_drama_path(@tv_drama)
    else
      flash[:error] = @tv_drama.errors.full_messages
      redirect_to :back
    end
  end

  def create
  end

  def new
  end

  private

  def init_tv_drama
    @tv_drama = TvDrama.find_by_id(params[:id])
  end

end
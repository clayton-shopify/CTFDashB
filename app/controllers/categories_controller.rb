# frozen_string_literal: true

class CategoriesController < ApplicationController
  skip_before_action :user_logged_in?
  before_action :ctf_has_started?
  before_action :fetch_categories
  before_action :fetch_team_submissions

  include Users
  include CtfSettings

  def index
    @challenges = Challenge.active
    render 'challenges/index'
  end

  def show
    @category = Category.find_by!(id: params[:id])
  end

  private

  def fetch_categories
    @categories = Category.all
  end

  def fetch_team_submissions
    @team_submissions = Submission.where(team: current_user&.team).group(:challenge_id).count
  end
end

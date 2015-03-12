class MembershipsController < ApplicationController

  before_action do
    @project = Project.find(params[:project_id])
  end

  def index
    @memberships = @project.memberships
  end

  def new
    @membership = Membership.new
  end

  def show
    @membership = Membership.find(params[:id])
  end

  def edit
    @membership = Membership.find(params[:id])
  end

  def update
    @membership = Membership.find(params[:id])
    end

  def create
    @membership = Membership.new(membership_params)
  end

  def destroy
  end

  private

end

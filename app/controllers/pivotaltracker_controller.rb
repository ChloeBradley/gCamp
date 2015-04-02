class PivotaltrackerController < ApplicationController
  def show
    @project_name = params["name"]
    tracker_api = TrackerAPI.new
    proj_id = (params[:id])
    @stories = tracker_api.stories(current_user.tracker_token, proj_id)
  end
end

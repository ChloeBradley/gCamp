require 'rails_helper'

describe ProjectsController do
  describe 'GET #index' do
    describe 'Permissions' do
      it 'it should redirect a non logged in user to the sign in path' do

        get :index
        expect(response).to redirect_to sign_in_path
        expect(flash[:danger]).to eq 'You must sign in'
      end
    end
  end
  describe 'Get #show' do
    describe 'Permissions' do
      it 'should redirect a non logged in user to the sign in path' do
        project = create_project

        get :show, id: project.id
        expect(response).to redirect_to sign_in_path
        expect(flash[:danger]).to eq 'You must sign in'
      end

      it 'should redirect a nonmember to projects path' do
        user = create_user
        session[:user_id] = user.id
        project = create_project

        get :show, id: project.id
        expect(response).to redirect_to projects_path
        expect(flash[:danger]).to eq 'You do not have access to that project'
      end
    end
  end

  describe 'PATCH #update' do
    describe 'permissions'do
      it 'should redirect a non logged in user to the sign in path' do
        project = create_project

        patch :update, id: project.id
        expect(response).to redirect_to sign_in_path
        expect(flash[:danger]).to eq 'You must sign in'
      end
      it 'should redirect a nonmember to projects path' do
        user = create_user
        session[:user_id] = user.id
        project = create_project

        patch :update, id: project.id
        expect(response).to redirect_to projects_path
        expect(flash[:danger]).to eq 'You do not have access to that project'
      end

      # it 'should redirect a member to projects path' do
      #   user = create_user
      #   session[:user_id] = user.id
      #   project = create_project
      #   # membership = create_membership(project_id: project.id, user_id: user.id)
      #
      #   expect{
      #     patch :update, id: project.id, project: {name: 'Change this name'}
      #   }.to_not change { project.reload.last }
      #
      #   expect(response).to redirect_to projects_path
      #   expect(flash[:danger]).to eq 'You do not have access'
      # end
    end
  end
end

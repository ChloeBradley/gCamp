require 'rails_helper'

describe TasksController do
  describe 'GET #index' do
    describe 'Permissions' do
      it 'it should redirect a non logged in user to the sign in path' do

        get :index

        expect(response).to redirect_to sign_in_path
        expect(flash[:danger]).to eq 'You must sign in'
      end
    end
  end

  describe 'GET #edit' do
    describe 'Permissions' do
      it 'it should redirect a non logged in user to the sign in path' do
        project = create_project

        get :edit, id: project.id

        expect(response).to redirect_to sign_in_path
        expect(flash[:danger]).to eq 'You must sign in'
      end

      it 'should redirect a nonmember to projects path' do
        user = create_user
        project = create_project
        session[:user_id] = user.id

        get :edit, id: project.id task_id: task.id

        expect(response).to redirect_to projects task_path
        expect(flash[:danger]).to eq 'You do not have access to that project'
      end
    end
  end

  describe 'GET #new' do
    describe 'Permissions' do
      it 'it should redirect a non logged in user to the sign in path' do

        get :new

        expect(response).to redirect_to sign_in_path
        expect(flash[:danger]).to eq 'You must sign in'
      end
    end
  end

  describe 'post #create' do
    describe 'Permissions' do
      it 'it should redirect a non logged in user to the sign in path' do

        post :create, project: { name: 'This is cool' }

        expect(response).to redirect_to sign_in_path
        expect(flash[:danger]).to eq 'You must sign in'
      end
    end
  end

  describe 'Get #show' do
    describe 'Permissions' do
      it 'should redirect a non logged in user to the sign in path' do
        project = create_project

        get :show, id: project.id, task_id: task.id
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

      it 'should redirect a member to projects path' do
        user = create_user
        session[:user_id] = user.id
        project = create_project
         membership = create_membership(project_id: project.id, user_id: user.id)

        expect{
          patch :update, id: project.id, project: {name: 'Change this name'}
        }.to_not change { project.reload.name }

        expect(response).to redirect_to projects_path
        expect(flash[:danger]).to eq 'You do not have access'
      end
    end
  end

   describe 'delete #destroy' do
     it 'admin is able to delete a project' do
     user = create_user(admin: true)
     session[:user_id] = user.id
     project = create_project

     expect{
       delete :destroy, id: project.id
     }.to change {Project.count}.by(-1)

     expect(flash[:success]).to eq 'Project was successfully deleted'
     expect(response).to redirect_to projects_path
    end

    it 'should redirect a visitor to sign in path' do
      project = create_project

      expect{
        delete :destroy, id: project.id
      }.to_not change{Project.count}

      expect(response).to redirect_to sign_in_path
      expect(flash[:danger]).to eq "You must sign in"
    end

    it 'should redirect a member to projects path' do
      user = create_user
      project = create_project
      membership = create_membership(user_id: user.id, project_id: project.id, role: 'Member')
      session[:user_id] = user.id

      expect{
        delete :destroy, id: project.id
      }.to_not change { Project.count }

      expect(response).to redirect_to projects_path
      expect(flash[:danger]).to eq "You do not have access"
     end
   end
end

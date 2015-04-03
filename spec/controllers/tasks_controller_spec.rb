require 'rails_helper'

describe TasksController do
  describe 'GET #index' do
    describe 'Permissions' do
      it 'it should redirect a non logged in user to the sign in path' do
        project = create_project

        get :index, project_id: project.id

        expect(response).to redirect_to sign_in_path
        expect(flash[:danger]).to eq 'You must sign in'
      end
    end
  end

  describe 'GET #edit' do
    describe 'Permissions' do
      it 'it should redirect a non logged in user to the sign in path' do
        project = create_project
        task = create_task({project_id: project.id})

        get :edit, { project_id: project.id, id: task.id}

        expect(response).to redirect_to sign_in_path
        expect(flash[:danger]).to eq 'You must sign in'
      end

      it 'should redirect a nonmember to projects path' do
        user = create_user
        project = create_project
        task = create_task({project_id: project.id})
        session[:user_id] = user.id

        get :edit, { project_id: project.id, id: task.id }

        expect(response).to redirect_to projects_path
        expect(flash[:danger]).to eq 'You do not have access to that project'
      end
    end
  end

  describe 'GET #new' do
    describe 'Permissions' do
      it 'it should redirect a non logged in user to the sign in path' do
        project = create_project

        get :new, { project_id: project.id }

        expect(response).to redirect_to sign_in_path
        expect(flash[:danger]).to eq 'You must sign in'
      end
    end
  end

  describe 'post #create' do
    describe 'Permissions' do
      it 'it should redirect a non logged in user to the sign in path' do
        project = create_project

        post :create, project_id: project.id

        expect(response).to redirect_to sign_in_path
        expect(flash[:danger]).to eq 'You must sign in'
      end
    end
  end

  describe 'Get #show' do
    describe 'Permissions' do
      it 'should redirect a non logged in user to the sign in path' do
        project = create_project
        task = create_task

        get :show, project_id: project.id, id: task.id
        expect(response).to redirect_to sign_in_path
        expect(flash[:danger]).to eq 'You must sign in'
      end

      it 'should redirect a nonmember to projects path' do
        user = create_user
        session[:user_id] = user.id
        project = create_project
        task = create_task(project_id: project.id)

        get :show, project_id: project.id, id: task.id
        expect(response).to redirect_to projects_path
        expect(flash[:danger]).to eq 'You do not have access to that project'
      end
    end
  end

  describe 'PATCH #update' do
    describe 'permissions'do
      it 'should redirect a non logged in user to the sign in path' do
        project = create_project
        task = create_task(project_id: project.id)

        patch :update, project_id: project.id, id: task.id
        expect(response).to redirect_to sign_in_path
        expect(flash[:danger]).to eq 'You must sign in'
      end

      it 'should redirect a nonmember to projects path' do
        user = create_user
        session[:user_id] = user.id
        project = create_project
        task = create_task(project_id: project.id)

        patch :update, project_id: project.id, id: task.id
        expect(response).to redirect_to projects_path
        expect(flash[:danger]).to eq 'You do not have access to that project'
      end
    end
  end

   describe 'delete #destroy' do
     it 'admin is able to delete a task' do
     user = create_user(admin: true)
     session[:user_id] = user.id
     project = create_project
     task = create_task(project_id: project.id)

     expect{
       delete :destroy, project_id: project.id, id: task.id
     }.to change {project.tasks.count}.by(-1)

     expect(flash[:success]).to eq 'Task was successfully deleted.'
     expect(response).to redirect_to project_tasks_path(project)
    end

    it 'should redirect a visitor to sign in path' do
      project = create_project
      task = create_task(project_id: project.id)

      expect{
        delete :destroy, project_id: project.id, id: task.id
      }.to_not change{project.tasks.count}

      expect(response).to redirect_to sign_in_path
      expect(flash[:danger]).to eq "You must sign in"
    end

    it 'should redirect a member to projects path' do
      user = create_user
      project = create_project
      membership = create_membership(user_id: user.id, project_id: project.id, role: 'Member')
      session[:user_id] = user.id
      task = create_task(project_id: project.id)

      expect{
        delete :destroy, project_id: project.id, id: task.id
      }.to change {project.tasks.count}.by(-1)

      expect(response).to redirect_to project_tasks_path
     end
   end
end

require 'rails_helper'

RSpec.describe TaskController, type: :controller do
  describe "get index" do
    it "list done and undone tasks" do
      get :index
      expect(assigns(:undone_tasks)).to eq Task.undone
      expect(assigns(:done_tasks)).to eq Task.done
    end
  end

  describe "GET show" do
    it "assigns task" do
      task = Task.create(task: "test")
      get :show, {id: task.id, format: 'json'}
      expect(assigns(:task)).to eq task
    end
  end

  it "GET edit" do
    task = Task.create(task: 'test')
    get :edit, {id: task.id}
    expect(response).to render_template(:edit)
  end

  describe 'test params' do
    it "accept nested params" do
      expect{
        post :create, {task: {task: "test"}}
      }.to change{Task.count}.by(1)
    end

    it "accept direct params" do
      expect{
        post :create, {task: "test"}
      }.to change{Task.count}.by(1)
    end
  end

  describe "POST create" do
    describe "html format" do
      it "redirect_to root when create with success" do
        post :create, {task: "test", format: "html"}
        expect(response).to redirect_to task_index_path
      end

      it "redirect_to root  with alert when not create with success" do
        post :create, {task: "", format: "html"}
        expect(response).to redirect_to task_index_path
        expect(flash[:alert].present?).to be true
      end
    end

    describe "json format" do
      it "render show when create with success" do
        post :create, {task: "test", format: "json"}
        expect(response).to render_template(:show)
      end

      it "render errors when not create with success" do
        post :create, {task: "", format: "json"}
        expect(JSON.parse(response.body).keys.include? 'task').to be true
      end
    end
  end

  describe "PUT update" do
    describe "html format" do
      it "redirect_to root when update with success" do
        task = Task.create(task: 'test')
        put :update, {id: task.id, task: "new_test", format: "html"}
        expect(response).to redirect_to task_index_path
      end

      it "redirect_to root  with alert when not update with success" do
        task = Task.create(task: 'test')
        put :update, {id: task.id, task: "", format: "html"}
        expect(response).to redirect_to edit_task_path(task)
        expect(flash[:alert].present?).to be true
      end
    end

    describe "json format" do
      it "render show when update with success" do
        task = Task.create(task: 'test')
        put :update, {id: task.id, task: "new_test", format: "json"}
        expect(response).to render_template(:show)
      end

      it "render errors when not update with success" do
        task = Task.create(task: 'test')
        put :update, {id: task.id, task: "", format: "json"}
        expect(JSON.parse(response.body).keys.include? 'task').to be true
      end
    end
  end

  describe "DELETE destroy" do
    before(:each) do
      @task = Task.create(task: 'test')
    end

    it 'respond to html' do
      delete :destroy, {id: @task.id}
      expect(response).to redirect_to task_index_path
      expect(flash[:notice].present?).to be true
    end

    it 'respond to json' do
      expect(response.body.empty?).to be true
    end

    it 'delete task' do
      expect{
        delete :destroy, {id: @task.id}
      }.to change{Task.count}.by(-1)
    end
  end
end

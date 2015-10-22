require 'rails_helper'

RSpec.feature "CreateAndDeleteTasks", type: :feature do
  before(:each) do
    @task = Task.create(task: 'test')
  end

  scenario "create task" do
    visit "/"
    fill_in "task_task", with: 'test'
    click_button "confirm_button"
    expect(Task.count).to eq 2
  end

  scenario "update task" do
    visit "/"
    click_link "change_state_#{@task.id}"
    expect(@task.reload.done).to be true
  end

  scenario "delete task" do
    visit "/"
    click_link "delete_task_#{@task.id}"
    expect(Task.count).to be 0
  end
end

require 'rails_helper'

RSpec.describe Task, type: :model do
  it "save a task" do
    task = Task.new(task: "test")
    expect(task.save).to be true
  end

  it "persist a task" do
    task = Task.create(task: "test")
    expect(task.persisted?).to be true
  end

  it "validate presence of task field" do
    task = Task.new
    expect(task.save).to be false
  end

  describe "create entry logs" do
      Task.create()

    before(:each) do
      @task = Task.new(task: "test")
    end

    it 'log on create' do
      expect{@task.save}.to change{Log.count}.by(1)
    end

    it 'log on update' do
      @task.save
      expect{@task.update(done: true)}.to change{Log.count}.by(1)
    end

    it 'log on destroy' do
      @task.save
      expect{@task.destroy}.to change{Log.count}.by(1)
    end
  end
end

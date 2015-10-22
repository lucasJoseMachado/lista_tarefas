class Task < ActiveRecord::Base
  validates_presence_of :task

  scope :undone, -> {where(done: false)}
  scope :done, -> {where(done: true)}

  after_create :log_entry_create
  after_update :log_entry_update
  after_destroy :log_entry_destroy

  def log_entry_create
    Log.create(entry: "create task '#{self.task}'")
  end

  def log_entry_update
    Log.create(entry: "update task, changes: '#{self.changes}'")
  end

  def log_entry_destroy
    Log.create(entry: "delete task '#{self.task}'")
  end
end

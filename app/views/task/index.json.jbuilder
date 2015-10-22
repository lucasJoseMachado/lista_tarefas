json.array!(@undone_tasks + @done_tasks) do |task|
  json.extract! task, :id, :task, :done
end

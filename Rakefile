# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rails.application.load_tasks

task :provision do
  sh "ansible-playbook -i ./ops/config.yml ./ops/playbook.yml"
end

task :deploy do
  sh "ansible-playbook -i ./ops/config.yml ./ops/playbook.yml --tags 'deploy'"
end

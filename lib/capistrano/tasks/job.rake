namespace :job do

  desc "Start job for mailer."
  task :start_job do
    on roles(:app) do
      within "#{current_path}" do
        with rails_env: :production do
          execute :rake, "jobs:work"
        end
      end
    end
  end
  
end

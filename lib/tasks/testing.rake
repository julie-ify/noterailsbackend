namespace :testing do
  desc 'Run tests'
  task run_tests: :environment do
    TestJob.perform_later
  end
end
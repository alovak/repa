namespace :task do
  task :generate => :environment do
    works_count = Task.create_missed_works
    puts "#{works_count} works was created"
  end
end

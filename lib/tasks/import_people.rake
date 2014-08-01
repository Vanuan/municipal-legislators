require 'csv'

namespace :csv do

  desc "Import people CSV Data"
  task :import_people => :environment do

    csv_file_path = 'db/people.csv'

    CSV.foreach(csv_file_path) do |row|
      Person.create!({
        :name => row[0],
        :date_of_birth => row[1],
        :image => row[2],        
      })
    end
  end
end


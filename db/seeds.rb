require 'date'
Dir[File.join(Rails.root, 'db', 'seeds', '*.rb')].each { |seed| load seed }
# Uncomment the lines below and comment out the line above for the presentation!
# Dir[File.join(Rails.root, 'db', 'seeds', '01_user_and_requirements.rb')].each { |seed| load seed }
# Dir[File.join(Rails.root, 'db', 'seeds', '04_presentable_fstival.rb')].each { |seed| load seed }

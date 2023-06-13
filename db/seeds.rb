require 'date'
Dir[File.join(Rails.root, 'db', 'seeds', '*.rb')].each { |seed| load seed }
# Uncomment the line below and comment out the line above for the presentation!
# Dir[File.join(Rails.root, 'db', 'seeds', '04_presentable_fstival.rb')].each { |seed| load seed }

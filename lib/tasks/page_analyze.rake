namespace :page  do
  task analyze: :environment do
    puts "page:analyze"
    Page.all.each do |page|
      Analyzer.for(page).run
    end
  end
end

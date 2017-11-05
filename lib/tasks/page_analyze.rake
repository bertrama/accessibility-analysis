namespace :page  do
  task analyze: :environment do
    persister = ActiveRecordAnalysisPersister.new
    path = File.join(Rails.application.root.to_s, 'public', 'screenshots')
    mkdir(path) unless File.exist?(path)
    Page.all.each do |page|
      Analyzer.for(page, persister).run(path)
    end
  end
end

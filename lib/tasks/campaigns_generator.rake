namespace :campaigns_generator do

  # in the case of generate_campaigns: :environment
  # the task name will be generate_campaigns and the :environment option makes
  # it load the Rails environment for this task
  desc "This task generates campaigns"
  task generate_campaigns: :environment do
    number =  ENV['NUMBER'] ? ENV['NUMBER'].to_i : 100
    number.times do
      FactoryGirl.create(:campaign)
    end
    print Cowsay::say("Created a #{number} campaigns")
  end

end

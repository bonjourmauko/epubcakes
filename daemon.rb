RobustThread.logger = Logger.new('log/daemon.log')

pid = fork do
  RobustThread.loop(:seconds => 1, :label => "Stalk!") do
    exec "stalk config/jobs.rb"
  end
  sleep
end

Process.detach pid

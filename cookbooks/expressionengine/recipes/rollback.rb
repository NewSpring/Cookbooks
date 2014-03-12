deploy "/home/capistrano_repo" do
  repo "git@github.com/NewSpring/NewSpring"
  enable_submodules true
  environment "RAKE_ENV" => "production"
  action :rollback
end


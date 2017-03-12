# config valid only for current version of Capistrano
lock '3.8.0'

set :application, 'masutaka-metrics'
set :repo_url, 'git@github.com:masutaka/masutaka-metrics.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/opt/masutaka-metrics'

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
set :log_level, ENV.fetch('LOG_LEVEL', :info)

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
set :linked_dirs, %w{log tmp vendor/bundle}

# Default value for default_env is {}
set :default_env, {
      'NEW_RELIC_ENV' => 'production',
      'NRCONFIG'      => current_path.join('config', 'newrelic.yml'),
    }

# Default value for keep_releases is 5
# set :keep_releases, 5

set :bundle_path, -> { shared_path.join('vendor', 'bundle') }
set :clockwork_file, -> { 'clockwork.rb' }

after 'deploy:updated', 'newrelic:notice_deployment'

namespace :deploy do
  desc 'Get settings.yml'
  before :updated, :setting_file do
    on roles(:all) do
      # Use `capture` instead of `execute` for not displaying environment variables in CircleCI
      capture "cd #{release_path.join('config')} && curl -Ls -o settings.yml '#{ENV.fetch('SETTINGS_FILE_PATH')}'"
      capture "cd #{release_path.join('config')} && curl -Ls -o newrelic.yml '#{ENV.fetch('NEWRELIC_FILE_PATH')}'"
    end
  end
end

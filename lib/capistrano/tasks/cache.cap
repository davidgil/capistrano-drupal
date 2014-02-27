set :varnish_cmd,         "/usr/bin/varnishadm"
set :varnish_address,     "127.0.0.1:6082"
set :varnish_ban_pattern, "req.url ~ ^/"

set :drush_cmd,           "drush"

desc "Clear all caches"
task :cache do
 invoke "cache:apc"
 invoke "cache:all"
 invoke "cache:varnish"
end

namespace :cache do
  %w[all themeregistry menu cssjs block modulelist themelist registry token views].each do |action|
    desc "Clear Drupal #{action} cache"
    task action do
      on roles(:all) do |host|
        within current_path do
          begin
            execute fetch(:drush_cmd), 'cache-clear', action
          rescue
          end
        end
      end
    end
  end

  desc "Clear Varnish cache"
  task :varnish do
    on roles(:all) do |host|
      begin
        puts capture(fetch(:varnish_cmd), '-T', fetch(:varnish_address), :ban, fetch(:varnish_ban_pattern))
      rescue
        # Ignore exceptions as they are thrown if varnish is down
      end
    end
  end

  desc "Clear APC cache"
  task :apc do
    on roles(:all) do |host|
      # upload as of Capistrano 3.0.1 does not support within.
      contents = %Q[
        <?php
          if (!in_array($_SERVER['REMOTE_ADDR'], array('127.0.0.1', '::1'))) return;
          apc_clear_cache();
          apc_clear_cache('user');
          apc_clear_cache('opcode');
      ]
      filepath = current_path.join('apc_clear.php');
      begin
        upload! StringIO.new(contents), filepath
        execute :curl, '--silent', "#{fetch(:app_url)}/apc_clear.php"
      ensure
        execute :rm, '-f', filepath
      end
    end
  end
end

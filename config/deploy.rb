# configuración GIT
set :repo_url, 'git@bitbucket.org:davidgil/internetacademi.git'
set :branch, 'master'

# configuración general de acceso a los servidores
set :use_sudo, false
set :ssh_options, { :forward_agent => true }

# absolute path where deploys.
set :deploy_to, '/opt/bitnami/apps/drupal/htdocs'
set :backup_dir,    "#{fetch(:deploy_to)}/backup"

# Drupal document  root
set :docroot, ''

#
# Relative path to Drupal files to be linked
#
set :linked_files_settings, "sites/default/settings.php"
set :linked_files_settings, "sites/default/local_conf.php"
set :linked_files_robots, "robots.txt"
set :linked_files_htaccess, ".htaccess"
set :linked_dirs_files, "sites/default/files"
set :linked_dirs_private, "sites/default/private"

set :linked_files, [fetch(:linked_files_settings), fetch(:linked_files_robots), fetch(:linked_files_htaccess)]
set :linked_dirs, [fetch(:linked_dirs_files), fetch(:linked_dirs_private)]

# Location where shared files reside on the development machine.
# This will be appended to :shared_settings and :shared_uploads
set :shared_local_dir,  "/Users/david/Sites/internetacademi"


# Configuración general de capistrano
set :keep_releases, 5
set :log_level, :debug


# Control del workflow de deploy
# http://capistranorb.com/documentation/getting-started/flow/
after 'deploy:check:linked_files', 'deploy:check:fix_permissions'
before 'deploy:updating', 'drush:backupdb'
after 'deploy:published', 'git:tag'


# Control del workflow de rollback
after "deploy:finishing_rollback", "drush:importdb"



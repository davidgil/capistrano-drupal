# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary
# server in each group is considered to be the first
# unless any hosts have the primary property set.
# Don't declare `role :all`, it's a meta role
##role :app, %w{bitnami 192.168.1.11}
##role :web, %w{bitnami 192.168.1.11}
##role :db,  %w{bitnami 192.168.1.11}

# Extended Server Syntax
# ======================
# This can be used to drop a more detailed server
# definition into the server list. The second argument
# something that quacks like a hash can be used to set
# extended properties on the server.

# user el rol app para el servidor donde deben ejecutarse exclusivamente tareas 1 vez.
server '192.168.1.11', user: 'bitnami', roles: %w{web app}

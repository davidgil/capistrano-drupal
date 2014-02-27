capistranorb-drupal
====================
Capistrano 3 recipes to deploy drupal projects.

## Requirements

* Ruby >= 1.9 (JRuby and C-Ruby/YARV are supported)
* [Capistrano 3](http://www.capistranorb.com/documentation/getting-started/installation/) (gem install capistrano)
* [Drush](https://github.com/drush-ops/drush)
* [Authentication & Authorisation](http://www.capistranorb.com/documentation/getting-started/authentication-and-authorisation/) for capistrano deployments

## Installation

* http://www.zodiacmedia.co.uk/blog/capistrano-3-tutorial-series-part-1

## Usage
// customize your staging.rb and deploy.rb

Este es el workflow completo de despliegue que vamos a utilizar para desplegar una nueva versión de código:
* cap [entorno] deploy: Es el comando que se usará para hacer un despliegue de código desde una rama concreta de GIT.
    * backup de BD: se crea un backup de la BD con drush en una carpeta identificando la release a la que pertenece.
    * clonar git: se obtiene una copia de GIT desde el repositorio en la rama definida para cada entorno
    * symlink files: se generan los enlaces simbólicos a los ficheros compartidos (files, settings, robots y htaccess).
    * se cambia el enlace simbólico que apunta a la nueva versión de código en el docroot de apache.
    * tagear GIT: se crea un tag en git identificando la realese desplegada y el entorno utilizado.
* cap [entorno] drupal:build: Se trata de un comando que realiza un despliegue de código y borrado de caches. No se lanza automáticamente con el deploy ya que puede ser que no sea necesario hacer estos pasos para deploys de ficheros estáticos por ejemplo.
    * update db: se lanza el comando drush updatedb
    * revert de features: se hace un revert de todas las features
    * limpieza de cache: se hace un limpiado de cache total

* use: cap -T to obtain full list of commands

## Authentication & Authorisation

Add your [Authentication & Authorisation](http://www.capistranorb.com/documentation/getting-started/authentication-and-authorisation/) config for deploy users.


## Based in:
https://github.com/mordonez/capistranorb-drupal
https://github.com/generoi/capistrano-tasks


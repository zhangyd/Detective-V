Detective V
===========

Version Info
------------

Ruby version: 2.3.1

Configuration and Setup
-----------------------

First make sure you have the following installed and in your path:

Node Security Project (NSP)

	$ npm install -g nsp

Retire.js

	$ npm install -g retire

FindSecurityBugs and PMD need to be installed separately and the locations on your system must be specified in the config/settings.yml file

Checkout a branch or fork this repo, then run:

	$ bundle install
	$ rake db:migrate RAILS_ENV=development

* System dependencies

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions
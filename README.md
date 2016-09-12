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

FindSecurityBugs and PMD need to be installed separately and the locations on your system must be specified beginning from the project root directory in config/settings.yml

Checkout a branch or fork this repo, then run:

	$ bundle install --without production

Next, migrate the database:

	$ rake db:migrate RAILS_ENV=development

If the test suite passes, you'll be ready to run the app in a local server:

	$ rails server

Running the Test Suite
----------------------

Run the test suite to verify that everything is working correctly:

	$ rake test

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions
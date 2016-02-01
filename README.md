# background
This project is used to build statistics for an experiment.  Here an experiment usually has some scripts to describe the procedure and some resources required in the procedure.  An experiment statistics is usually a bunch of charts, numbers and/or tables that are changed whenever the dependent scrips and resources changed.  This project uses gulp to automate the statistics building process by watching the dependent scripts and resources.  The outcome is a result page that shows all statistics.

# directory
app/	# files for the result page
  app.styl	# styles of the result page
  index.jade	# result page 
bin/	# script files
  build.json	# statistics settings, especially those for many scrips
  build.{ls,pl}	# building script, which load build.json
  [etc].{ls,pl}	# scrips requied by this experiment
gulpfile.ls	# settings of files watching and statistics building
package.json	# project settings
README.md	# this file
public/	# built files
res/	# resource files

# usage
* clone this project
* npm i
* put experiment scripts and resources to app/ and res/, respectively
* uncomment/edit gulpfile.ls after adding these scrips and resources
* edit gulpfile.ls to set the building process
* if the building process is complicated, move them to bin/build.json and bin/build.{ls,pl}
* npm start
* echo [port-number] > port 
* see http://localhost:[port-number]/

# vi:sw=20:ts=20:wrap

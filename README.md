ruby_message_agg
================

Project to aggregate and display chat message history, given time granularity. A project for NationBuilder!

**implementation**
I chose to use ruby, with the cli as the user interface for my application. Data is loaded by the application into memory from constants defined within the app. 

**disclaimers**
* This is my first ruby project. I chose to use ruby to demonstrate my ability to pickup new technologies in a short timeframe. 
* I attempted to spend the bulk of my time on designing the data structures, the aggregation algorithm and writing tests for these underlying structures.
* I intentionally neglected the reading in of data. See next steps for how I would like to improve this given more time and a greater scope.
* In an attempt to keep the amount of time spent reasonable, I have not spent any effort of validating input from the user, or data collected from the data source. In this line of thinking I have also invested no effort on exception handling. 

setup
================
* Install ruby: apt-get install ruby1.9.1 ruby1.9.1-dev (or use RVM)
* Clone the repo

usage
================
From within the project directory:
* ruby userinteract.rb (enters interactive shell)
* 'help' to see available commands
* history: command to see history in chronological order.
* aggregate [unit_time]: command to see aggregated time based on unit time passed. Acceptable params: 'minute', 'hour', 'day'
* exit to exit


**next steps & time constraints** 
* exception handling
* implement data sourcing to use persistent datastore and/or file
* improved validation of user input and cleaning of data retrieved from data source

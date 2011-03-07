# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Sharebox::Application.initialize!

#Formatiting DateTime to look like "01/20/2011 10:28PM"
Time::DATE_FORMATS[:default] = "%m/%d/%Y %l:%M%p"

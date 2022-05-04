require "ApplicationController"
activities = Activity.all

activities.each{|activity|
  p activity
}
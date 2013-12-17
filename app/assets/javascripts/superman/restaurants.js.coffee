# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $('#toggle_active_button').click ->
    confirm("Are you sure you want to take this restaurant offline? Customers will be unable to view the restaurant or make orders.")
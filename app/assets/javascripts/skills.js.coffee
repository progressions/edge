# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  if $("#edit_skills").length > 0
    console.log("yes")

class window.Skills
  @refresh: ->

  @behaviors: ->
    console.log("behaviors")
    Form.init()


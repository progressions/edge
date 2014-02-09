# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  if $("#edit_characteristics").length > 0
    console.log("yes")

class window.Characteristics
  @refresh: ->

  @behaviors: ->
    console.log("behaviors")
    Form.init()

# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  if $("#edit_species").length > 0
    console.log("yes")

class window.Species
  @refresh: ->

  @behaviors: ->
    console.log("behaviors")
    $("a.option_choice").click(Choice.show)
    Choice.init()
    Form.init()

class window.Choice
  @init: ->
    $("a.option_choice:first").first().click()

  @show: (event) ->
    element = $(event.target)
    id = element.data("target")

    block = $("##{id}")
    $("div.option_choice").hide()
    block.show()

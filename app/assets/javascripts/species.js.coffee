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
    $("a.option_choice").click(OptionChoice.show)
    OptionChoice.init()
    Form.init()

class window.OptionChoice
  @init: ->
    $("a.option_choice:first").first().click()

  @show: (event) ->
    element = $(event.target)
    id = element.data("target")

    block = $("##{id}")
    $("div.option_choice").hide()
    block.show()

class window.Option
  @init: ->
    $(".option_choice select").each ->
      Option.show(this)

  @show: (element) ->
    element = $(element)
    val = element.val()
    $("#option_#{val}").show()


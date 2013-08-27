# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $("#character_name").focus()
  Obligation.init()

class window.Obligation
  @init: ->
    $(".add_obligation").click(Obligation.show)
    $(".remove_obligation").click(Obligation.hide)

  @show: ->
    $(".obligation").show()
    false

  @remove: (event) ->
    $(event.target).hide()
    false

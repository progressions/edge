# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  if $("#edit_characteristics").length > 0
    console.log("yes")

class window.Characteristics
  @refresh: ->

  @behaviors: ->
    $(".minus").on('click', Characteristics.minus)
    $(".plus").on('click', Characteristics.plus)

    console.log("behaviors")
    Form.init()

  @minus: (event) ->
    target = $(event.target)
    parent = target.parent(".characteristic")
    value_field = parent.find(".current-value")
    field = parent.find("input")

    value = field.val()

    new_value = value - 1

    field.val(new_value)
    value_field.html(new_value)

    $('form').submit()


  @plus: (event) ->
    target = $(event.target)
    parent = target.parent(".characteristic")
    value_field = parent.find(".current-value")
    field = parent.find("input")

    value = field.val()

    new_value = value - 0 + 1

    field.val(new_value)
    value_field.html(new_value)

    $('form').submit()


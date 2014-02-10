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

  @modify: (event, callback) ->
    target = $(event.target)
    parent = target.parent(".characteristic")
    value_field = parent.find(".current-value")
    field = parent.find("input")
    max_purchasable_field = parent.find(".max_purchasable")
    Characteristics.max_purchasable_amount = parseInt(max_purchasable_field.html())

    value = field.val()

    new_value = callback(value)

    field.val(new_value)
    value_field.html(new_value)

    $('form').submit()

  @plus: (event) ->
    Characteristics.modify(event, Characteristics.add)

  @minus: (event) ->
    Characteristics.modify(event, Characteristics.subtract)

  @add: (value) ->
    if parseInt(value) < Characteristics.max_purchasable_amount
      parseInt(value) + 1
    else
      value

  @subtract: (value) ->
    if parseInt(value) >= 1
      parseInt(value) - 1
    else
      value

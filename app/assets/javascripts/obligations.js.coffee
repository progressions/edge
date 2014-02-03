# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('.obligation_select').change(Obligation.update)
  Obligation.update_all()

class window.Obligation
  @update_all: ->
    $(".obligation_select").each ->
      Obligation.update(
        target: this
      )

  @update: (event) ->
    element = $(event.target)
    id = element.val()

    parent = element.parents(".row").first()
    details = parent.find(".obligation_details")

    details.find(".obligation").hide()
    details.find("#obligation_#{id}").show()

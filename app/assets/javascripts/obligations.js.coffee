# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  if $("#edit_obligations").length > 0

    $('.obligation_select').change(Obligation.update)

    Obligation.update_all()

    $(document).on('nested:fieldAdded', (event) ->
      $('.obligation_select').change(Obligation.update)
      event.field.find(".size_input").val(10)
      event.field.addClass("unsaved")
      Obligation.update_all()
      Obligation.submit()
    )

    $(document).on('nested:fieldRemoved', (event) ->
      Obligation.submit()
    )

class window.Obligation
  @behaviors: ->
    $('.form-actions').hide()
    $('form').on 'change', (e) ->
      Obligation.submit()
    Obligation.update_all()

  @submit: ->
    url = $('form').prop('action')

    $.ajax
      type: "POST"
      url: url
      data: $('form').serialize()
      format: "js"
      success: ->
        console.log("success")
        Obligation.refresh()
        Portrait.update()
        Details.update()
        Flash.success("Changes saved.")

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


# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  if $("#edit_duties").length > 0

    $(document).on('nested:fieldAdded', (event) ->
      $('.duty_select').change(Duty.update)
      event.field.find(".size_input").val(10)
      event.field.addClass("unsaved")
      Duty.submit()
    )

    $(document).on('nested:fieldRemoved', (event) ->
      Duty.submit()
    )

class window.Duty
  @behaviors: ->
    $('.form-actions').hide()
    $('form').on 'change', (e) ->
      Duty.submit()
    Duty.update_all()

  @submit: ->
    url = $('form').prop('action')

    $.ajax
      type: "POST"
      url: url
      data: $('form').serialize()
      format: "js"
      success: ->
        console.log("success")
        Duty.refresh()
        Portrait.update()
        Details.update()
        Flash.success("Changes saved.")

  @update_all: ->
    $(".duty_select").each ->
      Duty.update(
        target: this
      )

  @update: (event) ->
    element = $(event.target)
    id = element.val()

    console.log(id)

    parent = element.parents(".fields").first()
    console.log(parent)
    details = parent.find(".duty_details")

    details.find(".duty").hide()
    details.find("#duty_#{id}").show()


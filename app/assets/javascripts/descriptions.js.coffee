# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('.form-actions').hide()
  $('.select-portrait').click ->
    $('.portrait-upload').show()
    false

  $('.close-portrait').click ->
    $('.portrait-upload').hide()
    false

  $('form.character').on 'change', ->
    $('form.character').trigger('submit.rails')

  $('form.character').on 'ajax:failure', (event, data, status, xhr) ->
    Flash.error("There was a problem saving your changes.")

  $('form.character').on 'ajax:success', (event, data, status, xhr) ->
    Portrait.update()
    Details.update()
    Flash.success("Changes saved.")

class window.Flash
  @close_button: ->
    $("<a>").addClass("close").attr("data-dismiss", "alert").html("&#215;")

  @alert_html: (type) ->
    $("<div>").addClass("alert").addClass("alert-#{type}")

  @message_html: (message) ->
    $("<div>").html(message)

  @update: (type, message) ->
    alert_html = Flash.alert_html(type)
    message_html = Flash.message_html(message)
    close_button = Flash.close_button()

    alert_html.append(close_button)
    alert_html.append(message_html)

    $(".flash").html(alert_html)
    $(".alert").alert()

    setTimeout(Flash.close, 2000)

  @error: (message) ->
    Flash.update('error', message)

  @success: (message) ->
    Flash.update('success', message)

  @close: ->
    $('.alert').alert('close')

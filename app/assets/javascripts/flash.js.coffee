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


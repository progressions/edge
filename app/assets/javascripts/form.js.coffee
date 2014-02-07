$ ->
  Form.init()

class window.Form
  @init: ->
    $('form.ajax .form-actions').hide()

    $('form.ajax').on 'change', (e) ->
      $($(e.target)).trigger('submit.rails')

    $('form.ajax').on 'ajax:failure', (event, data, status, xhr) ->
      Flash.error("There was a problem saving your changes.")

    $('form.ajax').on 'ajax:success', (event, data, status, xhr) ->
      Portrait.update()
      Details.update()
      Flash.success("Changes saved.")



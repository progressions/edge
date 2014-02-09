$ ->
  Form.init()

class window.Form
  @init: ->
    $('form[data-remote=true] .form-actions').hide()

    $('form[data-remote=true] ').on 'change', (e) ->
      $($(e.target)).trigger('submit.rails')

    $('form[data-remote=true]').on 'ajax:failure', (event, data, status, xhr) ->
      Flash.error("There was a problem saving your changes.")

    $('form[data-remote=true]').on 'ajax:success', (event, data, status, xhr) ->
      Portrait.update()
      Details.update()
      Species.refresh()
      Career.refresh()
      Skills.refresh()
      Characteristics.refresh()
      Flash.success("Changes saved.")

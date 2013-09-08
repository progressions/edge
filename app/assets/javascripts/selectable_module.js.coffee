class window.SelectableModule
  constructor: (@select_id) ->
    @behaviors()
    @setup

  setup: ->
    value = $(@select_id).val()

  behaviors: =>
    $(".module").click(@select)

  select: (event) =>
    element = $(event.target)
    unless element.hasClass("module")
      element = element.parents(".module")

    value = element.find(".hidden").val()
    $(".module.selected").removeClass("selected")
    element.addClass("selected")

    value_identifier = value.toLowerCase().replace("'", "")

    $(@select_id).val(value)


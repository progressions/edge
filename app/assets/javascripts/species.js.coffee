# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $(".non_js").hide()
  $(".js_only").show()

  if $(".species").length
    Species.init()

class window.Species
  @init: ->
    Species.behaviors()
    Species.setup()

  @setup: ->
    species = $("#character_species_id").val()
    modules = $(".species_module")
    $(modules).each (i, module) ->
      if $(module).find(".hidden").val() == species
        $(".species_module.selected").removeClass("selected")
        $(module).addClass("selected")

  @behaviors: ->
    $(".species_module").click(Species.select)
    $(".save_optional_skills").click(Species.close)

  @select: (event) ->
    element = $(event.target)
    unless element.hasClass("species_module")
      element = element.parents(".species_module")

    species = element.find(".hidden").val()
    $(".species_module.selected").removeClass("selected")
    element.addClass("selected")

    species_identifier = species.toLowerCase().replace("'", "")
    console.log(species)

    $("#character_species_id").val(species)

  @close: (event) ->
    element = $(event.target).parents(".optional_skills")

    if Species.validate(element)
      Species.assign_optional_skills(element)
      true
    else
      element.find(".message").html("Please choose different skills.")
      false

  @assign_optional_skills: (element) ->
    values = Species.collect(element)
    $("#character_optional_skills").val(JSON.stringify(values))


  @collect: (element) ->
    element = $(element)
    selects = element.find("select")
    values = []
    $(selects).each (i, select) ->
      values.push($(select).val())

    values

  @validate: (element) ->
    values = Species.collect(element)
    values_length = values.length
    unique_values_length = $.unique(values).length

    values_length == unique_values_length


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
    species = $("#character_species").val()
    console.log(species)
    modules = $(".species_module")
    $(modules).each (i, module) ->
      console.log("module")
      if $(module).find(".hidden").val() == species
        $(".species_module.selected").removeClass("selected")
        $(module).addClass("selected")

  @behaviors: ->
    $(".species_module").click(Species.select)

  @select: (event) ->
    element = $(event.target)
    unless element.hasClass("species_module")
      element = element.parents(".species_module")

    species = element.find(".hidden").val()
    console.log(species)
    $(".species_module.selected").removeClass("selected")
    element.addClass("selected")

    $("#character_species").val(species)


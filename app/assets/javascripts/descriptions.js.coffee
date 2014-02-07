# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class window.Descriptions
  @init: ->
    $('.select-portrait').click ->
      $('.portrait-upload').show()
      false

    $('.close-portrait').click ->
      $('.portrait-upload').hide()
      false


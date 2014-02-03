# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#character_social_class_id').change(SocialClass.update)
  $('#character_background_id').change(Background.update)
  SocialClass.update()
  Background.update()

class window.SocialClass
  @update: ->
    $('.social_class').hide()
    id = $('#character_social_class_id').val()
    $("#social_class_#{id}").show()

class window.Background
  @update: ->
    $('.background').hide()
    id = $('#character_background_id').val()
    $("#background_#{id}").show()

# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  Background.init()
  SocialClass.init()

class window.SocialClass
  @init: ->
    $('#character_social_class_id').change(SocialClass.update)
    SocialClass.update()

  @update: ->
    $('.social_class').hide()
    id = $('#character_social_class_id').val()
    $("#social_class_#{id}").show()

class window.Background
  @init: ->
    $('#character_background_id').change(Background.update)
    Background.update()

  @update: ->
    $('.background').hide()
    id = $('#character_background_id').val()
    $("#background_#{id}").show()

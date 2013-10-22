# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


# create or get auth_token
$(document).ready ->
  $('#collector-list').on 'click', ->
    unless $(this).val() == ""
      $.getJSON(
        '/auth_tokens/create_or_get',
        { collector_id: $(this).val() }
      ).done((result) ->
        if result['message'] == "ok"
          $('#auth_token span').html("<a href='" + result['url'] + "'>" + result['filename'] + "</a>")
      )
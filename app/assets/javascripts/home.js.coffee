# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

initialize = ->
  $('#collector-list').on 'click', ->
    unless $(this).val() == ""
      $.when( 
        $.getJSON('/collectors/' + $(this).val()), 
        $.getJSON(
          '/auth_tokens/create_or_get',
          { collector_id: $(this).val() }
        )
      ).done( (result1, result2)->
        $('#download_collector span').html("<a href='" + result1[0]['url'] + "'>" + result1[0]['filename'] + "</a>")
        #$('#auth_token span').html("<a href='" + result2[0]['url'] + "'>" + result2[0]['filename'] + "</a>")
      )

  $('#generate-key-form').on 'submit', (event)->
    event.preventDefault()
    $.getJSON(
      $(this).attr("action"),
      $(this).serialize()
    ).done( (result) ->
      $('#use_case_key span').html(result['response'])
      $("#generate-key-form input[type=submit]").removeAttr("disabled")
      $("#generate-key-form input[type=submit]").val("Generate key")
    )
$(document).ready(initialize)
$(document).on('page:load', initialize)
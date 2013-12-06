# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

initialize = ->
  # on 'change' doesn't work as expected on certain versions of IE.
  # put on 'click' if needed
  $('#collector-list').on 'change', ->
    $.ajax
      url: '/collectors/' + $(this).val() + '/versions'
      success: (options) ->
        html = ''
        options.forEach (option) ->
          html += "<option value='" + option['id'] + "'>" + option['version'] + "</option>"
        $("#collector-version-list").html(html)
        $.ajax
          url: '/collector_versions/' + $("#collector-version-list").val()
          dataType: 'json'
          success: (result) ->
            $('#download_collector span').html("<a href='" + result['url'] + "'>" + result['filename'] + "</a>")

      # $.when( 
      #   $.getJSON('/collectors/versions')
      # ,
      #   $.getJSON('/collector_versions/' + $("#collector-version-list").val())
      # ).done( (result1, result2)->
      #   # $('#collector-version-list').html("<a href='" + result2[0]['url'] + "'>" + result2[0]['filename'] + "</a>")
      #   $('#download_collector span').html("<a href='" + result2[0]['url'] + "'>" + result2[0]['filename'] + "</a>")
      # )

  $('#collector-version-list').on 'change', ->
    $.ajax
      url: '/collector_versions/' + $(this).val()
      dataType: 'json'
      success: (result) ->
        $('#download_collector span').html("<a href='" + result['url'] + "'>" + result['filename'] + "</a>")

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


  $('#add-collector-version-btn').on 'click', (event) ->
    event.preventDefault()
    $.get "/collectors/" + $(this).val() + "/add_version_form",
      success: (form) ->
        $("#versions").append(form)


$(document).ready(initialize)
$(document).on('page:load', initialize)
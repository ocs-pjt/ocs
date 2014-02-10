# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
initialize = ->

  # Refresh the collector versions options for a specific selected collector in a first ajax request
  # then do a second ajax request to get the associated installer
  # if on 'change' doesn't work as expected (happens on certain versions of IE) use on 'click' instead 
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


  # Ajax request to set the collector installer file associated to the version of the collector selected
  $('#collector-version-list').on 'change', ->
    $.ajax
      url: '/collector_versions/' + $(this).val()
      dataType: 'json'
      success: (result) ->
        $('#download_collector span').html("<a href='" + result['url'] + "'>" + result['filename'] + "</a>")


  # Ajax request to retrieve the generated use case key
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


  # Add new collector version inputs to the collector form
  $('#add-collector-version-btn').on 'click', (event) ->
    event.preventDefault()
    $.get "/collectors/" + $(this).val() + "/add_version_form",
      success: (inputs) ->
        $("#versions").append(inputs)


  # Filter users in users list
  $("#user_search").on('change', ->
    val = $(this).val().trim()
    val = val.replace(/\s+/g, "")
    if val.length % 3 is 0 #for checking 3 characters
      $.ajax
        url: '/users'
        data: { search_value: $(this).val() }
        success: (partial) ->
          $("#users-list").html(partial)
  ).keyup ->
    $(this).change()


  # Check/Uncheck First/Last records for CSV Export radio buttons
  $('#first_records').on('click', ->
    $('#last_records').attr('checked', false)
  )
  $('#last_records').on('click', ->
    $('#first_records').attr('checked', false)
  )

  # Fill in world map with statistics
  $.getJSON "/statistic/france-elections.json", (data) ->
  new jvm.WorldMap(
    map: "world_mill_en"
    container: $("#world-map")
    series:
      regions: [
        scale: ['#DEEBF7', '#08519C']
        attribute: "fill"
        values: {"US":1,"FR":2, "GB":3, "NZ":4, "RU":5, "AU": 5}
      ]
  )


# Necessary to do because of use of turbolinks
$(document).ready(initialize)
$(document).on('page:load', initialize)
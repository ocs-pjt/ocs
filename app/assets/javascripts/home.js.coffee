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

  # Get world map statistics
  getWorldStatistics = -> 
    console.log "here"
    $.ajax
      url: "/statistics/world"
      dataType: 'json'
      success: (data) ->
        displayWorldMap(data)

  # Call it on page loading
  getWorldStatistics()


  # Display the world map from the ajax data received
  displayWorldMap = (data) ->
    console.log "here"
    world_map = new jvm.WorldMap(
      map: "world_mill_en"
      backgroundColor: '#ccc'
      container: $("#world-map")
      series:
        regions: [
          scale: ['#DEEBF7', '#08519C']
          attribute: "fill"
          values: data
          normalizeFunction: 'polynomial' # related to size of the country
        ]
      onRegionLabelShow: (e, el, code) ->
        if data[code] isnt undefined
          el.html el.html() + " (" + data[code] + ")"             
        return
      onRegionClick: (e, code) ->
        displayCountry(e, code, world_map)
    )

  # Display the country with statistics per regions/states 
  displayCountry = (e, code, world_map) ->
    map = code.toLowerCase() + "_merc_en"
    if jvm.WorldMap.maps.hasOwnProperty(map)
      $.ajax(
        url: "/statistics/regions"
        data: {country_code: code}
        dataType: 'json'
        success: (data) ->
          world_map.remove()
          new jvm.WorldMap(
            map: map
            backgroundColor: '#ccc'
            container: $("#world-map")
            series:
              regions: [
                scale: ['#DEEBF7', '#08519C']
                attribute: "fill"
                values: data
                normalizeFunction: 'polynomial' # related to size of the country
              ]
            onRegionLabelShow: (e, el, code) ->
              if data[code] isnt undefined
                el.html el.html() + " (" + data[code] + ")"             
              return
          )
          # href only correct if the map is displayed in root_path
          $("#world-map").children(":first").prepend("<a class='back_to_world_map' href='/'>Back to world map</a>")
      )

# Necessary to do because of use of turbolinks
$(document).ready(initialize)
$(document).on('page:load', initialize)
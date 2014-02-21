

initialize = ->
  
  # Export form field
  $("#resource_type_field").on 'change', ->
    $.ajax
      url: "/search/export_form"
      data: {resource_type: $(this).val()}
      success: (data) ->
        $("#export-form").replaceWith(data)


# Necessary to do because of use of turbolinks
$(document).ready(initialize)
$(document).on('page:load', initialize)
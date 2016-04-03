# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $('#filter').keyup ->
    # Retrieve the input field text and reset the count to zero
    filter = $(this).val()
    # Loop through the comment list
    $('td.description').each ->
      # If the list item does not contain the text phrase fade it out
      if $(this).text().search(new RegExp(filter, 'i')) < 0
        $(this).parent().fadeOut()
        # Show the list item if the phrase matches
      else
        $(this).parent().show()
      return
    return
  $('#live-search').submit (e) ->
      e.preventDefault()
    return
  return
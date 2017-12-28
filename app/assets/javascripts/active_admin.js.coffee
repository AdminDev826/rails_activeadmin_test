#= require active_admin/base
#= require bootstrap-sprockets
#= require bootstrap-toggle

getDatawithFormat = (url, object_id, user_id, dataType, key, objectItem) -> 
	$.ajax
	  method: 'POST'
	  url: url
	  data: ({
	    object_id: object_id,
	    user_id: user_id,
	    key: key
    })
	  dataType: dataType
	  timeout: 10000
	  success: (data, status, xhr) ->
	    if key == 'js'
	    	objectItem.find('.col-email').html JSON.stringify(data)
	    return
	  error: (jqXHR, textStatus, errorThrown) ->
	    console.log 'Could not get posts, server response: ' + textStatus + ': ' + errorThrown
	    return
  return

updateAttribute = (url, id, itemText, settingText) ->
  $.ajax
    method: 'POST'
    url: url
    data:
      about_id: id
      option: itemText
      settings: settingText
    dataType: 'json'
    success: (data) ->
      if !data
        console.log 'error !'
      return
    error: ->
      alert 'Error occured!'
      return
  return

$(document).ready ->
	data_id = ''
	user_id = ''
	tab_selected_item = null

	$('.tab-setting-row').click ->
	  tab_selected_item = $(this)
	  user_id = tab_selected_item.find('.col-option').html()
	  getDatawithFormat '/admin/dashboard/lock', '', user_id, 'script', '', ''
	  return
	  
	$('#exampleModal').on 'hidden.bs.modal', ->
	  $(this).empty()
	  getDatawithFormat '/admin/dashboard/lock', '', user_id, 'json', 'js', tab_selected_item
	  return
	  
	$('.test-data-list li').click ->
		$('.test-data-list li').removeClass('active')
		$(this).addClass('active')
		data_id = $(this).find('.data-id').html()
		return

	$('.btn-model-setting').click ->
		user_id = $(this).parent().parent().find('.col-id').html()
		alert data_id + '--' + user_id
		getDatawithFormat '/admin/dashboard/lock', data_id, user_id, 'script', "key", ''
		return

	$('#exampleModal').on 'show.bs.modal', ->
		setTimeout (->
		  $('#d_list').sortable().bind 'sortupdate', (e, ui) ->
		  	sorted_array = []
		  	$('li', $(this)).each (index, e) ->
		  		label = $(e).children('label').text()
		  		sorted_array.push label
		  		return
		  	console.log(sorted_array)
		  	return
		), 300
		return

	$(document).on 'change', '#exampleModal .switch-input', (event) ->
	  settingText = 'YES'
	  checked = $(this).prop('checked')
	  parentItem = $(this).parent().parent().parent()
	  itemText = parentItem.children('label').text()
	  item_id = parentItem.children('.about_id').val()
	  if checked
	    settingText = 'YES'
	  else
	    settingText = 'NO'
	 	updateAttribute '/admin/dashboard/updateAbout', item_id, itemText, settingText
	  return

	return
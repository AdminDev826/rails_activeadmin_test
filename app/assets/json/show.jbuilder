json.set! 'crossapp.desk_top_object'  do 
  # Attributes
  
  json.id @desk_top_object.id
  json.desk_top_object_enhanced_description @desk_top_object.desk_top_object_enhanced_description
  json.object_id @desk_top_object.object_id
  json.user_id @desk_top_object.user_id
  json.subsystem_source_code @desk_top_object.subsystem_source_code
  json.subsystem_object_type @desk_top_object.subsystem_object_type
  json.subsystem_object_id @desk_top_object.subsystem_object_id
  json.subsystem_object_text @desk_top_object.subsystem_object_text
  json.date_in @desk_top_object.date_in
  json.time_in @desk_top_object.time_in
  json.options @options
  json.read_only_fields @read_only_fields 

end

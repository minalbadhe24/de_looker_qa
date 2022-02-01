connection: "qai_de_looker_training_q1271_minal_badhe"

# include all the views
include: "/views/**/*.view"

datagroup: qai_de_looker_training_minalbadhe_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: qai_de_looker_training_minalbadhe_default_datagroup

explore: dialogflow_cleaned_logs {}
explore: Session_level_data {}

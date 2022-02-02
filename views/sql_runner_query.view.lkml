view: sql_runner_query {
  derived_table: {
    sql: SELECT
          Count(Distinct dialogflow_cleaned_logs.session_ID) AS Total_Sessions
      FROM `looker_training.dialogflow_cleaned_logs`
           AS dialogflow_cleaned_logs
      ORDER BY
          1
      LIMIT 500
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: total_sessions {
    type: number
    sql: ${TABLE}.Total_Sessions ;;
  }

  set: detail {
    fields: [total_sessions]
  }
}

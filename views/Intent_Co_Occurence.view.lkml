

view: intent_co_occurence {
  # Or, you could make this view a derived table, like this:
  derived_table: {
    explore_source: dialogflow_cleaned_logs {
      column: session_ID {
        field: dialogflow_cleaned_logs.session_id
      }
      column: intent_triggered {
        field: dialogflow_cleaned_logs.intent_triggered
        }
      bind_all_filters: yes
  }
  }

  # Define your dimensions and measures here, like this:
  dimension: session_id {
    description: "Unique ID for each session that has occured"
    primary_key: yes
    type: string
    sql: ${TABLE}.session_id ;;
  }

  dimension: intent_triggered {
    description: "The intent triggered for each user query"
    type: string
    sql: ${TABLE}.intent_triggered ;;
  }

  # dimension_group: most_recent_purchase {
  #   description: "The date when each user last ordered"
  #   type: time
  #   timeframes: [date, week, month, year]
  #   sql: ${TABLE}.most_recent_purchase_at ;;
  # }

  # measure: total_lifetime_orders {
  #   description: "Use this for counting lifetime orders across many users"
  #   type: sum
  #   sql: ${lifetime_orders} ;;
  # }
}

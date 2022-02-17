view: dialogflow_cleaned_logs {
  sql_table_name: `looker_training.dialogflow_cleaned_logs`
    ;;

  dimension: action {
    type: string
    sql: ${TABLE}.action ;;
  }

  dimension_group: date {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.date ;;
  }

  dimension: intent_detection_confidence {
    type: number
    sql: ${TABLE}.intent_detection_confidence ;;
  }

  dimension: intent_triggered {
    type: string
    sql: ${TABLE}.intent_triggered ;;
  }

  dimension: is_fallback {
    type: yesno
    sql: ${TABLE}.isFallback ;;
  }

  dimension: language_code {
    type: string
    sql: ${TABLE}.language_code ;;
  }

  dimension: magnitude {
    type: number
    sql: ${TABLE}.magnitude ;;
  }

  dimension: month_number {
    type: number
    sql: ${TABLE}.month_number ;;
  }

  dimension: platform {
    type: string
    sql: ${TABLE}.platform ;;
  }

  dimension: query_text {
    type: string
    sql: ${TABLE}.query_text ;;
  }

  dimension: query_text_redacted {
    type: string
    sql: ${TABLE}.query_text_redacted ;;
  }

  dimension: response_id {
    type: string
    sql: ${TABLE}.response_ID ;;
  }

  dimension: sentiment_score {
    type: number
    sql: ${TABLE}.sentiment_score ;;
  }

  dimension: session_id {
    type: string
    sql: ${TABLE}.session_ID ;;
  }

  dimension_group: time {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.time ;;
  }

  dimension_group: time_stamp {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.time_stamp ;;
  }

  dimension: week_number {
    type: number
    sql: ${TABLE}.week_number ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }

  measure: Total_Unique_Sessions {
    type: count_distinct
    sql: ${session_id} ;;
  }

  measure: total_response_id {
    type: count_distinct
    sql: ${response_id} ;;
  }

  dimension: date {
    type: date
    sql: ${date_date} ;;
  }

  measure: Avg_queries_per_session {
    type: number
    sql: ${total_response_id}/NULLIF(${Total_Unique_Sessions},0);;
    value_format: "0"
  }

  measure: no_of_days {
    type: count_distinct
    sql: ${date_date} ;;
  }

  measure: avg_session_per_day {
    type: number
    sql: ${Total_Unique_Sessions}/NULLLIF(${no_of_days},0);;
    value_format: "0"
  }

  measure: avg_sentiment_score {
    type: average
    sql: ${sentiment_score};;
    value_format: "0.000"
  }
  dimension: success_queries {
    type: string
    sql:CASE
        WHEN intent_triggered LIKE '%fallback%' THEN 1
        END;;
  }
  measure: total_success_queries {
    type: count_distinct
    sql: ${success_queries};;
  }
  measure: success_rate_new{
    type: percent_of_total
    sql: ${total_success_queries}/NULLIF(${total_response_id},0);;
  }

  measure: success_queries_count {
    type: number
    sql: SELECT intent_triggered FROM `looker_training.dialogflow_cleaned_logs` AS cleaned_logs WHERE intent_triggered LIKE '%fallback%';;
  }

  measure: success_rate {
    type: number
    sql: sum(if(${is_fallback},0,1))/${count};;
    value_format_name: percent_2
  }

  dimension: sentiment_bucket{
    type: string
    sql: CASE
          WHEN magnitude > 3 and sentiment_score between 0.25 and 1 THEN '1. Positive'
          WHEN magnitude <= 3 and sentiment_score between 0.25 and 1 THEN '2. Partially Positive'
          WHEN magnitude <= 3 and sentiment_score between -1 and -0.25 THEN '4. Partially Negative'
          WHEN magnitude > 3 and sentiment_score between -1 and -0.25 THEN '5. Negative'
          ELSE "3. Neutral"
          END
          ;;
  }

  measure: Number_of_Fallbacks {
    type: sum
    sql: CASE WHEN ${is_fallback} then 1 END ;;
  }

  measure: Number_of_Livegenttransfer{
    type: sum
    sql: CASE WHEN ${intent_triggered} LIKE "LiveAgentTransfer" then 1 END ;;
  }
}

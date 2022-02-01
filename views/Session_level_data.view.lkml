view: Session_level_data {
  derived_table: {
    sql: SELECT a.session_ID, a.entry_intent ,d.first_intent, a.exit_intent, c.conversation_length_in_minutes , c.conversation_length_in_seconds , c.hour, c.count_of_msg , c.conv_date, c.platform FROM
        (WITH entry_exit_intent AS
        (
            SELECT session_ID , ROW_NUMBER() OVER(PARTITION BY session_ID ORDER BY time_stamp ASC) AS RowNumber, intent_triggered , time_stamp, date
          FROM `looker_training.dialogflow_cleaned_logs`AS dialogflow_cleaned_logs
        )

        SELECT c.session_id, c.entry_intent, exit_intent, date FROM
        (SELECT a.session_ID, intent_triggered as exit_intent, b.max_r_no, date
        FROM entry_exit_intent as a
        LEFT JOIN
        (SELECT session_ID , MAX(RowNumber) as max_r_no FROM entry_exit_intent GROUP BY session_ID ) as b
        on a.session_ID = b.session_ID
        WHERE RowNumber=b.max_r_no) as d
        LEFT JOIN
        (SELECT session_ID, intent_triggered as entry_intent
        FROM entry_exit_intent
        WHERE RowNumber=1) as c
        ON d.session_ID = c.session_ID) as a
        LEFT JOIN
        ---------------------------------------------

        (SELECT session_ID, TIMESTAMP_DIFF(end_time, start_time, MINUTE) as conversation_length_in_minutes, TIMESTAMP_DIFF(end_time, start_time, SECOND) as conversation_length_in_seconds, count_of_msg, conv_date, EXTRACT(HOUR FROM start_time) as hour, platform
        FROM(
        SELECT session_ID,  MAX(time_stamp) as end_time, MIN(time_stamp) as start_time, count(*) as count_of_msg, MIN(date) as conv_date, MAX(platform) as platform
        FROM `looker_training.dialogflow_cleaned_logs` AS dialogflow_cleaned_logs
        group by session_ID
        ORDER BY count_of_msg DESC)) as c
        ON a.session_ID=c.session_ID

        LEFT JOIN
        -----------------------------------------------
        (SELECT session_ID , intent_triggered as first_intent FROM (SELECT session_ID , ROW_NUMBER() OVER(PARTITION BY session_ID ORDER BY time_stamp ASC) AS RowNumber, intent_triggered
        FROM `looker_training.dialogflow_cleaned_logs` AS dialogflow_cleaned_logs
        where intent_triggered != 'Default Welcome Intent')
        where RowNumber = 1) as d
        on c.session_ID = d.session_ID
 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: session_id {
    type: string
    sql: ${TABLE}.session_ID ;;
  }

  dimension: entry_intent {
    type: string
    sql: ${TABLE}.entry_intent ;;
  }

  dimension: first_intent {
    type: string
    sql: ${TABLE}.first_intent ;;
  }

  dimension: exit_intent {
    type: string
    sql: ${TABLE}.exit_intent ;;
  }

  dimension: conversation_length_in_minutes {
    type: number
    sql: ${TABLE}.conversation_length_in_minutes ;;
  }

  dimension: conversation_length_in_seconds {
    type: number
    sql: ${TABLE}.conversation_length_in_seconds ;;
  }

  dimension: hour {
    type: number
    sql: ${TABLE}.hour ;;
  }

  dimension: count_of_msg {
    type: number
    sql: ${TABLE}.count_of_msg ;;
  }

  dimension: conv_date {
    type: date
    datatype: date
    sql: ${TABLE}.conv_date ;;
  }

  dimension: platform {
    type: string
    sql: ${TABLE}.platform ;;
  }

  set: detail {
    fields: [
      session_id,
      entry_intent,
      first_intent,
      exit_intent,
      conversation_length_in_minutes,
      conversation_length_in_seconds,
      hour,
      count_of_msg,
      conv_date,
      platform
    ]
  }

  measure: Avg_Conv_length{
    type: average
    sql:$(conversation_length_in_seconds)/60  ;;
    }

  dimension: Hourframe {
    type: tier
    tiers: [0,2,4,6,8,10,12,14,16,18,20,22,24]
    style: integer
    sql: ${hour} ;;
  }

  dimension: One_Hour_frame {
    type: tier
    tiers: [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23]
    style: integer
    sql: ${hour} ;;
  }

  dimension: one_Hour_frame {
  sql: CASE
        WHEN hour in (0) THEN "12am-2am"
        WHEN hour in (1) THEN "2am-4am"
        WHEN hour in (2) THEN "4am-6am"
        WHEN hour in (3) THEN "6am-8am"
        WHEN hour in (4) THEN "8am-10am"
        WHEN hour in (5) THEN "10am-12pm"
        WHEN hour in (6) THEN "12pm-2pm"
        WHEN hour in (7) THEN "2pm-4pm"
        WHEN hour in (8) THEN "4pm-6pm"
        WHEN hour in (9) THEN "6pm-8pm"
        WHEN hour in (10) THEN "8pm-10pm"
        WHEN hour in (11) THEN "10pm-12am"
        WHEN hour in (12) THEN "10pm-12am"
        WHEN hour in (13) THEN "10pm-12am"
        WHEN hour in (14) THEN "10pm-12am"
        WHEN hour in (15) THEN "10pm-12am"
      END;;
  }
  dimension: sentiment_bucket_logic {
    sql: CASE
          WHEN magnitude > 3 and sentiment_score between 0.25 and 1 THEN '1. Positive'
          WHEN magnitude <= 3 and sentiment_score between 0.25 and 1 THEN '2. Partially Positive'
          WHEN magnitude <= 3 and sentiment_score between -1 and -0.25 THEN '4. Partially Negative'
          WHEN magnitude > 3 and sentiment_score between -1 and -0.25 THEN '5. Negative'
          ELSE "3. Neutral" ;;
  }
}

view: Session_level_data {
  derived_table: {
    sql: SELECT a.session_ID, a.entry_intent ,d.first_intent, a.exit_intent, c.conversation_length_in_minutes , c.conversation_length_in_seconds , c.hour, c.count_of_msg , c.date, c.platform, c.average_sentiment FROM
        (WITH entry_exit_intent AS
        (
          SELECT session_ID , ROW_NUMBER() OVER(PARTITION BY session_ID ORDER BY time_stamp ASC) AS RowNumber, intent_triggered , time_stamp, date
          FROM `Looker_training_Minal.dialogflow_cleaned_logs`AS dialogflow_cleaned_logs
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

        (SELECT session_ID, TIMESTAMP_DIFF(end_time, start_time, MINUTE) as conversation_length_in_minutes, TIMESTAMP_DIFF(end_time, start_time, SECOND) as conversation_length_in_seconds, count_of_msg, date, EXTRACT(HOUR FROM start_time) as hour, platform, average_sentiment
        FROM(
        SELECT session_ID,  MAX(time_stamp) as end_time, MIN(time_stamp) as start_time, count(*) as count_of_msg, MIN(date) as date, MAX(platform) as platform, avg(sentiment_score) as average_sentiment
        FROM `Looker_training_Minal.dialogflow_cleaned_logs` AS dialogflow_cleaned_logs
        group by session_ID
        ORDER BY count_of_msg DESC)) as c
        ON a.session_ID=c.session_ID

        LEFT JOIN
        -----------------------------------------------
        (SELECT session_ID , intent_triggered as first_intent FROM (SELECT session_ID , ROW_NUMBER() OVER(PARTITION BY session_ID ORDER BY time_stamp ASC) AS RowNumber, intent_triggered
        FROM `Looker_training_Minal.dialogflow_cleaned_logs` AS dialogflow_cleaned_logs
        where intent_triggered != 'Default Welcome Intent')
        where RowNumber = 1) as d
        on c.session_ID = d.session_ID
        ;;



  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  measure: count_session_id {
    type: count_distinct
    sql: ${session_id} ;;
  }

  dimension: session_id {
    type: string
    primary_key: yes
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

  dimension: date {
    type: date
    datatype: date
    sql: ${TABLE}.date ;;
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
    convert_tz: yes
    datatype: date
  }

  dimension: platform {
    type: string
    sql: ${TABLE}.platform ;;
  }

  dimension: average_sentiment {
    type: number
    sql: ${TABLE}.average_sentiment ;;
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
      date,
      count_of_msg,
      platform,
      average_sentiment
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
  measure: avg_sentiment_score {
    type: average
    sql: ${average_sentiment} ;;
    value_format: "0.00"
  }
  dimension: one_Hour_frame_case{
  type: string
  sql: CASE
        WHEN ${hour} in (0) THEN "12am-1am"
        WHEN ${hour} in (1) THEN "1am-2am"
        WHEN ${hour} in (2) THEN "2am-3am"
        WHEN ${hour} in (3) THEN "3am-4am"
        WHEN ${hour} in (4) THEN "4am-5am"
        WHEN ${hour} in (5) THEN "5am-6am"
        WHEN ${hour} in (6) THEN "6am-7am"
        WHEN ${hour} in (7) THEN "7am-8am"
        WHEN ${hour} in (8) THEN "8am-9am"
        WHEN ${hour} in (9) THEN "9am-10am"
        WHEN ${hour} in (10) THEN "10am-11am"
        WHEN ${hour} in (11) THEN "11am-12pm"
        WHEN ${hour} in (12) THEN "12pm-1pm"
        WHEN ${hour} in (13) THEN "1pm-2pm"
        WHEN ${hour} in (14) THEN "2pm-3pm"
        WHEN ${hour} in (15) THEN "3pm-4pm"
        WHEN ${hour} in (16) THEN "4pm-5pm"
        WHEN ${hour} in (17) THEN "5pm-6pm"
        WHEN ${hour} in (18) THEN "6pm-7pm"
        WHEN ${hour} in (19) THEN "7pm-8pm"
        WHEN ${hour} in (20) THEN "8pm-9pm"
        WHEN ${hour} in (21) THEN "9pm-10pm"
        WHEN ${hour} in (22) THEN "10pm-11pm"
        WHEN ${hour} in (23) THEN "11pm-12am"
      END;;
  }
  dimension: sentiment_bucket_logic {
    type: string
    sql: CASE
          WHEN magnitude > 3 and sentiment_score between 0.25 and 1 THEN '1. Positive'
          WHEN magnitude <= 3 and sentiment_score between 0.25 and 1 THEN '2. Partially Positive'
          WHEN magnitude <= 3 and sentiment_score between -1 and -0.25 THEN '4. Partially Negative'
          WHEN magnitude > 3 and sentiment_score between -1 and -0.25 THEN '5. Negative'
          ELSE "3. Neutral" ;;
  }

  dimension: duration_bucket {
    type: string
    sql: CASE
          WHEN conversation_length_in_minutes < 1 THEN "< 1 Mins"
          WHEN conversation_length_in_minutes <= 3 and conversation_length_in_minutes > 1 THEN '1-3 Mins'
          WHEN conversation_length_in_minutes <= 5 and conversation_length_in_minutes > 3 THEN '3-5 Mins'
          WHEN conversation_length_in_minutes <= 7 and conversation_length_in_minutes > 5 THEN '5-7 Mins'
          ELSE "> 7 Mins"
          END ;;
  }

  dimension: duration_order {
    type: number
    sql: CASE
          WHEN conversation_length_in_minutes < 1 THEN 1
          WHEN conversation_length_in_minutes <= 3 and conversation_length_in_minutes > 1 THEN 2
          WHEN conversation_length_in_minutes <= 5 and conversation_length_in_minutes > 3 THEN 3
          WHEN conversation_length_in_minutes <= 7 and conversation_length_in_minutes > 5 THEN 4
          ELSE 5
          END ;;
  }

  measure: total_responses {
    type: sum
    sql: ${count_of_msg} ;;
  }

  measure: avg_conv_duration_seconds {
    type: average
    sql_distinct_key: ${session_id} ;;
    sql: ${conversation_length_in_seconds}/86400.0 ;;
    value_format: "[mm]\"m \"ss\"s\""
  }

}

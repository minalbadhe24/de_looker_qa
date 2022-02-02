view: session_level_old {
  derived_table: {
    sql:
    WITH entry_intent AS (
    SELECT session_ID, intent_triggered AS entry_intent FROM
    (SELECT session_ID, intent_triggered, ROW_NUMBER() OVER (PARTITION BY session_ID  ORDER BY time_stamp  ASC) AS entry_rn
    FROM `qp-qai-training-1-2021-05.looker_training.dialogflow_cleaned_logs`)
    WHERE entry_rn =1
    ),
    exit_intent AS (
      SELECT session_ID, intent_triggered AS exit_intent FROM
      (SELECT session_ID, intent_triggered, ROW_NUMBER() OVER (PARTITION BY session_ID  ORDER BY time_stamp  DESC) AS exit_rn
      FROM `qp-qai-training-1-2021-05.looker_training.dialogflow_cleaned_logs`)
      WHERE exit_rn=1
    ),
    conv_length AS(
      Select session_ID, DATETIME_DIFF(end_time, start_time, second) as conversation_length_in_seconds, count_of_msg, session_date_time, date, platform, avg_sentiment_score
      from
      (SELECT session_ID, min( time_stamp ) as start_time, max( time_stamp ) as end_time, count(distinct response_ID) as count_of_msg, MIN( time_stamp ) as session_date_time, MIN( date ) AS date, MIN( platform ) as platform, avg(sentiment_score) as avg_sentiment_score,
        FROM `qp-qai-training-1-2021-05.looker_training.dialogflow_cleaned_logs`
      group by session_ID)
    )
    SELECT entry_intent.*, exit_intent.exit_intent,
    conv_length.conversation_length_in_seconds as conversation_length_in_seconds, count_of_msg, session_date_time, date, platform,
    avg_sentiment_score,
    from entry_intent
    LEFT JOIN exit_intent
    on entry_intent.session_ID=exit_intent.session_ID
    LEFT JOIN conv_length
    ON entry_intent.session_ID=conv_length.session_ID
    ;;
  }


  dimension: session_ID {
    description: "Session ID"
    type: string
    sql: ${TABLE}.session_ID ;;
  }
  dimension: entry_intent {
    description: "Entry Intent"
    type: string
    sql: ${TABLE}.entry_intent ;;
  }
  dimension: exit_intent {
    description: "Exit Intent"
    type: string
    sql: ${TABLE}.exit_intent ;;
  }
  dimension: conversation_length_in_seconds {
    description: "Conversation length in Seconds"
    type: number
    sql: ${TABLE}.conversation_length_in_seconds ;;
  }
  dimension: count_of_msg {
    description: "Number of message"
    type: number
    sql: ${TABLE}.count_of_msg ;;
  }
  dimension_group: session_date {
    type: time
    timeframes: [raw,time,hour_of_day,date,week,month,quarter,year]
    sql: ${TABLE}.session_date_time ;;
  }
  dimension: date {
    description: "Date"
    type: date
    sql: ${TABLE}.date ;;
  }
  dimension: platform {
    description: "Platform"
    type: string
    sql: ${TABLE}.platform ;;
  }
  dimension: avg_sentiment_score {
    description: "Average Sentiment Score"
    type: number
    sql: ${TABLE}.avg_sentiment_score ;;
    value_format: "0.00"
  }
  measure: count {
    type: count
    drill_fields: []
  }
  measure: sessioncount {
    type: count_distinct
    sql:  ${session_ID} ;;
  }
  measure: avgduration {
    type:  average
    sql: ${conversation_length_in_seconds}/86400 ;;
    value_format: "[mm]\" min\" ss \" sec\""
  }
  measure: datecount {
    type: count_distinct
    sql: ${date} ;;
  }
  measure: avgsessionday {
    type: number
    sql: ${sessioncount}/${datecount} ;;
    value_format: "0"
  }
  measure: totalresponse {
    type:  sum
    sql: ${count_of_msg} ;;
  }
  measure: avgqueriesday {
    type: number
    sql: ${totalresponse}/${sessioncount} ;;
    value_format: "0"
  }

  dimension: hourframe {
    type: string
    sql: CASE
          WHEN ${session_date_hour_of_day} in (0) THEN "12am-1am"
          WHEN ${session_date_hour_of_day} in (1) THEN "1am-2am"
          WHEN ${session_date_hour_of_day} in (2) THEN "2am-3am"
          WHEN ${session_date_hour_of_day} in (3) THEN "3am-4am"
          WHEN ${session_date_hour_of_day} in (4) THEN "4am-5am"
          WHEN ${session_date_hour_of_day} in (5) THEN "5am-6am"
          WHEN ${session_date_hour_of_day} in (6) THEN "6am-7am"
          WHEN ${session_date_hour_of_day} in (7) THEN "7am-8am"
          WHEN ${session_date_hour_of_day} in (8) THEN "8am-9am"
          WHEN ${session_date_hour_of_day} in (9) THEN "9am-10am"
          WHEN ${session_date_hour_of_day} in (10) THEN "10am-11am"
          WHEN ${session_date_hour_of_day} in (11) THEN "11am-12pm"
          WHEN ${session_date_hour_of_day} in (12) THEN "12pm-1pm"
          WHEN ${session_date_hour_of_day} in (13) THEN "1pm-2pm"
          WHEN ${session_date_hour_of_day} in (14) THEN "2pm-3pm"
          WHEN ${session_date_hour_of_day} in (15) THEN "3pm-4pm"
          WHEN ${session_date_hour_of_day} in (16) THEN "4pm-5pm"
          WHEN ${session_date_hour_of_day} in (17) THEN "5pm-6pm"
          WHEN ${session_date_hour_of_day} in (18) THEN "6pm-7pm"
          WHEN ${session_date_hour_of_day} in (19) THEN "7pm-8pm"
          WHEN ${session_date_hour_of_day} in (20) THEN "8pm-9pm"
          WHEN ${session_date_hour_of_day} in (21) THEN "9pm-10pm"
          WHEN ${session_date_hour_of_day} in (22) THEN "10pm-11pm"
          WHEN ${session_date_hour_of_day} in (23) THEN "11pm-12am"
          END ;;
  }
  dimension: durationinmin {
    type: number
    sql: ${conversation_length_in_seconds}/60;;
    value_format: "00.00"
  }
  dimension: callduration {
    type: string
    sql:  CASE WHEN ${durationinmin} between 0.00 and 1.00 THEN '<1 min'
          WHEN ${durationinmin} between 1.00 and 3.00 THEN '1-3 min'
          WHEN ${durationinmin} between 3.00 and 5.00 THEN '3-5 min'
          WHEN ${durationinmin} between 5.00 and 7.00 THEN '5-7 min'
          ELSE ">7 min"
    END ;;
  }
  dimension: callduration1 {
    type: string
    sql:  CASE WHEN ${durationinmin} between 0.00 and 1.00 THEN '1'
          WHEN ${durationinmin} between 1.00 and 3.00 THEN '2'
          WHEN ${durationinmin} between 3.00 and 5.00 THEN '3'
          WHEN ${durationinmin} between 5.00 and 7.00 THEN '4'
          ELSE "5"
    END ;;
  }
  dimension: callduration2 {
    type: string
    sql:  CASE WHEN ${durationinmin} between 0.00 and 1.00 THEN '1)<1 min'
          WHEN ${durationinmin} between 1.00 and 3.00 THEN '2)1-3 min'
          WHEN ${durationinmin} between 3.00 and 5.00 THEN '3)3-5 min'
          WHEN ${durationinmin} between 5.00 and 7.00 THEN '4)5-7 min'
          ELSE "5)>7 min"
    END ;;
  }
  measure: avgsentimentscore {
    type: average
    sql: ${avg_sentiment_score} ;;
    value_format: "0.00"
  }


  #
  # dimension: lifetime_orders {
  #   description: "The total number of orders for each user"
  #   type: number
  #   sql: ${TABLE}.lifetime_orders ;;
  # }
  #
  # dimension_group: most_recent_purchase {
  #   description: "The date when each user last ordered"
  #   type: time
  #   timeframes: [date, week, month, year]
  #   sql: ${TABLE}.most_recent_purchase_at ;;
  # }
  #
  # measure: total_lifetime_orders {
  #   description: "Use this for counting lifetime orders across many users"
  #   type: sum
  #   sql: ${lifetime_orders} ;;
  # }
}

#
#   # Define your dimensions and measures here, like this:
#   dimension: user_id {
#     description: "Unique ID for each user that has ordered"
#     type: number
#     sql: ${TABLE}.user_id ;;
#   }
#
#   dimension: lifetime_orders {
#     description: "The total number of orders for each user"
#     type: number
#     sql: ${TABLE}.lifetime_orders ;;
#   }
#
#   dimension_group: most_recent_purchase {
#     description: "The date when each user last ordered"
#     type: time
#     timeframes: [date, week, month, year]
#     sql: ${TABLE}.most_recent_purchase_at ;;
#   }
#
#   measure: total_lifetime_orders {
#     description: "Use this for counting lifetime orders across many users"
#     type: sum
#     sql: ${lifetime_orders} ;;
#   }
# }

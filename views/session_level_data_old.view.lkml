 #view: intent_analytics {
  # # You can specify the table name if it's different from the view name:
  #sql_table_name: sql_table_name: `looker_training.dialogflow_cleaned_logs`;;
  #
  # # Define your dimensions and measures here, like this:
  # dimension: user_id {
  #   description: "Unique ID for each user that has ordered"
  #   type: number
  #   sql: ${TABLE}.user_id ;;
  # }
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
#}

  view: session_level_data_old {
#   # Or, you could make this view a derived table, like this:
   derived_table: {
     sql:  SELECT a.session_ID, a.entry_intent ,d.first_intent, a.exit_intent, c.conversation_length_in_minutes , c.conversation_length_in_seconds , c.hour, c.count_of_msg , c.DATE_EST, c.platform FROM
        (WITH entry_exit_intent AS
        (
            SELECT session_ID , ROW_NUMBER() OVER(PARTITION BY session_ID ORDER BY request_time ASC) AS RowNumber, intent_triggered , request_time, date
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

        (SELECT session_ID, TIMESTAMP_DIFF(end_time, start_time, MINUTE) as conversation_length_in_minutes, TIMESTAMP_DIFF(end_time, start_time, SECOND) as conversation_length_in_seconds, count_of_msg, DATE_EST, EXTRACT(HOUR FROM start_time) as hour, platform
        FROM(
        SELECT session_ID,  MAX(time_stamp_EST) as end_time, MIN(time_stamp_EST) as start_time, count(*) as count_of_msg, MIN(DATE_EST) as DATE_EST, MAX(platform) as platform
        FROM `looker_training.dialogflow_cleaned_logs` AS dialogflow_cleaned_logs
        group by session_ID
        ORDER BY count_of_msg DESC)) as c
        ON a.session_ID=c.session_ID

        LEFT JOIN
        -----------------------------------------------
        (SELECT session_ID , intent_triggered as first_intent FROM (SELECT session_ID , ROW_NUMBER() OVER(PARTITION BY session_ID ORDER BY request_time ASC) AS RowNumber, intent_triggered
        FROM `looker_training.dialogflow_cleaned_logs` AS dialogflow_cleaned_logs
        where intent_triggered != 'Default Welcome Intent')
        where RowNumber = 1) as d
        on c.session_ID = d.session_ID
       ;;

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
 }

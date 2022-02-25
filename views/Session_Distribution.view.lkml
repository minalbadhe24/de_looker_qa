
 view: session_distribution {
   # Or, you could make this view a derived table, like this:
   derived_table: {
    explore_source: dialogflow_cleaned_logs {
      column: session_ID {
        field: dialogflow_cleaned_logs.session_id
      }
      column: Number_of_Fallbacks {
        field: dialogflow_cleaned_logs.Number_of_Fallbacks
      }
      column: Number_of_Livegenttransfer {
        field: dialogflow_cleaned_logs.Number_of_Livegenttransfer
      }
      bind_all_filters: yes
    }
}

   # Define your dimensions and measures here, like this:
   dimension: session_ID {
    description: "Unique ID for each session of VA"
      type: string
      primary_key: yes
     sql: ${TABLE}.session_ID ;;
   }

   dimension: Number_of_Fallbacks {
     description: "The total number of fallbacks occured in a session"
     type: number
     sql: ${TABLE}.Number_of_Fallbacks ;;
   }

  dimension:  Number_of_Livegenttransfer{
    description: "The total number of live agent transfers occured in a session"
    type: number
    sql: ${TABLE}.Number_of_Livegenttransfer ;;
  }

    dimension: Session_Distribution {
      description: "Identify how sessions have been handled by bot
                    Sessions are distributed in following category:
                    1. Number of sessions that were successfully handled with bot end to end
                    2. Number of sessions that were partially handled by the bot and had at least one query unanswered but not transferred to live agent
                    3. Number of sessions that were transferred to live agent and has at least one fallback query (i.e.bot not able to answer)
                    4. Number of sessions that were transferred to live agent as per the expected flow but had not fallback query"
      type: string
      sql:CASE
           WHEN ${Number_of_Fallbacks} = 0 AND ${Number_of_Livegenttransfer} =0 THEN "FullyDeflected"
           WHEN ${Number_of_Fallbacks} = 0 AND ${Number_of_Livegenttransfer} > 0 THEN "TransfertoLiveAgentFlow"
           WHEN ${Number_of_Fallbacks} > 0 AND ${Number_of_Livegenttransfer} =0 THEN "PartiallyDeflected"
           WHEN ${Number_of_Fallbacks} > 0 AND ${Number_of_Livegenttransfer} >0 THEN "NotDeflected"
          END;;
    }

  dimension: Deflection_Rate {
    description: "Sessions are distributed in following category:
                1. Number of sessions that were successfully handled with bot end to end -- Fully Deflected
                2. Number of sessions that were partially handled by the bot and had at least one query unanswered but not transferred to live agent---> Fully Deflected
                3. Number of sessions that were transferred to live agent and has at least one fallback query (i.e.bot not able to answer)--->Partially Deflected
                4. Number of sessions that were transferred to live agent as per the expected flow but had not fallback query Not Deflected"
    type: string
    sql:CASE
           WHEN ${Number_of_Fallbacks} = 0 AND ${Number_of_Livegenttransfer} =0 THEN "FullyDeflected"
           WHEN ${Number_of_Fallbacks} = 0 AND ${Number_of_Livegenttransfer} > 0 THEN "Not Deflected"
           WHEN ${Number_of_Fallbacks} > 0 AND ${Number_of_Livegenttransfer} =0 THEN "FullyDeflected"
           WHEN ${Number_of_Fallbacks} > 0 AND ${Number_of_Livegenttransfer} >0 THEN "Partially Deflected"
          END;;
  }
 }

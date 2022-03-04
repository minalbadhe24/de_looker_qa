- dashboard: level_one
  title: Amwell VA Performance
  layout: newspaper
  preferred_viewer: dashboards-next
  tile_size: 100

  filters:
    - name: date
      title: 'Date Range'
      type: date_filter
      default_value: 30 days

    - name: language
      title: 'Language'
      type: string
      default_value:  en

  elements:
    - name: hello_world
      type: looker_column

    - title: Total Sessions
      name: Total Sessions
      model: qai_de_looker_training_minalbadhe
      explore: dialogflow_cleaned_logs
      type: single_value
      fields: [dialogflow_cleaned_logs]
      Measure: dialogflow_cleaned_logs.session_id.count
      limit: 500

    - name: Avg sessions/day
      type: Avg sessions/day
      model: qai_de_looker_training_minalbadhe
      explore: dialogflow_cleaned_logs
      dimensions: [order.created_date]
      measures: [order.count]
      filters:
      order.status: 'approved'

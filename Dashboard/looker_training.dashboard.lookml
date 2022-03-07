- dashboard: amwell_va_performance
  title: Amwell VA Performance
  layout: newspaper
  preferred_viewer: dashboards-next
  description: ''
  refresh: 1 hour
  query_timezone: user_timezone
  elements:
  - title: Total Sessions
    name: Total Sessions
    model: qai_de_looker_training_qa_minal_badhe
    explore: dialogflow_cleaned_logs
    type: single_value
    fields: [dialogflow_cleaned_logs.Total_Unique_Sessions]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    defaults_version: 1
    listen:
      Intent: dialogflow_cleaned_logs.intent_triggered
      Date Date: dialogflow_cleaned_logs.date_date
    row: 2
    col: 0
    width: 5
    height: 4
  - title: Average Sessions/Day
    name: Average Sessions/Day
    model: qai_de_looker_training_qa_minal_badhe
    explore: dialogflow_cleaned_logs
    type: single_value
    fields: [dialogflow_cleaned_logs.avg_session_per_day]
    limit: 500
    dynamic_fields: [{category: measure, expression: !!null '', label: Number of Sessions,
        value_format: !!null '', value_format_name: !!null '', based_on: dialogflow_cleaned_logs.session_id,
        _kind_hint: measure, measure: number_of_sessions, type: count_distinct, _type_hint: number},
      {category: measure, expression: !!null '', label: Number of Days, value_format: !!null '',
        value_format_name: !!null '', based_on: dialogflow_cleaned_logs.date_date,
        _kind_hint: measure, measure: number_of_days, type: count_distinct, _type_hint: number},
      {category: table_calculation, expression: 'ceiling(${number_of_sessions}/${number_of_days})',
        label: Average Sessions per Day, value_format: !!null '', value_format_name: !!null '',
        _kind_hint: measure, table_calculation: average_sessions_per_day, _type_hint: number,
        is_disabled: true}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    defaults_version: 1
    hidden_fields: []
    listen:
      Intent: dialogflow_cleaned_logs.intent_triggered
      Date Date: dialogflow_cleaned_logs.date_date
    row: 6
    col: 0
    width: 5
    height: 4
  - title: Average Queries/Session
    name: Average Queries/Session
    model: qai_de_looker_training_qa_minal_badhe
    explore: dialogflow_cleaned_logs
    type: single_value
    fields: [dialogflow_cleaned_logs.Avg_queries_per_session]
    limit: 500
    dynamic_fields: [{category: measure, expression: !!null '', label: No of Sessions,
        value_format: !!null '', value_format_name: !!null '', based_on: dialogflow_cleaned_logs.session_id,
        _kind_hint: measure, measure: no_of_sessions, type: count_distinct, _type_hint: number},
      {category: measure, expression: !!null '', label: No of Responses, value_format: !!null '',
        value_format_name: !!null '', based_on: dialogflow_cleaned_logs.response_id,
        _kind_hint: measure, measure: no_of_responses, type: count_distinct, _type_hint: number},
      {category: table_calculation, expression: 'ceiling(${no_of_responses}/${no_of_sessions})',
        label: Average Queries per Session, value_format: !!null '', value_format_name: !!null '',
        _kind_hint: measure, table_calculation: average_queries_per_session, _type_hint: number,
        is_disabled: true}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    defaults_version: 1
    hidden_fields: []
    listen:
      Intent: dialogflow_cleaned_logs.intent_triggered
      Date Date: dialogflow_cleaned_logs.date_date
    row: 2
    col: 5
    width: 5
    height: 4
  - title: Avg Conversation Length in Min
    name: Avg Conversation Length in Min
    model: qai_de_looker_training_qa_minal_badhe
    explore: Session_level_data
    type: single_value
    fields: [Session_level_data.avg_conv_duration_seconds]
    limit: 500
    dynamic_fields: [{category: measure, expression: !!null '', label: Sum of Conversation
          Length, value_format: !!null '', value_format_name: !!null '', based_on: Session_level_data.conversation_length_in_minutes,
        _kind_hint: measure, measure: sum_of_conversation_length, type: count_distinct,
        _type_hint: number}, {category: measure, expression: !!null '', label: No
          of Sessions, value_format: !!null '', value_format_name: !!null '', based_on: Session_level_data.session_id,
        _kind_hint: measure, measure: no_of_sessions, type: count_distinct, _type_hint: number},
      {category: table_calculation, expression: 'concat(round(ceiling(${avg_conversation_length_1}/60),2),"
          mins")', label: Avg Conversation Length, value_format: !!null '', value_format_name: !!null '',
        _kind_hint: measure, table_calculation: avg_conversation_length, _type_hint: string,
        is_disabled: true}, {category: measure, expression: !!null '', label: Avg
          Conversation Length, value_format: !!null '', value_format_name: decimal_2,
        based_on: Session_level_data.conversation_length_in_seconds, _kind_hint: measure,
        measure: avg_conversation_length_1, type: average, _type_hint: number}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    defaults_version: 1
    hidden_fields: []
    listen:
      Date Date: Session_level_data.date_date
    row: 6
    col: 5
    width: 5
    height: 4
  - title: Success Rate
    name: Success Rate
    model: qai_de_looker_training_qa_minal_badhe
    explore: dialogflow_cleaned_logs
    type: single_value
    fields: [dialogflow_cleaned_logs.success_rate]
    limit: 500
    dynamic_fields: [{category: dimension, expression: "if(${dialogflow_cleaned_logs.intent_triggered}\n\
          \  !=\"Default Fallback Intent\",1,0)", label: Successful Queries, value_format: !!null '',
        value_format_name: !!null '', dimension: successful_queries, _kind_hint: dimension,
        _type_hint: number}, {category: measure, expression: !!null '', label: Successful
          Queries Count, value_format: !!null '', value_format_name: !!null '', based_on: successful_queries,
        _kind_hint: measure, measure: successful_queries_count, type: count_distinct,
        _type_hint: number}, {category: table_calculation, expression: "(${successful_queries_count}/${dialogflow_cleaned_logs.count})*100",
        label: Success Rate, value_format: !!null '', value_format_name: percent_2,
        _kind_hint: measure, table_calculation: success_rate, _type_hint: number,
        is_disabled: true}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    defaults_version: 1
    hidden_fields: []
    listen:
      Intent: dialogflow_cleaned_logs.intent_triggered
      Date Date: dialogflow_cleaned_logs.date_date
    row: 18
    col: 18
    width: 6
    height: 3
  - title: Total Queries
    name: Total Queries
    model: qai_de_looker_training_qa_minal_badhe
    explore: dialogflow_cleaned_logs
    type: single_value
    fields: [dialogflow_cleaned_logs.count]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    defaults_version: 1
    hidden_fields: []
    groupBars: true
    labelSize: 10pt
    showLegend: true
    listen:
      Intent: dialogflow_cleaned_logs.intent_triggered
      Date Date: dialogflow_cleaned_logs.date_date
    row: 18
    col: 0
    width: 6
    height: 3
  - title: Unhandled Queries
    name: Unhandled Queries
    model: qai_de_looker_training_qa_minal_badhe
    explore: dialogflow_cleaned_logs
    type: single_value
    fields: [dialogflow_cleaned_logs.count, dialogflow_cleaned_logs.is_fallback]
    filters:
      dialogflow_cleaned_logs.is_fallback: 'Yes'
    sorts: [dialogflow_cleaned_logs.count desc]
    limit: 500
    dynamic_fields: [{category: measure, expression: !!null '', label: Count of Intent
          Triggered, value_format: !!null '', value_format_name: decimal_2, based_on: dialogflow_cleaned_logs.is_fallback,
        _kind_hint: measure, measure: count_of_intent_triggered, type: count_distinct,
        _type_hint: number, filters: {}}]
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    defaults_version: 1
    hidden_fields: [dialogflow_cleaned_logs.is_fallback]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    header_text_alignment: left
    header_font_size: 12
    rows_font_size: 12
    listen:
      Intent: dialogflow_cleaned_logs.intent_triggered
      Date Date: dialogflow_cleaned_logs.date_date
    row: 18
    col: 12
    width: 6
    height: 3
  - title: Total Handled Queries
    name: Total Handled Queries
    model: qai_de_looker_training_qa_minal_badhe
    explore: dialogflow_cleaned_logs
    type: single_value
    fields: [dialogflow_cleaned_logs.is_fallback, dialogflow_cleaned_logs.count]
    filters:
      dialogflow_cleaned_logs.is_fallback: 'No'
    sorts: [dialogflow_cleaned_logs.count desc]
    limit: 500
    custom_color_enabled: true
    show_single_value_title: true
    show_comparison: false
    comparison_type: value
    comparison_reverse_colors: false
    show_comparison_label: true
    enable_conditional_formatting: false
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    series_types: {}
    defaults_version: 1
    hidden_fields: [dialogflow_cleaned_logs.is_fallback]
    listen:
      Intent: dialogflow_cleaned_logs.intent_triggered
      Date Date: dialogflow_cleaned_logs.date_date
    row: 18
    col: 6
    width: 6
    height: 3
  - name: Conversation Summary
    type: text
    title_text: Conversation Summary
    subtitle_text: ''
    body_text: ''
    row: 0
    col: 0
    width: 24
    height: 2
  - name: Summary of Queries
    type: text
    title_text: Summary of Queries
    subtitle_text: ''
    body_text: ''
    row: 16
    col: 0
    width: 24
    height: 2
  - title: Avg Sentiment Score
    name: Avg Sentiment Score
    model: qai_de_looker_training_qa_minal_badhe
    explore: dialogflow_cleaned_logs
    type: marketplace_viz_radial_gauge::radial_gauge-marketplace
    fields: [avg_sentiment_score]
    limit: 500
    dynamic_fields: [{category: measure, expression: !!null '', label: Avg Sentiment
          Score, value_format: !!null '', value_format_name: decimal_3, based_on: dialogflow_cleaned_logs.sentiment_score,
        _kind_hint: measure, measure: avg_sentiment_score, type: average, _type_hint: number}]
    hidden_fields: []
    hidden_points_if_no: []
    series_labels: {}
    show_view_names: true
    arm_length: 9
    arm_weight: 48
    spinner_length: 149
    spinner_weight: 36
    target_length: 10
    target_gap: 10
    target_weight: 25
    range_min: -1
    range_max: 1
    value_label_type: value
    value_label_font: 12
    value_label_padding: 45
    target_source: 'off'
    target_label_type: nolabel
    target_label_font: 3
    label_font_size: 6
    fill_color: "#0092E5"
    background_color: "#CECECE"
    spinner_color: "#282828"
    range_color: "#282828"
    gauge_fill_type: segment
    fill_colors: ["#7FCDAE", "#ffed6f", "#EE7772"]
    angle: 90
    cutout: 30
    range_x: 1
    range_y: 1
    target_label_padding: 1.06
    series_types: {}
    defaults_version: 0
    listen:
      Intent: dialogflow_cleaned_logs.intent_triggered
      Date Date: dialogflow_cleaned_logs.date_date
    row: 21
    col: 0
    width: 6
    height: 7
  - title: Weekly Avg Sentiment Trend
    name: Weekly Avg Sentiment Trend
    model: qai_de_looker_training_qa_minal_badhe
    explore: dialogflow_cleaned_logs
    type: looker_column
    fields: [average_of_sentiment_score, dialogflow_cleaned_logs.date_week]
    fill_fields: [dialogflow_cleaned_logs.date_week]
    sorts: [dialogflow_cleaned_logs.date_week desc]
    limit: 500
    dynamic_fields: [{category: measure, expression: !!null '', label: Average of
          Sentiment Score, value_format: !!null '', value_format_name: !!null '',
        based_on: dialogflow_cleaned_logs.sentiment_score, _kind_hint: measure, measure: average_of_sentiment_score,
        type: average, _type_hint: number}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: time
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: average_of_sentiment_score,
            id: average_of_sentiment_score, name: Average of Sentiment Score}], showLabels: true,
        showValues: true, maxValue: 1, minValue: -1, unpinAxis: false, tickDensity: custom,
        tickDensityCustom: 30, type: linear}]
    x_axis_label: Week
    series_types: {}
    defaults_version: 1
    listen:
      Date Date: dialogflow_cleaned_logs.date_date
    row: 21
    col: 6
    width: 9
    height: 7
  - title: User Utterances
    name: User Utterances
    model: qai_de_looker_training_qa_minal_badhe
    explore: dialogflow_cleaned_logs
    type: looker_grid
    fields: [dialogflow_cleaned_logs.query_text, dialogflow_cleaned_logs.count]
    filters:
      dialogflow_cleaned_logs.query_text: -Yes,-"TELEPHONY_WARMUP",-"TELEPHONY_WELCOME",-No.,-Hello.,-Yes.,-no,-yes,-Yeah.,-None,-hello,-Goodbye.
    sorts: [dialogflow_cleaned_logs.count desc]
    limit: 500
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: gray
    limit_displayed_rows: false
    enable_conditional_formatting: true
    header_text_alignment: center
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
      palette_id: fb7bb53e-b77b-4ab6-8274-9d420d3d73f3
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    series_labels:
      dialogflow_cleaned_logs.query_text: Sessions
      dialogflow_cleaned_logs.count: Total Sessions
    series_cell_visualizations:
      dialogflow_cleaned_logs.count:
        is_active: false
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: 0
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#3EB0D5",
        font_color: !!null '', color_application: {collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7,
          palette_id: afd46b40-e939-4ace-bffd-69d1bb16ee05, options: {steps: 5}},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    series_value_format: {}
    series_types: {}
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    hidden_fields: []
    hidden_points_if_no: []
    listen:
      Date Date: dialogflow_cleaned_logs.date_date
    row: 28
    col: 0
    width: 24
    height: 7
  - title: Top 10 Positive Queries
    name: Top 10 Positive Queries
    model: qai_de_looker_training_qa_minal_badhe
    explore: dialogflow_cleaned_logs
    type: looker_grid
    fields: [dialogflow_cleaned_logs.query_text, dialogflow_cleaned_logs.sentiment_score]
    filters:
      dialogflow_cleaned_logs.sentiment_score: ">=0"
    sorts: [dialogflow_cleaned_logs.sentiment_score desc]
    limit: 500
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: true
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    series_labels:
      dialogflow_cleaned_logs.query_text: QUERIES
      dialogflow_cleaned_logs.sentiment_score: SENTIMENT SCORE
    series_text_format:
      dialogflow_cleaned_logs.query_text:
        align: left
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '10'
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#3EB0D5",
        font_color: !!null '', color_application: {collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7,
          custom: {id: cd43a31b-ce85-a627-8489-f90e271bfcda, label: Custom, type: continuous,
            stops: [{color: "#87B984", offset: 0}, {color: "#74A563", offset: 50},
              {color: "#599F57", offset: 100}]}, options: {steps: 5, reverse: false}},
        bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    series_types: {}
    defaults_version: 1
    listen:
      Date Date: dialogflow_cleaned_logs.date_date
    row: 35
    col: 0
    width: 12
    height: 8
  - title: Top 10 Negative Queries
    name: Top 10 Negative Queries
    model: qai_de_looker_training_qa_minal_badhe
    explore: dialogflow_cleaned_logs
    type: looker_grid
    fields: [dialogflow_cleaned_logs.query_text, dialogflow_cleaned_logs.sentiment_score]
    filters:
      dialogflow_cleaned_logs.sentiment_score: "<0"
    sorts: [dialogflow_cleaned_logs.sentiment_score]
    limit: 500
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: true
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: true
    conditional_formatting_include_nulls: false
    color_application:
      collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e
      palette_id: be92eae7-de25-46ae-8e4f-21cb0b69a1f3
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    series_labels:
      dialogflow_cleaned_logs.query_text: QUERIES
      dialogflow_cleaned_logs.sentiment_score: SENTIMENT SCORE
    series_text_format:
      dialogflow_cleaned_logs.query_text: {}
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '10'
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#462C9D",
        font_color: !!null '', color_application: {collection_id: 5f313589-67ce-44ba-b084-ec5107a7bb7e,
          palette_id: 2229f400-11a4-4b0d-b224-abe608161947, options: {steps: 5, reverse: true,
            mirror: false}}, bold: false, italic: false, strikethrough: false, fields: !!null ''}]
    series_types: {}
    defaults_version: 1
    listen:
      Date Date: dialogflow_cleaned_logs.date_date
    row: 35
    col: 12
    width: 12
    height: 8
  - title: Weekly Traffic
    name: Weekly Traffic
    model: qai_de_looker_training_qa_minal_badhe
    explore: dialogflow_cleaned_logs
    type: looker_column
    fields: [dialogflow_cleaned_logs.date_week, dialogflow_cleaned_logs.Total_Unique_Sessions]
    fill_fields: [dialogflow_cleaned_logs.date_week]
    sorts: [dialogflow_cleaned_logs.date_week]
    limit: 500
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: circle
    show_value_labels: false
    label_density: 25
    x_axis_scale: ordinal
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
      custom:
        id: 4c83df6e-19ee-c6f1-f690-ff4785e068d5
        label: Custom
        type: discrete
        colors:
        - "#1B72E9"
        - "#B1399E"
        - "#C2DD67"
        - "#592EC2"
        - "#4276BE"
        - "#72D16D"
        - "#FFD95F"
        - "#B32F37"
        - "#9174F0"
        - "#E57947"
        - "#75E2E2"
        - "#FBB555"
      options:
        steps: 5
    y_axes: [{label: Total Sessions, orientation: left, series: [{axisId: dialogflow_cleaned_logs.Total_Unique_Sessions,
            id: dialogflow_cleaned_logs.Total_Unique_Sessions, name: Total Unique
              Sessions}], showLabels: true, showValues: true, maxValue: !!null '',
        minValue: 0, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    x_axis_label: WEEK
    series_types: {}
    defaults_version: 1
    listen:
      Date Date: dialogflow_cleaned_logs.date_date
    row: 45
    col: 12
    width: 11
    height: 8
  - title: Traffic by Time
    name: Traffic by Time
    model: qai_de_looker_training_qa_minal_badhe
    explore: Session_level_data
    type: looker_column
    fields: [Session_level_data.count, Session_level_data.one_Hour_frame_case]
    sorts: [Session_level_data.count desc]
    limit: 500
    dynamic_fields: [{category: table_calculation, expression: "if(${Session_level_data.One_Hour_frame}=\"\
          0\",\"12am to 1am\",\n  if(${Session_level_data.One_Hour_frame}=\"1\",\"\
          1am to 2am\",\n  if(${Session_level_data.One_Hour_frame}=\"2\",\"2am to\
          \ 3am\",\n  if(${Session_level_data.One_Hour_frame}=\"3\",\"3am to 4am\"\
          ,\n  if(${Session_level_data.One_Hour_frame}=\"4\",\"4am to 5am\",\n  if(${Session_level_data.One_Hour_frame}=\"\
          5\",\"5am to 6am\",\n  if(${Session_level_data.One_Hour_frame}=\"6\",\"\
          6am to 7am\",\n  if(${Session_level_data.One_Hour_frame}=\"7\",\"7am to\
          \ 8am\",\n  if(${Session_level_data.One_Hour_frame}=\"8\",\"8am to 9am\"\
          ,\n  if(${Session_level_data.One_Hour_frame}=\"9\",\"9am to 10am\",\n  if(${Session_level_data.One_Hour_frame}=\"\
          10\",\"10am to 11am\",\n  if(${Session_level_data.One_Hour_frame}=\"11\"\
          ,\"11am to 12pm\",\n  if(${Session_level_data.One_Hour_frame}=\"12\",\"\
          12pm to 1pm\", if(${Session_level_data.One_Hour_frame}=\"13\",\"1pm to 2pm\"\
          , if(${Session_level_data.One_Hour_frame}=\"14\",\"2pm to 3pm\",if(${Session_level_data.One_Hour_frame}=\"\
          15\",\"3pm to 4pm\",if(${Session_level_data.One_Hour_frame}=\"16\",\"4pm\
          \ to 5pm\",if(${Session_level_data.One_Hour_frame}=\"17\",\"5pm to 6pm\"\
          ,if(${Session_level_data.One_Hour_frame}=\"18\",\"6pm to 7pm\",if(${Session_level_data.One_Hour_frame}=\"\
          19\",\"7pm to 8pm\",if(${Session_level_data.One_Hour_frame}=\"20\",\"8pm\
          \ to 9pm\",if(${Session_level_data.One_Hour_frame}=\"21\",\"9pm to 10pm\"\
          ,if(${Session_level_data.One_Hour_frame}=\"22\",\"10pm to 11pm\",if(${Session_level_data.One_Hour_frame}=\"\
          23\",\"11pm to 12am\",\"\"\n))))))))))))))))))))))))\n", label: one_hour_frame,
        value_format: !!null '', value_format_name: !!null '', _kind_hint: dimension,
        table_calculation: one_hour_frame, _type_hint: string, is_disabled: true}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: time
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: TOTAL SESSIONS, orientation: left, series: [{axisId: Session_level_data.count,
            id: Session_level_data.count, name: Session Level Data}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    x_axis_label: HOUR FRAME
    limit_displayed_rows_values:
      show_hide: hide
      first_last: first
      num_rows: 0
    hide_legend: false
    series_types:
      Session_level_data.count: area
    defaults_version: 1
    hidden_fields: []
    listen:
      Date Date: Session_level_data.date_date
    row: 45
    col: 0
    width: 12
    height: 8
  - title: Traffic by Entry Intent
    name: Traffic by Entry Intent
    model: qai_de_looker_training_qa_minal_badhe
    explore: Session_level_data
    type: looker_column
    fields: [Session_level_data.first_intent, Session_level_data.count]
    filters:
      Session_level_data.count: NOT NULL
      Session_level_data.first_intent: "-NULL"
    sorts: [Session_level_data.count desc]
    limit: 500
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: true
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: TOTAL SESSIONS, orientation: left, series: [{axisId: Session_level_data.count,
            id: Session_level_data.count, name: Session Level Data}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    x_axis_label: INTENTS
    limit_displayed_rows_values:
      show_hide: show
      first_last: first
      num_rows: '10'
    series_types: {}
    defaults_version: 1
    listen:
      Date Date: Session_level_data.date_date
    row: 62
    col: 0
    width: 12
    height: 8
  - title: Traffic by Exit Intent
    name: Traffic by Exit Intent
    model: qai_de_looker_training_qa_minal_badhe
    explore: Session_level_data
    type: looker_column
    fields: [Session_level_data.exit_intent, Session_level_data.count]
    filters:
      Session_level_data.count: NOT NULL
      Session_level_data.exit_intent: "-NULL"
    sorts: [Session_level_data.count desc]
    limit: 500
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: TOTAL SESSIONS, orientation: left, series: [{axisId: Session_level_data.count,
            id: Session_level_data.count, name: Session Level Data}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    x_axis_label: INTENTS
    defaults_version: 1
    listen:
      Date Date: Session_level_data.date_date
    row: 62
    col: 12
    width: 12
    height: 8
  - title: Intent Wise Information
    name: Intent Wise Information
    model: qai_de_looker_training_qa_minal_badhe
    explore: dialogflow_cleaned_logs
    type: looker_grid
    fields: [dialogflow_cleaned_logs.intent_triggered, dialogflow_cleaned_logs.count,
      avg_sentiment_score]
    sorts: [avg_sentiment_score desc]
    limit: 500
    dynamic_fields: [{category: measure, expression: !!null '', label: Avg Sentiment
          Score, value_format: !!null '', value_format_name: decimal_3, based_on: dialogflow_cleaned_logs.sentiment_score,
        _kind_hint: measure, measure: avg_sentiment_score, type: average, _type_hint: number}]
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    show_totals: true
    show_row_totals: true
    series_labels:
      dialogflow_cleaned_logs.count: Total Sessions
      dialogflow_cleaned_logs.intent_triggered: Intent
    series_cell_visualizations:
      dialogflow_cleaned_logs.count:
        is_active: false
    conditional_formatting: [{type: along a scale..., value: !!null '', background_color: "#3EB0D5",
        font_color: !!null '', color_application: {collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7,
          palette_id: 471a8295-662d-46fc-bd2d-2d0acd370c1e, options: {steps: 5, constraints: {
              min: {type: minimum}, mid: {type: number, value: 0}, max: {type: maximum}},
            mirror: false, reverse: false, stepped: false}}, bold: false, italic: false,
        strikethrough: false, fields: !!null ''}]
    series_types: {}
    defaults_version: 1
    listen:
      Date Date: dialogflow_cleaned_logs.date_date
    row: 70
    col: 12
    width: 12
    height: 6
  - title: Conversation Distribution vs Duration
    name: Conversation Distribution vs Duration
    model: qai_de_looker_training_qa_minal_badhe
    explore: Session_level_data
    type: looker_column
    fields: [duration_bucket, Session_level_data.count, duration_order]
    filters:
      duration_bucket: "-EMPTY"
    sorts: [duration_order]
    limit: 500
    dynamic_fields: [{category: dimension, expression: "if(${Session_level_data.conversation_length_in_minutes}\
          \ < 1,1,\n  if(${Session_level_data.conversation_length_in_minutes}<= 3\
          \ AND ${Session_level_data.conversation_length_in_minutes} > 1, 2,\n   \
          \ if(${Session_level_data.conversation_length_in_minutes} <= 5 AND ${Session_level_data.conversation_length_in_minutes}\
          \ > 3,3,\n      if(${Session_level_data.conversation_length_in_minutes}\
          \ <= 7 AND ${Session_level_data.conversation_length_in_minutes} > 5,4,\n\
          \        if(${Session_level_data.conversation_length_in_minutes} > 7,5,null)))))",
        label: Duration Order, value_format: !!null '', value_format_name: !!null '',
        dimension: duration_order, _kind_hint: dimension, _type_hint: number}, {category: dimension,
        expression: 'if(${Session_level_data.conversation_length_in_minutes} < 1,
          "< 1 Mins",if(${Session_level_data.conversation_length_in_minutes} <= 3
          AND ${Session_level_data.conversation_length_in_minutes} > 1  , "1-3 Mins",if(${Session_level_data.conversation_length_in_minutes}
          <= 5 AND ${Session_level_data.conversation_length_in_minutes} > 3 , "3-5
          Mins",if(${Session_level_data.conversation_length_in_minutes} <= 7 AND ${Session_level_data.conversation_length_in_minutes}
          > 5 , "5-7 Mins",if(${Session_level_data.conversation_length_in_minutes}
          > 7 , "> 7 Mins","")))))', label: Duration Bucket, value_format: !!null '',
        value_format_name: !!null '', dimension: duration_bucket, _kind_hint: dimension,
        _type_hint: string}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: TOTAL SESSIONS, orientation: left, series: [{axisId: Session_level_data.count,
            id: Session_level_data.count, name: Session Level Data}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    x_axis_label: CONVERSATION DURATION
    series_types: {}
    series_colors:
      Session_level_data.count: "#1B72E9"
    defaults_version: 1
    hidden_fields: [duration_order]
    listen:
      Date Date: Session_level_data.date_date
    row: 53
    col: 0
    width: 12
    height: 7
  - name: Intent Analytics
    type: text
    title_text: Intent Analytics
    subtitle_text: ''
    body_text: ''
    row: 60
    col: 0
    width: 24
    height: 2
  - name: Session Analytics
    type: text
    title_text: Session Analytics
    subtitle_text: ''
    body_text: ''
    row: 43
    col: 0
    width: 24
    height: 2
  - title: Query Sentiment Distribution
    name: Query Sentiment Distribution
    model: qai_de_looker_training_qa_minal_badhe
    explore: dialogflow_cleaned_logs
    type: looker_pie
    fields: [dialogflow_cleaned_logs.sentiment_bucket, dialogflow_cleaned_logs.count]
    sorts: [dialogflow_cleaned_logs.count desc]
    limit: 500
    value_labels: legend
    label_type: labPer
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    defaults_version: 1
    series_types: {}
    listen:
      Date Date: dialogflow_cleaned_logs.date_date
    row: 21
    col: 15
    width: 9
    height: 7
  - title: Weekly Intent Trend Over Time
    name: Weekly Intent Trend Over Time
    model: qai_de_looker_training_qa_minal_badhe
    explore: dialogflow_cleaned_logs
    type: looker_line
    fields: [dialogflow_cleaned_logs.date_week, dialogflow_cleaned_logs.intent_triggered,
      dialogflow_cleaned_logs.count]
    pivots: [dialogflow_cleaned_logs.intent_triggered]
    fill_fields: [dialogflow_cleaned_logs.date_week]
    sorts: [dialogflow_cleaned_logs.date_week desc, dialogflow_cleaned_logs.intent_triggered]
    limit: 500
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: true
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: circle
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    y_axes: [{label: NUMBER of INTENTS, orientation: left, series: [{axisId: dialogflow_cleaned_logs.count,
            id: AcceptedInsurance - dialogflow_cleaned_logs.count, name: AcceptedInsurance},
          {axisId: dialogflow_cleaned_logs.count, id: AcceptInsurance - dialogflow_cleaned_logs.count,
            name: AcceptInsurance}, {axisId: dialogflow_cleaned_logs.count, id: AcceptInsurance
              - fallback - dialogflow_cleaned_logs.count, name: AcceptInsurance -
              fallback}, {axisId: dialogflow_cleaned_logs.count, id: AcceptInsurance
              - no - dialogflow_cleaned_logs.count, name: AcceptInsurance - no}, {
            axisId: dialogflow_cleaned_logs.count, id: AcceptInsurance - yes - dialogflow_cleaned_logs.count,
            name: AcceptInsurance - yes}, {axisId: dialogflow_cleaned_logs.count,
            id: AcceptInsurance - yes - fallback - dialogflow_cleaned_logs.count,
            name: AcceptInsurance - yes - fallback}, {axisId: dialogflow_cleaned_logs.count,
            id: Acknowledge - dialogflow_cleaned_logs.count, name: Acknowledge}, {
            axisId: dialogflow_cleaned_logs.count, id: Acknowledge - fallback - dialogflow_cleaned_logs.count,
            name: Acknowledge - fallback}, {axisId: dialogflow_cleaned_logs.count,
            id: Acknowledge - no - dialogflow_cleaned_logs.count, name: Acknowledge
              - no}, {axisId: dialogflow_cleaned_logs.count, id: Acknowledge - yes
              - dialogflow_cleaned_logs.count, name: Acknowledge - yes}, {axisId: dialogflow_cleaned_logs.count,
            id: Acknowledge - yes - fallback - dialogflow_cleaned_logs.count, name: Acknowledge
              - yes - fallback}, {axisId: dialogflow_cleaned_logs.count, id: AppointmentPsychiatrist
              - dialogflow_cleaned_logs.count, name: AppointmentPsychiatrist}, {axisId: dialogflow_cleaned_logs.count,
            id: AppointmentPsychiatrist - fallback - dialogflow_cleaned_logs.count,
            name: AppointmentPsychiatrist - fallback}, {axisId: dialogflow_cleaned_logs.count,
            id: AppointmentPsychiatrist - no - dialogflow_cleaned_logs.count, name: AppointmentPsychiatrist
              - no}, {axisId: dialogflow_cleaned_logs.count, id: AppointmentPsychiatrist
              - no - fallback - dialogflow_cleaned_logs.count, name: AppointmentPsychiatrist
              - no - fallback}, {axisId: dialogflow_cleaned_logs.count, id: AppointmentPsychiatrist
              - no - yes - dialogflow_cleaned_logs.count, name: AppointmentPsychiatrist
              - no - yes}, {axisId: dialogflow_cleaned_logs.count, id: AppointmentPsychiatrist
              - yes - dialogflow_cleaned_logs.count, name: AppointmentPsychiatrist
              - yes}, {axisId: dialogflow_cleaned_logs.count, id: AppointmentTherapist
              - dialogflow_cleaned_logs.count, name: AppointmentTherapist}, {axisId: dialogflow_cleaned_logs.count,
            id: AppointmentTherapist - fallback - dialogflow_cleaned_logs.count, name: AppointmentTherapist
              - fallback}, {axisId: dialogflow_cleaned_logs.count, id: AppointmentTherapist
              - no - dialogflow_cleaned_logs.count, name: AppointmentTherapist - no},
          {axisId: dialogflow_cleaned_logs.count, id: AppointmentTherapist - yes -
              dialogflow_cleaned_logs.count, name: AppointmentTherapist - yes}, {
            axisId: dialogflow_cleaned_logs.count, id: AppointmentUrgent - dialogflow_cleaned_logs.count,
            name: AppointmentUrgent}, {axisId: dialogflow_cleaned_logs.count, id: AppointmentUrgent
              - fallback - dialogflow_cleaned_logs.count, name: AppointmentUrgent
              - fallback}, {axisId: dialogflow_cleaned_logs.count, id: CheckInsurance
              - dialogflow_cleaned_logs.count, name: CheckInsurance}, {axisId: dialogflow_cleaned_logs.count,
            id: CheckInsurance - fallback - dialogflow_cleaned_logs.count, name: CheckInsurance
              - fallback}, {axisId: dialogflow_cleaned_logs.count, id: CoPay - dialogflow_cleaned_logs.count,
            name: CoPay}, {axisId: dialogflow_cleaned_logs.count, id: CreditCard -
              dialogflow_cleaned_logs.count, name: CreditCard}, {axisId: dialogflow_cleaned_logs.count,
            id: CreditCard - no - dialogflow_cleaned_logs.count, name: CreditCard
              - no}, {axisId: dialogflow_cleaned_logs.count, id: Default Fallback
              Intent - dialogflow_cleaned_logs.count, name: Default Fallback Intent},
          {axisId: dialogflow_cleaned_logs.count, id: Default Fallback Intent - fallback
              - dialogflow_cleaned_logs.count, name: Default Fallback Intent - fallback},
          {axisId: dialogflow_cleaned_logs.count, id: Default Fallback Intent - no
              - dialogflow_cleaned_logs.count, name: Default Fallback Intent - no},
          {axisId: dialogflow_cleaned_logs.count, id: Default Fallback Intent - no
              - fallback - dialogflow_cleaned_logs.count, name: Default Fallback Intent
              - no - fallback}, {axisId: dialogflow_cleaned_logs.count, id: Default
              Fallback Intent - yes - dialogflow_cleaned_logs.count, name: Default
              Fallback Intent - yes}, {axisId: dialogflow_cleaned_logs.count, id: Default
              Welcome Intent - dialogflow_cleaned_logs.count, name: Default Welcome
              Intent}, {axisId: dialogflow_cleaned_logs.count, id: Default Welcome
              Intent - fallback - dialogflow_cleaned_logs.count, name: Default Welcome
              Intent - fallback}, {axisId: dialogflow_cleaned_logs.count, id: FindInsuranceHelpLine
              - dialogflow_cleaned_logs.count, name: FindInsuranceHelpLine}, {axisId: dialogflow_cleaned_logs.count,
            id: FindInsuranceHelpLine - fallback - dialogflow_cleaned_logs.count,
            name: FindInsuranceHelpLine - fallback}, {axisId: dialogflow_cleaned_logs.count,
            id: GetAppointment - dialogflow_cleaned_logs.count, name: GetAppointment},
          {axisId: dialogflow_cleaned_logs.count, id: GetAppointment - fallback -
              dialogflow_cleaned_logs.count, name: GetAppointment - fallback}, {axisId: dialogflow_cleaned_logs.count,
            id: GetMobileNumber - dialogflow_cleaned_logs.count, name: GetMobileNumber},
          {axisId: dialogflow_cleaned_logs.count, id: GetMobileNumber - fallback -
              dialogflow_cleaned_logs.count, name: GetMobileNumber - fallback}, {
            axisId: dialogflow_cleaned_logs.count, id: HaveAccount - dialogflow_cleaned_logs.count,
            name: HaveAccount}, {axisId: dialogflow_cleaned_logs.count, id: LiveAgentTransfer
              - dialogflow_cleaned_logs.count, name: LiveAgentTransfer}, {axisId: dialogflow_cleaned_logs.count,
            id: LiveAgentTransfer - fallback - dialogflow_cleaned_logs.count, name: LiveAgentTransfer
              - fallback}, {axisId: dialogflow_cleaned_logs.count, id: LiveAgentTransfer
              - yes - dialogflow_cleaned_logs.count, name: LiveAgentTransfer - yes},
          {axisId: dialogflow_cleaned_logs.count, id: NoAccount - dialogflow_cleaned_logs.count,
            name: NoAccount}, {axisId: dialogflow_cleaned_logs.count, id: NoAccount
              - fallback - dialogflow_cleaned_logs.count, name: NoAccount - fallback},
          {axisId: dialogflow_cleaned_logs.count, id: NoAccount - no - dialogflow_cleaned_logs.count,
            name: NoAccount - no}, {axisId: dialogflow_cleaned_logs.count, id: NoAccount
              - no - fallback - dialogflow_cleaned_logs.count, name: NoAccount - no
              - fallback}, {axisId: dialogflow_cleaned_logs.count, id: Prescription
              - dialogflow_cleaned_logs.count, name: Prescription}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    x_axis_label: WEEK
    series_types: {}
    series_point_styles:
      dialogflow_cleaned_logs.count: auto
    swap_axes: false
    defaults_version: 1
    hidden_fields: []
    listen:
      Date Date: dialogflow_cleaned_logs.date_date
    row: 76
    col: 0
    width: 24
    height: 14
  - title: Avg Sentiment Vs Call duration
    name: Avg Sentiment Vs Call duration
    model: qai_de_looker_training_qa_minal_badhe
    explore: Session_level_data
    type: looker_column
    fields: [Session_level_data.duration_bucket, Session_level_data.duration_order,
      Session_level_data.avg_sentiment_score]
    sorts: [Session_level_data.duration_order]
    limit: 500
    query_timezone: America/Chicago
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: '', orientation: left, series: [{axisId: Session_level_data.avg_sentiment_score,
            id: Session_level_data.avg_sentiment_score, name: Avg Sentiment Score}],
        showLabels: true, showValues: true, maxValue: 1, minValue: -1, unpinAxis: false,
        tickDensity: custom, tickDensityCustom: 9, type: linear}]
    x_axis_label: Conversation Duration
    series_types: {}
    defaults_version: 1
    hidden_fields: [Session_level_data.duration_order]
    listen:
      Date Date: Session_level_data.date_date
    row: 53
    col: 12
    width: 12
    height: 7
  - title: Total Queries Vs Duration
    name: Total Queries Vs Duration
    model: qai_de_looker_training_qa_minal_badhe
    explore: Session_level_data
    type: looker_column
    fields: [Session_level_data.total_responses, Session_level_data.duration_bucket,
      Session_level_data.duration_order]
    sorts: [Session_level_data.duration_order]
    limit: 500
    query_timezone: America/Chicago
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: Total Queries, orientation: left, series: [{axisId: Session_level_data.total_responses,
            id: Session_level_data.total_responses, name: Total Responses}], showLabels: true,
        showValues: true, unpinAxis: false, tickDensity: default, tickDensityCustom: 5,
        type: linear}]
    x_axis_label: Duration
    series_types: {}
    defaults_version: 1
    hidden_fields: [Session_level_data.duration_order]
    listen:
      Date Date: Session_level_data.date_date
    row: 70
    col: 0
    width: 12
    height: 6
  - title: Session Distribution Vs Call Deflection
    name: Session Distribution Vs Call Deflection
    model: qai_de_looker_training_qa_minal_badhe
    explore: dialogflow_cleaned_logs
    type: looker_column
    fields: [session_distribution.Session_Distribution, no_of_sessions]
    sorts: [no_of_sessions desc]
    limit: 500
    dynamic_fields: [{category: measure, expression: !!null '', label: No of Sessions,
        value_format: !!null '', value_format_name: !!null '', based_on: dialogflow_cleaned_logs.session_id,
        _kind_hint: measure, measure: no_of_sessions, type: count_distinct, _type_hint: number}]
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    series_types: {}
    defaults_version: 1
    listen:
      Date Date: dialogflow_cleaned_logs.date_date
    row: 10
    col: 0
    width: 12
    height: 6
  - title: Deflection Rate
    name: Deflection Rate
    model: qai_de_looker_training_qa_minal_badhe
    explore: dialogflow_cleaned_logs
    type: looker_pie
    fields: [session_distribution.Deflection_Rate, total_sessions]
    sorts: [total_sessions desc]
    limit: 500
    dynamic_fields: [{category: measure, expression: !!null '', label: Total Sessions,
        value_format: !!null '', value_format_name: !!null '', based_on: dialogflow_cleaned_logs.session_id,
        _kind_hint: measure, measure: total_sessions, type: count_distinct, _type_hint: number}]
    value_labels: legend
    label_type: labPer
    series_types: {}
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    listen:
      Date Date: dialogflow_cleaned_logs.date_date
    row: 10
    col: 12
    width: 12
    height: 6
  - title: Intent Co Occurence
    name: Intent Co Occurence
    model: qai_de_looker_training_qa_minal_badhe
    explore: dialogflow_cleaned_logs
    type: looker_column
    fields: [intent_co_occurence.intent_triggered, dialogflow_cleaned_logs.intent_triggered,
      dialogflow_cleaned_logs.count]
    pivots: [intent_co_occurence.intent_triggered]
    sorts: [intent_co_occurence.intent_triggered, dialogflow_cleaned_logs.intent_triggered]
    limit: 500
    query_timezone: America/Chicago
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: normal
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: true
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    y_axes: [{label: Frequency, orientation: left, series: [{axisId: AcceptedInsurance
              - dialogflow_cleaned_logs.count, id: AcceptedInsurance - dialogflow_cleaned_logs.count,
            name: AcceptedInsurance}, {axisId: AcceptInsurance - dialogflow_cleaned_logs.count,
            id: AcceptInsurance - dialogflow_cleaned_logs.count, name: AcceptInsurance},
          {axisId: AcceptInsurance - fallback - dialogflow_cleaned_logs.count, id: AcceptInsurance
              - fallback - dialogflow_cleaned_logs.count, name: AcceptInsurance -
              fallback}, {axisId: AcceptInsurance - no - dialogflow_cleaned_logs.count,
            id: AcceptInsurance - no - dialogflow_cleaned_logs.count, name: AcceptInsurance
              - no}, {axisId: AcceptInsurance - yes - dialogflow_cleaned_logs.count,
            id: AcceptInsurance - yes - dialogflow_cleaned_logs.count, name: AcceptInsurance
              - yes}, {axisId: AcceptInsurance - yes - fallback - dialogflow_cleaned_logs.count,
            id: AcceptInsurance - yes - fallback - dialogflow_cleaned_logs.count,
            name: AcceptInsurance - yes - fallback}, {axisId: Acknowledge - dialogflow_cleaned_logs.count,
            id: Acknowledge - dialogflow_cleaned_logs.count, name: Acknowledge}, {
            axisId: Acknowledge - fallback - dialogflow_cleaned_logs.count, id: Acknowledge
              - fallback - dialogflow_cleaned_logs.count, name: Acknowledge - fallback},
          {axisId: Acknowledge - no - dialogflow_cleaned_logs.count, id: Acknowledge
              - no - dialogflow_cleaned_logs.count, name: Acknowledge - no}, {axisId: Acknowledge
              - yes - dialogflow_cleaned_logs.count, id: Acknowledge - yes - dialogflow_cleaned_logs.count,
            name: Acknowledge - yes}, {axisId: Acknowledge - yes - fallback - dialogflow_cleaned_logs.count,
            id: Acknowledge - yes - fallback - dialogflow_cleaned_logs.count, name: Acknowledge
              - yes - fallback}, {axisId: AppointmentPsychiatrist - dialogflow_cleaned_logs.count,
            id: AppointmentPsychiatrist - dialogflow_cleaned_logs.count, name: AppointmentPsychiatrist},
          {axisId: AppointmentPsychiatrist - fallback - dialogflow_cleaned_logs.count,
            id: AppointmentPsychiatrist - fallback - dialogflow_cleaned_logs.count,
            name: AppointmentPsychiatrist - fallback}, {axisId: AppointmentPsychiatrist
              - no - dialogflow_cleaned_logs.count, id: AppointmentPsychiatrist -
              no - dialogflow_cleaned_logs.count, name: AppointmentPsychiatrist -
              no}, {axisId: AppointmentPsychiatrist - no - fallback - dialogflow_cleaned_logs.count,
            id: AppointmentPsychiatrist - no - fallback - dialogflow_cleaned_logs.count,
            name: AppointmentPsychiatrist - no - fallback}, {axisId: AppointmentPsychiatrist
              - no - yes - dialogflow_cleaned_logs.count, id: AppointmentPsychiatrist
              - no - yes - dialogflow_cleaned_logs.count, name: AppointmentPsychiatrist
              - no - yes}, {axisId: AppointmentPsychiatrist - yes - dialogflow_cleaned_logs.count,
            id: AppointmentPsychiatrist - yes - dialogflow_cleaned_logs.count, name: AppointmentPsychiatrist
              - yes}, {axisId: AppointmentTherapist - dialogflow_cleaned_logs.count,
            id: AppointmentTherapist - dialogflow_cleaned_logs.count, name: AppointmentTherapist},
          {axisId: AppointmentTherapist - fallback - dialogflow_cleaned_logs.count,
            id: AppointmentTherapist - fallback - dialogflow_cleaned_logs.count, name: AppointmentTherapist
              - fallback}, {axisId: AppointmentTherapist - no - dialogflow_cleaned_logs.count,
            id: AppointmentTherapist - no - dialogflow_cleaned_logs.count, name: AppointmentTherapist
              - no}, {axisId: AppointmentTherapist - yes - dialogflow_cleaned_logs.count,
            id: AppointmentTherapist - yes - dialogflow_cleaned_logs.count, name: AppointmentTherapist
              - yes}, {axisId: AppointmentUrgent - dialogflow_cleaned_logs.count,
            id: AppointmentUrgent - dialogflow_cleaned_logs.count, name: AppointmentUrgent},
          {axisId: AppointmentUrgent - fallback - dialogflow_cleaned_logs.count, id: AppointmentUrgent
              - fallback - dialogflow_cleaned_logs.count, name: AppointmentUrgent
              - fallback}, {axisId: CheckInsurance - dialogflow_cleaned_logs.count,
            id: CheckInsurance - dialogflow_cleaned_logs.count, name: CheckInsurance},
          {axisId: CheckInsurance - fallback - dialogflow_cleaned_logs.count, id: CheckInsurance
              - fallback - dialogflow_cleaned_logs.count, name: CheckInsurance - fallback},
          {axisId: CoPay - dialogflow_cleaned_logs.count, id: CoPay - dialogflow_cleaned_logs.count,
            name: CoPay}, {axisId: CreditCard - dialogflow_cleaned_logs.count, id: CreditCard
              - dialogflow_cleaned_logs.count, name: CreditCard}, {axisId: CreditCard
              - no - dialogflow_cleaned_logs.count, id: CreditCard - no - dialogflow_cleaned_logs.count,
            name: CreditCard - no}, {axisId: Default Fallback Intent - dialogflow_cleaned_logs.count,
            id: Default Fallback Intent - dialogflow_cleaned_logs.count, name: Default
              Fallback Intent}, {axisId: Default Fallback Intent - fallback - dialogflow_cleaned_logs.count,
            id: Default Fallback Intent - fallback - dialogflow_cleaned_logs.count,
            name: Default Fallback Intent - fallback}, {axisId: Default Fallback Intent
              - no - dialogflow_cleaned_logs.count, id: Default Fallback Intent -
              no - dialogflow_cleaned_logs.count, name: Default Fallback Intent -
              no}, {axisId: Default Fallback Intent - no - fallback - dialogflow_cleaned_logs.count,
            id: Default Fallback Intent - no - fallback - dialogflow_cleaned_logs.count,
            name: Default Fallback Intent - no - fallback}, {axisId: Default Fallback
              Intent - yes - dialogflow_cleaned_logs.count, id: Default Fallback Intent
              - yes - dialogflow_cleaned_logs.count, name: Default Fallback Intent
              - yes}, {axisId: Default Welcome Intent - dialogflow_cleaned_logs.count,
            id: Default Welcome Intent - dialogflow_cleaned_logs.count, name: Default
              Welcome Intent}, {axisId: Default Welcome Intent - fallback - dialogflow_cleaned_logs.count,
            id: Default Welcome Intent - fallback - dialogflow_cleaned_logs.count,
            name: Default Welcome Intent - fallback}, {axisId: FindInsuranceHelpLine
              - dialogflow_cleaned_logs.count, id: FindInsuranceHelpLine - dialogflow_cleaned_logs.count,
            name: FindInsuranceHelpLine}, {axisId: FindInsuranceHelpLine - fallback
              - dialogflow_cleaned_logs.count, id: FindInsuranceHelpLine - fallback
              - dialogflow_cleaned_logs.count, name: FindInsuranceHelpLine - fallback},
          {axisId: GetAppointment - dialogflow_cleaned_logs.count, id: GetAppointment
              - dialogflow_cleaned_logs.count, name: GetAppointment}, {axisId: GetAppointment
              - fallback - dialogflow_cleaned_logs.count, id: GetAppointment - fallback
              - dialogflow_cleaned_logs.count, name: GetAppointment - fallback}, {
            axisId: GetMobileNumber - dialogflow_cleaned_logs.count, id: GetMobileNumber
              - dialogflow_cleaned_logs.count, name: GetMobileNumber}, {axisId: GetMobileNumber
              - fallback - dialogflow_cleaned_logs.count, id: GetMobileNumber - fallback
              - dialogflow_cleaned_logs.count, name: GetMobileNumber - fallback},
          {axisId: HaveAccount - dialogflow_cleaned_logs.count, id: HaveAccount -
              dialogflow_cleaned_logs.count, name: HaveAccount}, {axisId: LiveAgentTransfer
              - dialogflow_cleaned_logs.count, id: LiveAgentTransfer - dialogflow_cleaned_logs.count,
            name: LiveAgentTransfer}, {axisId: LiveAgentTransfer - fallback - dialogflow_cleaned_logs.count,
            id: LiveAgentTransfer - fallback - dialogflow_cleaned_logs.count, name: LiveAgentTransfer
              - fallback}, {axisId: LiveAgentTransfer - yes - dialogflow_cleaned_logs.count,
            id: LiveAgentTransfer - yes - dialogflow_cleaned_logs.count, name: LiveAgentTransfer
              - yes}, {axisId: NoAccount - dialogflow_cleaned_logs.count, id: NoAccount
              - dialogflow_cleaned_logs.count, name: NoAccount}, {axisId: NoAccount
              - fallback - dialogflow_cleaned_logs.count, id: NoAccount - fallback
              - dialogflow_cleaned_logs.count, name: NoAccount - fallback}, {axisId: NoAccount
              - no - dialogflow_cleaned_logs.count, id: NoAccount - no - dialogflow_cleaned_logs.count,
            name: NoAccount - no}, {axisId: NoAccount - no - fallback - dialogflow_cleaned_logs.count,
            id: NoAccount - no - fallback - dialogflow_cleaned_logs.count, name: NoAccount
              - no - fallback}, {axisId: Prescription - dialogflow_cleaned_logs.count,
            id: Prescription - dialogflow_cleaned_logs.count, name: Prescription}],
        showLabels: true, showValues: true, unpinAxis: false, tickDensity: default,
        tickDensityCustom: 5, type: linear}]
    x_axis_label: Intents
    series_types: {}
    defaults_version: 1
    listen:
      Date Date: dialogflow_cleaned_logs.date_date
    row: 90
    col: 0
    width: 24
    height: 16
  - title: Busiest Hours
    name: Busiest Hours
    model: qai_de_looker_training_qa_minal_badhe
    explore: Session_level_data
    type: looker_funnel
    fields: [Session_level_data.count_session_id, Session_level_data.one_Hour_frame_case]
    sorts: [Session_level_data.count_session_id desc]
    limit: 500
    query_timezone: America/Chicago
    leftAxisLabelVisible: false
    leftAxisLabel: ''
    rightAxisLabelVisible: false
    rightAxisLabel: ''
    smoothedBars: false
    orientation: automatic
    labelPosition: right
    percentType: total
    percentPosition: hidden
    valuePosition: Hidden
    labelColorEnabled: false
    labelColor: "#FFF"
    color_application:
      collection_id: b43731d5-dc87-4a8e-b807-635bef3948e7
      palette_id: 85de97da-2ded-4dec-9dbd-e6a7d36d5825
      options:
        steps: 5
        reverse: true
    isStepped: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    series_types: {}
    listen:
      Date Date: Session_level_data.date_date
    row: 2
    col: 10
    width: 14
    height: 8
  filters:
  - name: Intent
    title: Intent
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
      options: []
    model: qai_de_looker_training_qa_minal_badhe
    explore: dialogflow_cleaned_logs
    listens_to_filters: []
    field: dialogflow_cleaned_logs.intent_triggered
  - name: Date Date
    title: Date Date
    type: field_filter
    default_value: 7 day
    allow_multiple_values: true
    required: false
    ui_config:
      type: relative_timeframes
      display: inline
      options: []
    model: qai_de_looker_training_qa_minal_badhe
    explore: dialogflow_cleaned_logs
    listens_to_filters: []
    field: dialogflow_cleaned_logs.date_date

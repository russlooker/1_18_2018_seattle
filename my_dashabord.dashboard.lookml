- dashboard: brand_summary
  title: Brand Summary
  layout: newspaper
  elements:
  - title: Profit Report
    name: Profit Report
    model: 1_18_training_seattle
    explore: order_items
    type: looker_column
    fields:
    - order_items.average_profit
    - products.brand
    sorts:
    - order_items.average_profit desc
    limit: 500
    query_timezone: America/Los_Angeles
    stacking: ''
    show_value_labels: false
    label_density: 25
    legend_position: center
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    limit_displayed_rows: false
    y_axis_combined: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    y_axis_scale_mode: linear
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    row: 0
    col: 0
    width: 24
    height: 6

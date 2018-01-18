view: user_order_facts {
  derived_table: {
    sql: SELECT
        u.id,
        sum(OI.sale_price) lifetime_revenue
      FROM
        public.users U
        LEFT JOIN public.order_items OI ON (U.id = OI.user_id)
      GROUP BY 1
       ;;
#     persist_for: "24 hours"
    datagroup_trigger: nightly_etl
    distribution_style: even
    sortkeys: ["id"]
#     sql_trigger_value:  select current_date ;;

  }

#       --WHERE
#        -- {% condition lifetime_value_date_range %} OI.created_at {% endcondition %}


  filter: lifetime_value_date_range {
    view_label: "Ordering Users"
    label: "Lifetime Orders Range"
    type: date_time
  }


  dimension: id {
    primary_key: yes
    type: string
    hidden: yes
    sql: ${TABLE}.id ;;
  }

  dimension: lifetime_revenue {
    hidden: yes
    type: string
    sql: ${TABLE}.lifetime_revenue ;;
  }

  measure: average_lifetime_revenue {
    view_label: "Ordering Users"
    description: "Calculates the total lifetime order value (doesn't subtract returns)"
    type: average
    sql:  ${lifetime_revenue} ;;
    value_format_name: usd
  }


  set: detail {
    fields: [id, lifetime_revenue]
  }
}

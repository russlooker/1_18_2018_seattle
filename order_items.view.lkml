view: order_items {
  sql_table_name: public.order_items ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year,
      day_of_week
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: delivered {
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
    sql: ${TABLE}.delivered_at ;;
  }

  dimension: inventory_item_id {
    type: number
    hidden: yes
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
  }

  dimension_group: returned {
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
    sql: ${TABLE}.returned_at ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price * 1.10;;
    value_format_name: usd
  }


  dimension: profit {
    type: number
    sql: ${sale_price} - ${inventory_items.cost} ;;
#     value_format: ""
    value_format_name: usd
  }


  dimension_group: shipped {
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
    sql: ${TABLE}.shipped_at ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: total_sale_price {
    type: sum
    sql: ${sale_price} ;;
  }

  measure: total_profit {
    type: sum
    sql: ${profit} ;;
    value_format_name: usd
  }

  measure: total_profit_over_21 {
    type: sum
    sql:
    CASE WHEN ${users.can_drink} THEN ${profit}
    ELSE 0
    END
     ;;
    value_format_name: usd
#     filters: {
#       field: users.age
#       value: ">21"
#     }

  }



  measure: average_profit {
    type: average
    sql: ${profit} ;;
  }




  measure: alternative_total_profit {
    type: number
    sql:
        ${total_sale_price} - ${inventory_items.total_cost}
    ;;
    value_format_name: usd
  }

  measure: alternative_average_profit {
    type: number
    sql:  sum(${TABLE}.sale_price - ${inventory_items.cost}) * 1.0 / nullif(${count},0) ;;
  }


  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
      id,
      inventory_items.id,
      inventory_items.product_name,
      users.id,
      users.last_name,
      users.first_name
    ]
  }
}

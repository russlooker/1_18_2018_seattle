view: order_totals {
  derived_table: {
    sql: SELECT
        COALESCE(SUM(((order_items.sale_price * 1.11) - inventory_items.cost) ), 0) AS "order_items.total_profit",
        COALESCE(SUM(CASE WHEN (users.age >= 23) THEN ((order_items.sale_price * 1.10) - inventory_items.cost)
          ELSE 0
          END
           ), 0) AS "order_items.total_profit_over_23"
      FROM public.order_items  AS order_items
      LEFT JOIN public.inventory_items  AS inventory_items ON order_items.inventory_item_id = inventory_items.id
      LEFT JOIN public.users  AS users ON order_items.user_id = users.id
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: order_items_total_profit {
    type: string
    sql: ${TABLE}."order_items.total_profit" ;;
  }

  dimension: order_items_total_profit_over_23 {
    type: string
    sql: ${TABLE}."order_items.total_profit_over_23" ;;
  }

  set: detail {
    fields: [order_items_total_profit, order_items_total_profit_over_23]
  }
}

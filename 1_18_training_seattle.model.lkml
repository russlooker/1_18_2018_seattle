connection: "events_ecommerce"

include: "*.view.lkml"         # include all views in this project
include: "*.dashboard.lookml"  # include all dashboards in this project



named_value_format: my_custom_format {
  value_format: "0.00"
}

datagroup: nightly_etl {
  sql_trigger: select current_date ;;
  max_cache_age: "24 hours"
}


# My nice comment

explore: order_items {
  access_filter: {
    field: products.brand
    user_attribute: retailer_id
  }

  persist_with: nightly_etl
  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: one_to_one
  }

  join: products {
    type: left_outer
    sql:  ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: users {
    type: left_outer
    sql_on: ${order_items.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

  join: user_order_facts {
    type: left_outer
    sql_on: ${users.id} = ${user_order_facts.id} ;;
    relationship: one_to_one
  }

  join: ndt_user_order_facts {
    type: left_outer
    sql_on:  ${users.id} = ${ndt_user_order_facts.id} ;;
    relationship: one_to_one
  }

}


explore: events {}



# explore: user_order_facts {}

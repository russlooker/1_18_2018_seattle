view: users {
  sql_table_name: public.users ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: age_tier {
    label: "(Demographics -- Age Group)"
    sql: ${age} ;;
    type: tier
    tiers: [0,10,20,30,40,50,100, 150]
    style: integer
  }

  dimension: can_drink {
   label: "Can Drink......legally"
   sql: ${age} >= 23 ;;
   type: yesno
  }


  dimension: city {
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
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
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
    link: {
      url: "/dashboards/880?user_id={{ id._value }}"
      label: "Go To User Web Activity"
      icon_url: "http://looker.com/favicon.ico"
    }
  }

  filter: user_email_selector {
    type: string
    suggest_dimension: users.email
  }

  dimension: user_comparison {
    type: string
    sql:
      CASE WHEN {% condition user_email_selector %} ${email} {% endcondition %} then 'Comparison Group'
      else 'Rest of Population'
      END

    ;;
  }




  dimension: first_name {
    type: string
    sql:
    {% if last_name._in_query  %}
      'Name Hidden'
    {% else %}
    ${TABLE}.first_name
    {% endif %}
    ;;

  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
  }

  dimension: latitude {
    type: number
    sql: ${TABLE}.latitude ;;
  }

  dimension: longitude {
    type: number
    sql: ${TABLE}.longitude ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  dimension: traffic_source {
    type: string
    sql: ${TABLE}.traffic_source ;;
  }

  dimension: zip {
    type: zipcode
    sql: ${TABLE}.zip ;;
  }

  measure: count {
    type: count
    drill_fields: [id, last_name, first_name, events.count, order_items.count]
  }
}

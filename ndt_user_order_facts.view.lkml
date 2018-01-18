view: ndt_user_order_facts {
    derived_table: {
      explore_source: order_items {
        column: total_sale_price {}
        column: id { field: users.id }
      }
      distribution_style: even
      datagroup_trigger: nightly_etl
      sortkeys: ["id"]
    }
    dimension: total_sale_price {
      type: number
    }
    dimension: id {
      type: number
      primary_key: yes
    }

    measure: average_lifetime_value {
      type: average
      sql:

      ${total_sale_price} ;;
      value_format_name: usd
      html:
        {% if value >= 100 %}
        <p style='color:green;' > {{rendered_value}}</p>
        {% else %}
        <p style='color:red;' > {{rendered_value}}</p>
        {% endif %}
      ;;
    }

  }

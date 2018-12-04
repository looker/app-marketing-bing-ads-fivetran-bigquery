view: bing_account {
  extends: [bing_ads_config]
  sql_table_name: {{ bing_ads_schema._sql }}.account_history ;;

  dimension: account_id {
    type: string
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.id ;;
  }

  dimension: _date {
    type: date
    sql: ${TABLE}.last_modified_time ;;
    hidden: yes
  }

  dimension: account_name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: account_number {
    type: string
    sql: ${TABLE}.number ;;
    hidden: yes
  }

  dimension: account_status {
    type: string
    sql: ${TABLE}.account_financial_status ;;
  }
}

explore: bing_account_join {
  extension: required

  join: account {
    from: bing_account
    view_label: "Account"
    sql_on: ${fact.account_id} = ${account.account_id} AND
      ${fact._date} = ${account._date} ;;
    relationship: many_to_one
  }
}

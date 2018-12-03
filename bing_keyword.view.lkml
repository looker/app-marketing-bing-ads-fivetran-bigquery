view: bing_keyword {
  extends: [bing_ads_config]
  sql_table_name: {{ bing_ads_schema._sql }}.keyword_history ;;

  dimension: ad_group_id {
    type: string
    hidden: yes
  }

  dimension: keyword_id {
    type: string
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.id ;;
  }

  dimension: _date {
    type: date
    sql: ${TABLE}.modified_time ;;
    hidden: yes
  }

  dimension: keyword {
    type: string
    hidden: no
    sql: ${TABLE}.name ;;
  }

  dimension: keyword_status {
    type: string
    hidden: yes
    sql: ${TABLE}.status ;;
  }

  dimension: bid_strategy_type {
    type: string
  }

  dimension: destination_url {
    type: string
  }

  dimension: final_url {
    type: string
  }

}

explore: bing_keyword_join {
  extension: required

  join: keyword {
    from: bing_keyword
    view_label: "Keyword"
    sql_on: ${fact.keyword_id} = ${keyword.keyword_id} AND
      ${fact.ad_group_id} = ${keyword.ad_group_id} AND
      ${fact._date} = ${keyword._date} ;;
    relationship: many_to_one
  }
}

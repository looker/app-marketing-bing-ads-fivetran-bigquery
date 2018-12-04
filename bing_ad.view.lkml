view: bing_ad {
  extends: [bing_ads_config]
  sql_table_name: {{ bing_ads_schema._sql }}.ad_history ;;

  dimension: ad_group_id {
    type: string
    hidden: yes
  }

  dimension: ad_id {
    type: string
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.id ;;
  }

  dimension: _date {
    type: date
    sql: ${TABLE}.modified_time ;;
  }

  dimension: text {
    type: string
    hidden: no
  }

  dimension: status {
    type: string
    hidden: no
  }

  dimension: type {
    type: string
    hidden: yes
  }

  dimension: title {
    type: string
    group_label: "Title"
  }

  dimension: title_part_1 {
    type: string
    group_label: "Title"
  }

  dimension: title_part_2 {
    type: string
    group_label: "Title"
  }

  dimension: ad_status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: path_1 {
    type: string
  }

  dimension: path_2 {
    type: string
  }

  dimension: display_url {
    type: string
  }
}

explore: bing_ad_join {
  extension: required

  join: ad {
    from: bing_ad
    view_label: "Ads"
    sql_on: ${fact.ad_id} = ${ad.ad_id} AND
      ${fact.ad_group_id} = ${ad.ad_group_id} AND
      ${fact._date} = ${ad._date} ;;
    relationship:  many_to_one
  }
}

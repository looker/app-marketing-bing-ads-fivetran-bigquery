view: bing_ad_group {
  extends: [bing_ads_config]
  sql_table_name: {{ bing_ads_schema._sql }}.ad_group_history ;;

  dimension: campaign_id {
    type: string
    hidden: yes
  }

  dimension: account_id {
    type: string
    hidden:  yes
  }

  dimension: ad_group_id {
    type: string
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.id ;;
  }

  dimension: _date {
    type: date
    sql: ${TABLE}.modified_time ;;
    hidden:  yes
  }

  dimension: ad_group_name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: ad_group_status {
    type: string
    sql: ${TABLE}.status ;;
  }
}

explore: bing_ad_group_join {
  extension: required

  join: ad_group {
    from: bing_ad_group
    view_label: "Ad Group"
    sql_on: ${fact.ad_group_id} = ${ad_group.ad_group_id} AND
      ${fact.campaign_id} = ${ad_group.campaign_id} AND
      ${fact._date} = ${ad_group._date} ;;
    relationship: many_to_one
  }
}

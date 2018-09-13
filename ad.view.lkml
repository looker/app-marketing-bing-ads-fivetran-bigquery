include: "ad_group.view"

explore: ad_join {
  extension: required

  join: ad {
    from: ad_adapter
    view_label: "Ads"
    sql_on: ${fact.ad_id} = ${ad.ad_id} AND
      ${fact.ad_group_id} = ${ad.ad_group_id} AND
      ${fact.campaign_id} = ${ad.campaign_id} AND
      ${fact.account_id} = ${ad.account_id} AND
      ${fact._date} = ${ad._date} ;;
    relationship:  many_to_one
  }
}

explore: ad_adapter {
  persist_with: adwords_etl_datagroup
  from: ad_adapter
  view_name: ad
  hidden: yes

  join: ad_group {
    from: ad_group_adapter
    view_label: "Ad Group"
    sql_on: ${ad.ad_group_id} = ${ad_group.ad_group_id} AND
      ${ad.campaign_id} = ${ad_group.campaign_id} AND
      ${ad.account_id} = ${ad_group.account_id} AND
      ${ad._date} = ${ad_group._date};;
    relationship: many_to_one
  }
  join: campaign {
    from: campaign_adapter
    view_label: "Campaign"
    sql_on: ${ad.campaign_id} = ${campaign.campaign_id} AND
      ${ad.account_id} = ${campaign.account_id} AND
      ${ad._date} = ${campaign._date};;
    relationship: many_to_one
  }
  join: account {
    from: account_adapter
    view_label: "Customer"
    sql_on: ${ad.account_id} = ${account.account_id} AND
      ${ad._date} = ${account._date} ;;
    relationship: many_to_one
  }
}

view: ad_adapter {
  extends: [bingads_config, bingads_base]
  sql_table_name: {{ ad.bingads_schema._sql }}.ad_stats ;;

  dimension: _fivetran_id {
    type: number
    sql: ${TABLE}._fivetran_id ;;
  }

  dimension_group: _fivetran_synced {
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
    sql: ${TABLE}._fivetran_synced ;;
  }

  dimension: account_id {
    type: number
    sql: ${TABLE}.account_id ;;
  }

  dimension: account_name {
    type: string
    sql: ${TABLE}.account_name ;;
  }

  dimension: account_status {
    type: string
    sql: ${TABLE}.account_status ;;
  }

  dimension: ad_description {
    type: string
    sql: ${TABLE}.ad_description ;;
  }

  dimension: ad_distribution {
    type: string
    sql: ${TABLE}.ad_distribution ;;
  }

  dimension: ad_group_id {
    type: number
    sql: ${TABLE}.ad_group_id ;;
  }

  dimension: ad_group_name {
    type: string
    sql: ${TABLE}.ad_group_name ;;
  }

  dimension: ad_group_status {
    type: string
    sql: ${TABLE}.ad_group_status ;;
  }

  dimension: ad_id {
    type: number
    sql: ${TABLE}.ad_id ;;
  }

  dimension: ad_status {
    type: string
    sql: ${TABLE}.ad_status ;;
  }

  dimension: ad_title {
    type: string
    sql: ${TABLE}.ad_title ;;
  }

  dimension: ad_type {
    type: string
    sql: ${TABLE}.ad_type ;;
  }

  dimension: assists {
    type: number
    sql: ${TABLE}.assists ;;
  }

  dimension: average_position {
    type: number
    sql: ${TABLE}.average_position ;;
  }

  dimension: bid_match_type {
    type: string
    sql: ${TABLE}.bid_match_type ;;
  }

  dimension: campaign_id {
    type: number
    sql: ${TABLE}.campaign_id ;;
  }

  dimension: campaign_name {
    type: string
    sql: ${TABLE}.campaign_name ;;
  }

  dimension: campaign_status {
    type: string
    sql: ${TABLE}.campaign_status ;;
  }

  dimension: clicks {
    type: number
    sql: ${TABLE}.clicks ;;
  }

  dimension: conversions {
    type: number
    sql: ${TABLE}.conversions ;;
  }

  dimension: delivered_match_type {
    type: string
    sql: ${TABLE}.delivered_match_type ;;
  }

  dimension: destination_url {
    type: string
    sql: ${TABLE}.destination_url ;;
  }

  dimension: device_os {
    type: string
    sql: ${TABLE}.device_os ;;
  }

  dimension: device_type {
    type: string
    sql: ${TABLE}.device_type ;;
  }

  dimension: display_url {
    type: string
    sql: ${TABLE}.display_url ;;
  }

  dimension: final_url {
    type: string
    sql: ${TABLE}.final_url ;;
  }

  dimension_group: gregorian {
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
    sql: ${TABLE}.gregorian_date ;;
  }

  dimension: impressions {
    type: number
    sql: ${TABLE}.impressions ;;
  }

  dimension: language {
    type: string
    sql: ${TABLE}.language ;;
  }

  dimension: network {
    type: string
    sql: ${TABLE}.network ;;
  }

  dimension: path_1 {
    type: string
    sql: ${TABLE}.path_1 ;;
  }

  dimension: path_2 {
    type: string
    sql: ${TABLE}.path_2 ;;
  }

  dimension: revenue {
    type: number
    sql: ${TABLE}.revenue ;;
  }

  dimension: spend {
    type: number
    sql: ${TABLE}.spend ;;
  }

  dimension: title_part_1 {
    type: string
    sql: ${TABLE}.title_part_1 ;;
  }

  dimension: title_part_2 {
    type: string
    sql: ${TABLE}.title_part_2 ;;
  }

  dimension: top_vs_other {
    type: string
    sql: ${TABLE}.top_vs_other ;;
  }


}

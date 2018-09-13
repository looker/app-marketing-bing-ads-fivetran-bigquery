include: "ad_group.view"
include: "bingads_base.view"

explore: keyword_join {
  extension: required

  join: keyword {
    from: keyword_adapter
    view_label: "Keyword"
    sql_on: ${fact.criterion_id} = ${keyword.criterion_id} AND
      ${fact.ad_group_id} = ${keyword.ad_group_id} AND
      ${fact.campaign_id} = ${keyword.campaign_id} AND
      ${fact.account_id} = ${keyword.account_id} AND
      ${fact._date} = ${keyword._date} ;;
    relationship: many_to_one
  }
}

explore: keyword_adapter {
  persist_with: adwords_etl_datagroup
  from: keyword_adapter
  view_name: keyword
  hidden: yes

  join: ad_group {
    from: ad_group_adapter
    view_label: "Ad Groups"
    sql_on: ${keyword.ad_group_id} = ${ad_group.ad_group_id} AND
      ${keyword.campaign_id} = ${ad_group.campaign_id} AND
      ${keyword.account_id} = ${ad_group.account_id} AND
      ${keyword._date} = ${ad_group._date} ;;
    relationship: many_to_one
  }
  join: campaign {
    from: campaign_adapter
    view_label: "Campaign"
    sql_on: ${keyword.campaign_id} = ${campaign.campaign_id} AND
      ${keyword.account_id} = ${campaign.account_id} AND
      ${keyword._date} = ${campaign._date};;
    relationship: many_to_one
  }
  join: account {
    from: account_adapter
    view_label: "Account"
    sql_on: ${keyword.account_id} = ${account.account_id} AND
      ${keyword._date} = ${account._date} ;;
    relationship: many_to_one
  }
}

view: keyword_adapter {
#    extends: [bingads_config, bingads_base]
  extends: [ bingads_base]
  sql_table_name: {{ keyword.bingads_schema._sql }}.keyword_stats ;;

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

  dimension: ad_relevance {
    type: number
    sql: ${TABLE}.ad_relevance ;;
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

  dimension: bid_strategy_type {
    type: string
    sql: ${TABLE}.bid_strategy_type ;;
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

  dimension: currency_code {
    type: string
    sql: ${TABLE}.currency_code ;;
  }

  dimension: current_max_cpc {
    type: number
    sql: ${TABLE}.current_max_cpc ;;
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

  dimension: expected_ctr {
    type: number
    sql: ${TABLE}.expected_ctr ;;
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

  dimension: keyword {
    type: string
    sql: ${TABLE}.keyword ;;
  }

  dimension: keyword_id {
    type: number
    sql: ${TABLE}.keyword_id ;;
  }

  dimension: keyword_status {
    type: string
    sql: ${TABLE}.keyword_status ;;
  }

  dimension: landing_page_experience {
    type: number
    sql: ${TABLE}.landing_page_experience ;;
  }

  dimension: language {
    type: string
    sql: ${TABLE}.language ;;
  }

  dimension: network {
    type: string
    sql: ${TABLE}.network ;;
  }

  dimension: quality_impact {
    type: number
    sql: ${TABLE}.quality_impact ;;
  }

  dimension: quality_score {
    type: number
    sql: ${TABLE}.quality_score ;;
  }

  dimension: revenue {
    type: number
    sql: ${TABLE}.revenue ;;
  }

  dimension: spend {
    type: number
    sql: ${TABLE}.spend ;;
  }

  dimension: top_vs_other {
    type: string
    sql: ${TABLE}.top_vs_other ;;
  }

}

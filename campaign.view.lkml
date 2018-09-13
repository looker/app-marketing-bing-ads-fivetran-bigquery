include: "account.view"
include: "bingads_base.view"

explore: campaign_join {
  extension: required

  join: campaign {
    from: campaign_adapter
    view_label: "Campaign"
    sql_on: ${fact.campaign_id} = ${campaign.campaign_id} AND
      ${fact.account_id} = ${campaign.account_id} AND
      ${fact._date} = ${campaign._date} ;;
    relationship: many_to_one
  }
}

explore: campaign_adapter {
  persist_with: adwords_etl_datagroup
  from: campaign_adapter
  view_name: campaign
  hidden: yes

  join: account {
    from: account_adapter
    view_label: "Account"
    sql_on: ${campaign.account_id} = ${account.account_id} AND
      ${campaign._date} = ${account._date} ;;
    relationship: many_to_one
  }
}

view: campaign_adapter {
#    extends: [bingads_config, bingads_base]
  extends: [ bingads_base]
   sql_table_name: {{ campaign.bingads_schema._sql }}.campaign_stats ;;


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

dimension: click_calls {
  type: number
  sql: ${TABLE}.click_calls ;;
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

dimension: device_os {
  type: string
  sql: ${TABLE}.device_os ;;
}

dimension: device_type {
  type: string
  sql: ${TABLE}.device_type ;;
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

dimension: low_quality_clicks {
  type: number
  sql: ${TABLE}.low_quality_clicks ;;
}

dimension: low_quality_conversions {
  type: number
  sql: ${TABLE}.low_quality_conversions ;;
}

dimension: low_quality_general_clicks {
  type: number
  sql: ${TABLE}.low_quality_general_clicks ;;
}

dimension: low_quality_impressions {
  type: number
  sql: ${TABLE}.low_quality_impressions ;;
}

dimension: low_quality_sophisticated_clicks {
  type: number
  sql: ${TABLE}.low_quality_sophisticated_clicks ;;
}

dimension: manual_calls {
  type: number
  sql: ${TABLE}.manual_calls ;;
}

dimension: network {
  type: string
  sql: ${TABLE}.network ;;
}

dimension: phone_calls {
  type: number
  sql: ${TABLE}.phone_calls ;;
}

dimension: phone_impressions {
  type: number
  sql: ${TABLE}.phone_impressions ;;
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

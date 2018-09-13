include: "ad_metrics_base.view"
include: "ad_group.view"
include: "account.view"
include: "keyword.view"
include: "campaign.view"
include: "ad.view"


explore: ad_impressions_adapter {
  extends: [account_join]
  from: ad_impressions_adapter
  view_name: fact
  hidden: yes
  group_label: "BingAds"
  label: "BingAds Impressions"
  view_label: "Impressions"
}

view: ad_impressions_derived_table {
  extension: required
  derived_table: {
    datagroup_trigger: bingads_etl_datagroup
    explore_source: ad_impressions_adapter {
      column: date { field: fact._date }
      column: account_id { field: fact.account_id }
      column: network { field: fact.network }
      column: device_os { field: fact.device_os }
      column: device_type { field: fact.device_type }
      column: average_position {field: fact.weighted_average_position}
      column: clicks {field: fact.total_clicks }
      column: conversions {field: fact.total_conversions}
      column: conversion_value {field: fact.total_conversionvalue}
      column: cost {field: fact.total_cost}
      column: impressions { field: fact.total_impressions}
    }
  }
}

view: ad_impressions_adapter {
  extends: [ad_impressions_derived_table, ad_impressions_adapter_base]
}

view: ad_impressions_adapter_base {
  extension: required
  extends: [bingads_config, bingads_base, ad_metrics_base_adapter]

  dimension: account_primary_key {
    hidden: yes
    sql: concat(
      ${date_string}, "|",
      ${account_id_string}, "|",
      cast(${ad_id} as string), "|",
      ${ad_distribution}, "|",
      ${device_type}, "|",
      ${device_os}, "|",
      ${delivered_match_type}, "|",
      ${bid_match_type}, "|",
      ${language}, "|",
      ${top_vs_other}, "|",
      ${network}) ;;
  }

  dimension: primary_key {
    primary_key: yes
    hidden: yes
    sql: ${account_primary_key} ;;
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

  dimension: conversionvalue {
    type: number
    sql: ${TABLE}.revenue ;;
  }

  dimension: cost {
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



explore: ad_impressions_campaign_adapter {
  extends: [ad_impressions_adapter, campaign_join]
  from: ad_impressions_campaign_adapter
  view_name: fact
  group_label: "BingAds"
  label: "BingAds Impressions by Campaign"
  view_label: "Impressions by Campaign"
}

view: ad_impressions_campaign_derived_table {
  extension: required
  derived_table: {
    datagroup_trigger: bingads_etl_datagroup
    explore_source: ad_impressions_campaign_adapter {
      column: date { field: fact._date }
      column: account_id { field: fact.account_id }
      column: campaign_id { field: fact.campaign_id }
      column: network { field: fact.network }
      column: device_os { field: fact.device_os }
      column: device_type { field: fact.device_type }
      column: average_position {field: fact.weighted_average_position}
      column: clicks {field: fact.total_clicks }
      column: conversions {field: fact.total_conversions}
      column: conversion_value {field: fact.total_conversionvalue}
      column: cost {field: fact.total_cost}
      column: impressions { field: fact.total_impressions}
    }
  }
}

view: ad_impressions_campaign_adapter {
  extends: [ad_impressions_campaign_derived_table, ad_impressions_campaign_adapter_base]
}

view: ad_impressions_campaign_adapter_base {
  extends: [ad_impressions_adapter_base]

  dimension: campaign_primary_key {
    hidden: yes
    sql: concat(${account_primary_key}, "|", ${campaign_id_string}) ;;
  }

  dimension: primary_key {
    primary_key: yes
    hidden: yes
    sql: ${campaign_primary_key} ;;
  }

  dimension: campaign_id {
    hidden: yes
    sql: ${TABLE}.campaign_id ;;
  }

  dimension: campaign_id_string {
    hidden: yes
    sql: CAST(${TABLE}.campaign_id as STRING) ;;
  }
}



explore: ad_impressions_ad_group_adapter {
  extends: [ad_impressions_campaign_adapter, ad_group_join]
  from: ad_impressions_ad_group_adapter
  view_name: fact
  group_label: "BingAds"
  label: "BingAds Impressions by Ad Group"
  view_label: "Impressions by Ad Group"
}

view: ad_impressions_ad_group_derived_table {
  extension: required
  derived_table: {
    datagroup_trigger: bingads_etl_datagroup
    explore_source: ad_impressions_ad_group_adapter{
      column: date { field: fact._date }
      column: account_id { field: fact.account_id }
      column: campaign_id { field: fact.campaign_id }
      column: ad_group_id { field: fact.ad_group_id }
      column: network { field: fact.network }
      column: device_os { field: fact.device_os }
      column: device_type { field: fact.device_type }
      column: average_position {field: fact.weighted_average_position}
      column: clicks {field: fact.total_clicks }
      column: conversions {field: fact.total_conversions}
      column: conversion_value {field: fact.total_conversionvalue}
      column: cost {field: fact.total_cost}
      column: impressions { field: fact.total_impressions}
    }
  }
}

view: ad_impressions_ad_group_adapter {
  extends: [ad_impressions_ad_group_derived_table, ad_impressions_ad_group_adapter_base]
}

view: ad_impressions_ad_group_adapter_base {
  extension: required
  extends: [ad_impressions_campaign_adapter_base]

  dimension: ad_group_primary_key {
    hidden: yes
    sql: concat(${campaign_primary_key}, "|", ${ad_group_id_string}) ;;
  }

  dimension: primary_key {
    primary_key: yes
    hidden: yes
    sql: ${ad_group_primary_key} ;;
  }

  dimension: ad_group_id {
    hidden: yes
    sql: ${TABLE}.ad_group_id ;;
  }

  dimension: ad_group_id_string {
    hidden: yes
    sql: CAST(${TABLE}.ad_group_id as STRING) ;;
  }

}




explore: ad_impressions_keyword_adapter {
  extends: [ad_impressions_ad_group_adapter, keyword_join]
  from: ad_impressions_keyword_adapter
  view_name: fact
  group_label: "BingAds"
  label: "BingAds Impressions by Keyword"
  view_label: "Impressions by Keyword"
}

view: ad_impressions_keyword_adapter {
  extends: [ad_impressions_ad_group_adapter_base]
  sql_table_name: {{ fact.bingads_schema._sql }}.keyword_stats ;;

  dimension: keyword_primary_key {
    hidden: yes
    sql: concat(${ad_group_primary_key}, "|", ${keyword_id_string}) ;;
  }

  dimension: primary_key {
    primary_key: yes
    hidden: yes
    sql: ${keyword_primary_key} ;;
  }

  dimension: keyword_id {
    hidden: yes
    sql: ${TABLE}.keyword_id ;;
  }

  dimension: keyword_id_string {
    hidden: yes
    sql: CAST(${TABLE}.keyword_id as STRING) ;;
  }


}

explore: ad_impressions_ad_adapter {
  extends: [ad_impressions_keyword_adapter, ad_join]
  from: ad_impressions_ad_adapter
  view_name: fact
  group_label: "Bing Ads"
  label: "BingAds Impressions by Ad"
  view_label: "Impressions by Ad"

}

view: ad_impressions_ad_adapter {
  extends: [ad_impressions_keyword_adapter]
  sql_table_name: {{ fact.bingads_schema._sql }}.ad_stats ;;

  dimension: ad_primary_key {
    hidden: yes
    sql: concat(${keyword_primary_key}, "|", ${ad_id}, "|") ;;
  }

  dimension: primary_key {
    primary_key: yes
    hidden: yes
    sql: ${ad_primary_key} ;;
  }

  dimension: keyword_id {
    hidden: yes
    sql: ${TABLE}.keyword_id ;;
  }

  dimension: keyword_type {
    hidden: yes
    sql: ${TABLE}.keyword_type ;;
  }

  dimension: ad_id {
    hidden: yes
    sql: ${TABLE}.ad_id ;;
  }

  dimension: ad_id_string {
    hidden: yes
    sql: CAST(${TABLE}.ad_id as STRING) ;;
  }

}

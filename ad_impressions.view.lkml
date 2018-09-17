# Views and Explores for Bing Ads rolled up stats tables

explore: bing_ad_impressions_adapter {
  from: bing_ad_impressions_adapter
  view_name: fact
  hidden: yes
  group_label: "Bing Ads"
  label: "Bing Ads Impressions"
  view_label: "Impressions"
}

view: bing_ad_impressions_adapter {
  extends: [bing_ad_impressions_adapter_base]
  sql_table_name: {{ fact.bing_ads_schema._sql }}.account_stats ;;
}

view: bing_ad_impressions_adapter_base {
  extension: required
  extends: [bing_ads_config, bing_ads_base]

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
    hidden: yes
    type: number
  }

  dimension: account_name {
    type: string
  }

  dimension: account_status {
    type: string
  }

  dimension: ad_description {
    type: string
  }

  dimension: ad_distribution {
    type: string
  }

  dimension: ad_group_id {
    hidden: yes
    type: number
  }

  dimension: ad_group_name {
    type: string
  }

  dimension: ad_group_status {
    type: string
  }

  dimension: ad_id {
    hidden: yes
    type: number
  }

  dimension: ad_status {
    hidden: yes
    type: string
  }

  dimension: ad_title {
    type: string
  }

  dimension: ad_type {
    type: string
  }

  dimension: bid_match_type {
    type: string
  }

  dimension: campaign_id {
    hidden: yes
    type: number
  }

  dimension: campaign_name {
    type: string
  }

  dimension: campaign_status {
    type: string
  }

  dimension: delivered_match_type {
    type: string
  }

  dimension: destination_url {
    type: string
  }

  dimension: device_os {
    type: string
  }

  dimension: device_type {
    type: string
  }

  dimension: display_url {
    type: string
  }

  dimension: final_url {
    type: string
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

  dimension: language {
    type: string
  }

  dimension: network {
    type: string
  }

  dimension: path_1 {
    type: string
  }

  dimension: path_2 {
    type: string
  }

  dimension: title_part_1 {
    type: string
  }

  dimension: title_part_2 {
    type: string
  }

  dimension: top_vs_other {
    type: string
  }

}



explore: bing_ad_impressions_campaign_adapter {
  extends: [bing_ad_impressions_adapter]
  from: bing_ad_impressions_campaign_adapter
  view_name: fact
  group_label: "Bing Ads"
  label: "Bing Ads Impressions by Campaign"
  view_label: "Impressions by Campaign"
}

view: bing_ad_impressions_campaign_adapter {
  extends: [bing_ad_impressions_campaign_adapter_base]
  sql_table_name: {{ fact.bing_ads_schema._sql }}.campaign_stats ;;
}

view: bing_ad_impressions_campaign_adapter_base {
  extends: [bing_ad_impressions_adapter_base]

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



explore: bing_ad_impressions_ad_group_adapter {
  extends: [bing_ad_impressions_campaign_adapter]
  from: bing_ad_impressions_ad_group_adapter
  view_name: fact
  group_label: "Bing Ads"
  label: "Bing Ads Impressions by Ad Group"
  view_label: "Impressions by Ad Group"
}

view: bing_ad_impressions_ad_group_adapter {
#   extension: required
  extends: [bing_ad_impressions_campaign_adapter_base]
  sql_table_name: {{ fact.bing_ads_schema._sql }}.ad_group_stats ;;

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




explore: bing_ad_impressions_keyword_adapter {
  extends: [bing_ad_impressions_ad_group_adapter]
  from: bing_ad_impressions_keyword_adapter
  view_name: fact
  group_label: "Bing Ads"
  label: "Bing Ads Impressions by Keyword"
  view_label: "Impressions by Keyword"
}

view: bing_ad_impressions_keyword_adapter {
  extends: [bing_ad_impressions_ad_group_adapter]
  sql_table_name: {{ fact.bing_ads_schema._sql }}.keyword_stats ;;

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

explore: bing_ad_impressions_ad_adapter {
  extends: [bing_ad_impressions_keyword_adapter]
  from: bing_ad_impressions_ad_adapter
  view_name: fact
  group_label: "Bing Ads"
  label: "Bing Ads Impressions by Ad"
  view_label: "Impressions by Ad"

}

view: bing_ad_impressions_ad_adapter {
  extends: [bing_ad_impressions_keyword_adapter]
  sql_table_name: {{ fact.bing_ads_schema._sql }}.ad_stats ;;

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

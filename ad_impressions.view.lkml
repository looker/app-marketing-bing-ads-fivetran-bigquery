# Views and Explores for Bing Ads rolled up stats tables

explore: bing_ad_impressions_adapter {
  from: bing_ad_impressions_adapter
  extends: [bing_account_join]
  view_name: fact
  hidden: yes
  group_label: "Bing Ads"
  label: "Bing Ads Impressions"
  view_label: "Impressions"
}

view: bing_ad_impressions_adapter {
  extends: [bing_ad_impressions_adapter_base]
  sql_table_name: {{ fact.bing_ads_schema._sql }}.account_performance_daily_report ;;
}

view: bing_ad_metrics_base_dimensions {
  extension: required

  dimension: assists {
    type: number
  }

  dimension: average_position {
    type: number
  }

  dimension: click_calls {
    type: number
  }

  dimension: clicks {
    type: number
  }

  dimension: conversions {
    type: number
  }

  dimension: impressions {
    type: number
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
    sql: CAST(${TABLE}.revenue as numeric) ;;
  }

  dimension: spend {
    type: number
    sql: ${TABLE}.spend ;;
  }
}


view: bing_ad_impressions_adapter_base {
  extension: required
  extends: [bing_ads_config, bing_ads_base, bing_ad_metrics_base_dimensions]

  dimension: account_id {
    hidden: yes
    type: number
  }

  dimension: account_id_string {
    hidden: yes
    sql: CAST(${TABLE}.account_id as STRING) ;;
  }

  dimension: ad_distribution {
    type: string
  }

  dimension: bid_match_type {
    type: string
  }

  dimension: delivered_match_type {
    type: string
  }

  dimension: device_os {
    type: string
  }

  dimension: device_type_raw {
    type: string
    sql: ${TABLE}.device_type ;;
    hidden: yes
  }

  dimension: device_type {
    hidden: no
    type: string
    case: {
      when: {
        sql: ${device_type_raw} = 'Computer' ;;
        label: "Desktop"
      }
      when: {
        sql: ${device_type_raw} = 'Smartphone' ;;
        label: "Mobile"
      }
      when: {
        sql: ${device_type_raw} = 'Tablet' ;;
        label: "Tablet"
      }
      else: "Other"
    }
  }

  dimension: network_raw {
    type: string
    sql: ${TABLE}.network ;;
    hidden: yes
  }

  dimension: network {
    hidden: no
    type: string
    case: {
      when: {
        sql: ${network_raw} = 'Syndicated search partners' ;;
        label: "Search Partners"
      }
      when: {
        sql: ${network_raw} = 'Bing and Yahoo! search' ;;
        label: "Bing and Yahoo!"
      }
      when: {
        sql: ${network_raw} = 'AOL search' ;;
        label: "AOL"
      }
      else: "Other"
    }
  }

  dimension: top_vs_other {
    type: string
  }
}



explore: bing_ad_impressions_campaign_adapter {
  extends: [bing_ad_impressions_adapter, bing_campaign_join]
  from: bing_ad_impressions_campaign_adapter
  view_name: fact
  group_label: "Bing Ads"
  label: "Bing Ads Impressions by Campaign"
  view_label: "Impressions by Campaign"
}


view: bing_ad_impressions_campaign_adapter {
  extends: [bing_ad_impressions_campaign_adapter_base]
  sql_table_name: {{ fact.bing_ads_schema._sql }}.campaign_performance_daily_report ;;
}

view: bing_ad_impressions_campaign_adapter_base {
  extends: [bing_ad_impressions_adapter_base]

  dimension: campaign_id {
    hidden: yes
    type: number
  }

  dimension: campaign_id_string {
    hidden: yes
    sql: CAST(${TABLE}.campaign_id as STRING) ;;
  }

  dimension_group: date {
    hidden: yes
    type: time
  }
}

explore: bing_ad_impressions_ad_group_adapter {
  extends: [bing_ad_impressions_campaign_adapter, bing_ad_group_join]
  from: bing_ad_impressions_ad_group_adapter
  view_name: fact
  group_label: "Bing Ads"
  label: "Bing Ads Impressions by Ad Group"
  view_label: "Impressions by Ad Group"
}

view: bing_ad_impressions_ad_group_adapter {
#   extension: required
  extends: [bing_ad_impressions_campaign_adapter_base]
  sql_table_name: {{ fact.bing_ads_schema._sql }}.ad_group_performance_daily_report ;;

  dimension: ad_group_id {
    hidden: yes
    type: number
  }

  dimension: ad_group_id_string {
    hidden: yes
    sql: CAST(${TABLE}.ad_group_id as STRING) ;;
  }

  dimension: ad_relevance {
    type: number
  }

  dimension: landing_page_experience {
    type: number
  }

  dimension: _date {
    type: date
    sql: ${TABLE}.date ;;
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
  sql_table_name: {{ fact.bing_ads_schema._sql }}.keyword_performance_daily_report ;;

  dimension: ad_id {
    hidden: yes
    type: number
  }

  dimension: ad_id_string {
    hidden: yes
    sql: CAST(${TABLE}.ad_id as STRING) ;;
  }

  dimension: currency_code {
    type: string
  }

  dimension: current_max_cpc {
    type: number
  }

  dimension: expected_ctr {
    type: number
  }

  dimension: keyword_id {
    hidden: yes
    type: number
  }

  dimension: keyword_id_string {
    hidden: yes
    sql: CAST(${TABLE}.keyword_id as STRING) ;;
  }

  dimension: language {
    type: string
  }

  dimension: quality_impact {
    type: number
  }

  dimension: quality_score {
    type: number
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
  sql_table_name: {{ fact.bing_ads_schema._sql }}.ad_performance_daily_report ;;

  dimension: ad_id {
    hidden: yes
    type: number
  }

  dimension: ad_id_string {
    hidden: yes
    sql: CAST(${TABLE}.ad_id as STRING) ;;
  }

}

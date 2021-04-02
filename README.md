# Bing Ads: Fivetran

THIS BLOCK IS DEPRECATED AS OF 4/2/2021.

### Dependencies

This adapter relies on a project `app_marketing_analytics_config` as specified in the manifest.lkml file. This project needs to include an `bing_ads_config.view.lkml` file.

For example:

```LookML
view: bing_ads_config {
  extension: required

  dimension: bing_ads_schema {
    hidden: yes
    sql:bing_ads;;
  }
}
```

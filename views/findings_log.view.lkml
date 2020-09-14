view: findings_log {
  sql_table_name: `looker-private-demo.security_logs.findings_log`
    ;;

# alternatively use Shad's view: https://googlecloud.looker.com/projects/scc_findings/files/findings_log.view.lkml

  dimension: asset {
    hidden: yes
    sql: ${TABLE}.asset ;;
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension_group: create {
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
    sql: ${TABLE}.createTime ;;
  }

  dimension_group: event {
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
    sql: ${TABLE}.eventTime ;;
  }

  dimension: external_uri {
    type: string
    sql: ${TABLE}.externalUri ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: parent {
    type: string
    sql: ${TABLE}.parent ;;
  }

  dimension: resource_name {
    type: string
    sql: ${TABLE}.resourceName ;;
  }

  dimension: security_marks {
    hidden: yes
    sql: ${TABLE}.securityMarks ;;
  }

  dimension: source_properties {
    type: string
    sql: ${TABLE}.sourceProperties ;;
  }

  dimension: severity {
    type: string
    sql:
      CASE JSON_EXTRACT_SCALAR(${TABLE}.sourceProperties, "$.SeverityLevel")
        WHEN "Low" THEN "1 - Low"
        WHEN "Medium" THEN "2 - Medium"
        WHEN "High" THEN "3 - High"
        WHEN "Critical" THEN "4 - Critical"
        ELSE COALESCE(JSON_EXTRACT_SCALAR(${TABLE}.sourceProperties, "$.SeverityLevel"), "0 - Unknown")
      END ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.state ;;
  }

  measure: count {
    type: count
    drill_fields: [name, resource_name]
  }


  dimension: marks {
    type: string
    sql: ${TABLE}.securityMarks.marks ;;
  }

  dimension: security_marks_name {
    type: string
    sql: ${TABLE}.securityMarks.name ;;
  }

  dimension_group: security_marks_create {
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
    sql: ${TABLE}.asset.createTime ;;
  }

  dimension: iam_policy_blob {
    type: string
    sql: ${TABLE}.asset.iamPolicyBlob ;;
  }

  dimension: asset_name {
    type: string
    sql: ${TABLE}.asset.name ;;
  }

  dimension: resource_properties {
    type: string
    sql: ${TABLE}.asset.resourceProperties ;;
  }

  dimension: security_center_properties {
    hidden: yes
    sql: ${TABLE}.asset.securityCenterProperties ;;
  }

  dimension: asset_security_marks {
    hidden: yes
    sql: ${TABLE}.asset.securityMarks ;;
  }



  dimension_group: update {
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
    sql: ${TABLE}.asset.updateTime ;;
  }

  dimension: asset_security_marks_marks {
    type: string
    sql: ${TABLE}.asset.securityMarks.marks ;;
  }

  dimension: asset_security_name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: resource_display_name {
    type: string
    sql: ${TABLE}.asset.securityCenterProperties.resourceDisplayName ;;
  }

  dimension: asset_sc_properties_resource_name {
    type: string
    sql: ${TABLE}.asset.securityCenterProperties.resourceName ;;
  }

#   dimension: resource_owners {
#     type: string
#     sql: ${TABLE}.asset.securityCenterProperties.resourceOwners ;;
#   }

  dimension: resource_parent {
    type: string
    sql: ${TABLE}.asset.securityCenterProperties.resourceParent ;;
  }

  dimension: resource_parent_display_name {
    type: string
    sql: ${TABLE}.asset.securityCenterProperties.resourceParentDisplayName ;;
  }

  dimension: resource_project {
    type: string
    sql: ${TABLE}.asset.securityCenterProperties.resourceProject ;;
  }

  dimension: resource_project_display_name {
    type: string
    sql: ${TABLE}.asset.securityCenterProperties.resourceProjectDisplayName ;;
  }

  dimension: resource_type {
    type: string
    sql: ${TABLE}.asset.securityCenterProperties.resourceType ;;
  }
}
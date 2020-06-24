{% snapshot ACCOUNTSECURITIES_SNAPSHOT %}

{{
    config(
      unique_key="ENTITY_CODE||'-'||UNIQUE_SECURITY_ID",
      updated_at='INGESTION_TIME',
    )
}}

select * from {{ source('PUBLIC', 'ACCOUNTSECURITIES') }}

{% endsnapshot %}

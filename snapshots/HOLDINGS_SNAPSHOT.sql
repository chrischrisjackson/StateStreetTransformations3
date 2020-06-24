{% snapshot HOLDINGS_SNAPSHOT %}

{{
    config(
      unique_key="ASSET_IDENTIFIER||'-'||ENTITY_CODE||'-'||EFFECTIVE_DATE",
      updated_at='INGESTION_TIME',
    )
}}

select * from {{ source('PUBLIC', 'HOLDINGS') }}

{% endsnapshot %}

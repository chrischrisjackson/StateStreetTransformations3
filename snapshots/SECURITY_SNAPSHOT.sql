{% snapshot SECURITY_SNAPSHOT %}

{{
    config(
      unique_key='UNIQUE_SECURITY_ID',
      updated_at='INGESTION_TIME',
    )
}}

select * from {{ source('CURRENT_RAW', 'SMF') }}

{% endsnapshot %}
{% snapshot FXRATES_SNAPSHOT %}

{{
    config(
      unique_key="EXCHANGE_SOURCE_CODE||'-'||CURRENCY_PAIR_CODE||'-'||EFFECTIVE_DATE",
      updated_at='INGESTION_TIME',
    )
}}

select * from {{ source('CURRENT_RAW', 'FXRATES') }}

{% endsnapshot %}
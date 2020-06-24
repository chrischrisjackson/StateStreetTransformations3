{% snapshot FXRATES_SNAPSHOT %}

{{
    config(
      unique_key="EXCHANGE_SOURCE_CODE||'-'||CURRENCY_PAIR_CODE||'-'||EFFECTIVE_DATE",
      updated_at='INGESTION_TIME',
    )
}}

select * from {{ source('PUBLIC', 'FXRATES') }}

{% endsnapshot %}

{% snapshot TRANSACTIONS_SNAPSHOT %}

{{
    config(
      unique_key='TRANS_CODE_KEY',
      updated_at='INGESTION_TIME',
    )
}}

select * from {{ source('PUBLIC', 'TRANSACTIONS') }}

{% endsnapshot %}

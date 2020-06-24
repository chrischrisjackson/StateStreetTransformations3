SELECT 
    T1.PRIMARY_KEY AS TRANSACTION_KEY,
    {{ ref('CLIENT_DIM') }}.CLIENT_KEY AS CLIENT_KEY,
    NULL AS INVESTMENT_KEY,
    {{ ref('TRANSACTION_TYPE_DIM') }}.TRANSACTION_TYPE_KEY AS TRANSACTION_TYPE_KEY,
    NULL AS TRANSACTION_SUB_TYPE_KEY,
    {{ ref('CURRENCY_DIM')}}.CURRENCY_KEY AS CURRENCY_KEY,
    {{ ref('FUND_DIM') }}.FUND_KEY AS FUND_KEY,
    {{ ref('SECURITY_DIM') }}.SECURITY_KEY AS SECURITY_KEY,
    {{ ref('DATE_DIM')}}.DATE_KEY AS DATE_KEY,
    NULL AS COMMITMENT_TYPE_KEY,
    T1.CASH_FLOW_CATEGORY_NAME,
    T1.MATURITY_DATE,
    T1.SETTLEMENT_DATE_CONTRACTUAL AS SETTLEMENT_DATE,
    T1.UNIT_PRICE,
    T1.UNITS_AMOUNT AS UNIT_AMOUNT,
    NULL AS TOTAL_AMOUNT,
    T1.TRADE_DATE_LOCAL_EXCHANGE_RATE AS EXCHANGE_RATE,
    T1.SOURCE_TRADE_IDENTIFIER AS EXTERNAL_TRADE_ID,
    T1.TRANSACTION_IDENTIFIER AS EXTERNAL_TRANSACTION_ID,
    T1.TRANS_CODE_KEY AS EXTERNAL_TRANSACTION_CODE,
    NULL AS COMMENT,
    T1.SOURCE_FILENAME AS LINEAGEKEY,
    T1.DBT_VALID_FROM AS VALIDFROM,
    T1.DBT_VALID_TO AS VALIDTO
FROM {{ ref('TRANSACTIONS_SNAPSHOT') }} T1
JOIN {{ ref('CLIENT_DIM') }} ON {{ ref('CLIENT_DIM') }}.NAME = T1.SPONSOR_ID
JOIN {{ ref('TRANSACTION_TYPE_DIM') }} ON {{ ref('TRANSACTION_TYPE_DIM') }}.TRANSACTION_TYPE_NAME = T1.TRANSACTION_TYPE_CODE
JOIN {{ ref('CURRENCY_DIM') }} ON {{ ref('CURRENCY_DIM') }}.CURRENCY_CODE = T1.CURRENCY_LOCAL_CODE
JOIN {{ ref('FUND_DIM') }} ON {{ ref('FUND_DIM') }}.EXTERNAL_FUND_ID = T1.ENTITY_CODE
JOIN {{ ref('SECURITY_DIM') }} ON {{ ref('SECURITY_DIM') }}.EXTERNAL_SECURITY_ID = T1.UNIQUE_SECURITY_ID
JOIN {{ ref('DATE_DIM') }} ON {{ ref('DATE_DIM') }}.FULL_DATE = T1.EFFECTIVE_DATE
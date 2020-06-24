USE SCHEMA CURRENT_RAW;

CREATE OR REPLACE VIEW SMF 
COMMENT = 'VIEW TO FETCH THE MOST RECENT RECORDS' 
AS
SELECT
    PRIMARY_KEY,
    ISSUE_SHORT_NAME,
    CURRENCY_TRADE_CODE,
    UNIQUE_SECURITY_ID,
    ASSET_IDENTIFIER,
    MATURITY_DATE,
    COUPON_RATE,
    ISSUE_LONG_NAME,
    BLOOMBERG_IDENTIFIER,
    ISIN_IDENTIFIER,
    SEDOL_IDENTIFIER,
    SECURITY_GROUP_CODE,
    CALL_PUT_IDENTIFIER,
    MULTIPLIER_CURRENT_NUMBER,
    STRIKE_CURRENT_PRICE,
    EXCHANGE_TICKER_IDENTIFIER,
    CONTRACT_EXPIRATION_DATE,
    CURRENCY_INCOME_CODE,
    COUNTRY_INCORPORATED_CODE,
    SECURITY_TYPE_CODE,
    COUNTRY_ISSUE_CODE,
    ISSUE_DESCRIPTION_NAME,
    ISSUE_DESCRIPTION_SECONDARY_NAME,
    COUNTRY_NRA_TAX_CODE,
    COUNTRY_TRADE_CODE,
    SOURCE_FILENAME,
    INGESTION_TIME
FROM
    (
        SELECT
            *,
            ROW_NUMBER() OVER(
                PARTITION BY UNIQUE_SECURITY_ID
                ORDER BY
                    INGESTION_TIME DESC
            ) AS RN
        FROM
            RAW.SMF
    )
WHERE
    RN = 1
ORDER BY
    UNIQUE_SECURITY_ID,
    INGESTION_TIME;
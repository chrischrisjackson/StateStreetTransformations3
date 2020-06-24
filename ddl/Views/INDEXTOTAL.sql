USE SCHEMA CURRENT_RAW;

CREATE OR REPLACE VIEW INDEXTOTAL 
COMMENT = 'VIEW TO FETCH THE MOST RECENT RECORDS' 
AS
SELECT
PRIMARY_KEY,
ENTITY_CODE,
EFFECTIVE_DATE,
DATATYPE,
MARKET_CAP,
INDEX_LEVEL,
CURRENCY_CODE,
RETURN,
SOURCE_FILENAME,
INGESTION_TIME
FROM
    (
        SELECT
            *,
            ROW_NUMBER() OVER(
                PARTITION BY 
                ENTITY_CODE, -- check the correctness of column used
                EFFECTIVE_DATE -- check the correctness of column used
                ORDER BY
                    INGESTION_TIME DESC
            ) AS RN
        FROM
            RAW.INDEXTOTAL
    )
WHERE
    RN = 1
ORDER BY
    ENTITY_CODE,
    EFFECTIVE_DATE,
    INGESTION_TIME;
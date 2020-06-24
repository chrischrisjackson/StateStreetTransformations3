USE SCHEMA CURRENT_RAW;

CREATE OR REPLACE VIEW PORTFOLIOTOTAL 
COMMENT = 'VIEW TO FETCH THE MOST RECENT RECORDS' 
AS
SELECT
PRIMARY_KEY,
SPONSOR_ID,
DATATYPE,
ENTITY_CODE,
ENTITY_SHORT_NAME,
EFFECTIVE_DATE,
RETURN_TYPE,
BMV,
EMV,
ABAL,
INC,
GN_LS,
CSH_VAL_ADD,
INFLOWS,
OUTFLOWS,
NCF,
RETURN,
SOURCE_FILENAME,
INGESTION_TIME
FROM
    (
        SELECT
            *,
            ROW_NUMBER() OVER(
                PARTITION BY 
                SPONSOR_ID, -- check the correctness of column used
                ENTITY_CODE, -- check the correctness of column used
                EFFECTIVE_DATE -- check the correctness of column used
                ORDER BY
                    INGESTION_TIME DESC
            ) AS RN
        FROM
            RAW.PORTFOLIOTOTAL
    )
WHERE
    RN = 1
ORDER BY
    SPONSOR_ID,
    ENTITY_CODE,
    EFFECTIVE_DATE,
    INGESTION_TIME;
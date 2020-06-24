USE SCHEMA CURRENT_RAW;

CREATE OR REPLACE VIEW SPONSORBENCHMARK 
COMMENT = 'VIEW TO FETCH THE MOST RECENT RECORDS' 
AS
SELECT
PRIMARY_KEY,
SPONSOR_ID,
BENCHMARK_ID,
BENCHMARK_OVERRIDE_NAME,
ACTIVE_FLAG,
SEC_ROLLUP_FLAG,
LVL_BELOW_TOTAL_FLAG,
SEC_DISPLAY_ALLOWED_FLAG,
SUMMARY_REPORTING_FLG,
SOURCE_FILENAME,
INGESTION_TIME
FROM
    (
        SELECT
            *,
            ROW_NUMBER() OVER(
                PARTITION BY SPONSOR_ID, BENCHMARK_ID  -- check the correctness of column used
                ORDER BY
                    INGESTION_TIME DESC
            ) AS RN
        FROM
            RAW.SPONSORBENCHMARK
    )
WHERE
    RN = 1
ORDER BY
    SPONSOR_ID,
    BENCHMARK_ID,
    INGESTION_TIME;
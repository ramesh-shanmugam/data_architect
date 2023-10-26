
-- select database and schema to set fileformat
use UDACITY_LAB;
use SCHEMA STAGING;

-- create new file format for data loading
create or replace file format myjsonformat type='JSON' strip_outer_array=true;
create or replace file format mycsvformat type='CSV'
field_delimiter = ','
record_delimiter = '\\n'
skip_header = 1
date_format = 'auto'
compression= 'auto';

-- setup new internal staging for local to snowflake file upload 
create or replace stage my_json_stage file_format = myjsonformat;


-- copy all local files to snowflake interanl stage called "my_json_stage"

put file://C:\DataScience\Data_architect\data\backup\yelp_academic_dataset_business.json @my_json_stage auto_compress = true;

put file://C:\DataScience\Data_architect\data\backup\yelp_academic_dataset_review.json @my_json_stage auto_compress = true;

put file://C:\DataScience\Data_architect\data\backup\yelp_academic_dataset_checkin.json @my_json_stage auto_compress = true;

put file://C:\DataScience\Data_architect\data\backup\yelp_academic_dataset_tip.json @my_json_stage auto_compress = true;

put file://C:\DataScience\Data_architect\data\backup\yelp_academic_dataset_user.json @my_json_stage auto_compress = true;

put file://C:\DataScience\Data_architect\data\backup\yelp_academic_dataset_covid_features.json @my_json_stage auto_compress = true;

put file://C:\DataScience\Data_architect\data\usw00023169_precipitation_inch.csv @my_json_stage auto_compress = true;

put file://C:\DataScience\Data_architect\data\usw00023169_temperature_degreef.csv @my_json_stage auto_compress = true;


-- setup stg_yelp_business table and create a view to convert JSON data into more structured format 

create table stg_yelp_business(businessjson variant);
copy into stg_yelp_business from @my_json_stage/yelp_academic_dataset_business.json.gz file_format=myjsonformat on_error='skip_file';

create or replace view yelp_business as 
		select parse_json($1):business_id :: string as business_id,
        parse_json($1):name :: string as name ,
		parse_json($1):address :: string as address,
		parse_json($1):city :: string as city ,
		parse_json($1):state :: string as state,
		parse_json($1):postal_code :: string as postal_code,
		parse_json($1):latitude :: float as latitude,
		parse_json($1):longitude :: float as longitude,
		parse_json($1):stars :: float as stars ,
		parse_json($1):review_count :: integer as review_count,
		parse_json($1):is_open :: integer as is_open,
		parse_json($1):attributes :: string as attributes,
		parse_json($1):categories :: string as categories,
		parse_json($1):hours.Monday :: string as Monday,
		parse_json($1):hours.Tuesday :: string as Tuesday,
		parse_json($1):hours.Wednesday :: string as Wednesday,
		parse_json($1):hours.Thursday :: string as Thursday,
		parse_json($1):hours.Friday :: string as Friday,
		parse_json($1):hours.Saturday :: string as Saturday,
		parse_json($1):hours.Sunday :: string as Sunday
from stg_yelp_business;


-- setup stg_yelp_review table and create a view to convert JSON data into more structured format 

create table stg_yelp_review(reviewjson variant);
copy into stg_yelp_review from @my_json_stage/yelp_academic_dataset_review.json.gz file_format=myjsonformat on_error='skip_file';

create or replace view yelp_review as 
        select parse_json($1):review_id :: string as review_id ,
        parse_json($1):user_id :: string as user_id,
        parse_json($1):business_id :: string as business_id,
        parse_json($1):stars :: float as stars,
        parse_json($1):useful :: integer as useful,
        parse_json($1):funny :: integer as funny,
        parse_json($1):cool :: integer as cool,
        parse_json($1):text :: string as text,
        to_timestamp_ntz(parse_json($1):date) as timestamp
from stg_yelp_review;

-- setup stg_yelp_checkin table and create a view to convert JSON data into more structured format 

create table stg_yelp_checkin(checkinjson variant);
copy into stg_yelp_checkin from @my_json_stage/yelp_academic_dataset_checkin.json.gz file_format=myjsonformat on_error='skip_file';

create or replace view yelp_checkin as 
		select parse_json($1):business_id :: string as business_id ,
        parse_json($1):date :: string as date
from stg_yelp_checkin;


-- setup stg_yelp_tip table and create a view to convert JSON data into more structured format 

create table stg_yelp_tip(tipjson variant);
copy into stg_yelp_tip from @my_json_stage/yelp_academic_dataset_tip.json.gz file_format=myjsonformat on_error='skip_file';

create or replace view yelp_tip as 
		select parse_json($1):user_id :: string as user_id,
        parse_json($1):business_id :: string as business_id,
        parse_json($1):text :: string as text,
        to_timestamp_ntz(parse_json($1):date) as timestamp,
        parse_json($1):compliment_count :: integer as compliment_count
from stg_yelp_tip;


-- setup stg_yelp_user table and create a view to convert JSON data into more structured format 

create table stg_yelp_user(userjson variant);
copy into stg_yelp_user from @my_json_stage/yelp_academic_dataset_user.json.gz file_format=myjsonformat on_error='skip_file';

create or replace view yelp_user as 
		select parse_json($1):user_id :: string as user_id,
		parse_json($1):name :: string as name,
		parse_json($1):review_count :: integer as review_count,
		to_timestamp_ntz(parse_json($1):yelping_since) as yelping_since,
		parse_json($1):useful :: integer as useful,
		parse_json($1):funny :: integer as funny,
		parse_json($1):cool :: integer as cool,
		parse_json($1):elite :: string as elite,
		parse_json($1):friends :: string as friends,
		parse_json($1):fans :: integer as fans,
		parse_json($1):average_stars :: float as average_stars,
		parse_json($1):compliment_hot :: integer as compliment_hot,
		parse_json($1):compliment_more :: integer as compliment_more,
		parse_json($1):compliment_profile :: integer as compliment_profile,
		parse_json($1):compliment_cute :: integer as compliment_cute,
		parse_json($1):compliment_list :: integer as compliment_list,
		parse_json($1):compliment_note :: integer as compliment_note,
		parse_json($1):compliment_plain :: integer as compliment_plain,
		parse_json($1):compliment_cool :: integer as compliment_cool,
		parse_json($1):compliment_funny :: integer as compliment_funny,
		parse_json($1):compliment_writer :: integer as compliment_writer,
		parse_json($1):compliment_photo :: integer as compliment_photo
from stg_yelp_user;


-- setup stg_yelp_covid table and create a view to convert JSON data into more structured format 

create table stg_yelp_covid(covidjson variant);
copy into stg_yelp_covid from @my_json_stage/yelp_academic_dataset_covid_features.json.gz file_format=myjsonformat on_error='skip_file';


create or replace view yelp_covid as
		select parse_json($1):business_id :: string as business_id,
        parse_json($1):highlights :: string as highlights,
        parse_json($1):"delivery or takeout" :: string as delivery_or_takeout,
        parse_json($1):"Grubhub enabled" :: string as Grubhub_enabled,
        parse_json($1):"Call To Action enabled" :: string as Call_To_Action_enabled,
        parse_json($1):"Request a Quote Enabled" :: string as Request_a_Quote_Enabled,
        parse_json($1):"Covid Banner" :: string as Covid_Banner,
        parse_json($1):"Temporary Closed Until" :: string as Temporary_Closed_Until,
        parse_json($1):"Virtual Services Offered" :: string as Virtual_Services_Offered
from stg_yelp_covid;

-- setup weather temp table and create a view to convert csv data into structured format

/* Table temperature */
create or replace table stg_weather_temp (
    date                        DATE,
    temp_max                    FLOAT,
    temp_min                    FLOAT,
    temp_normal_max             FLOAT,
    temp_normal_min             FLOAT
);

/* Table precipitation */
create or replace table stg_weather_precipitation (
    date                        DATE,
    precipitation               FLOAT,
    precipitation_normal        FLOAT
);



COPY INTO "UDACITY_LAB"."STAGING"."STG_WEATHER_TEMP"
FROM '@"UDACITY_LAB"."STAGING"."MY_CSV_STAGE"'
FILES = ('usw00023169-temperature-degreef.csv')
FILE_FORMAT = (
    TYPE=CSV,
    SKIP_HEADER=1,
    FIELD_DELIMITER=',',
    DATE_FORMAT='YYYYMMDD',
    TIME_FORMAT=AUTO,
    RECORD_DELIMITER = '\\n',
    TIMESTAMP_FORMAT=AUTO
)
ON_ERROR=CONTINUE;

COPY INTO "UDACITY_LAB"."STAGING"."STG_WEATHER_PRECIPITATION"
FROM '@"UDACITY_LAB"."STAGING"."MY_CSV_STAGE"'
FILES = ('usw00023169-las-vegas-mccarran-intl-ap-precipitation-inch.csv')
FILE_FORMAT = (
    TYPE=CSV,
    SKIP_HEADER=1,
    FIELD_DELIMITER=',',
    DATE_FORMAT='YYYYMMDD',
    TIME_FORMAT=AUTO,
    RECORD_DELIMITER = '\\n',
    TIMESTAMP_FORMAT=AUTO
)
ON_ERROR=CONTINUE;

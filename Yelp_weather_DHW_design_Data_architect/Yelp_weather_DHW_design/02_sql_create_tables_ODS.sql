
CREATE OR REPLACE TABLE yelp_location (
    location_id     INT    PRIMARY KEY    IDENTITY,
    address         TEXT,
    city            TEXT,
    state           TEXT,
    postal_code     TEXT,
    latitude        FLOAT,
    longitude       FLOAT
);


CREATE OR REPLACE TABLE yelp_business (
    business_id         TEXT    PRIMARY KEY,
    name                TEXT,
    location_id         INT,
    stars               NUMERIC(3,2),
    review_count        INT,
    is_open             BOOLEAN,
    CONSTRAINT FK_LO_ID FOREIGN KEY(location_id)    REFERENCES  yelp_location(location_id)
);


CREATE OR REPLACE TABLE table_timestamp (
    timestamp           DATETIME    PRIMARY KEY,
    date                DATE,
    day                 INT,
    week                INT,
    month               INT,
    year                INT
);

CREATE OR REPLACE TABLE yelp_user (
    user_id             TEXT    PRIMARY KEY,
    name                TEXT,
    review_count        INT,
    yelping_since       DATETIME,
    useful              INT,
    funny               INT,
    cool                INT,
    elite               TEXT,
    friends             TEXT,
    fans                INT,
    average_stars       NUMERIC(3,2),
    compliment_hot      INT,
    compliment_more     INT,
    compliment_profile  INT,
    compliment_cute     INT,
    compliment_list     INT,
    compliment_note     INT,
    compliment_plain    INT,
    compliment_cool     INT,
    compliment_funny    INT,
    compliment_writer   INT,
    compliment_photos   INT,
    CONSTRAINT FK_TI_ID FOREIGN KEY(yelping_since)      REFERENCES  table_timestamp(timestamp)
);


CREATE OR REPLACE TABLE yelp_tip (
    tip_id              INT    PRIMARY KEY    IDENTITY,
    user_id             TEXT,
    business_id         TEXT,
    text                TEXT,
    timestamp           DATETIME,
    compliment_count    INT,
    CONSTRAINT FK_US_ID FOREIGN KEY(user_id)        REFERENCES  yelp_user(user_id),
    CONSTRAINT FK_BU_ID FOREIGN KEY(business_id)    REFERENCES  yelp_business(business_id),
    CONSTRAINT FK_TI_ID FOREIGN KEY(timestamp)      REFERENCES  table_timestamp(timestamp)
);


CREATE OR REPLACE TABLE weather_temperature (
    temperature_id              INT    PRIMARY KEY    IDENTITY,
    date                        DATE,
    temp_min                    FLOAT,
    temp_max                    FLOAT,
    temp_normal_min             FLOAT,
    temp_normal_max             FLOAT
);


CREATE OR REPLACE TABLE weather_precipitation (
    precipitation_id            INT    PRIMARY KEY    IDENTITY,
    date                        DATE,
    precipitation               FLOAT,
    precipitation_normal        FLOAT
);


CREATE OR REPLACE TABLE yelp_review (
    review_id           TEXT    PRIMARY KEY,
    user_id             TEXT,
    business_id         TEXT,
    stars               NUMERIC(3,2),
    useful              BOOLEAN,
    funny               BOOLEAN,
    cool                BOOLEAN,
    text                TEXT,
    timestamp           DATETIME,
    CONSTRAINT FK_US_ID FOREIGN KEY(user_id)        REFERENCES  yelp_user(user_id),
    CONSTRAINT FK_BU_ID FOREIGN KEY(business_id)    REFERENCES  yelp_business(business_id),
    CONSTRAINT FK_TI_ID FOREIGN KEY(timestamp)      REFERENCES  table_timestamp(timestamp)
);


CREATE OR REPLACE TABLE yelp_checkin (
    checkin_id          INT    PRIMARY KEY    IDENTITY,
    business_id         TEXT,
    date                TEXT,
    CONSTRAINT FK_BU_ID FOREIGN KEY(business_id)    REFERENCES  yelp_business(business_id)
);


CREATE OR REPLACE TABLE yelp_covid (
    covid_id                    INT    PRIMARY KEY    IDENTITY,
    business_id                 TEXT,
    highlights                  TEXT,
    delivery_or_takeout         TEXT,
    grubhub_enabled             TEXT,
    call_to_action_enabled      TEXT,
    request_a_quote_enabled     TEXT,
    covid_banner                TEXT,
    temporary_closed_until      TEXT,
    virtual_services_offered    TEXT,
    CONSTRAINT FK_BU_ID         FOREIGN KEY(business_id)    REFERENCES  yelp_business(business_id)
);


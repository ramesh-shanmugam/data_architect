
-- move data from ODS to DHW 
INSERT INTO dim_business (business_id, name, address, city, state, postal_code, latitude, longitude, stars,
                         review_count, is_open, checkin_date, covid_highlights, covid_delivery_or_takeout,
                         covid_grubhub_enabled, covid_call_to_action_enabled, covid_request_a_quote_enabled,
                         covid_banner, covid_temporary_closed_until, covid_virtual_services_offered)
SELECT  bu.business_id,
        bu.name,
        lo.address,
        lo.city,
        lo.state,
        lo.postal_code,
        lo.latitude,
        lo.longitude,
        bu.stars,
        bu.review_count,
        bu.is_open,
        ch.date,
        co.highlights,
        co.delivery_or_takeout,
        co.grubhub_enabled,
        co.call_to_action_enabled,
        co.request_a_quote_enabled,
        co.covid_banner,
        co.temporary_closed_until,
        co.virtual_services_offered
FROM ODS.yelp_business AS bu
LEFT JOIN ODS.yelp_location   AS lo ON bu.location_id = lo.location_id
LEFT JOIN ODS.yelp_checkin    AS ch ON bu.business_id = ch.business_id
LEFT JOIN ODS.yelp_covid      AS co ON bu.business_id = co.business_id;


INSERT INTO dim_user (user_id, name, review_count, yelping_since, useful, funny, cool, elite, friends, fans,
                      average_stars, compliment_hot, compliment_more, compliment_profile, compliment_cute,
                      compliment_list, compliment_note, compliment_plain, compliment_cool, compliment_funny,
                      compliment_writer, compliment_photos)
SELECT  user_id,
        name,
        review_count,
        yelping_since,
        useful,
        funny,
        cool,
        elite,
        friends,
        fans,
        average_stars,
        compliment_hot,
        compliment_more,
        compliment_profile,
        compliment_cute,
        compliment_list,
        compliment_note,
        compliment_plain,
        compliment_cool,
        compliment_funny,
        compliment_writer,
        compliment_photos
FROM ODS.yelp_user;


INSERT INTO dim_timestamp (timestamp, date, day, week, month, year)
SELECT timestamp, date, day, week, month, year
FROM ODS.table_timestamp;


INSERT INTO dim_temperature (date, temp_min, temp_max, temp_normal_min, temp_normal_max)
SELECT date, temp_min, temp_max, temp_normal_min, temp_normal_max
FROM ODS.weather_temperature;


INSERT INTO dim_precipitation (date, precipitation, precipitation_normal)
SELECT date, precipitation, precipitation_normal
FROM ODS.weather_precipitation;


INSERT INTO fact_review (review_id, user_id, business_id, stars, useful, funny, cool, text, timestamp, date)
SELECT  re.review_id,
        re.user_id,
        re.business_id,
        re.stars,
        re.useful,
        re.funny,
        re.cool,
        re.text,
        re.timestamp,
        ti.date
FROM ODS.yelp_review AS re
LEFT JOIN ODS.table_timestamp AS ti ON re.timestamp=ti.timestamp;
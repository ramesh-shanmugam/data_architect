SELECT fr.date, db.name, AVG(fr.stars) AS avg_stars, dt.temp_min, dt.temp_max, dp.precipitation, dp.precipitation_normal
FROM fact_review             AS fr
LEFT JOIN dim_business       AS db  ON fr.business_id=db.business_id
LEFT JOIN dim_temperature    AS dt ON fr.date=dt.date
LEFT JOIN dim_precipitation  AS dp ON fr.date=dp.date
where temp_max is not null
GROUP BY fr.date, db.name, dt.temp_min, dt.temp_max, dp.precipitation, dp.precipitation_normal
ORDER BY fr.date DESC;
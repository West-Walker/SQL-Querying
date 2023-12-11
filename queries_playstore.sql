-- App with id 1880 --
SELECT * FROM analytics WHERE id = 1880;

-- Apps updated August 01, 2018 --
SELECT id, app_name FROM analytics WHERE last_updated = '2018-08-01';

-- Count apps in each category --
SELECT category, COUNT(*) AS apps_in_category FROM analytics GROUP BY category;

-- Top 5 most-reveiwed apps --
SELECT app_name, reviews
FROM analytics
ORDER BY reviews DESC
LIMIT 5;

--Most reviewed app with rating greater than 4.8 --
SELECT app_name, reviews, rating FROM analytics WHERE rating >= 4.8
ORDER BY reviews DESC LIMIT 1;

--Avg rating per category high to low --
SELECT category, AVG(rating) AS average_rating
FROM analytics
GROUP BY category
ORDER BY average_rating DESC;

-- Most expensive app with rating less than 3 --
SELECT app_name, price, rating
FROM analytics
WHERE rating < 3
ORDER BY price DESC
LIMIT 1;

-- App with installs 50 or less highest to lowest rated --
SELECT *
FROM analytics
WHERE min_installs <= 50 AND rating IS NOT NULL
ORDER BY rating DESC;

-- All apps rated less than 3 and reviews 10,000 minimum --
SELECT app_name
FROM analytics
WHERE rating < 3 AND reviews >= 10000;

-- Top 10 most reviewed apps that cost between $0.10 - $1.00 --
SELECT *
FROM analytics
WHERE price BETWEEN 0.1 AND 1.0
ORDER BY reviews DESC
LIMIT 10;

-- Most out-dated app --
SELECT *
FROM analytics
ORDER BY last_updated ASC
LIMIT 1;

-- Most expensive app --
SELECT *
FROM analytics
ORDER BY price DESC
LIMIT 1;

-- Count all reviews in playstore --
SELECT SUM(reviews) AS total_reviews FROM analytics;

-- All categories with more than 300 apps --
SELECT category
FROM analytics
GROUP BY category
HAVING COUNT(*) > 300;

-- Find the app that has the highest proportion of min_installs to reviews, among apps that have been installed at least 100,000 times. Display the name of the app along with the number of reviews, the min_installs, and the proportion --
WITH AppStats AS (
    SELECT
        app_name,
        MIN(min_installs) AS min_installs,
        COUNT(reviews) AS num_reviews
    FROM
        analytics
    GROUP BY
        app_name
    HAVING
        MIN(min_installs) >= 100000
)
SELECT
    app_name,
    num_reviews,
    min_installs,
    CAST(min_installs AS DECIMAL) / CAST(num_reviews AS DECIMAL) AS proportion
FROM
    AppStats
ORDER BY
    proportion DESC
LIMIT 1;

-- Find the name and rating of the top rated apps in each category, among apps that have been installed at least 50,000 times --
WITH RankedApps AS (
    SELECT
        app_name,
        category,
        rating,
        ROW_NUMBER() OVER (PARTITION BY category ORDER BY rating DESC) AS ranking
    FROM
        analytics
    WHERE
        min_installs >= 50000
)
SELECT
    app_name,
    category,
    rating
FROM
    RankedApps
WHERE
    ranking = 1;


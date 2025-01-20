-- View Sample Data from Each Table
-- View data from the cast table
SELECT * FROM cast LIMIT 10;

-- View data from the category table
SELECT * FROM category LIMIT 10;

-- View data from the countries table
SELECT * FROM countries LIMIT 10;

-- View data from the directors table
SELECT * FROM directors LIMIT 10;

-- View data from the netflix_titles table
SELECT * FROM netflix_titles LIMIT 10;

-- View data from the rating table
SELECT * FROM rating LIMIT 10;

-- View data from the show_cast table
SELECT * FROM show_cast LIMIT 10;

-- View data from the show_category table
SELECT * FROM show_category LIMIT 10;

-- View data from the show_country table
SELECT * FROM show_country LIMIT 10;

-- View data from the show_director table
SELECT * FROM show_director LIMIT 10;


 --  Inspect Shows and Their Categories
SELECT 
    nt.title AS Show_Title, 
    c.category AS Category
FROM 
    netflix_titles nt
JOIN 
    show_category sc ON nt.show_id = sc.show_id
JOIN 
    category c ON sc.Cat_ID = c.Cat_ID
LIMIT 10;


-- Inspect Shows and Their Cast
SELECT 
    nt.title AS Show_Title, 
    cs.Name AS Cast_Name
FROM 
    netflix_titles nt
JOIN 
    show_cast sc ON nt.show_id = sc.show_id
JOIN 
    cast cs ON sc.Cast_ID = cs.Cast_ID
LIMIT 10;

-- Inspect Shows and Their Directors
SELECT 
    nt.title AS Show_Title, 
    d.Director_Name AS Director_Name
FROM 
    netflix_titles nt
JOIN 
    show_director sd ON nt.show_id = sd.show_id
JOIN 
    directors d ON sd.Director_Id = d.Director_ID
LIMIT 10;

-- Inspect Shows and Their Ratings
SELECT 
    nt.title AS Show_Title, 
    r.rating AS Rating
FROM 
    netflix_titles nt
JOIN 
    rating r ON nt.Rating_ID = r.Rating_ID
LIMIT 10;

  -- Inspect Shows and Their Countries
  SELECT 
    nt.title AS Show_Title, 
    cn.Country AS Country
FROM 
    netflix_titles nt
JOIN 
    show_country sc ON nt.show_id = sc.show_id
JOIN 
    countries cn ON sc.Country_ID = cn.country_ID
LIMIT 10;

-- Count the total number of rows in each table
SELECT 'cast' AS TableName, COUNT(*) AS TotalRows FROM cast
UNION ALL
SELECT 'category', COUNT(*) FROM category
UNION ALL
SELECT 'countries', COUNT(*) FROM countries
UNION ALL
SELECT 'directors', COUNT(*) FROM directors
UNION ALL
SELECT 'netflix_titles', COUNT(*) FROM netflix_titles
UNION ALL
SELECT 'rating', COUNT(*) FROM rating
UNION ALL
SELECT 'show_cast', COUNT(*) FROM show_cast
UNION ALL
SELECT 'show_category', COUNT(*) FROM show_category
UNION ALL
SELECT 'show_country', COUNT(*) FROM show_country
UNION ALL
SELECT 'show_director', COUNT(*) FROM show_director;

-- Check for orphaned records
SELECT nt.show_id, nt.title
FROM netflix_titles nt
LEFT JOIN show_cast sc ON nt.show_id = sc.show_id
WHERE sc.show_id IS NULL;






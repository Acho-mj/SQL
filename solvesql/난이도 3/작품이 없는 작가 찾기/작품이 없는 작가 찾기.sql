SELECT a.artist_id, name
FROM artists a
LEFT JOIN artworks_artists  aa ON (a.artist_id = aa.artist_id) 
WHERE death_year IS NOT NULL AND artwork_id IS NULL
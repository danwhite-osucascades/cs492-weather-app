CREATE TABLE IF NOT EXISTS location_entries
    (id INTEGER PRIMARY KEY AUTOINCREMENT, 
    city TEXT NOT NULL,
    state TEXT NOT NULL,
    zip TEXT NOT NULL,
    country TEXT NOT NULL,
    latitude NUMBER NOT NULL,
    longitude NUMBER NOT NULL
    );
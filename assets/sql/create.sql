CREATE TABLE IF NOT EXISTS location_entries
    (id INTEGER PRIMARY KEY AUTOINCREMENT, 
    latitude NUMBER NOT NULL,
    longitude NUMBER NOT NULL,
    city TEXT NOT NULL,
    state TEXT NOT NULL,
    zip TEXT NOT NULL
    );
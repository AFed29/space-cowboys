DROP TABLE IF EXISTS bounties;

CREATE TABLE bounties (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
  danger_level VARCHAR(255),
  last_known_location VARCHAR(255),
  cashed_in BOOLEAN
);

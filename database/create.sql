CREATE TYPE GENDER_NAME AS ENUM (
    'Male',
    'Female',
    'Transgender male',
    'Transgender female',
    'Non-binary'
    );

CREATE TABLE gender (
    gender_id SMALLSERIAL PRIMARY KEY,
    name      GENDER_NAME NOT NULL UNIQUE
);

CREATE TYPE INTEREST_NAME AS ENUM (
    'Biking',
    'Hiking',
    'Traveling',
    'Skiing',
    'Snowboarding'
    );

CREATE TABLE interest (
    interest_id SMALLSERIAL PRIMARY KEY,
    name        INTEREST_NAME NOT NULL UNIQUE
);

CREATE TABLE person (
    person_id  SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name  VARCHAR(50) NOT NULL,
    birthday   DATE        NOT NULL,
    -- email               NOT NULL UNIQUE,
    -- interests
    bio        VARCHAR(1000),
    gender_id  SMALLINT    NOT NULL,
    CONSTRAINT check_birthday_age
        CHECK (birthday >= CURRENT_DATE - INTERVAL '100 years'),
    FOREIGN KEY (gender_id)
        REFERENCES gender (gender_id)
);

CREATE TABLE connection (
    person1_id INT NOT NULL,
    person2_id INT NOT NULL,
    CHECK (person1_id < person2_id),
    PRIMARY KEY (person1_id, person2_id),
    FOREIGN KEY (person1_id)
        REFERENCES person (person_id),
    FOREIGN KEY (person2_id)
        REFERENCES person (person_id)
);

CREATE TABLE direct_messages (
    person1_id INT NOT NULL,
    person2_id INT NOT NULL,
    CHECK (person1_id < person2_id),
    PRIMARY KEY (person1_id, person2_id),
    FOREIGN KEY (person1_id)
        REFERENCES person (person_id),
    FOREIGN KEY (person2_id)
        REFERENCES person (person_id)
);
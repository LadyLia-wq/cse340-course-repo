-- ========================================
-- Organization Table
-- ========================================
CREATE TABLE organization (
    organization_id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    description TEXT NOT NULL,
    contact_email VARCHAR(255) NOT NULL,
    logo_filename VARCHAR(255) NOT NULL
);


-- ========================================
-- Insert sample data: Organizations
-- ========================================
INSERT INTO organization (name, description, contact_email, logo_filename)
VALUES
('BrightFuture Builders', 'A nonprofit focused on improving community infrastructure through sustainable construction projects.', 'info@brightfuturebuilders.org', 'brightfuture-logo.png'),
('GreenHarvest Growers', 'An urban farming collective promoting food sustainability and education in local neighborhoods.', 'contact@greenharvest.org', 'greenharvest-logo.png'),
('UnityServe Volunteers', 'A volunteer coordination group supporting local charities and service initiatives.', 'hello@unityserve.org', 'unityserve-logo.png');

SELECT * FROM organization;

-- ========================================
-- Project Table
-- ========================================
CREATE TABLE project (
	project_id SERIAL PRIMARY KEY,
	organization_id INT NOT NULL,
	title VARCHAR(150) NOT NULL,
	description TEXT NOT NULL,
	location VARCHAR(150) NOT NULL,
	project_date DATE NOT NULL,
	FOREIGN KEY (organization_id)
		REFERENCES organization(organization_id)
);

-- ========================================
-- Insert sample data: Project
-- ========================================
INSERT INTO project
(organization_id, title, description, location, project_date)
VALUES

-- BrightFuture Builders (organization_id = 1)
(1, 'Community Center Renovation',
 'Renovating an aging community center to provide safer facilities.',
 'Accra Central', '2026-01-15'),

(1, 'Playground Construction',
 'Building a modern playground for local families and children.',
 'Tema Community Park', '2026-02-20'),

(1, 'School Classroom Expansion',
 'Adding new classrooms to reduce overcrowding in local schools.',
 'Madina', '2026-03-12'),

(1, 'Public Library Upgrade',
 'Improving library infrastructure and study spaces.',
 'Cape Coast', '2026-04-08'),

(1, 'Accessible Ramp Installation',
 'Installing wheelchair-accessible ramps in public buildings.',
 'Kumasi', '2026-05-17'),

-- Keep one GreenHarvest project with an old date
(2, 'Community Garden Project',
 'Creating a shared vegetable garden for neighborhood residents.',
 'East Legon', '2026-01-25'),

-- Future projects
(2, 'Urban Farming Workshop',
 'Teaching sustainable farming techniques to community members.',
 'Achimota', '2026-08-14'),

(2, 'School Vegetable Garden',
 'Helping students establish and maintain a school garden.',
 'Takoradi', '2026-09-20'),

(2, 'Tree Planting Campaign',
 'Planting trees to promote environmental sustainability.',
 'Aburi', '2026-10-22'),

(2, 'Food Sustainability Fair',
 'Hosting an event focused on local food production and education.',
 'Tamale', '2026-11-28'),

(3, 'Food Bank Distribution',
 'Organizing volunteers to distribute food packages to families.',
 'Accra North', '2026-12-10'),

(3, 'Homeless Shelter Support',
 'Providing volunteer assistance at a local shelter.',
 'Tema', '2027-01-18'),

(3, 'Charity Fundraising Event',
 'Coordinating a fundraising event for local charities.',
 'Kumasi', '2027-03-27'),

(3, 'Youth Mentorship Program',
 'Connecting volunteers with youth for mentoring and tutoring.',
 'Sunyani', '2027-05-15'),

(3, 'Community Health Outreach',
 'Supporting free health screenings and awareness campaigns.',
 'Ho', '2027-06-23');

 SELECT * FROM project;

-- ========================================
-- Category Table
-- ========================================
 CREATE TABLE category (
	category_id SERIAL PRIMARY KEY,
	name VARCHAR(100) NOT NULL  UNIQUE
 );


-- ========================================
-- Insert sample data: Category
-- ========================================
INSERT INTO category (name)
VALUES
('Environmental'),
('Educational'),
('Community Service'),
('Health and Wellness');

 SELECT * FROM category;

-- ========================================
-- Project Category Table
-- ========================================
 CREATE TABLE project_category (
    project_id INT NOT NULL,
    category_id INT NOT NULL,

    PRIMARY KEY (project_id, category_id),

    FOREIGN KEY (project_id)
        REFERENCES project(project_id)
        ON DELETE CASCADE,

    FOREIGN KEY (category_id)
        REFERENCES category(category_id)
        ON DELETE CASCADE
);

-- ========================================
-- Insert sample data: Project Category
-- ========================================
INSERT INTO project_category (project_id, category_id)
VALUES
(1, 3),
(2, 3),
(3, 2),
(4, 2),
(5, 3),

(6, 1),
(7, 2),
(8, 2),
(9, 1),
(10, 1),

(11, 3),
(12, 3),
(13, 3),
(14, 2),
(15, 4);

SELECT * FROM project_category;

CREATE table roles (
	role_id SERIAL PRIMARY KEY,
	role_name VARCHAR(50) UNIQUE NOT NULL,
	role_description TEXT
);

INSERT INTO roles (role_name, role_description)
VALUES 
('user', 'Standard user with basic access'),
('admin', 'Administrator with full system access');

SELECT * FROM roles;

CREATE table users (
	user_id SERIAL PRIMARY KEY,
	name VARCHAR(100) NOT NULL,
	email VARCHAR(100) NOT NULL,
	password_hash VARCHAR(255) NOT NULL,
	role_id INT REFERENCES roles(role_id),
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
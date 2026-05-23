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

-- GreenHarvest Growers (organization_id = 2)
(2, 'Community Garden Project',
 'Creating a shared vegetable garden for neighborhood residents.',
 'East Legon', '2026-01-25'),

(2, 'Urban Farming Workshop',
 'Teaching sustainable farming techniques to community members.',
 'Achimota', '2026-02-14'),

(2, 'School Vegetable Garden',
 'Helping students establish and maintain a school garden.',
 'Takoradi', '2026-03-20'),

(2, 'Tree Planting Campaign',
 'Planting trees to promote environmental sustainability.',
 'Aburi', '2026-04-22'),

(2, 'Food Sustainability Fair',
 'Hosting an event focused on local food production and education.',
 'Tamale', '2026-05-28'),

-- UnityServe Volunteers (organization_id = 3)
(3, 'Food Bank Distribution',
 'Organizing volunteers to distribute food packages to families.',
 'Accra North', '2026-01-10'),

(3, 'Homeless Shelter Support',
 'Providing volunteer assistance at a local shelter.',
 'Tema', '2026-02-18'),

(3, 'Charity Fundraising Event',
 'Coordinating a fundraising event for local charities.',
 'Kumasi', '2026-03-27'),

(3, 'Youth Mentorship Program',
 'Connecting volunteers with youth for mentoring and tutoring.',
 'Sunyani', '2026-04-15'),

(3, 'Community Health Outreach',
 'Supporting free health screenings and awareness campaigns.',
 'Ho', '2026-05-23');

 SELECT * FROM project;
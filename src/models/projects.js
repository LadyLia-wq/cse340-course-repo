import db from './db.js';

const getAllProjects = async () => {
    const query = `
        SELECT
            p.project_id,
            p.title,
            p.description,
            p.location,
            p.project_date,
            o.name AS organization_name
        FROM project p
        JOIN organization o
            ON p.organization_id = o.organization_id
        ORDER BY p.project_date;
    `;

    const result = await db.query(query);

    return result.rows;
};

const getProjectsByOrganizationId = async (organizationId) => {
    const query = `
        SELECT
            project_id,
            organization_id,
            title,
            description,
            location,
            project_date
        FROM project
        WHERE organization_id = $1
        ORDER BY project_date;
    `;

    const queryParams = [organizationId];
    const result = await db.query(query, queryParams);

    return result.rows;
};

//GET UPCOMING PROJECTS
const getUpcomingProjects = async (number_of_projects) => {
    const query = `
        SELECT
            p.project_id,
            p.title,
            p.description,
            p.project_date AS date,
            p.location,
            p.organization_id,
            o.name AS organization_name
        FROM project p
        JOIN organization o
            ON p.organization_id = o.organization_id
        WHERE p.project_date >= CURRENT_DATE
        ORDER BY p.project_date ASC
        LIMIT $1;
    `;

    const queryParams = [number_of_projects];

    const result = await db.query(query, queryParams);

    return result.rows;
};

// Get single project details by ID
const getProjectDetails = async (id) => {
    const query = `
        SELECT
            p.project_id,
            p.title,
            p.description,
            p.project_date AS date,
            p.location,
            p.organization_id,
            o.name AS organization_name
        FROM project p
        JOIN organization o
            ON p.organization_id = o.organization_id
        WHERE p.project_id = $1;
    `;

    const queryParams = [id];

    const result = await db.query(query, queryParams);

    return result.rows[0];
};

const getProjectCategories = async (projectId) => {
    const query = `
    SELECT 
    c.category_id,
    c.name
    FROM category c
    JOIN project_category pc
    ON c.category_id = pc.category_id
    WHERE pc.project_id = $1
    ORDER BY c.name;
    `;

    const result = await db.query(query, [projectId]);

    return result.rows;
};

//Insert new service projects
const createProject = async (title, description, location, projectDate, organizationId) => {
    const query = `
    INSERT INTO project (title, description, location, project_date, organization_id)
    VALUES ($1, $2, $3, $4, $5)
    RETURNING project_id;
    `;

    const queryParams = [title, description, location, projectDate, organizationId];
    const result = await db.query(query, queryParams);

    if (result.rows.length === 0) {
        throw new Error('Failed to create project');
    }

    if (process.env.ENABLE_SQL_LOGGING === 'true') {
        console.log('Created new project with ID:', result.rows[0].project_id);
    }

    return result.rows[0].project_id;
}

//Export the model functions
export { 
    getAllProjects, 
    getProjectsByOrganizationId, 
    getUpcomingProjects, 
    getProjectDetails, 
    getProjectCategories,
    createProject
};
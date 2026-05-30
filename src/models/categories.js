import db from './db.js';

const getAllCategories = async () => {
    const query = `
        SELECT category_id, name
        FROM category
        ORDER BY name;
    `;

    const result = await db.query(query);

    return result.rows;
};

const getCategoryById = async (categoryId) => {
    const query = `
    SELECT category_id, name
    FROM category
    WHERE CATEGORY_id = $1;
    `;

    const result = await db.query(query, [categoryId]);

    return result.rows[0];
};

const getProjectsByCategoryId = async (categoryId) => {
    const query = `
    SELECT
        p.project_id,
        p.title
    FROM project p
    JOIN project_category pc
        ON p.project_id = pc.project_id
    WHERE pc.category_id = $1
    ORDER BY p.title;
    `;

    const result = await db.query(query, [categoryId]);

    return result.rows;
};

export { getAllCategories, getCategoryById, getProjectsByCategoryId };
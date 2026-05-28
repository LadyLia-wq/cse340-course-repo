import {
    getUpcomingProjects,
    getProjectDetails
} from '../models/projects.js';

// Constant for number of upcoming projects
const NUMBER_OF_UPCOMING_PROJECTS = 5;

// Show upcoming projects page
const showProjectsPage = async (req, res) => {
    const projects = await getUpcomingProjects(NUMBER_OF_UPCOMING_PROJECTS);

    const title = 'Upcoming Service Projects';

    res.render('projects', { title, projects });
};

// Show single project details page
const showProjectDetailsPage = async (req, res) => {
    // Get project ID from URL parameters
    const id = req.params.id;

    // Retrieve project details from database
    const project = await getProjectDetails(id);

    // Render project details page
    res.render('project', {
        title: project.title,
        project
    });
};

// Export controller functions
export {
    showProjectsPage,
    showProjectDetailsPage
};
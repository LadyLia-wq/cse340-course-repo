import express from 'express';

import { showHomePage } from './controllers/index.js';
import {
    showProjectsPage,
    showProjectDetailsPage,
    showNewProjectForm,
    processNewProjectForm,
    showEditProjectForm,
    processEditProjectForm,
    projectValidation
} from './controllers/projects.js';

import {
    showOrganizationsPage,
    showOrganizationDetailsPage,
    showNewOrganizationForm,
    processNewOrganizationForm,
    organizationValidation,
    showEditOrganizationForm,
    processEditOrganizationForm
} from './controllers/organizations.js';

import { 
    showCategoriesPage, 
    showCategoryDetailsPage,
    showAssignCategoriesForm,
    processAssignCategoriesForm,
    showNewCategoryForm,
    processNewCategoryForm,
    showEditCategoryForm,
    processEditCategoryForm,
    categoryValidation
} from './controllers/categories.js';

import { testErrorPage } from './controllers/errors.js';

import { createUser } from './models/users.js';
import { 
    showUserRegistrationForm, 
    processUserRegistrationForm,
    showLoginForm,
    processLoginForm,
    processLogout,
    requireLogin,
    showDashboard,
    requireRole
} from './controllers/users.js';

const router = express.Router();

router.get('/', showHomePage);

router.get('/organizations', showOrganizationsPage);
router.get('/organization/:id', showOrganizationDetailsPage);

router.get('/projects', showProjectsPage);

// NEW ROUTE
router.get('/project/:id', showProjectDetailsPage);

router.get('/categories', showCategoriesPage);
router.get('/category/:id', showCategoryDetailsPage);

router.get('/new-organization', requireRole('admin'), showNewOrganizationForm);

// Route to handle new organization form submission
router.post('/new-organization', requireRole('admin'), organizationValidation, processNewOrganizationForm);

//Edit organization route
router.get('/edit-organization/:id', requireRole('admin'), showEditOrganizationForm);
router.post('/edit-organization/:id', requireRole('admin'), organizationValidation, processEditOrganizationForm);

//New Service project route
//router for new project page
router.get('/new-project', requireRole('admin'), showNewProjectForm);

//router to handle new project form submission
router.post('/new-project', requireRole('admin'), projectValidation, processNewProjectForm);

// Edit service project routes
router.get('/edit-project/:id', requireRole('admin'), showEditProjectForm);
router.post('/edit-project/:id', requireRole('admin'), projectValidation, processEditProjectForm);

//Assign categories route
router.get('/assign-categories/:projectId', requireRole('admin'), showAssignCategoriesForm);
router.post('/assign-categories/:projectId', requireRole('admin'), processAssignCategoriesForm);

router.get('/new-category', requireRole('admin'), showNewCategoryForm);
router.post('/new-category', requireRole('admin'), categoryValidation, processNewCategoryForm);

router.get('/edit-category/:id', requireRole('admin'), showEditCategoryForm);
router.post('/edit-category/:id', requireRole('admin'), categoryValidation, processEditCategoryForm);

// User registration routes
router.get('/register', showUserRegistrationForm);
router.post('/register', processUserRegistrationForm);

// User login routes
router.get('/login', showLoginForm);
router.post('/login', processLoginForm);
router.get('/logout', processLogout);

//dashboard route
router.get('/dashboard', requireLogin, showDashboard);

// error-handling routes
router.get('/test-error', testErrorPage);

export default router;
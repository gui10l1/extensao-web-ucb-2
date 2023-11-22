const { Router } = require('express');
const router = Router();

const userController = require('../controller/UserController');
const ensureAuth = require('../middleware/ensureAuth');

router.post('/sign-up', userController.signUpUser);
router.post('/login', userController.login);
router.post('/update', userController.updateUser);

router.get('/logout', userController.logout);
router.get('/sign-up', userController.goToSignUpPage);
router.get('/login', userController.goToLoginPage);
router.get('/', userController.goToLoginPage);
router.get('/profile', ensureAuth, userController.goToProfilePage);

module.exports = router;
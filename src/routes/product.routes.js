const { Router } = require('express');
const router = Router();

const productController = require('../controller/ProductController');
const ensureAuth = require('../middleware/ensureAuth');

router.get('/home', ensureAuth, productController.goToHomePage);

router.post('/product', ensureAuth, productController.createProduct);
router.post('/product/delete/:id', ensureAuth, productController.deleteProduct);
router.post('/product/edit/:id', ensureAuth, productController.updateProduct);

module.exports = router;
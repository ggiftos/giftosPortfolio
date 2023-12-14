const express = require('express');
const multer = require('multer');

const {handleErrors, requireAuth} = require('./middlewares');
const productsRepo = require('../../repositories/products');
const productsNewTemplate = require('../../views/admin/products/new');
const productsIndexTemplate = require('../../views/admin/products/index');
const productsEditTemplate = require('../../views/admin/products/edit');
const {requireTitle, requirePrice} = require('./validators');
const products = require('../../repositories/products');

const router = express.Router();
const upload = multer({storage: multer.memoryStorage()});

router.get('/eComm/admin/products', requireAuth, async (req, res) => {
	const products = await productsRepo.getAll();
	res.send(productsIndexTemplate({products}));
});

router.get('/eComm/admin/products/new', requireAuth, (req, res) => {
	res.send(productsNewTemplate({}));
});

router.post('/eComm/admin/products/new',
	requireAuth,
	upload.single('image'),
	[
		requireTitle,
		requirePrice
	],
	handleErrors(productsNewTemplate),
	async (req, res) => {
		const image = req.file.buffer.toString('base64');
		const {title, price} = req.body;
		await productsRepo.create({title, price, image});

		res.redirect('/eComm/admin/products');
	}
);

router.get('/eComm/admin/products/:id/edit',
	requireAuth,
	async (req, res) => {
	const product = await productsRepo.getOne(req.params.id);

	if(!product){
		return res.send('Product not found');
	}

	res.send(productsEditTemplate({product}));
});

router.post('/eComm/admin/products/:id/edit',
	requireAuth,
	upload.single('image'),
	[
		requireTitle,
		requirePrice
	],
	handleErrors(productsEditTemplate, async (req) => {
		const product = await productsRepo.getOne(req.params.id);
		return {product};
	}),
	async (req, res) => {
		const changes = req.body;

		if(req.file){
			changes.image = req.file.buffer.toString('base64');
		}

		try{
			await productsRepo.update(req.params.id, changes);
		} catch(err){
			return res.send('Could not find item');
		}

		res.redirect('/eComm/admin/products');
	}
);

router.post('/eComm/admin/products/:id/delete',
	requireAuth,
	async (req, res) => {
		await productsRepo.delete(req.params.id);

		res.redirect('/eComm/admin/products');
	}
);

module.exports = router;
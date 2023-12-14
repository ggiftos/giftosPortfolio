const express = require('express');
const cartsRepo = require('../repositories/carts');
const productsRepo = require('../repositories/products');
const cartShowTemplate = require('../views/carts/show');

const router = express.Router();

// Receive POST request to add item to a cart
router.post('/eComm/cart/products', async (req, res) => {
	let cart;
	if(!req.session.cartId){
		cart = await cartsRepo.create({ items: [] })
		req.session.cartId = cart.id;
	} else{
		cart = await cartsRepo.getOne(req.session.cartId);
	}

	const existingItem = cart.items.find(item => item.id === req.body.productId);

	if(existingItem){
		existingItem.quantity++;
	} else{
		cart.items.push({id: req.body.productId, quantity: 1});
	}

	await cartsRepo.update(cart.id, {
		items: cart.items
	});

	res.redirect('/eComm/cart');
});

// Receive GET request to show all items in cart
router.get('/eComm/cart', async (req, res) => {
	if(!req.session.cartId){
		return res.redirect('/eComm');
	}

	const cart = await cartsRepo.getOne(req.session.cartId);

	for(let item of cart.items){
		const product = await productsRepo.getOne(item.id);

		item.product = product;
	}

	res.send(cartShowTemplate({items: cart.items}));
});

// Receive POST request to delete an item from a cart
router.post('/eComm/cart/products/delete', async (req, res) => {
	const {itemId} = req.body;
	const cart = await cartsRepo.getOne(req.session.cartId);
	const itemToDelete = cart.items.find(item => item.id === itemId);

	if(itemToDelete.quantity > 1){
		itemToDelete.quantity--;
	} else{
		cart.items = cart.items.filter(item => item.id !== itemId);
	}

	await cartsRepo.update(req.session.cartId, {items: cart.items});

	res.redirect('/eComm/cart');
});

module.exports = router;
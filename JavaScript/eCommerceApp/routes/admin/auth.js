const express = require('express');

const {handleErrors} = require('./middlewares');
const usersRepo = require('../../repositories/users');
const signupTemplate = require('../../views/admin/auth/signup');
const signinTemplate = require('../../views/admin/auth/signin');
const {
	requireEmail,
	requirePassword,
	requirePasswordConfirmation,
	requireEmailExists,
	requireValidPasswordForUser
} = require('./validators');
const signin = require('../../views/admin/auth/signin');

const router = express.Router();

router.get('/eComm/signup', (req, res) => {
	res.send(signupTemplate({req}));
});

router.post('/eComm/signup',
	[
		requireEmail,
		requirePassword,
		requirePasswordConfirmation
	],
	handleErrors(signupTemplate),
	async (req, res) => {
		const {email, password} = req.body;
		const user = await usersRepo.create({email, password});

		req.session.userId = user.id;

		res.redirect('/eComm/admin/products');
});

router.get('/eComm/signout', (req, res) => {
	req.session = null;
	res.send('You are logged out');
});

router.get('/eComm/signin', (req, res) => {
	res.send(signinTemplate({}));
});

router.post('/eComm/signin',
	[
		requireEmailExists,
		requireValidPasswordForUser
	],
	handleErrors(signinTemplate),
	async (req, res) => {
		const {email} = req.body;
		const user = await usersRepo.getOneBy({email});		

		req.session.userId = user.id;

		res.redirect('/eComm/admin/products');
	}
);

module.exports = router;
const mongoose = require('mongoose');

const MONGO_USERNAME = 'mongoadmin';
const MONGO_PASSWORD = 'secret';
const MONGO_HOSTNAME = '127.0.0.1';
const MONGO_PORT = '27888';
const MONGO_DB = 'sharkinfo';

const url = `mongodb://${MONGO_USERNAME}:${MONGO_PASSWORD}@${MONGO_HOSTNAME}:${MONGO_PORT}/${MONGO_DB}?authSource=admin`;

mongoose.connect(url, {useNewUrlParser: true});

const Sequelize = require('sequelize');
const database = require('../db');

const Product = database.define('products', {
    id: {
        type: Sequelize.INTEGER,
        autoIncrement: true,
        allowNull: false,
        primaryKey: true
    },
    name: {
        type: Sequelize.INTEGER,
        allowNull: false
    },
    description: {
        type: Sequelize.TEXT,
        allowNull: true
    },
    price: {
        type: Sequelize.DECIMAL,
        allowNull: false,
        precision: 8,
        scale: 2,
    },
    quantity: {
        type: Sequelize.INTEGER,
        allowNull: false,
        default: 1,
    },
});

module.exports = Product;
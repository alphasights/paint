var compileSass = require('broccoli-sass');

module.exports = compileSass(['styles'], 'paint.scss', 'paint.css');

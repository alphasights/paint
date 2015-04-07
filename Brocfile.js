var compileSass = require('broccoli-sass');

module.exports = compileSass(['.', 'components', 'globals', 'bower_components'], 'paint.scss', 'paint.css');
Paint
=====

Paint is a collection of SCSS functions, mixins, placeholders and global styles that help us bootstrap our internal apps.

The main goal of Paint is to provide a set of easily consumable and extendable tools to developers so they don’t have to “re-invent the wheel” every time they need some basic front-end components.

---

## Setup

Paint comes as a bower package (`paint`) and an npm package (`as-paint`).

To use the **bower package**, run `bower install paint --save-dev`.  
For **npm**, run `npm install as-paint --save-dev`.

There are 2 ways to import paint into an application:

* Out-of-the-box, without any theming / resets.  
For that, just `@import '/bower_components/paint/styles/paint'` or `@import '/node_modules/paint/styles/paint'`

* Allow theming and customising components. In this case, you need to load some components individually and create an app-specific `paint-settings` file _(which will act as your theme file)_:  

```scss
/// Paint Dependencies
@import '/bower_components/paint/styles/dependencies';

/// Paint Core
@import '/bower_components/paint/styles/core';

/// Application-specific Resets
@import 'paint-settings';

/// Paint Tools / Helpers
@import '/bower_components/paint/styles/tools';

/// Import Global Components
@import '/bower_components/paint/styles/global';

/// Import all other Paint Components
@import '/bower_components/paint/styles/components';
```

To make any future changes easier, add all of the above in a `paint-loader.scss` file and import it in your main `application` stylesheet, before the app-specific dependencies and styles, e.g

```scss
/// application.scss
@import 'paint-loader';
@import 'styles';

/// paint-loader.scss
@import '/bower_components/paint/styles/dependencies';
@import '/bower_components/paint/styles/core';
@import 'paint-settings';
@import '/bower_components/paint/styles/tools';
@import '/bower_components/paint/styles/global';
@import '/bower_components/paint/styles/components';

/// styles.scss
@import 'components/custom-component1';
@import 'components/custom-component2';
...
```

---

## Structure

Paint is structured into 4 main sections:

- /CORE - contains a set of functions and mixins that are mandatory for the rest of the paint components to work properly. It includes:
- /TOOLS - a collection of mixins, placeholders and functions that we want to use across all components and the application
- /GLOBAL - This contains the most basic set of components
- /COMPONENTS - A set of generated placeholders commonly used in all applications

Choosing which component goes where is decided mainly by the usage pattern:

- If it uses a core function, it’s at least a tool.
- If it uses a tool, it’s at least a global.
- If it uses globals, it’s a component.

Dependencies on components of the same type is not encouraged.

---

## How to use Paint - The DSL explained

The base layer of functionality Paint provides is a set of functions that can be used consistently to define reusable values for standard properties.

### `rem($value)` - function

This function converts any pixel / units into their REM representation.
_Using REM units for pixel values greater than the base font size to make sure the spacing / sizes are proportional if we change the base. Read more about [typography units](https://snook.ca/archives/html_and_css/font-size-with-rem) here._

__Example:__

* `width: rem(300);` returns `width: 18.75rem` for a 16px REM base.
* `width: rem(16)` returns `width: 1.23077rem` for a 13px REM base and `width: 1rem` for a 16px base.

### `color($style, [$variant])` - function

Function to fetch a color value from the default palette map. _`$variant` is optional, it defaults to `base`_.
Default palette values [here](https://github.com/alphasights/paint/blob/master/styles/tools/_color.scss#L9)

__Example:__

* `color: color(primary)` returns `color: #f36b09` - from `$color-defaults: ... (primary: (base: #f36b09, ...))`
* `border-color: color(border, dark)` returns the dark variant for the border color.

__Customisation:__

Add or update color palettes by defining a `$color` map in your `paint-settings.scss`:

```css
// paint-settings.scss
$color: (
  fancy-labels: (
    cleared: #70c0f2,
    available: #e5c95d,
    interested: #4ba59b,
    pending: #eb5851
  )    
);

// custom-component.scss
color: color(fancy-labels, cleared);

// compiles to
color: #4ba59b;
```

### `gutter($size: base)` - function

Used for general spacing around headings, listing rows, padded containers.
Returns a consistent spacing value proportional to the base font size.
Default size values [here](https://github.com/alphasights/paint/blob/master/styles/tools/_gutter.scss#L7).

__Example:__

* `padding: gutter()` returns `padding: 1.5rem`
* `margin-right: gutter(smaller)` returns `margin-right: 0.375rem`

__Customisation:__

```css
// paint-settings.scss
$gutter: (
  base: 1rem,
  hulk: 10rem
);

// custom-component.scss
padding: gutter(hulk) 0;

//compiles to
padding: 10rem 0;
```

### `radius($style)` - function

__Example:__

__Customisation:__

```css
// paint-settings.scss
$component: (
);

// custom-component.scss


//compiles to

```

### `mq($size, [$options])` - function

__Example:__

__Customisation:__

```css
// paint-settings.scss
$component: (
);

// custom-component.scss


//compiles to

```

### `z($layer)` - function

__Example:__

__Customisation:__

```css
// paint-settings.scss
$component: (
);

// custom-component.scss


//compiles to

```

### `animation($setting, $variant)` - function

__Example:__

__Customisation:__

```css
// paint-settings.scss
$component: (
);

// custom-component.scss


//compiles to

```

### `%clearfix` - placeholder

__Example:__

---

## Customising Component Settings

[upcoming]

---

## Usage Guidelines

Most coding style issues are taken care of automatically by the linter. There are though some things that are difficult to implement/not yet implemented in the linter and you should check manually.

[upcoming]

---

## Contributing

We use `git flow` to manage feature/hotfixes/releases.
The easiest setup is to clone the repository, then run:

```
cd paint
git branch master origin/master
git flow init -d
git flow feature start <your initials>/<feature name>
```

Then, do the work and commit your changes.
```
git flow feature publish <your initials>/<feature name>
```
When done, open a pull request for your feature branch. Make sure you branched-off `develop` not `master`.

### Publishing process _(internal)_

* After the review, merge to `develop`, then create a new release _(vX.xx.xx)_.

* **Bump** Paint version (bower / npm) `bower patch && npm patch`.  
_Npm might return an error, since the tag name might already exist. No worries, all good._

* Push changes and tags

* **Finish** the release, adding the release notes to the description:  

```
## Changelog

* Feature
* Feature
...
```

* Run `npm publish` on master.

* Generate Documentation:

```
npm install -g sassdoc
npm install -g sassdocify
// run the above only once, during app setup

bin/docs
```

_This is going to push documentation to a `gh-pages` branch that automatically updates http://alphasights.github.io/paint/_

If the changes you made affect any `ember-cli-paint` component you also need to:

- Update paint's version in ember-cli-paint `index.js` and `bower.json`
- Release a new version of `ember-cli-paint`
  - `npm version major | minor | patch`
  - `npm publish`

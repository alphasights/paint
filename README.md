Paint
=====

Paint is a collection of SCSS functions, mixins, placeholders and global styles that help us bootstrap our internal apps.

It also acts as an abstraction layer, keeping other frameworks / dependencies away from the applications. This makes structural changes _(like removing a dependency or adding a new one)_ easier to implement.

---

## Setup

Paint comes as a bower package (`paint`) and an npm package (`as-paint`).

To use the **bower package**, run `bower install paint --save-dev`.  
For **npm**, run `npm install as-paint --save-dev`.

This is going to install all dependencies.  

There are 2 ways to import paint into an application:

* Out-of-the-box, without any theming / resets.  
For that, just `@import '/bower_components/paint/styles/paint'` or `@import '/node_modules/paint/styles/paint'`

* Allow theming and customising components. In this case, you need to load some components individually and create an app-specific `paint-settings` file _(which will act as your theme file)_:  
```scss
/// Paint Core
@import '/bower_components/paint/styles/core';

/// Application-specific Resets
@import 'paint-settings';

/// Import Paint Global Settings
@import '/bower_components/paint/styles/settings';

/// Paint Tools / Helpers
@import '/bower_components/paint/styles/tools';

/// Import Global Components
@import '/bower_components/paint/styles/global';

/// Import all Paint Components
@import '/bower_components/paint/styles/components';
```

To make any future changes easier, add all of the above in a `paint-loader.scss` file and import it in your main `application` stylesheet, before the app-specific dependencies and styles, e.g

```scss
/// application.scss
@import 'paint-loader';
@import 'styles';

/// paint-loader.scss
@import '/bower_components/paint/styles/core';
@import 'paint-settings';
@import '/bower_components/paint/styles/settings';
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

Paint is separated into

* Core
* Settings
* Tools
* Globals
* Components

### Core

This contains a set of functions and mixins that are mandatory for the rest of the paint components to work properly. It includes:

```
- core/dependencies
  normalize-scss
  bourbon
- core/functions
  export
  map
  bound
- core/resets
```

### Settings

This contains variables that are shared between globals, tools and components. Settings use the core functions, that's the reason why we need to load Core before.

### Tools

A set of reusable styles that we want to share between the components and throughout the application.

```
- tools/functions
  color
- tools/mixins
  detached-border
  overlay
  bem
- tools/placeholders
  vertical-align
```

### Global

This contains the most basic set of components.  
_Each component might have extra package dependencies that are not defined above._

```
- global/components
  icon
    font-awesome
  button
  grid
    neat (bower) / node-neat (npm)
  typography  
```

### Components

A set of components that are pretty common in all applications

```
- layout
- navigation
- label
- panel
- flip-panel
- side-panel
- tab
- table
- notification
- progress-bar
- form
- quick-jump
- modal
- dropdown
- step
```

**Deprecation warning**  
Most of these components are going to be extracted into separate repos and refactored to make it easier to customise and more flexible to extend.

---

## How to use Paint

[upcoming]

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

Then, do work and commit your changes.
```
git flow feature publish <your initials>/<feature name>
```
When done, open a pull request for your feature branch. Make sure you branched-off `develop` not `master`.

### Publishing process _(internal)_

After the review, we merge the PR to `develop`, then create a new release _(vX.xx.xx)_. Then we

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

* Run `npm publish`, preferably on master.

* Generate Documentation:

```
npm install -g sassdoc
npm install -g sassdocify
// run the above just once

bin/docs
```

_This is going to push documentation to a `gh-pages` branch that automatically updates http://alphasights.github.io/paint/_

If the changes you've made affect any `ember-cli-paint` component you also need to:

- Update paint's version in ember-cli-paint `index.js` and `bower.json`
- Release a new version of `ember-cli-paint`
  - `npm version major | minor | patch`
  - `npm publish`

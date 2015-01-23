Paint
=====

Paint is a collection of SCSS mixins, placeholders and global styles to bootstrap all our apps.
Mixins and placeholders with the same prefix are put in a single file. This file is generically named "component".
The prefix represents the broad category to which the mixins or placeholders belong, e.g. "button" or "grid".

Paint is thought as an extension of Foundation, and many of the components share prefixes with the Foundation ones (for instance, we don't redefine the "button" mixin inside Paint because it's already present in Foundation). We also try to use Foundation variables as much as possible before defining our own.


## Inside a component

Let's have a look at how the button component is implemented.

```scss
// We import any components or files we depend on
@import "icon";

// We expose configuration options by declaring default settings
$button-base-background-color: $white !default;
$button-base-text-color: $jumbo !default;
$button-icon-size: 28px !default;
$button-primary-background-color: #008fd9 !default;

// If this component extends a Foundation one, we configure it
$include-html-paint-button: true !default;

// We declare any sub-placeholder or mixin before the main one
@mixin button-icon($icon) {
  @extend %button-icon;
  @include icon($icon);
}

%button-icon {
  margin-bottom: 0;
  padding: 0;

  &:before {
    display: block;
    line-height: $button-icon-size;
    width: $button-icon-size;
  }
}

/* We declare the main placeholder. Every component should expose at least one placeholder that has the same name of the file it's contained in. Placeholders should "materialize" the most common usages of the mixin declared by the component. The declaration of the mixin is optional, since it could happen that nothing in the component is configurable, or that the mixin is already declared inside Foundation. */

%button {
  // We include the mixin(s) we are materializing into a placeholder.
  @include button-base;
  
  // We declare additional properties not included in the mixin (this should not be needed in case you're the author of the mixin)
  background-color: $button-base-background-color;
  color: $button-base-text-color;
  border: 1px solid lighten($button-base-text-color, 20%);
  border-radius: $global-radius;
  
  &:hover {
    color: darken($button-base-text-color, 20%);
  }

  &:focus {
    outline: 0;
  }
}

// We declare additional placeholders
%button-primary {
  @include button(
    $bg: $button-primary-background-color,
    $padding: $column-gutter / 2,
    $radius: $global-radius
  );

  font-size: $small-font-size;
  font-weight: $font-weight-bold;
  text-transform: uppercase;
}

// We declare any component-specific global styles. The exports mixin should be included with the name of the component prefixed by 'paint-'
@include exports("paint-button") {
  @if $include-html-paint-button {
    button {
      @extend %button;
    }
  }
}
```

## Coding style

Most coding style issues are taken care of automatically by the linter. There are though some things that are difficult to implement/not yet implemented in the linter and you should check manually.

- Any selector that uses pseudo classes should be put at the end of the selector they refer to, using the SCSS `&` operator
- Every variable declared inside a component should be prefixed by the component's name and a dash, e.g.: `button-`
- Mixins that do not have a corresponding placeholder should be put in the `globals/mixins.scss` file.
- Not everything should be exposed as a setting. If a setting is dependent on another one, and it's not reused, you should avoid creating a separate variable. Not only this would pollute the top of the file too much, but it could expose "implementation" details to the user of your component.


## Contributing

Clone the repository.  Then, run:

    cd paint
    git branch master origin/master
    git flow init -d
    git flow feature start <your feature>

Then, do work and commit your changes.

    git flow feature publish <your feature>

When done, open a pull request to your feature branch.

## Releasing

In order to make use of Paint changes in your project you need to:

- Bump paint's version in bower.json using `bower version major | minor | patch`
- Push git tags to GitHub
- Update paint's version in your project bower.json

If the changes you've made affect ember-cli-paint Ember component you also need to:

- Update paint's version in ember-cli-paint index.js and bower.json
- Release a new version of ember-cli-paint
  - `npm version major | minor | patch`
  - `npm publish`

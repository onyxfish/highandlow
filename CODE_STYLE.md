Coding Style
============

Syntax
------

* `{` on next line for classes and functions. Braces on the same line for loops and conditionals.
* `}` always on the next line.

Naming
------

* Class names are `TitleCase`.
* Function and variable names are `camelCase`.
* Private member variables are prefixed with `_`.

Layout
------

* 4-space indentation.
* No spaces between variable names, `:` and type.
* Spaces around `:` when declaring function return types.
* Divide imports into three groups: 1) standard libraries, 2) third-party libraries and 3) our own code. Alphabetize within each group.

Classes
-------

* Private member variables are prefixed with a single `_`.
* Never use `private` to declare member variables. (It's the default.)
* Abstract classes have a `private` constructor.

Documentation
-------------

* Classes and functions are prefixed with `/** Javadoc */`.

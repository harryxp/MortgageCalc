Mortgage Calculator in Haskell.

This demonstrates how a command line interface and a web interface can share
the same Haskell library.

See [ghcjs-playground](https://github.com/harryxp/ghcjs-playground) for general
instructions for setting up a `ghcjs` project.

Standalone (command line):

    cd standalone
    stack setup

    stack build
    stack exec MortgageCalc
    stack exec MortgageCalc -- -v 400000 4.5 30
    stack exec MortgageCalc -- 400000 4.5 30

Web:

    cd web
    stack setup

    stack build
    open index.html     # generated JS files are referenced by index.html

[Link to the calculator.](https://cdn.rawgit.com/harryxp/MortgageCalc/326b42c3/web/dist/index.html)

TODO:

* Move common library code to a proper place.
* Input rate as `3.5` instead of `0.035`.
* There's a small difference between results calculated by Haskell and JavaScript compiled from Haskell.


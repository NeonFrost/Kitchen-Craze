# Kitchen Craze
Kitchen Craze is a very very simple video game. It's purpose is to test out the Tamias game engine.

Kitchen Craze is licensed under GPL v3 with the Tamias game engine licensed under the MIT license

With the release of SBCL 2.3.2 Kitchen Craze can now be run on Windows. The only platform I've tested it on is Windows 10.

# Releases

Zips of KC can be found here: https://www.indiedb.com/games/kitchen-craze/downloads

Unzip and then execute "vidya" (VOLUME WARNING)

# Running
Use SBCL because I know KC/SB will work with SBCL.

If you don't have it, install quicklisp, link it up with SBCL. Once that's all done then, in the directory where KC/SB is located:

(load "compile.cl") (main)

A window should pop up after a couple of seconds. If any errors come up, make sure you have the sdl2 development libs installed.



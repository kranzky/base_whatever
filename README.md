Secret
======

Create and remember an unguessable secret.

Read this blog post for more information, then visit
secret.kranzky.com to get started!

Overview
--------

Your password is hard to remember but easy to guess. That's the wrong way
around. You should do this instead:

1. Choose a really, really big random number.
2. Encode that number as a sequence of simple words.
3. Commit the words to memory by creating a funny story.
4. Use these words as the only password you need to remember.

Usage
-----

Start by visiting secret.kranzky.com

You will be asked to select how secure you would like your secret to be.
We recommend a six-word secret (which has an entropy of 72 bits), but you
are free to select between 2 and 10 words.

You will then need to generate a random number. This can be done by using
a cryptographically secure pseudo random number generator, or by using
random.org, or by flipping coins and rolling dice in the real word.

Installation
------------

```
> nvm use 7.10.0
> yarn global add quasar-cli --global-folder=`yarn global bin`
> yarn install
> quasar dev
```

Copyright
---------

Copyright (c) 2017 Jason Hutchens. See UNLICENSE for further details.

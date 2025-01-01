Clausewitch
===========

A Magic:the Gathering deck simulator in Prolog.

This is meant to be a very simple, partial simulator of a M:tG game. The
motivation is to optimise a specific deck for M:tG Arena that I'm working on.
The deck has a mana acceleration engine based on `Forsaken Monument` and
colourless mana-producing artifacts such as `Mind Stone` and `Worn Powerstone`.
There are only limited card options for this kind of deck in Historic so I want
to find the best configuration for the engine. This is hard to do just by
playtesting the deck (against human players, or ... Sparky) so I've written some
Prolog to optimise it to model the engine-building problem as a combinatorial
optimisation problem.

Combinatorial optimisation is hard (as in NP-Hard) and fully simulating a
complete M:tG game will only make it harder, because the number of variables
needed to describe the game state will blow up. Therefore this project mainly
takes into account the mana cost of cards and the maximum amount of mana they
could add to a player's mana pool in a turn. This should be enough to give a
rough and ready approximation of the optimal engine build.

If this works at all well I will probably hack at it a bit more and make it
possible to simulate a) more of the game and b) more decks. If it doesn't work,
oh well. The journey is more important than the destination.

Unless you're going to Paris. We'll always have Paris.

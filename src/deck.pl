:-module(deck, [draws/4
               ,draw/3
               ,deck_assembler/3
               ,deck_scrambler/2
               ]).

:-use_module(data(deck_database)).
:-use_module(data(card_database)).

/** <module> Construct and manage Magic: the Gathering decks.

*/


%!      decks(+K,+Cards,-Draws,-Rest) is det.
%
%       Draw K cards from the top of a deck in order.
%
%       K is an integer, the number of cards to draw from the top of a
%       deck.
%
%       Cards is the list of cards in the deck.
%
%       Draws is a list of the first K cards in Cards.
%
%       Rest is the cards remaining in Cards after the first K are
%       drawn.
%
%       Example query:
%       ==
%       ?- _M = deck
%       ,_M:deck_assembler(maindeck,colourless_1,_Ds)
%       ,length(_Ds,N)
%       ,_M:deck_scrambler(_Ds,_Ss)
%       ,_M:draws(7,_Ss,_Rs,_Cs)
%       ,maplist(writeln,_Rs).
%
%       karn_1
%       crawling_barrens
%       inventors_fair
%       worn_powerstone
%       irencrag
%       karn_1
%       guardian_idol
%       N = 61.
%       ==
%
draws(K,Cs,Ds,Cs_):-
        draws(0,K,Cs,Ds,[],Cs_).

%!      draws(+Counter,+K,+Cards,+Acc,-Drawn,-Rest) is det.
%
%       Business end of draws/4.
%
draws(K,K,Cs,Ds,Ds,Cs):-
        !.
draws(I,K,[C|Cs],[C|Acc],Ds_Bind,Cs_Bind):-
        succ(I,J)
        ,draws(J,K,Cs,Acc,Ds_Bind,Cs_Bind).



%!      draw(?Cards,?Card,?Remaining) is semidet.
%
%       Draw one card from a list of Cards.
%
%       Cards is a list of cards.
%
%       Card is the first card in the list.
%
%       Remaining are the cards in the list after Card.
%
%       Simple head-tail splitter, used to draw the top card from a
%       deck.
%
draw([C|Cs],C,Cs).


%!      deck_assembler(+Type,+Deck,-Cards) is det.
%
%       Assemble a set of Cards in a Deck.
%
%       Type is the type of deck, one of: [maindeck,sideboard].
%
%       Deck is the identifier of the deck, matching the first argument
%       of a deck/2 clause in the deck database.
%
%       Cards is the list of card identifiers in the deck matching the
%       first argument of a card/6 clause in the card database, sorted
%       by card identifier. Each identifier is included N times in
%       Cards, where N is the number of copies of the card in the deck,
%       matching the third argument of a deck_card/4 clause in the deck
%       database.
%
%       Example:
%
%       ==
%       ?- deck:deck_assembler(sideboard,colourless_1,_Ds)
%       ,length(_Ds,N)
%       ,maplist(writeln,_Ds).
%
%       akromas_memorial
%       amulet_of_safekeeping
%       candy_trail
%       darksteel_citadel
%       forsaken_monument
%       god_pharaohs_statue
%       grafdiggers_cage
%       perilous_vault
%       planar_bridge
%       platinum_angel
%       ratchet_bomb
%       sorcerous_spyglass
%       stone_brain
%       transmogrifying_wand
%       weathered_runestone
%       N = 15.
%       ==
%
deck_assembler(T,D,Ds):-
        findall(Ci
               ,(order_by([asc(Ci)],
                          deck_card(D,Ci,K,T)
                         )
                ,between(1,K,_)
                )
               ,Ds).



%!      deck_scrambler(+Deck,-Shuffled) is det.
%
%       Shuffle a Deck.
%
%       Thin shell around random_permutation/2 returning the list
%       of cards in Deck in a randomly shuffled order.
%
%       Deck is a list of card identifiers as returned by
%       deck_assembler/3.
%
%       Shuffled is the list of cards in Deck, in a random order.
%
deck_scrambler(Ds,Ss):-
        random_permutation(Ds,Ss).

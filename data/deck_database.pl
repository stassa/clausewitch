:-module(deck_database,[deck/2
                       ,deck_card/4
                       ]).

/** <module> A database of M:tG decks.
*/

%!      deck(?Id,?Name) is semidet.
%
%       The Identifier and Name of a deck.
%
%       Fields:
%       * Id: an identifier used to refer to the deck internally.
%       * Name: a user-friendly name for the deck.
%
deck(colourless_1,'Ulamog et al. v.1.5.3').


%!      deck_card(?DeckId,?CardId,?Copies,?MainOrSide) is semidet.
%
%       A card in a deck.
%
%       Fields are as follows:
%       * DeckID: the identifier for the deck this card is included in,
%       matching the first argument of a card/2 clause.
%       * CardId: the identifier for the card in the card database
%       matching the first argument of a card/6 clause.
%       * Copies: the number of copies of this card included in the
%       deck.
%       * MainOrSide: whether the card is included in the main deck or
%       sideboard.
%
%
deck_card(colourless_1,candy_trail,3,maindeck).
deck_card(colourless_1,guardian_idol,4,maindeck).
deck_card(colourless_1,mind_stone,4,maindeck).
deck_card(colourless_1,irencrag,3,maindeck).
deck_card(colourless_1,unstable_obelisk,1,maindeck).
deck_card(colourless_1,worn_powerstone,3,maindeck).
deck_card(colourless_1,karn_1,4,maindeck).
deck_card(colourless_1,forsaken_monument,3,maindeck).
deck_card(colourless_1,ugin_1,4,maindeck).
deck_card(colourless_1,ugin_2,4,maindeck).
deck_card(colourless_1,ulamog,3,maindeck).
deck_card(colourless_1,crawling_barrens,4,maindeck).
deck_card(colourless_1,crystal_grotto,2,maindeck).
deck_card(colourless_1,inventors_fair,3,maindeck).
deck_card(colourless_1,labyrinth_of_skopos,4,maindeck).
deck_card(colourless_1,mobilized_district,4,maindeck).
deck_card(colourless_1,ugins_labyrinth,4,maindeck).
deck_card(colourless_1,zhalfirin_void,4,maindeck).
% Sideboard
deck_card(colourless_1,candy_trail,1,sideboard).
deck_card(colourless_1,transmogrifying_wand,1,sideboard).
deck_card(colourless_1,perilous_vault,1,sideboard).
deck_card(colourless_1,forsaken_monument,1,sideboard).
deck_card(colourless_1,planar_bridge,1,sideboard).
deck_card(colourless_1,akromas_memorial,1,sideboard).
deck_card(colourless_1,darksteel_citadel,1,sideboard).
deck_card(colourless_1,grafdiggers_cage,1,sideboard).
deck_card(colourless_1,amulet_of_safekeeping,1,sideboard).
deck_card(colourless_1,ratchet_bomb,1,sideboard).
deck_card(colourless_1,sorcerous_spyglass,1,sideboard).
deck_card(colourless_1,stone_brain,1,sideboard).
deck_card(colourless_1,weathered_runestone,1,sideboard).
deck_card(colourless_1,god_pharaohs_statue,1,sideboard).
deck_card(colourless_1,platinum_angel,1,sideboard).


:-module(clausewitch, [game_init/3
                      ,draw_card/2
                      ,play_card/2
                      ,state/7
                      ,library/2
                      ,hand/2
                      ,play_area/2
                      ,sideboard/2
                      ]).

:-use_module(project_root(configuration)).
:-use_module(src(deck)).
:-use_module(data(card_database)).

/** <module> Simulate Magic the Gathering deck behaviour.

Example of behaviour so-far:

==
?- debug(play_card).
true.

?- game_init(simple,colourless_1,_Ss), draw_card(_Ss,_Ss2), play_card(_Ss2,_Ss3), state(_Ss3,T,M,Ls,Hs,Ps,Bs).
% Cards: [guardian_idol,crawling_barrens,mind_stone,crawling_barrens,inventors_fair,mind_stone,candy_trail,ugins_labyrinth]
% Playing card: crawling_barrens
T = M, M = 1,
Ls = [ugin_2,ulamog,mind_stone,crystal_grotto,zhalfirin_void,ulamog,labyrinth_of_skopos,karn_1,crawling_barrens,forsaken_monument,zhalfirin_void,ugin_2,worn_powerstone,worn_powerstone,mobilized_district,ugins_labyrinth,ugin_1,inventors_fair,forsaken_monument|...],
Hs = [guardian_idol,mind_stone,crawling_barrens,inventors_fair,mind_stone,candy_trail,ugins_labyrinth],
Ps = [crawling_barrens],
Bs = [akromas_memorial,amulet_of_safekeeping,candy_trail,darksteel_citadel,forsaken_monument,god_pharaohs_statue,grafdiggers_cage,perilous_vault,planar_bridge,platinum_angel,ratchet_bomb,sorcerous_spyglass,stone_brain,transmogrifying_wand,weathered_runestone].
==

*/

%!      player_strategy(?Strategy) is semidet.
%
%       An identifier for a player's Strategy.
%
%       Used to select clauses of predicates that manage playing
%       decisions.
%
%       Known strategies:
%       * next_card: selects the next card (first in the list) in the
%       current Hand and plays it, if mana permits.
%
%       @tbd Move to configuration module.
%
player_strategy(next_card).


%!      init_cards_drawn(?Cards) is semidet.
%
%       Number of cards to draw when starting the game.
%
%       Normally that's 7.
%
%       @tbd Move to configuration module.
%
init_cards_drawn(7).


%!      game_init(+Representation,+Deck,-State) is det.
%
%       Initialise a new game State.
%
%       Representation is the representation of the game state,
%       curretnly only the atom "simple" for a simplified
%       representation that abstracts away most of a card's abilities
%       and measures mainly its mana cost and mana production.
%
%       Deck is the name of a deck in the deck database.
%
%       State is a game state, represented as a Prolog list of the form
%       [T,M,Ls,Hs,Ps,Bs], where:
%       * T is an integer, the current turn (set to 0 initially).
%       * M is the current maximum mana producible by permanents in play
%       (set to 0 initially).
%       * Ls, Hs, Ps and Bs are lists of atomic names represenging cards
%       in Library, Hand, Play and Sideboard, respectively. The
%       Graveyard is not modelled in the 'simple' representation.
%
game_init(simple,D,[0,0,Ls,Hs,[],Bs]):-
        init_cards_drawn(N)
        ,deck_assembler(maindeck,D,Ls_)
        ,deck_assembler(sideboard,D,Bs)
        ,deck_scrambler(Ls_,Ls_s)
        ,draws(N,Ls_s,Hs,Ls).


%!      state(?State,?Turn,?Mana,?Lib,?Hand,?Play,?Board) is semidet.
%
%       A game State and its constituent elements.
%
%       Helper predicate to inspect or compose a game state.
%
%       State is a Prolog list repreenting a game state.
%
%       Turn is the current turn in the given State.
%
%       Mana is the current maximum amount of mana producible by
%       permanents in play, in the current State.
%
%       Lib is the player's library, Hand their hand, Play the play area
%       and Board their sidebarod, in the given State.
%
state([T,M,Ls,Hs,Ps,Bs],T,M,Ls,Hs,Ps,Bs).


%!      library(?State,?Library) is semidet.
%
%       A player's Library in the given game State.
%
library([_T,_M,Ls,_Hs,_Ps,_Bs],Ls).


%!      hand(?State,?Hand) is semidet.
%
%       A player's Hand in the given game State.
%
hand([_T,_M,_Ls,Hs,_Ps,_Bs],Hs).


%!      play_area(?State,?Play) is semidet.
%
%       The Play area in the given game State.
%
play_area([_T,_M,_Ls,_Hs,Ps,_Bs],Ps).


%!      sidebarod(?State,?Board) is semidet.
%
%       A player's Sideboard in the given game State.
%
sideboard([_T,_M,_Ls,_Hs,_Ps,Bs],Bs).


%!      draw_card(+StateIn,-StateOut) is semidet.
%
%       Move a card from a player's Library to their Hand.
%
draw_card([T,M,[C|Ls],Hs,Ps,Bs],[T,M,Ls,[C|Hs],Ps,Bs]).


%!      play_card(+StateIn,-StateOut) is semidet.
%
%       Move a card from a player's Hand to the Play area.
%
%       Currently a stump that always plays the first card in the
%       player's hand that can be played with the current mana
%       production and then ends the turn.
%
%       @tbd Make this an actual card play decision.
%
play_card([T,M0,Ls,Hs,Ps,Bs],[T_,M2,Ls,Hs_,[C|Ps],Bs]):-
        player_strategy(next_card)
        ,debug(play_card,'Cards: ~w',[Hs])
        ,select(C,Hs,Hs_)
        ,pay_mana_cost(C,M0,M1)
        ,debug(play_card,'Playing card: ~w',[C])
        ,!
        ,add_to_mana_production(C,M1,M2)
        ,succ(T,T_).


%!      pay_mana_cost(+CardId,+Mana,-New) is det.
%
%       Pay the Mana cost for one Card and update Mana Production.
%
pay_mana_cost(C,M,M_):-
        card_field_value(C,cost,MC)
        ,M_ is M - MC
        ,M_ >= 0.


%!      add_to_mana_production(+CardId,+Mana,-New) is det.
%
%       Update Mana production after playing a card.
%
add_to_mana_production(C,M,M_):-
        card_field_value(C,mana,MP)
        ,M_ is M + MP.

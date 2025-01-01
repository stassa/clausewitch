:-module(card_database,[card_field_value/3
                       ,card/6
                       ]).

/** <module> Magic: the Gathering card database.

*/

%!      card_field_value(+CardId,+FieldId,-Value) is det.
%
%       Query the Value of a name Field in a Card.
%
%       Interface to card/6 terms. Allows the values of card/6 fields to
%       be retrieved by name. The names of fields, and their indices
%       in card/6 terms are defined in card_field/2.
%
card_field_value(Id,F,V):-
        must_be(oneof([id,name,cost,mana,wait,legend]),F)
        ,card_field(F,I)
        ,T = card(Id,_Name,_Cost,_Mana,_Wait,_Legegnd)
        ,call(T)
        ,arg(I,T,V).


%!      card_field(?Field,?Index) is semidet.
%
%       The Index of a named Field in a card/6 clause.
%
%       Used to index into a card/6 term with arg/3 and friends.
%
%       @tbd Move to configuration module.
%
card_field(id,1).
card_field(name,2).
card_field(cost,3).
card_field(mana,4).
card_field(wait,5).
card_field(legend,6).


%!      card(?Id,?Name,?Cost,?Mana,?Wait,?Legend) is semidet.
%
%       A simplified description of a Magic card.
%
%       Represented fields are as follows:
%       * Id: an internal identifier for the card, used to match it with
%       other database predicates.
%       * Name: The name printed on the card.
%       * Cost: The card's mana cost.
%       * Mana: the amount of mana produced by the card.
%       * Wait: 'false' if the card can tap the turn it enters play, or
%       'true' otherwise. e.g. a creature without haste must "wait" so
%       this field would be "true". If the card doesn't tap then Wait is
%       'nil'.
%       * Legend: true of the card is legendary, false otherwise.
%
%       For now this is a very simple representation of cards without
%       any real attempt to represent their abilities. The goal is to be
%       able to simulate draws and mana production over time.
%
card(candy_trail,'Candy Trail',1,0,false,false).
card(guardian_idol,'Guardian Idol',2,1,true,false).
card(mind_stone,'Mind Stone',2,1,false,false).
card(irencrag,'The Irencrag',2,1,false,true).
card(unstable_obelisk,'Unstable Obelisk',3,1,false,false).
card(worn_powerstone,'Worn Powerstone',3,2,true,false).
card(karn_1,'Karn, the Great Creator',4,0,false,true).
card(forsaken_monument,'Forsaken Monument',5,0,false,true).
card(ugin_1,'Ugin, the Ineffable',6,0,false,true).
card(ugin_2,'Ugin, the Spirit Dragon',8,0,false,true).
card(ulamog,'Ulamog, the Ceaseless Hunger',10,0,false,true).
card(crawling_barrens,'Crawling Barrens',0,1,false,false).
card(crystal_grotto,'Crystal Grotto',0,1,false,false).
card(inventors_fair,'Inventor\'s Fair',0,1,false,true).
card(labyrinth_of_skopos,'Labyrinth of Skopos',0,1,false,false).
card(mobilized_district,'Mobilized District',0,1,false,false).
card(ugins_labyrinth,'Ugin\s Labyrinth',0,1,false,false).
card(zhalfirin_void,'Zhalfirin Void',0,1,false,false).
card(transmogrifying_wand,'Transmogrifying Wand',3,0,false,false).
card(perilous_vault,'Perilous Vault',4,0,true,false).
card(planar_bridge,'Planar Bridge',6,0,true,true).
card(akromas_memorial,'Akroma\s Memorial',7,0,nil,true).
card(darksteel_citadel,'Darksteel Citadel',0,1,true,false).
card(grafdiggers_cage,'Grafdigger\s Cage',1,0,nil,false).
card(amulet_of_safekeeping,'Amulet of Safekeeping',2,0,nil,false).
card(ratchet_bomb,'Ratchet Bomb',2,0,true,false).
card(sorcerous_spyglass,'Sorcerous Spyglass',2,0,nil,false).
card(stone_brain,'The Stone Brain',2,0,true,true).
card(weathered_runestone,'Weathered Runestone',2,0,nil,false).
card(god_pharaohs_statue,'God-Pharaoh\s Statue',6,0,nil,true).
card(platinum_angel,'Platinum Angel',7,0,false,false).

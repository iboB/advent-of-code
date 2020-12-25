lm = 20201227;
card = 9033205;
door = 9281649;
(* card = 5764801;
door = 17807724; *)

Print@PowerMod[door, MultiplicativeOrder[7, lm, {card}], lm]

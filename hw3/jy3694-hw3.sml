(*========================================
==========================================
Question 4
==========================================*)

(*============Question 4.1================*)
fun test1 (x, []) = [x]
  | test1(x, y::ys) = x :: test1(y, ys);

test1(2, [1,2]);
test1("hello", ["there"]);

(*============Question 4.2================*)
fun test2 pred [] y = y
  | test2 pred (x::xs) y = test2 pred xs (pred(x, y));

test2 (fn (x, y) => y) [1,2,5] 4;

(*============Question 4.3================*)
datatype ('a, 'b) tree = Leaf of 'a
                        | Node of 'a * 'b;
fun test3 (Node(x, y)) pred1 pred2= 
  let
     val tmp1 = (pred1 x)
     val tmp2 = (pred2 tmp1 y)
     val tmp3 = (pred2 tmp2 y)
  in
    Node(x, tmp2)
  end

(*========================================
==========================================
Question 5
==========================================*)

(*============Question 5.1================*)
fun digitsPos x = if x < 10 then [x] else digitsPos (x div 10) @ [x mod 10];
(*
(if (digitsPos 3124) = [3,1,2,4] then print("digitsPos passes\n") 
else print("digitsPos fails\n"));
(if (digitsPos 352663) = [3,5,2,6,6,3] then print("digitsPos passes\n") 
else print("digitsPos fails\n"));*)

(*============Question 5.2================*)
fun additivePersistence x = 
  let 
    fun sum_all_digits(x) = if x < 10 then x else x mod 10 + sum_all_digits(x div 10)
    fun count_digits_length(x) = if x < 10 then 1 else 1 + count_digits_length(x div 10)
    val tmp = sum_all_digits(x)
    val tmp_length = count_digits_length(x)
  in
    if tmp_length = 1 then 1 
    else (if count_digits_length(tmp) = 1 then 1 else 1+(additivePersistence tmp))
  end;

fun digitalRoot x = 
  let 
    fun sum_all_digits(x) = if x < 10 then x else x mod 10 + sum_all_digits(x div 10)
  fun count_digits_length(x) = if x < 10 then 1 else 1 + count_digits_length(x div 10)
    val tmp = sum_all_digits(x)
    val tmp_length = count_digits_length(x)
  in
    if tmp_length = 1 then tmp else (digitalRoot tmp)
  end;
(*
(if (additivePersistence 9876) = 2 then print("additivePersistence passes\n") 
else print("additivePersistence fails\n"));
(if (digitalRoot 9876) = 3 then print("digitalRoot passes\n") 
else print("digitalRoot fails\n"));
(if (additivePersistence 5) = 1 then print("additivePersistence passes\n") 
else print("additivePersistence fails\n"));
(if (digitalRoot 5) = 5 then print("digitalRoot passes\n") 
else print("digitalRoot fails\n"));*)

(*============Question 5.3================*)
fun alternate(L) = 
  if L = nil then 0 else hd(L) + sub(tl(L))
and sub(L) = 
  if L = nil then 0 else 0 - alternate(tl(L));
(*
(if (alternate [1,2,3,4]) = ~2 then print("alternate passes\n") 
else print("alternate fails\n"));*)

(*============Question 5.4================*)
fun alternate2 [] f g = 0
  | alternate2 [x1, x2] f g = f(x1, x2)
  | alternate2 (x1::x2::xs) f g = 
    let 
      val tmp = f(x1, x2) :: xs
    in 
      alternate3 tmp f g
    end 
and alternate3 [] f g = 0
  | alternate3 [x1, x2] f g = g(x1, x2)
  | alternate3 (x1::x2::xs) f g = 
    let 
      val tmp = g(x1, x2) :: xs
    in 
      alternate2 tmp f g
    end;
(*
(if (alternate2 [1,2,3,4] op+ op-) = 4 then print("alternate2 passes\n") 
else print("alternate2 fails\n"));*)

(*============Question 5.5================*)
fun scan_left f y [] = []
  | scan_left f y (x::xs) = 
  let
    fun acc (y, ys) =
      if null ys 
        then []
      else
        (f (hd ys) y) :: acc((f (hd ys) y), tl ys)
  in 
    y :: acc(y, x::xs)
  end;
(*
(if (scan_left (fn x => fn y => x+y) 0 [1, 2, 3]) = [0, 1, 3, 6] then print("scan_left passes\n") 
else print("scan_left fails\n"));*)

(*============Question 5.6================*)
fun zipRecycle(xs, ys) = 
  let
    fun helper x y 0 = []
      | helper [] (T as (head_y::tail_y)) len = helper xs T len
      | helper (T as (head_x::tail_x)) [] len = helper T ys len
      | helper (head_x::tail_x) (head_y::tail_y) len = (head_x, head_y)::(helper tail_x tail_y (len-1))
    fun list_length x = if null x then 0 else 1 + list_length (tl x)
  in
    helper xs ys (list_length ys)
  end;
(*
(if (zipRecycle([1,2,3], ["a","b","c"])) = [(1, "a"), (2, "b"), (3, "c")] 
  then print("zipRecycle passes\n") 
else print("zipRecycle fails\n"));
(if (zipRecycle ([1,2,3,4,5], ["a","b","c"])) = [(1, "a"), (2, "b"), (3, "c")] 
  then print("zipRecycle passes\n") 
else print("zipRecycle fails\n"));
(if (zipRecycle ([1,2,3], ["a","b","c", "d", "e"])) = [(1, "a"), (2, "b"), (3, "c"), (1, "d"), (2, "e")] 
  then print("zipRecycle passes\n") 
else print("zipRecycle fails\n"));
(if (zipRecycle ([1,2,3], ["a","b","c", "d", "e", "f", "g"])) = [(1, "a"), (2, "b"), (3, "c"), (1, "d"), (2, "e"), (3, "f"), (1, "g")] 
  then print("zipRecycle passes\n") 
else print("zipRecycle fails\n"));*)

(*============Question 5.7================*)
fun add x y = x + y;
fun bind NONE (SOME y) f = NONE 
  | bind (SOME x) NONE f = NONE
  | bind (SOME x) (SOME y) f = SOME (f x y);

(*
(if (bind (SOME 4) (SOME 3) add) = (SOME 7)
  then print("bind passes\n") 
else print("bind fails\n"));
(if (bind (SOME 4) NONE add) = NONE
  then print("bind passes\n") 
else print("bind fails\n"));*)

(*============Question 5.8================*)
fun lookup (xs: (string * int) list) (key: string) =
  if null xs 
    then NONE 
  else
    if #1(hd xs) = key 
      then SOME (#2(hd xs)) 
    else
      lookup (tl xs) key;
(*
(if (lookup [("hello",1), ("world", 2)] "hello") = (SOME 1)
  then print("lookup passes\n") 
else print("lookup fails\n"));
(if (lookup [("hello",1), ("world", 2)] "world") = (SOME 2)
  then print("lookup passes\n") 
else print("lookup fails\n"));
(if (lookup [("hello",1), ("world", 2)] "he") = NONE
  then print("lookup passes\n") 
else print("lookup fails\n"));*)

(*============Question 5.9================*)
fun getitem key xs = 
  let
    fun list_length x = if null x then 0 else 1 + list_length (tl x)
    val len_x = list_length xs
  in 
    if key > len_x
      then NONE 
    else
      if key = 1
        then SOME (hd xs)
      else 
        getitem (key-1) (tl xs)
  end;
(*
(if (getitem 2 [1,2,3,4]) = (SOME 2)
  then print("getitem passes\n") 
else print("getitem fails\n"));
(if (getitem 5 [1,2,3,4]) = NONE
  then print("getitem passes\n") 
else print("getitem fails\n"));*)


(*============Question 5.10================*)
fun getitem2 NONE xs = NONE
  | getitem2 (SOME key) [] = NONE
  | getitem2 (SOME key) xs = 
    getitem key xs; 
(*
(if (getitem2 (SOME 2) [1,2,3,4]) = (SOME 2)
  then print("getitem2 passes\n") 
else print("getitem2 fails\n"));
(if (getitem2 (SOME 5) [1,2,3,4]) = NONE
  then print("getitem2 passes\n") 
else print("getitem2 fails\n"));
(if (getitem2 NONE [1,2,3]) = NONE
  then print("getitem2 passes\n") 
else print("getitem2 fails\n"));
(if (getitem2 (SOME 5) []) = NONE
  then print("getitem2 passes\n") 
else print("getitem2 fails\n"));
(if (getitem2 (SOME 5) ([] : int list)) = NONE
  then print("getitem2 passes\n") 
else print("getitem2 fails\n"));*)

(*============Question 6================*)
signature DICT = 
sig 
  type key = string
  type 'a entry = key * 'a
  type 'a dict 

  val empty: 'a dict 
  val lookup : 'a dict -> key -> 'a option 
  val insert: 'a dict * 'a entry -> 'a dict 
end;

structure Trie :> DICT = 
struct 
  type key = string 
  type 'a entry = key * 'a 

  datatype 'a trie = 
    Root of 'a option * 'a trie list 
    | Node of 'a option * char * 'a trie list 
  
  type 'a dict = 'a trie 

  val empty = Root(NONE, [])

  fun lookup_branch [] xs = NONE 
    | lookup_branch (Node(value, key, _)::trie_list) [x]= 
      if key = x then value else NONE
    | lookup_branch (Node(value, key, node_list)::trie_list) (x::xs)= 
      if key = x then lookup_branch node_list xs
      else lookup_branch trie_list (x::xs)
     
  fun lookup_depth((Root(value, trie_list)), []) = value
    | lookup_depth((Root(value, trie_list)), (x::xs)) = lookup_branch trie_list (x::xs)
    | lookup_depth((Node(value, key, trie_list)), []) = value
    | lookup_depth((Node(value, key, trie_list)), (x::xs)) = lookup_branch trie_list (x::xs)
     

  fun lookup trie key = lookup_depth(trie, explode key)
   

  fun child([], ([x], value)) = [Node(SOME value, x, [])]
    | child([], ((x::xs), value)) = [Node(NONE, x, child([], (xs, value)))]
    | child(Node(node_value, node_key, node_list)::tail_node, ((x::xs), value)) = 
      if x = node_key then insert_helper(Node(node_value, node_key, node_list), (xs, value))::tail_node
      else Node(node_value, node_key, node_list)::child(tail_node, ((x::xs), value))
        
  and insert_helper(Root(trie_value, trie_list), (nil, value)) = Root(SOME value, trie_list)
    | insert_helper(Root(trie_value, trie_list), (key, value)) = Root(trie_value, child(trie_list, (key, value)))
    | insert_helper(Node(node_value, node_key, trie_list), (nil, value)) = Node(SOME value, node_key, trie_list)
    | insert_helper(Node(node_value, node_key, trie_list), (key, value)) = Node(node_value, node_key, child(trie_list, (key, value)))

  fun insert (trie, (key, value)) = insert_helper(trie, (explode key, value))
   
end;


(*
(*Check the case with invalid key*)
open Trie; 

val trie = insert(empty, ("bad", 1));
val trie = insert(trie, ("badge", 2));
val trie = insert(trie, ("icon", 3));
val trie = insert(trie, ("", 4));
val trie = insert(trie, ("badly", 5));
(if (lookup trie "b") = NONE then print("lookup passes\n") 
else print("lookup fails\n"));
(if (lookup trie "ba") = NONE then print("lookup passes\n") 
else print("lookup fails\n"));
(if (lookup trie "iconnn") = NONE then print("lookup passes\n") 
else print("lookup fails\n"));
(if (lookup trie "test") = NONE then print("lookup passes\n") 
else print("lookup fails\n"));

(*Check the case with valid key*)
(if (lookup trie "bad") = SOME 1 then print("lookup passes\n") 
else print("lookup fails\n"));
(if (lookup trie "badge") = SOME 2 then print("lookup passes\n") 
else print("lookup fails\n"));
(if (lookup trie "badly") = SOME 5 then print("lookup passes\n") 
else print("lookup fails\n"));
(if (lookup trie "icon") = SOME 3 then print("lookup passes\n") 
else print("lookup fails\n"));
(if (lookup trie "") = SOME 4 then print("lookup passes\n") 
else print("lookup fails\n"));*)
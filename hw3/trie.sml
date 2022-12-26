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
     
  and lookup_depth((Root(value, trie_list)), []) = value
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

open Trie; 

val trie = insert(empty, ("bad", 1));
val trie = insert(trie, ("badge", 2));
val trie = insert(trie, ("icon", 3));
val trie = insert(trie, ("", 4));
val trie = insert(trie, ("badly", 5));

(*Check the case with invalid key
(if (lookup trie "b") = NONE then print("insert passes\n") 
else print("insert fails\n"));
(if (lookup trie "test") = NONE then print("insert passes\n") 
else print("insert fails\n"));

Check the case with invalid key
(if (lookup trie "bad") = SOME 1 then print("insert passes\n") 
else print("insert fails\n"));
(if (lookup trie "badge") = SOME 2 then print("insert passes\n") 
else print("insert fails\n"));
(if (lookup trie "badly") = SOME 5 then print("insert passes\n") 
else print("insert fails\n"));
(if (lookup trie "icon") = SOME 3 then print("insert passes\n") 
else print("insert fails\n"));
(if (lookup trie "") = SOME 4 then print("insert passes\n") 
else print("insert fails\n"));*)

datatype 'a trie = 
  Root of 'a option * 'a trie list 
  | Node of 'a option * char * 'a trie list 

fun lookup_branch [] [] = NONE 
  | lookup_branch (node: 'a trie list) [x] = 
    let 
      val Node(value, key, _) = (hd node)
    in 
      if key = x then value else lookup_branch (tl node) [x]
    end
  | lookup_branch (node: 'a trie list) (x::xs)= 
    let 
      val Node(value, key, node_list) = (hd node)
    in 
      if key = x then lookup_depth((hd node), xs)
      else lookup_branch (tl node) xs
    end
and lookup_depth((Root(value, [])), []) = value
    | lookup_depth((Root(value, [])), (x::xs)) = NONE
    |  lookup_depth((Node(value, key, [])), [x]) = 
      if x = key then value else NONE
    | lookup_depth((Node(value, key, [])), (x::xs)) = NONE 
    | lookup_depth((Node(value, key, (node::node_list))), [x]) = 
      if x = key then value else NONE 
    | lookup_depth((Node(value, key, (node::node_list))), (x::xs)) = 
      if x = key then lookup_depth(node, xs)
      else lookup_branch node_list xs 
    | lookup_depth((Root(value, (node::node_list))), (x::xs)) =
      lookup_branch (node::node_list) (x::xs)

val empty = Root(NONE, nil);

fun lookup trie key = 
  let 
    val char_list = explode(key)
  in 
    lookup_depth(trie, char_list)
  end 

fun lookup2 trie key =
    let
      (* val lookupList: 'a trie list * char list -> 'a option *)
      fun lookupList (nil, _) = NONE
        | lookupList (_, nil) = NONE
        | lookupList ((trie as Node(_, letter', _))::lst, key as letter::rest) =
            if letter = letter' then lookup' (trie, rest)
            else lookupList (lst, key)
        | lookupList (_, _) = NONE

      (*
        val lookup': 'a trie -> char list
      *)
      and lookup' (Root(elem, _), nil) = elem
        | lookup' (Root(_, lst), key) = lookupList (lst, key)
        | lookup' (Node(elem, _, _), nil) = elem
        | lookup' (Node(elem, letter, lst), key) = lookupList (lst, key)
    in
      lookup' (trie, explode key)
    end


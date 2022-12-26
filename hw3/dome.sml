structure Mapping = struct 
    exception NotFound;

    val create = [];

    fun lookup(key, nil) = raise NotFound
      | lookup(d, (e, r)::es) = 
        if d=e then r 
        else lookup(d, es)
    
    fun insert(d, r, nil) = [(d, r)]
      | insert (d, r, (e, s)::es) = 
        if d = e then (d, r):: es 
        else (e, s):: insert(d, r, es)
end;

signature SIMAPPING =  sig 
  exception NotFound;
  val create: (string * int) list;
  val lookup: string * (string * int) list -> int;
  val insert: string * int * (string * int) list -> (string * int) list;
end;

structure SiMapping:> SIMAPPING = Mapping
val m = SiMapping.create;
val n = SiMapping.insert("dome", 4, m);
val n = SiMapping.insert("tte", 5, n);

datatype 'a trie = 
  Root of 'a option * 'a trie list
  | Node of 'a option * char * 'a trie list;

(*Root (NONE, [
  Node(SOME 2, #"b", []),
  Node(SOME 3, #"c", [])
])*)
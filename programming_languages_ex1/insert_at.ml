let insert_at item n l =
let rec aux i = function
|[]-> item::[]
|h::t->if i=n then item::h::t else h::aux(i+1)t in aux 0 l;;

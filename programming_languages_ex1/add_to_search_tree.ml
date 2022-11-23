type 'a binary_tree=
       |Empty
       |Node of 'a * 'a binary_tree * 'a binary_tree;;
let rec add_to_search_tree bst x = match bst with
       |Empty -> Node (x, Empty, Empty)
       |Node (y, left, right) ->
           if x < y then Node ( y, add_to_search_tree left x, right)
           else Node (y, left, add_to_search_tree right x);;
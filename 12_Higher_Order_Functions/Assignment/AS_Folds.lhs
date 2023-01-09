== Übung 11: Folds ==

In dieser Übung dreht sich alles um folds. Folds implementieren mächtige
Rekursionsmuster mit deren Hilfe Sie einige bekannte andere HOFs
implementieren können:

Aufgabe 1: Filter
Implementieren Sie die Funktion filter' mittels foldr:

> filter' :: (a -> Bool) -> [a] -> [a]
> filter' = error "ToDo"


Aufgabe 2: Map
a) Implementieren Sie die Funktion mapr mittels foldr.
Sie dürfen nur Lambda Ausdrücke, (:) und foldr verwenden:

> mapr :: (a -> b) -> [a] -> [b]
> mapr = error "ToDo"

b) Implementieren Sie die Funktion mapl mittels foldl.
Sie dürfen nur Lambda Ausdrücke, (++) und foldl verwenden:

> mapl :: (a -> b) -> [a] -> [b]
> mapl = error "ToDo"


Aufgabe 3: Length
Implementieren Sie die Funktion lenght' mittels foldr:

> length' :: [a] -> Int
> length' = error "ToDo"


Aufgabe 4: Concat
Implementieren Sie die Funktion concat' mittels foldr:

> concat' :: [[a]] -> [a]
> concat' = error "ToDo"

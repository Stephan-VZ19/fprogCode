{- Arbeitsblatt: Recursion II -}

{-
Gesucht sind jeweils eigene rekursive Definitionen, ohne die Verwendung 
von Standardfunktionen.

Falls Sie die Aufgaben einfach finden, implementieren Sie die folgenden 
Funktionen komplett, d.h. überprüfen Sie auch die übergebenen Parameter 
ob sie überhaupt sinnvoll sind. Sie können mit error „eine Fehlermeldung“ 
eine Meldung auf der Konsole ausgeben und das Programm abbrechen.
-}


-- Aufgabe 1
-- Implementieren Sie eine Funktion welche die Länge einer Liste bestimmt:


len :: [a] -> Int
len [] = 0
len (_:xs) = 1 + len xs


-- Aufgabe 2
-- Implementieren Sie eine Funktion, welche überprüft ob in einer Liste von 
-- Bool alle Werte True sind.
-- Hinweis: allTrue [] soll auf True evaluieren.

allTrue :: [Bool] -> Bool
allTrue [] = True
allTrue (x:xs)
    | x == False = False
    | otherwise = allTrue xs


-- Aufgabe 3
-- Implementieren Sie eine Funktion, welche aus einer List eine Teilliste extrahiert, 
-- indem dessen Startposition und Länge gegeben ist.

sublist :: Int -> Int -> [a] -> [a]
sublist x y (e:es)
    | e == y = []
    | e < x = sublist x y ((e+1):es)
    | e >= x && e <= y = sublist x y (e:e+1:es)

    
-- Beispiel: sublist 3 7 "Hello World" == "lo Worl"


-- Aufgabe 4 
-- Implementieren Sie eine Funktion, welche eine Liste an eine andere Liste anhängt:

(+++) :: [a] -> [a] -> [a]
(+++) = todo


todo :: a
todo = error "todo"

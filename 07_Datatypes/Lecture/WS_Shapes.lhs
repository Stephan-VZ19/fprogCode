Arbeitsblatt: Figuren als Algebraische Datentypen

Hinweis: Sie lesen diesen Text in einem literate Haskell File.
Aller Text wird als Kommentar behandelt, ausser er startet mit '>'.

Folgende Option schaltet alle Compiler-Warnungen ein.

> {-# OPTIONS_GHC -Wall #-}

In diesem Arbeitsblatt implementieren wir eine kleine Bibliothek für den
Umgang mit Figuren.

a) Definieren Sie den Datentyp Shape.
Zwei Formen werden von der Bibliothek unterstützt:
- Kreis: Die Grösse wird über den Radius angegeben
- Rechteck: Die Grösse wird über die Länge und die Breite angegeben

Hinweis: Verwenden Sie deriving (Show) damit Ihr Datentyp auf in einen
lesbaren String übersetzt werden kann.

> data Shape = Rectangle Float Float
>            | Circle Float
>              deriving (Show)

b) Definieren Sie die Funktion circumference, die den Umfang einer Form berechnet:
Hinweis: Die Kreiskonstante π ist vordefiniert unter dem Namen pi.

> circumference :: Shape -> Float
> circumference (Circle radius) = 2 * radius * pi
> circumference (Rectangle w h) = 2 * w + 2 * h 

c) Gegeben ist der Datentyp Point. Ein Punkt beschreibt mit zwei Float
Werten eine X/Y Koordinate in der Ebene.

> data Point = XY Float Float deriving (Show)

> getpoint :: Point -> (Float, Float)
> getpoint (XY x y) = (x, y)


Definieren Sie den Typ Figure. Eine Figure ist ein positioniertes Shape.
Verwenden Sie als Komponenten den Typ Point und den Typ Shape.

> data Figure = MkFigure Point Shape deriving (Show)

getfigure :: Point -> Shape // wird nicht gebraucht

getfigure (MkFigure (getpoint (XY a b)) (circumference (Circle c))) = ...

d) Definieren Sie die Funktion um eine Figur zu verschieben.
Der erste Float ist die Differenz in Richtung x und der zweite Float ist
die Differenz in Richtung y.

> movePoint :: Point -> Float -> Float -> Point
> movePoint (XY x y) dx dy = XY (x + dx) (y + dy)

> move :: Figure -> Float -> Float -> Figure
> move (MkFigure p s) dx dy = MkFigure (movePoint p dx dy) s

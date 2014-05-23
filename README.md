# Projekt Stringologie

## Algorithmen

### Auswahl
* Naives Schiebefenster
* Schiebefenster mit Heuristik (Buchstabenhäufigkeit)
* Boyer-Moore

### Grund
* Wieviele Vergleiche kann ich wirklich sparen im Vergleich zum naiven Algorithmus?
* Ist das nur für automatische Verarbeitung interessant, oder auch ein “fühlbarer” Unterschied?
* Heuristiken ermöglichen häufig sehr effiziente Algorithmen (Paradebeispiel A*). Gilt der deutliche Vorteil auch bei der Suche auf Strings?
* Boyer-Moore vergleicht die Fenster von hinten und unterscheided sich deutlicher vom naiven Ansatz, als die Anderen.

## Datensätze

### Textcorpus Shakespeare
* schon vorhanden
* im englischen gibt es Buchstabenkombinationen, die sehr häufig vorkommen (Endung -ing, viele andere [link](http://norvig.com/ngrams/count_3l.txt))
* diese sollten ermöglichen das Fenster relativ weit springen können
* 37 Texte, ~4MB
* Vermutlich reicht Test auf einem davon

### CLMET - The Corpus of Late Modern English Texts
* schon vorhanden
* 200MB roher Text
* ich will alle Dokumente zu einem zusammenführen 
* darauf alle Vorkommen eines Wortes suchen

### Künstlicher Corpus
* Begrenztes Alphabet (5 Zeichen)
* 2 Texte, einmal Zeichen gleichverteilt, einmal Unterschiedlich
* Zufallsmuster

## Erwartete Ergebnisse

### Auf Shakespeare
* Zu Messen 
    - Vergleiche Zählen
    - Fensterverschiebung (max/avg)
* Gewinnt Boyer-Moore wegen den Vergleichen von hinten (-ing)?
* Gewinnt Heuristik bei Suche nach Wörtern mit seltenen Buchstaben (x, q)?

### auf CLMET
* Zu Messen
    - alle Vorkommen finden
    - Laufzeit (geht das unter 1 sek?)
      Wenn ja Corpus noch vergrößern (aber in RAM bleiben)
* Dimensionen Suchmuster: Länge, Häufigkeit in Text

### Künstlicher Corpus
* Dimension Suchmuster: Länge (50 Zeichen vs. 5)
* Bei langem sollte Boyer-Moore deutlich überlegen sein
* Heuristik sollte bei Gleichverteilter Buchstabenhäufigkeit wertlos sein

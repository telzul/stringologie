# Projekt Stringologie

## Algorithmen

### Auswahl
* Naives Schiebefenster
* Schiebefenster mit Heuristik (Buchstabenhäufigkeit)
* Boyer-Moore

### Grund
* Wieviele Vergleiche kann ich wirklich sparen im Vergleich zum naiven Algorithmus?
* Ist das nur für automatische Verarbeitung interessant, oder auch ein “fühlbarer” Unterschied?

## Datensätze

### Textcorpus Shakespeare
* schon vorhanden
* im englischen gibt es Buchstabenkombinationen, die sehr häufig vorkommen (Endung -ing, viele andere [http://norvig.com/ngrams/count_3l.txt])
* diese sollten ermöglichen das Fenster relativ weit springen können
* 37 Texte, ~4MB
* Vermutlich reicht Test auf einem davon

### CLMET - The Corpus of Late Modern English Texts
* schon vorhanden
* 200MB roher Text
* ich will alle Dokumente zu einem zusammenführen 
* darauf alle Vorkommen eines Wortes suchen

## Erwartete Ergebnisse

### Auf Shakespeare
* Vergleiche Zählen
* Fensterverschiebung (max/avg)
* Gewinnt Boyer-Moore wegen den Vergleichen von hinten (-ing)?
* Gewinnt Heuristik bei Suche nach Wörtern mit seltenen Buchstaben (x, q)?

### auf CLMET
* alle Vorkommen finden
* Laufzeit messen (geht das unter 1 sek?)
* kurze & häufige Wörter
* seltene

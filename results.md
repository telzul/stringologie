### Textstatistiken
- Kleine Texte:   1.000.000 Zeichen
- Große  Texte: 100.000.000 Zeichen
- CLMET:        187.717.141 Zeichen

- Kleines Pattern:  5
- Großes Pattern:  50
- Pattern bei Normalverteilung so angelegt, dass seltenster Buchstabe in der Mitte liegt


### Überall:
* Naive etwas über n
* Heuristik knapp besser ~10% bei kleinem Alphabet normalverteilt
* Heuristik deutlich schlechter (fast 20%) bei gleichverteilt

* Boyer-Moore 3 - >20 mal schneller


* BM bei langem pattern 2-5 mal schneller
* Bei CLMET 3*

### Art der Verteilung praktisch unwichtig
* BM ca. ~10-30% besser bei Gleichverteilung

### Bei allen Algorithmen verbesserung bei größerem Alphabet 
* Naive ~25% besser
* BM bei langem Pattern 3* besser
* BM bei kurzem Pattern ~50% Verbesserung

### Zeitmessung
Nicht durchgeführt, weil alle Algorithmen so lang gebraucht haben, das wollte ich nicht messen, ist eh zu ungenau.

### Zusammenfassung
* Boyer-Moore in allen Fällen sehr deutlich überlegen!
* Heuristik nur marginal besser als Naiv
* Heuristik bei gleichverteiltem Alphabet sogar schlechter!

# Wall Box Logs 2.0

## Ziele und Aufgaben
Ziel dieses Projekts ist ein neuer Ansatz für die Wallbox- App. Sie soll, wie schon die V1, die Logdateien der Wallboxen einlesen und daraus Daten über Transaktionen extrahieren.

Die App soll es dem WB-Betreiber möglichst einfach und dynamisch ermöglichen, Kundenstammdaten zu erfassen, sie zu pflegen ihnen und vor allem die Tag-IDs zuzuordnen, um einen Überblick zu haben, wer wann wie viel geladen hat.

Außerdem soll die App es dem Betreiber ermöglichen, auf Basis dieser Daten rechtskonforme Rechnungen zu erstellen.

## Warum Neubau?

Im Prinzip sollen die Funktionalitäten der V1 noch erweitert und verfeinert werden. Auch wenn das ein oder andere der vorigen App übernommen werden kann, wird die App im Kern neu gebaut, da einige Funktionalitäten nun deutllich anders angegangen werden sollen und eine Umstrukturierung des bisherigen Codes vermutlich ein größerer Aufwand wäre.

## Begrifflichkeiten & Grundkonzepte

### "Akteure"
Im Grunde gibt es 3 Kategorien von Personen, von denen im Kontext dieser App gesprochen wird:
- der/ die Betreiber*in, also der, dem die Wallboxen gehören und die Tags ausgeben.
- die Kund*innen: "die Vertragspartner" des Betreibers. Diese erhalten die tags und an sie werdedn auch die Rechnungen erstellt
- die Nutzer*innen: Die, die tatsächlich die Fahrzueuge an den WB laden. Ein Nutzer kann entweder eine Person oder auch ein Fahrzeug sein.

diese App ist zunächst rein für den Betreiber gedacht, um tagIds Kunden zuzurodnen. Die Nutzer*innen werden zunächst keine weitere Relevanz für DIESE App haben.
=> dafür ist für die Zukunft eine zweite Kunden-App geplant, in der Kunden dann ihre TagIDs genauer den tatsächlichen Nutzenden zuordnen, Transaktionen einsehen und ggf ebenfalls echnungen erstellen kann.
Diese zweite App soll dabei definitiv optional für den Kunden sein, sofern dieser mehr Kontrolle und Übersicht wünscht. Notwendig wird sie nicht sein.


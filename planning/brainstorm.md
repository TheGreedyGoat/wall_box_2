# wall_box_2 Brainstorm

>## Grundstruktur
>### drei Hauptebenen/ Akteure:
>
>- **Betreiber**: Besitzer der Wallbox, gibt Tags aus (zB Inventarkreisel)
>- **Kunde**: Empfänger der Tags, Rechnungsempfänger von Betreiber (zB. cdemy)
 Kann Firma, Privatperson etc. sein
>- **Nutzer**: Entweder die Person (zB Mitarbeitende), die die WB nutzt oder Fahrzeuge, die geladen werden. Zuordnung durch Kunde
>
>idR stehen also Betreiber und Kunden sowie Kunden und Nutzer in einer direkten Beziehung zueinander. Der Betreiber verwaltet seine Kunden, die Kunden ihre Nutzer. Der Betreiber hat keine direkte Bezihung zum Nutzer




## Nutzung
### WB-Betreiber:
gibt tags an Kunden aus und ordnet sie diesen zu. Legt entsprechende Preislevel fest
(Im Prinzip interessiert ja nach meinem Verständnis den Betreiber in der Hinsicht nur, welcher Firma etc. er tags ausgegeben hat und möchte Tranksaktionen über die Tags dem jeweiligen Kunden zuordnen)


### Kunde (zB Firma, Privatkunde)
erhält Tags, bestimmt selbst, inwiefern sie Nutzern zugeordnet werden.
#### Mögliche Nutzungsarten:
>**Firma**
- Tags sind Nutzer*innen (zB Mitarbeitenden) zugeordnet:
  - aus der tagID wird geschlossen, WER geladen hat
- Tags sind Fahrzeugen zugeordnet
  - aus der tagId wird angeschlossen, WELCHES FAHRZEUG geladen wurde
- Tags werden garnicht fest zugeordnet
  >Beispiel: Eine Firma erhält 10 tags. Möchte ein/e Mitarbeitende/r die Wallbox nutzen, wird ein tag ausgegeben. Die Firma lässt sich die Ausgabe bestätigen. Nach der Nutzung wird das tag zurück an die Firma gegeben
>**Privatperson**
- idR Regel wahrscheinlich keine weitere Zuordnung nötig



# Ansätze

Möglicherweise zwei Apps:

## für Betreiber
- Erstellung und Pflege von Kunden-Stammdaten
- Festlegung von Preisen
- ggf Einsicht in die kundeninternen Zuordnungen
- Erstellung und Ausgabe von Rechnungen

## für Kund*innen
- Erstellung und Pflege von Nutzer-Stammdaten
- Zuordnung zwischen Tags und Fahrzeugen/ Personen
- ggf Rechnungsfunktionen für Nutzer

## Genreller gedachter Ablauf:
- Betreiber gibt Tag an Kunden aus
- Betreiber erfasst ggf die Kundenstammdaten (falls nicht bereits erfasst) und ordnet diesen das herausgegebene Tag zu
- Kunde nimmt Tag entgegen und ordnet es nach eigenem Ermessen zu
  - Fahrzeugen, Personen o. keine direkte Zuordnung
  - ggf hat der Betreiber ebenfalls Einsicht auf Teile der Nutzerzuordnungen des Kunden?
- Kunden können ebenfalls Transaktionen ihrer Tags einsehen?
- Betreiber liest Logdaten ein und kann entspechend Rechnungen an die Kunden erstellen/ herausgeben
- Kunde kann ebenfalls Rechnungen an Nutzer*innen erstellen (natürlich, sofern es Personen sind)

# Sistema Expert de Recomanació d'Habitatges

Aquest projecte implementa un Sistema Basat en el Coneixement (SBC) utilitzant CLIPS per recomanar ofertes de lloguer a diferents perfils de sol·licitants, seguint la metodologia de Classificació Heurística.

---

## Components del Sistema

El sistema està dividit en els següents fitxers CLIPS:

* **`main.clp`**: Fitxer de càrrega principal. Conté la seqüència d'instruccions per carregar tots els mòduls.
* **`ontologiaSBC.clp`**: Defineix les classes (`defclass`) i la jerarquia de conceptes (Habitatge, Sollicitant, Servei, etc.).
* **`instancies.clp`**: Conté les dades de prova inicials (`definstances`).
* **`regles.clp`**: Conté la lògica del sistema (`defmodule` i `defrule`) organitzada en les fases d'Abstracció, Resolució i Refinament.

---

## Instruccions d'Ús

Per executar el sistema expert i veure les recomanacions generades, segueix els següents passos:


1.  **Obrir CLIPS:** Inicia la consola de CLIPS.
2.  **Carregar el sistema:** Escriu l'ordre per carregar el fitxer principal:
    ```clips
    (load "main.clp")
    ```
3.  **Executar el procés:** Un cop carregat, inicialitza i executa el sistema:
    ```clips
    (main)
    (reset)
    (run)
    ```


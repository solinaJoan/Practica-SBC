# Sistema Expert de Recomanació d'Habitatges

Aquest projecte implementa un Sistema Basat en el Coneixement (SBC) utilitzant CLIPS per recomanar ofertes de lloguer a diferents perfils de sol·licitants, seguint la metodologia de Classificació Heurística.

---

## Instruccions d'Ús

Per executar el sistema expert i veure les recomanacions generades, segueix els següents passos:


1. Descomprimir el fitxer `codi.zip` i dirigir-se al directori `codi`. 
2. **Obrir CLIPS:** Inicia la consola de CLIPS.
3.  **Carregar el sistema i executar el procés:** Escriu l'ordre per carregar i executar el fitxer principal:
    ```clips
    (batch "run.clp")
    ``` 
El fitxer 'run.clp' s'encarrega de carregar l'ontologia, les regles, i si cal les instàncies de sol·licitants. També de crear un nou perfil si volem. S'executa el main automàticament.


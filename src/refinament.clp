;;; ============================================================
;;; PRESENTACIÓ TOP 3
;;; ============================================================

(defrule presentacio-top3-inici
    "Marca l'inici de la presentació limitada als TOP 3"
    (declare (salience -5))
    (fase (actual presentacio))
    =>
    (printout t crlf)
    (printout t "================================================================" crlf)
    (printout t "          TOP 3 MILLORS RECOMANACIONS PER SOL·LICITANT          " crlf)
    (printout t "================================================================" crlf)
    (printout t crlf)
)

(defrule presentacio-top3-per-solicitant
    "Mostra només les 3 millors ofertes per cada sol·licitant"
    (declare (salience -10))
    (fase (actual presentacio))
    ?sol <- (object (is-a Solicitant))
    =>
    (bind ?nom-sol (send ?sol get-nom))
    (printout t crlf)
    (printout t "┌────────────────────────────────────────────────────────────┐" crlf)
    (printout t "│  SOL·LICITANT: " ?nom-sol crlf)                            │
    (printout t "└────────────────────────────────────────────────────────────┘" crlf)
    (printout t crlf)
    
    ;; Obtenir totes les recomanacions d'aquest sol·licitant ordenades per puntuació
    (bind $?recomanacions (create$))
    (do-for-all-facts ((?rec Recomanacio))
        (and (eq ?rec:solicitant ?sol) (neq ?rec:grau NULL))
        (bind $?recomanacions (create$ $?recomanacions ?rec))
    )
    
    ;; Ordenar per puntuació (bubble sort simple)
    (bind ?n (length$ $?recomanacions))
    (if (> ?n 0) then
        (loop-for-count (?i 1 (- ?n 1))
            (loop-for-count (?j 1 (- ?n ?i))
                (bind ?rec1 (nth$ ?j $?recomanacions))
                (bind ?rec2 (nth$ (+ ?j 1) $?recomanacions))
                (if (< (fact-slot-value ?rec1 puntuacio) (fact-slot-value ?rec2 puntuacio)) then
                    (bind $?recomanacions (replace$ $?recomanacions ?j ?j ?rec2))
                    (bind $?recomanacions (replace$ $?recomanacions (+ ?j 1) (+ ?j 1) ?rec1))
                )
            )
        )
        
        ;; Mostrar només els 3 primers
        (bind ?max-mostrar (min 3 (length$ $?recomanacions)))
        (loop-for-count (?i 1 ?max-mostrar)
            (bind ?rec (nth$ ?i $?recomanacions))
            (bind ?of (fact-slot-value ?rec oferta))
            (bind ?grau (fact-slot-value ?rec grau))
            (bind ?punt (fact-slot-value ?rec puntuacio))
            
            (bind ?habitatge (send ?of get-teHabitatge))
            (bind ?localitzacio (send ?habitatge get-teLocalitzacio))
            (bind ?preu (send ?of get-preuMensual))
            (bind ?tipus (class ?habitatge))
            (bind ?sup (send ?habitatge get-superficieHabitable))
            (bind ?dorm (send ?habitatge get-numeroDormitoris))
            (bind ?banys (send ?habitatge get-numeroBanys))
            (bind ?adreca (send ?localitzacio get-adreca))
            (bind ?districte (send ?localitzacio get-districte))
            
            (printout t "  ╔════════════════════════════════════════════════════════╗" crlf)
            (printout t "  ║  #" ?i " - " (instance-name ?of) " - " ?grau " (" ?punt " punts)" crlf) ║
            (printout t "  ╚════════════════════════════════════════════════════════╝" crlf)
            (printout t "    Tipus:       " ?tipus crlf)
            (printout t "    Superficie:  " ?sup " m²" crlf)
            (printout t "    Dormitoris:  " ?dorm " | Banys: " ?banys crlf)
            (printout t "    Preu:        " ?preu " EUR/mes" crlf)
            (printout t "    Adreça:      " ?adreca crlf)
            (printout t "    Districte:   " ?districte crlf)
            (printout t "    ────────────────────────────────────────────────────" crlf)
            
            ;; Mostrar punts positius
            (bind ?punts-positius 0)
            (do-for-all-facts ((?pp punt-positiu))
                (and (eq ?pp:solicitant ?sol) (eq ?pp:oferta ?of))
                (if (= ?punts-positius 0) then
                    (printout t "    PUNTS FORTS:" crlf)
                )
                (printout t "      [+] " ?pp:descripcio " (+" ?pp:punts "p)" crlf)
                (bind ?punts-positius (+ ?punts-positius 1))
            )
            
            ;; Mostrar criteris no complerts si n'hi ha
            (if (or (eq ?grau Parcialment) (eq ?grau Adequat)) then
                (bind ?criteris 0)
                (do-for-all-facts ((?cn criteri-no-complert))
                    (and (eq ?cn:solicitant ?sol) (eq ?cn:oferta ?of))
                    (if (= ?criteris 0) then
                        (printout t "    ASPECTES A CONSIDERAR:" crlf)
                    )
                    (printout t "      ⚠ " ?cn:criteri " (" ?cn:gravetat ")" crlf)
                    (bind ?criteris (+ ?criteris 1))
                )
            )
            (printout t crlf)
        )
        
        (if (> (length$ $?recomanacions) 3) then
            (printout t "  ... i " (- (length$ $?recomanacions) 3) " ofertes més disponibles." crlf)
        )
    else
        (printout t "  ⚠ No s'han trobat ofertes adequades per aquest sol·licitant." crlf)
    )
    (printout t crlf)
)
;;; ============================================================
;;; main.clp
;;; Sistema Expert Interactiu de Recomanació d'Habitatges
;;; ============================================================

;;; ============================================================
;;; FUNCIONS AUXILIARS PER LLEGIR DADES
;;; ============================================================

(deffunction pregunta-si-no (?pregunta)
    "Pregunta amb resposta si/no"
    (printout t ?pregunta " (si/no): ")
    (bind ?resp (read))
    (while (and (neq ?resp si) (neq ?resp no))
        (printout t "Si us plau, respon 'si' o 'no': ")
        (bind ?resp (read))
    )
    ?resp
)

(deffunction pregunta-numero (?pregunta ?min ?max)
    "Pregunta amb resposta numerica amb limits"
    (printout t ?pregunta " [" ?min "-" ?max "]: ")
    (bind ?resp (read))
    (while (or (not (numberp ?resp)) (< ?resp ?min) (> ?resp ?max))
        (printout t "Si us plau, introdueix un numero entre " ?min " i " ?max ": ")
        (bind ?resp (read))
    )
    ?resp
)

(deffunction pregunta-text (?pregunta)
    "Pregunta amb resposta de text"
    (printout t ?pregunta ": ")
    (bind ?resp (readline))
    ?resp
)

(deffunction pregunta-opcio (?pregunta $?opcions)
    "Pregunta amb opcions predefinides"
    (printout t ?pregunta crlf)
    (bind ?i 1)
    (foreach ?opc ?opcions
        (printout t "   " ?i ". " ?opc crlf)
        (bind ?i (+ ?i 1))
    )
    (bind ?resp (pregunta-numero "Tria una opcio" 1 (length$ ?opcions)))
    (nth$ ?resp ?opcions)
)

;;; ============================================================
;;; CREACIÓ DEL PERFIL DEL SOL·LICITANT
;;; ============================================================

(deffunction crear-perfil-solicitant ()
    "Crea un nou perfil de solicitant mitjancant preguntes"
    
    (printout t crlf)
    (printout t "============================================================" crlf)
    (printout t "          CREACIÓ DEL PERFIL DEL SOLLICITANT" crlf)
    (printout t "============================================================" crlf)
    (printout t crlf)
    
    ;;; Dades basiques
    (bind ?nom (pregunta-text "Nom o identificador"))
    (bind ?edat (pregunta-numero "Edat" 18 120))
    (bind ?num-persones (pregunta-numero "Nombre de persones que viviran a l'habitatge" 1 10))
    
    ;;; Pressupost
    (printout t crlf "--- PRESSUPOST ---" crlf)
    (bind ?pres-max (pregunta-numero "Pressupost maxim mensual (EUR)" 0 10000))
    (bind ?pres-min (pregunta-numero "Pressupost minim mensual (EUR)" 0 ?pres-max))
    (bind ?marge-estricte (pregunta-si-no "El pressupost es estricte? (si = no puc gastar mes)"))
    
    ;;; Situacio familiar
    (printout t crlf "--- SITUACIÓ FAMILIAR ---" crlf)
    (bind ?num-fills (pregunta-numero "Nombre de fills" 0 10))
    (bind ?edats-fills (create$))
    (if (> ?num-fills 0) then
        (loop-for-count (?i 1 ?num-fills)
            (bind ?edat-fill (pregunta-numero (str-cat "Edat del fill " ?i) 0 25))
            (bind ?edats-fills (create$ ?edats-fills ?edat-fill))
        )
    )
    
    (bind ?te-avis (pregunta-si-no "Conviureu amb avis o gent gran?"))
    
    ;;; Mobilitat
    (printout t crlf "--- MOBILITAT ---" crlf)
    (bind ?te-vehicle (pregunta-si-no "Tens vehicle propi?"))
    (bind ?pref-transport (pregunta-si-no "Prefereixes transport public?"))
    (bind ?treballa-ciutat (pregunta-si-no "Treballes a la ciutat?"))
    (bind ?estudia-ciutat (pregunta-si-no "Estudies a la ciutat?"))
    
    ;;; Accessibilitat
    (bind ?nec-access (pregunta-si-no "Necessites accessibilitat (ascensor, planta baixa)?"))
    
    ;;; Mascotes
    (printout t crlf "--- MASCOTES ---" crlf)
    (bind ?te-mascotes (pregunta-si-no "Tens mascotes?"))
    (bind ?num-mascotes 0)
    (bind ?tipus-mascota "Cap")
    (if (eq ?te-mascotes si) then
        (bind ?num-mascotes (pregunta-numero "Quantes mascotes tens?" 1 5))
        (bind ?tipus-mascota (pregunta-opcio "Quin tipus de mascota?" Gos Gat Ocell Altre))
    )
    
    ;;; Determinar tipus de solicitant
    (printout t crlf "--- TIPUS DE SOLICITANT ---" crlf)
    (bind ?tipus (pregunta-opcio 
        "Quin tipus de sollicitant ets?"
        "Individu"
        "Parella sense fills"
        "Parella amb plans de tenir fills"
        "Familia amb fills"
        "Grup d'estudiants"
        "Persona gran (>60 anys)"
    ))
    
    ;;; Crear la instancia segons el tipus
    (bind ?nom-inst (sym-cat sol- (gensym*)))
    
    (switch ?tipus
        (case "Individu" then
            (make-instance ?nom-inst of Individu
                (nom ?nom)
                (edat ?edat)
                (numeroPersones ?num-persones)
                (pressupostMaxim ?pres-max)
                (pressupostMinim ?pres-min)
                (margeEstricte ?marge-estricte)
                (numeroFills ?num-fills)
                (edatsFills ?edats-fills)
                (teAvis ?te-avis)
                (teVehicle ?te-vehicle)
                (prefereixTransportPublic ?pref-transport)
                (necessitaAccessibilitat ?nec-access)
                (teMascotes ?te-mascotes)
                (numeroMascotes ?num-mascotes)
                (tipusMascota ?tipus-mascota)
                (treballaACiutat ?treballa-ciutat)
            )
        )
        (case "Parella sense fills" then
            (make-instance ?nom-inst of ParellaSenseFills
                (nom ?nom)
                (edat ?edat)
                (numeroPersones ?num-persones)
                (pressupostMaxim ?pres-max)
                (pressupostMinim ?pres-min)
                (margeEstricte ?marge-estricte)
                (numeroFills 0)
                (teAvis ?te-avis)
                (teVehicle ?te-vehicle)
                (prefereixTransportPublic ?pref-transport)
                (necessitaAccessibilitat ?nec-access)
                (teMascotes ?te-mascotes)
                (numeroMascotes ?num-mascotes)
                (tipusMascota ?tipus-mascota)
                (treballaACiutat ?treballa-ciutat)
            )
        )
        (case "Parella amb plans de tenir fills" then
            (make-instance ?nom-inst of ParellaFutursFills
                (nom ?nom)
                (edat ?edat)
                (numeroPersones ?num-persones)
                (pressupostMaxim ?pres-max)
                (pressupostMinim ?pres-min)
                (margeEstricte ?marge-estricte)
                (numeroFills 0)
                (teAvis ?te-avis)
                (teVehicle ?te-vehicle)
                (prefereixTransportPublic ?pref-transport)
                (necessitaAccessibilitat ?nec-access)
                (teMascotes ?te-mascotes)
                (numeroMascotes ?num-mascotes)
                (tipusMascota ?tipus-mascota)
                (treballaACiutat ?treballa-ciutat)
            )
        )
        (case "Familia amb fills" then
            (make-instance ?nom-inst of FamiliaBiparental
                (nom ?nom)
                (edat ?edat)
                (numeroPersones ?num-persones)
                (pressupostMaxim ?pres-max)
                (pressupostMinim ?pres-min)
                (margeEstricte ?marge-estricte)
                (numeroFills ?num-fills)
                (edatsFills ?edats-fills)
                (teAvis ?te-avis)
                (teVehicle ?te-vehicle)
                (prefereixTransportPublic ?pref-transport)
                (necessitaAccessibilitat ?nec-access)
                (teMascotes ?te-mascotes)
                (numeroMascotes ?num-mascotes)
                (tipusMascota ?tipus-mascota)
                (treballaACiutat ?treballa-ciutat)
            )
        )
        (case "Grup d'estudiants" then
            (make-instance ?nom-inst of GrupEstudiants
                (nom ?nom)
                (edat ?edat)
                (numeroPersones ?num-persones)
                (pressupostMaxim ?pres-max)
                (pressupostMinim ?pres-min)
                (margeEstricte ?marge-estricte)
                (numeroFills 0)
                (teAvis no)
                (teVehicle ?te-vehicle)
                (prefereixTransportPublic ?pref-transport)
                (necessitaAccessibilitat ?nec-access)
                (teMascotes ?te-mascotes)
                (numeroMascotes ?num-mascotes)
                (tipusMascota ?tipus-mascota)
                (treballaACiutat no)
                (estudiaACiutat ?estudia-ciutat)
            )
        )
        (case "Persona gran (>60 anys)" then
            (make-instance ?nom-inst of PersonaGran
                (nom ?nom)
                (edat ?edat)
                ;(numeroPersones ?num-persones)
                (pressupostMaxim ?pres-max)
                (pressupostMinim ?pres-min)
                (margeEstricte ?marge-estricte)
                (numeroFills 0)
                (teAvis no)
                (teVehicle ?te-vehicle)
                (prefereixTransportPublic ?pref-transport)
                (necessitaAccessibilitat ?nec-access)
                (teMascotes ?te-mascotes)
                (numeroMascotes ?num-mascotes)
                (tipusMascota ?tipus-mascota)
                (treballaACiutat no)
            )
        )
    )
    
    (printout t crlf)
    (printout t "============================================================" crlf)
    (printout t "  Perfil creat correctament: " ?nom crlf)
    (printout t "============================================================" crlf)
    (printout t crlf)
    
    ?nom-inst
)

;;; ============================================================
;;; FUNCIÓ PRINCIPAL
;;; ============================================================

(deffunction main ()
    "Funció principal per executar el sistema"

    (printout t crlf)
    (printout t "============================================================" crlf)
    (printout t "   SISTEMA EXPERT DE RECOMANACIÓ D'HABITATGES DE LLOGUER" crlf)
    (printout t "============================================================" crlf)
    (printout t crlf)

    
    
    ;; Recorda: Ontologia, Regles i Instancies s'han de carregar ABANS 
    ;; de carregar aquest fitxer (main.clp).
    
    (printout t "Sistema carregat i a punt." crlf)
    (printout t crlf)
    
    ;;; Preguntar si vol crear un nou perfil
    (bind ?crear-nou (pregunta-si-no "Vols crear un nou perfil de solicitant?"))
    
    (if (eq ?crear-nou si) then
        ;;; Crear nou perfil i executar
        (bind ?perfil (crear-perfil-solicitant))
        (printout t crlf)
        (printout t "Iniciant cerca d'habitatges..." crlf)
        (printout t crlf)
        (run)
    else
        ;;; Usar perfils existents
        (printout t crlf)
        (printout t "Usant perfils predefinits de les instàncies..." crlf)
        (printout t "Iniciant cerca d'habitatges..." crlf)
        (printout t crlf)
        (load instancies_solicitants_senzill.clp)
        (reset)
        (run)

        ;;; (printout t "Per executar el sistema manualment:" crlf)
        ;;; (printout t "  1. Escriu: (reset)" crlf)
        ;;; (printout t "  2. Escriu: (run)" crlf)
        ;;; (printout t crlf)
    )
    
    (printout t "============================================================" crlf)
    (printout t crlf)
)
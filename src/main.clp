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

(deffunction pregunta-multiopcio (?pregunta $?opcions)
    "Pregunta amb seleccio multiple segura"
    (printout t ?pregunta crlf)
    (printout t "   0. Cap servei molest" crlf)
    (bind ?i 1)
    (foreach ?opc ?opcions
        (printout t "   " ?i ". " ?opc crlf)
        (bind ?i (+ ?i 1))
    )
    (printout t crlf "Tria una o més opcions: ")
    (bind $?numeros (explode$ (readline)))
    ;; Inicialitzem resposta
    (bind $?resposta (create$))
    (foreach ?n $?numeros
        ;; Només si és un número vàlid
        (if (numberp ?n) then
            (bind ?idx (integer ?n))
            ;; Rang correcte
            (if (and (>= ?idx 1) (<= ?idx (length$ ?opcions))) then
                    (bind $?resposta (create$ $?resposta (nth$ ?idx ?opcions)))
            )
        )
    )
    (bind ?resp ?resposta)
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
    (printout t crlf "--- IDENTIFICACIÓ ---" crlf)
    (bind ?nom (pregunta-text "Nom o identificador"))
    (bind ?edat (pregunta-numero "Edat" 18 99))
    (bind ?seg-residencia (pregunta-si-no "Es tracta de la compra d'una primera residència?"))

    ;;; Situació familiar
    (printout t crlf "--- SITUACIÓ FAMILIAR ---" crlf)
    (bind ?num-persones (pregunta-numero "Nombre de persones que viuran a l'habitatge" 1 10))

    (bind ?num-fills 0)
    (if (> ?num-persones 1) then 
        (bind ?num-fills (pregunta-numero "Dels quals fills" 0 (- ?num-persones 1)))
    ) 

    (bind ?edats-fills (create$))
    (if (> ?num-fills 0) then
        (loop-for-count (?i 1 ?num-fills)
            (bind ?edat-fill (pregunta-numero (str-cat "Edat del fill " ?i) 0 25))
            (bind ?edats-fills (create$ ?edats-fills ?edat-fill))
        ) else 
        (bind ?futur-fills (pregunta-si-no "Tindràs/eu fills properament?"))
    )

    ; (bind ?num-gent-gran 0)
    ; (if (< 0 (- ?num-persones ?num-fills)) then
    ;    (bind ?num-gent-gran (pregunta-numero "Conviureu amb avis o gent gran" 0 (- ?num-persones ?num-fills)))
    ;)
    ; (bind ?te-avis (> ?num-gent-gran 0))

    (bind ?te-avis (pregunta-si-no "Conviureu amb avis o gent gran"))
    
    ;;; Pressupost
    (printout t crlf "--- PRESSUPOST ---" crlf)
    (bind ?pres-max (pregunta-numero "Pressupost màxim mensual (EUR)" 1 100000))
    (bind ?pres-min (pregunta-numero "Pressupost mínim mensual (EUR)" 0 ?pres-max))
    (bind ?marge-estricte (pregunta-si-no "És important que es respecti el pressupost"))
    
    ;;; Mobilitat
    (printout t crlf "--- MOBILITAT ---" crlf)
    (bind ?treballa-ciutat (pregunta-si-no "Treballes a la ciutat?"))
    (bind ?estudia-ciutat (pregunta-si-no "Estudies a la ciutat?"))
    (bind ?te-vehicle (pregunta-si-no "Tens vehicle propi?"))

    ; Potser aquesta preguntaria me l'evitaria i faria que si no te vehicle propi i treballa o estudia a la ciutat es posi automàticament a cert
    (bind ?req-transport (pregunta-si-no "Es imprec?"))
    
    ;;; Accessibilitat
    (bind ?nec-reformes (pregunta-si-no "T'interessen cases per reformar"))
    (bind ?prim-residencia (pregunta-si-no "Es tractaria de la primera residència"))
    (bind ?nec-access (pregunta-si-no "L'habitatge ha de ser accessible (ascensor, planta baixa...)?"))
    
    ;;; Mascotes
    (printout t crlf "--- MASCOTES ---" crlf)
    (bind ?te-mascotes (pregunta-si-no "Tens mascotes?"))
    (bind ?num-mascotes 0)
    (bind ?tipus-mascota "Cap")
    (if (eq ?te-mascotes si) then
        (bind ?tipus-mascota (pregunta-opcio "Quin tipus de mascota?" Gos Gat Ocell Altre))
        (bind ?num-mascotes (pregunta-numero "Quantes mascotes tens?" 1 5))
    )

    (bind $?prefereix-servei
        (pregunta-multiopcio
        "Consideres algun d'aquests serveis imprescindibles?" Discoteca Parc Estadi Bar Mercat Autopista Aeroport)
    )
    (printout t crlf $?prefereix-servei crlf)

    (bind $?serveis-molestos
        (pregunta-multiopcio
        "Consideres algun d'aquests serveis molests?" Discoteca Parc Estadi Bar Mercat Autopista Aeroport)
    )
    (printout t crlf $?serveis-molestos crlf)


    ;;; Crear una instancia amb nom únic 
    (bind ?nom-inst (sym-cat sol- (gensym*)))

    ; En ves de preguntar al usuari quin tipus és, fer comprovacions per determinar-lo nosaltres.  No sé si comprovar-ho aquí al main o crear un solicitant i més tard dir que es de la classe X més concreta

    (make-instance ?nom-inst of Solicitant
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
        (requereixTransportPublic ?req-transport)
        (necessitaAccessibilitat ?nec-access)
        (teMascotes ?te-mascotes)
        (numeroMascotes ?num-mascotes)
        (tipusMascota ?tipus-mascota)
        (treballaACiutat ?treballa-ciutat)
        (estudiaACiutat ?estudia-ciutat)
        (evitaServei $?serveis-molestos)
        (prefereixServei $?prefereix-servei)
        (segonaResidencia ?seg-residencia)
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
        (load instancies_solicitants.clp)
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
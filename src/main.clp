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
    "Pregunta amb seleccio multiple"
    (printout t ?pregunta crlf)
    (printout t "   0. Cap / Saltar" crlf)
    (bind ?i 1)
    (foreach ?opc ?opcions
        (printout t "   " ?i ". " ?opc crlf)
        (bind ?i (+ ?i 1))
    )
    (printout t crlf "Tria una o més opcions (separades per espais, o 0 per cap): ")
    (bind $?numeros (explode$ (readline)))
    (bind $?resposta (create$))
    (foreach ?n $?numeros
        (if (numberp ?n) then
            (bind ?idx (integer ?n))
            (if (and (>= ?idx 1) (<= ?idx (length$ ?opcions))) then
                (bind $?resposta (create$ $?resposta (nth$ ?idx ?opcions)))
            )
        )
    )
    ?resposta
)


;;; ============================================================
;;; CREACIÓ DEL PERFIL DEL SOL·LICITANT
;;; ============================================================

(deffunction crear-perfil-solicitant ()
    "Recull dades i fa ASSERT del template dades-solicitant"
    
    (printout t crlf)
    (printout t "============================================================" crlf)
    (printout t "          CREACIÓ DEL PERFIL DEL SOL·LICITANT" crlf)
    (printout t "============================================================" crlf)
    (printout t crlf)
    
    ;;; --- 1. DADES BÀSIQUES ---
    (printout t "--- 1. DADES PERSONALS ---" crlf)
    (bind ?nom (pregunta-text "Nom o identificador del sol·licitant"))
    (bind ?edat (pregunta-numero "Edat del sol·licitant principal" 18 99))
    (bind ?seg-residencia (pregunta-si-no "Es tracta de la compra d'una segona residència "))
    
    ;;; --- 2. SITUACIÓ FAMILIAR ---
    (printout t crlf "--- 2. CONVIVÈNCIA ---" crlf)
    (bind ?num-persones (pregunta-numero "Nombre de persones que viuran a l'habitatge (incloent-te)" 1 10))
    
    (bind ?num-fills 0)
    (bind ?edats-fills (create$))
    (bind ?te-avis no)
    (bind ?planeja-fills no)
    
    (if (> ?num-persones 1) then
        (bind ?té-fills (pregunta-si-no "Hi haurà fills menors (<18 anys) convivint"))
        (if (eq ?té-fills si) then
            (bind ?num-fills (pregunta-numero "Quants fills menors" 1 (- ?num-persones 1)))
            (loop-for-count (?i 1 ?num-fills)
                (bind ?edat-fill (pregunta-numero (str-cat "  Edat del fill " ?i) 0 17))
                (bind ?edats-fills (create$ ?edats-fills ?edat-fill))
            )
        else
            ;; Parella o grup sense fills actuals
            (if (and (eq ?seg-residencia no) (<= ?edat 45)) then
                (bind ?planeja-fills (pregunta-si-no "Planegeu tenir fills en un futur proper (1-2 anys)"))
            )
        )
        (if (< (+ 1 ?num-fills) ?num-persones) then
            (bind ?te-avis (pregunta-si-no "Conviureu amb persones grans (>65 anys)"))
        )
    else
        ;; Individu sol
        (if (and (eq ?seg-residencia no) (<= ?edat 45)) then
            (bind ?planeja-fills (pregunta-si-no "Planegeu tenir fills o formar família en un futur proper"))
        )
    )
    
    ;;; --- 3. PRESSUPOST ---
    (printout t crlf "--- 3. ECONOMIA I HABITATGE ---" crlf)
    (bind ?pres-max (pregunta-numero "Pressupost màxim mensual (EUR)" 300 10000))
    (bind ?pres-min (pregunta-numero "Pressupost mínim ideal (EUR)" 0 ?pres-max))
    (bind ?marge-estricte (pregunta-si-no "El pressupost màxim és INFRANQUEJABLE (sense marge de flexibilitat)"))
    
    ;;; --- 4. MOBILITAT I UBICACIÓ ---
    (printout t crlf "--- 4. UBICACIÓ I MOBILITAT ---" crlf)
    (bind ?treballa-ciutat (pregunta-si-no "El lloc de treball principal és a la ciutat"))
    
    (bind ?estudia-ciutat no)
    (if (and (< ?edat 30) (eq ?treballa-ciutat no)) then
        (bind ?estudia-ciutat (pregunta-si-no "Estudies a la ciutat"))
    )
    
    (bind ?te-vehicle (pregunta-si-no "Disposeu de vehicle propi (cotxe/moto)"))
    
    (bind ?req-transport no)
    (if (eq ?te-vehicle no) then
        (printout t ">> Com que no teniu vehicle..." crlf)
        (bind ?req-transport (pregunta-si-no "És imprescindible que tingueu transport públic molt a prop"))
    else
        (bind ?req-transport (pregunta-si-no "Tot i tenir vehicle, us interessa transport públic a prop"))
    )
    
    ;;; --- 5. ACCESSIBILITAT ---
    (bind ?nec-access no)
    (if (or (eq ?te-avis si) (> ?edat 65)) then
        (printout t ">> Detectat: Persona gran a la llar" crlf)
        (bind ?nec-access (pregunta-si-no "És imprescindible que l'edifici tingui ascensor"))
    else
        (bind ?nec-access (pregunta-si-no "Necessiteu accés per a mobilitat reduïda (cadira rodes, etc.)"))
    )
    
    ;;; --- 6. MASCOTES ---
    (printout t crlf "--- 5. MASCOTES ---" crlf)
    (bind ?te-mascotes (pregunta-si-no "Teniu mascotes"))
    (bind ?num-mascotes 0)
    (bind ?tipus-mascota "Cap")
    (if (eq ?te-mascotes si) then
        (bind ?tipus-mascota (pregunta-opcio "Quin tipus principal de mascota?" Gos Gat Ocell Altre))
        (bind ?num-mascotes (pregunta-numero "Quantes mascotes teniu" 1 5))
    )
    
    ;;; --- 7. PREFERÈNCIES DE SERVEIS ---
    (printout t crlf "--- 6. PREFERÈNCIES I EXCLUSIONS ---" crlf)
    (bind $?prefereix-servei
        (pregunta-multiopcio
            "Considereu algun d'aquests serveis preferibles?"
            Discoteca Parc Estadi Bar Mercat Autopista Aeroport Gimnas Cinema Teatre)
    )
    
    (bind $?serveis-molestos
        (pregunta-multiopcio
            "Voleu evitar viure a prop d'algun d'aquests llocs?"
            Discoteca Parc Estadi Bar Mercat Autopista Aeroport)
    )
    
    ;;; --- ASSERT DEL FET (DADES RAW) ---
    (printout t crlf ">> Dades recollides. Generant perfil..." crlf crlf)
    
    (assert (dades-solicitant
        (nom ?nom)
        (edat ?edat)
        (numeroPersones ?num-persones)
        (numeroFills ?num-fills)
        (edatsFills ?edats-fills)
        (teAvis ?te-avis)
        (segonaResidencia ?seg-residencia)
        (estudiaACiutat ?estudia-ciutat)
        (pressupostMaxim ?pres-max)
        (pressupostMinim ?pres-min)
        (margeEstricte ?marge-estricte)
        (teVehicle ?te-vehicle)
        (requereixTransportPublic ?req-transport)
        (necessitaAccessibilitat ?nec-access)
        (teMascotes ?te-mascotes)
        (numeroMascotes ?num-mascotes)
        (tipusMascota ?tipus-mascota)
        (planejaFills ?planeja-fills)
        (evitaServei $?serveis-molestos)
        (prefereixServei $?prefereix-servei)
    ))
    
    TRUE
)


;;; ============================================================
;;; FUNCIÓ PRINCIPAL
;;; ============================================================

(deffunction main ()
    "Funció principal per executar el sistema amb presentació TOP 3"
    
    (printout t crlf)
    (printout t "╔════════════════════════════════════════════════════════════╗" crlf)
    (printout t "║   SISTEMA EXPERT DE RECOMANACIÓ D'HABITATGES DE LLOGUER    ║" crlf)
    (printout t "╚════════════════════════════════════════════════════════════╝" crlf)
    (printout t crlf)
    
    (printout t "Sistema carregat i a punt." crlf)
    (printout t crlf)
    (reset)
    ;;; Preguntar mode d'execució
    (bind ?crear-nou (pregunta-si-no "Vols crear un nou perfil de sol·licitant personalitzat"))
    
    (if (eq ?crear-nou si) then

        (printout t crlf "Iniciant mode interactiu..." crlf)
        
        ;; Esborrar sol·licitants anteriors per evitar confusions
        (do-for-all-instances ((?s Solicitant)) TRUE (send ?s delete))
        
        ;; Crear el nou perfil
        (bind ?perfil (crear-perfil-solicitant))
        (run)
    else

        (printout t crlf "Mode automàtic: Utilitzant perfils predefinits..." crlf)
        (printout t crlf)
        (load instancies_solicitants.clp)
        (reset)
        (run)
    )
    
    (printout t crlf)
    (printout t "╔════════════════════════════════════════════════════════════╗" crlf)
    (printout t "║                   PROCÉS FINALITZAT                        ║" crlf)
    (printout t "╚════════════════════════════════════════════════════════════╝" crlf)
    (printout t crlf)
)
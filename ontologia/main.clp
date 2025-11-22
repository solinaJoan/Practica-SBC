;;; ============================================================
;;; main.clp
;;; Fitxer principal del Sistema de Recomanació d'Habitatges
;;; ============================================================
;;;
;;; INSTRUCCIONS D'ÚS:
;;;
;;; 1. Obrir CLIPS
;;; 2. Carregar aquest fitxer: (load "main.clp")
;;; 3. Executar: (reset) i després (run)
;;;
;;; O bé carregar els fitxers individualment:
;;; (load "ontologiaSBC.clp")
;;; (load "instancies.clp")
;;; (load "regles.clp")
;;; (reset)
;;; (run)
;;;
;;; ============================================================

(printout t crlf)
(printout t "============================================================" crlf)
(printout t "   SISTEMA EXPERT DE RECOMANACIÓ D'HABITATGES DE LLOGUER" crlf)
(printout t "============================================================" crlf)
(printout t crlf)

;;; Carregar l'ontologia (classes)
(printout t "Carregant ontologia..." crlf)
(load "ontologiaSBC.clp")

;;; Carregar les instàncies (dades)
(printout t "Carregant instàncies..." crlf)
(load "instancies.clp")

;;; Carregar les regles (raonament)
(printout t "Carregant regles..." crlf)
(load "regles.clp")

(printout t crlf)
(printout t "Sistema carregat correctament!" crlf)
(printout t crlf)
(printout t "Per executar el sistema:" crlf)
(printout t "  1. Escriu: (reset)" crlf)
(printout t "  2. Escriu: (run)" crlf)
(printout t crlf)
(printout t "============================================================" crlf)
(printout t crlf)

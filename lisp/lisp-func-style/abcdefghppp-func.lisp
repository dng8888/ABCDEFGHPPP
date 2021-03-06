(DECLAIM (OPTIMIZE (SPEED 3)
           (COMPILATION-SPEED 0)
           (SAFETY 0)
           (DEBUG 0)))
(DEFVAR BASE 10)
(DEFVAR PPP 111)
(DEFVAR ALL NIL)
(DEFUN PASS-RULE1? (ANSWER N M)
  (IF (= N 7)
      (LET ((B (NTH 0 ANSWER))
        (C (NTH 1 ANSWER))
        (D (NTH 2 ANSWER))
        (E (NTH 3 ANSWER))
        (F (NTH 4 ANSWER)))
       (= (- (+ (* M BASE) B) (+ (* C BASE) D)) (+ (* E BASE) F)))
      T))
(DEFUN PASS-RULE2? (ANSWER N M)
  (IF (= N 3)
      (LET ((F (NTH 0 ANSWER))
        (G (NTH 1 ANSWER))
        (H (NTH 2 ANSWER)))
       (= (+ (+ (* M BASE) F) (+ (* G BASE) H)) PPP))
      T))
(DEFUN R-SEARCH (ANSWER N M)
  (COND ((= N 8)(SETF ALL (CONS ANSWER ALL)))
    ((= M BASE))
    ((AND (= M 0) (ODDP N)) (R-SEARCH ANSWER N 2))
    ((= M 1) (R-SEARCH ANSWER N 2))
    (T (COND ((MEMBER M ANSWER))
         ((NOT (PASS-RULE1? ANSWER N M)))
         ((NOT (PASS-RULE2? ANSWER N M)))
         (T (R-SEARCH (CONS M ANSWER) (+ N 1) 0)))
       (R-SEARCH ANSWER N (+ M 1)))))
(DEFUN I-SEARCH ()
  (SETF BASE (READ))
  (SETF PPP (+ (* BASE BASE) BASE 1))
  (SETF ALL NIL)
  (TIME (R-SEARCH NIL 0 0)))
(DEFUN BASE-N (X)
  (SETF BASE X)
  (SETF PPP (+ (* X X) X 1))
  (SETF ALL NIL)
  (TIME (R-SEARCH NIL 0 0))
  (FORMAT T "BASE:~A ANSWER:~A~%~%~%" BASE (LENGTH ALL)) 
  (DO ((N 1 (+ N 1)))
      ((> N (min 50 (length all))))
      (FORMAT T "~A~%" (NTH (RANDOM (LENGTH ALL)) ALL)))
  (PRINT '++++++++++++++++++++++++++++++++++++++++++++++++++))

(BASE-N 10)
(BASE-N 16)
(BASE-N 28)
(BASE-N 34)
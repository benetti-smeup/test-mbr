000100070528     V* ==============================================================
000200070528     V* MODIFICHE Ril.  T Au Descrizione
000300070528     V* gg/mm/aa  nn.mm i xx Breve descrizione
000400070528     V* ==============================================================
000500171106     V* 06/11/17  V5R1   BMA Creazione programma
000501171106     V* 06/11/17  V5R1   BMA Altre modifiche
000600070528     V* ==============================================================
000700070528     H/COPY QILEGEN,£INIZH
000800161020      *COPY QILEGEN,£MDVF        *** /COPY Soppressa da PTF B£61020B ***
000900070528     F*-------------------------------------------------------------------
001000160316     FTSTXXX0V  CF   E             WORKSTN
001100070528     F                                     INFDS(DSSF01)
001200130730      *--------------------------------------------------------------*
001300070528     D/COPY QILEGEN,£FEME
001400070528     D/COPY QILEGEN,£DMSE
001500070528     D/COPY QILEGEN,£KEY
001600070528      *--------------------------------------------------------------*
001700070528     D DSSF01          DS
001800070528     D  £KEY                 369    369
001900070528      *----------------------------------------------------------------
002000070528     D/COPY QILEGEN,£MDVDS_PG
002100160316     D  W$XXFU
002200160316     D  W$XXME
002300160316     D  W$XXYY
002400160316     D  W$XXOYY
002500160315     D/COPY QILEGEN,£MDVDS_AP
002600070528     D/COPY QILEGEN,£MDVDS_00
002700070528      *----------------------------------------------------------
002800070528     I/COPY QILEGEN,£FUNDS1
002900070528     I/COPY QILEGEN,£TABB£1DS
003000070528     I/COPY QILEGEN,£PDS
003100070528     I/COPY QILEGEN,£DMSI
003200160316     I/COPY QILEGEN,£xxxDS
003300070528      *--------------------------------------------------------------*
003400020122      * Ripresa dati memorizzati
003500940409     C                   EXSR      £MDV
003600070420     C                   EXSR      CTF1
003700940511     C                   EXSR      £OFV
003800020122      * Ciclo di gestione
0039009807171    C                   DO        *HIVAL
004000981119      * Emissione formato video
004100981119     C                   EXFMT     FMT1
004200981119      * Uscita
0043009811192    C     £KEY          IFEQ      £F03
004400981119     C     £KEY          OREQ      £F12
004500020705     C                   LEAVE
0046009811192e   C                   ENDIF
004700070420     C* Gestione memorizzazione dati video
0048000704202    C     W$RISC        IFNE      *BLANKS
004900070420     C                   CALL      'B£MDV5'
005000070420     C                   PARM      £PDSNP        $PDSNP           10
005100070420     C                   PARM                    W$RISC
005200070420     C                   PARM                    £MDVTO
005300070420     C                   PARM                    $IN35             1
005400070420     C                   MOVEL     *BLANKS       W$RISC
005500070420     C                   ITER
0056000704202e   C                   ENDIF
005700940414      * Test formato video
005800940414     C                   EXSR      CTF1
005900020705      * Esecuzione funzione
006000020705     C  N10
006100070412     CANN60              EXSR      ELB1
0062000207051e   C                   ENDDO
006300981119      *
006400940414      * Memorizzazione dati in uscita
006500940414     C                   EXSR      £MDV
006600940414     C                   SETON                                        LR
006700020705      *--------------------------------------------------------------*
006800930109     C/COPY QILEGEN,£INZSR
006900020705     C/COPY QILEGEN,£VEDSR
007000020705     C/COPY QILEGEN,£DECER
007100020705     C/COPY QILEGEN,£MDVC
007200020705     C/COPY QILEGEN,£DEC
007300020705     C/COPY QILEGEN,£OFV
007400020705     C/COPY QILEGEN,£DMS
007500020705     C/COPY QILEGEN,£NAV
007600020705     C/COPY QILEGEN,£CKO
007700020705     C/COPY QILEGEN,£FEM
007800160316     C/COPY QILEGEN,£xxx
007900070528     C/COPY QILEGEN,£TIM
008000940409      *--------------------------------------------------------------*
008100940409    RD*  Controllo Videata Guida
008200940409      *--------------------------------------------------------------*
008300940405     C     CTF1          BEGSR
008400070424      *
0085000704241    C     W$NUES        IFEQ      0
008600070424     C                   Z-ADD     1             W$NUES
0087000704241e   C                   ENDIF
008800130731      *
008900940414      * Refresh indicatori di errore
009000940414     C                   EXSR      £OFV
009100070420      *
009200070420     C                   SETON                                        10
0093000704201    C                   SELECT
009400070420      * Navigazione
0095000704201x   C     £KEY          WHENEQ    £F02
009600070420     C                   EXSR      £NAV
009700070420     C                   GOTO      G9CTF1
009800070420      * Visualizzazione messaggi
0099000704201x   C     £KEY          WHENEQ    £F22
010000070420     C                   EXSR      £DMSC3
010100070420     C                   GOTO      G9CTF1
010200020705      * Visualizzazione dati tecnici
0103000704201x   C     £KEY          WHENEQ    £F05
010400020705     C     *IN42         COMP      *ON                                4242
010500070420     C                   GOTO      G9CTF1
010600070420      * Decodifica
0107000704201x   C     £KEY          WHENEQ    £F04
010800070424     C                   EXSR      CON1
010900070424     C                   GOTO      G9CTF1
011000070420      * Visualizzazione sorgente
0111000704201x   C     £KEY          WHENEQ    £F16
011200160315     C                   MOVEL     '£K12'        £VEDSM
011300020705     C                   EXSR      £VEDSR
0114000207052    C     £VEDRC        IFEQ      '1'
011500020705     C                   MOVEL     'BAS0105'     £DMSME
011600020705     C                   EXSR      £DMSC2
011700020705     C                   SETON                                        60
0118000207052e   C                   ENDIF
011900020705     C                   GOTO      G9CTF1
012000070420      * Enter
0121000704201x   C                   OTHER
012200070420     C                   SETOFF                                       10
0123000704201e   C                   ENDSL
012400941111      * Refresh aree gestione errori
012500941111     C                   EXSR      £DMSC1
012600070420      * Salto i controlli se F10
0127000704021    C     £KEY          IFNE      £F10
012800940509     C                   EXSR      CON1
0129000704021e   C                   ENDIF
013000940428      *
013100940414      * Carica il primo messaggio d'errore
013200940414     C     G9CTF1        TAG
013300940502     C   60              EXSR      £DMSC4
013400940502     C   60              MOVEL     £DMS1M        W$MESV
013500991021      *
013600940414     C                   ENDSR
013700940506      *--------------------------------------------------------------*
013800940509    RD* Controllo campi immessi
013900940506      *--------------------------------------------------------------*
014000940509     C     CON1          BEGSR
014100020705      * Funzione/Metodo
014200160316     C                   MOVEL     W$XXFU        £FEM$F
014300160316     C                   MOVEL     W$XXME        £FEM$M
014400020705     C                   Z-ADD     61            £FEM1
014500020705     C                   Z-ADD     62            £FEM2
014600020705     C                   EXSR      £FEM
014700020705     C   36              SETON                                        10
014800160316     C                   MOVEL     £FEM$F        W$XXFU
014900160316     C                   MOVEL     £FEM$M        W$XXME
015000160316     C                   MOVEL     £FEM£F        W£XXFU
015100160316     C                   MOVEL     £FEM£M        W£XXME
0152000207051    C     *IN61         IFEQ      *ON
015300020705     C     *IN62         OREQ      *ON
015400020705     C                   SETON                                        60
0155000207051e   C                   ENDIF
015600951211      *
015700020122     C     G9CON1        ENDSR
015800020705      *--------------------------------------------------------------*
015900020705    RD* Esecuzione funzione
016000020705      *--------------------------------------------------------------*
016100070412     C     ELB1          BEGSR
016200130730      *
016300070420     C                   EVAL      £TIMNE=W$NUES
016400070406     C                   EXSR      £TIM
0165000507071    C                   DO        W$NUES
016600130806      *
016700160316     C                   EVAL      £xxxI_FU=W$XXFU
016800160316     C                   EVAL      £xxxI_ME=W$XXME
016900160316     C                   EVAL      £xxxI_YY=W$XXYY
017000130806      *
017100160316     C                   EXSR      £xxx
017200160316     C                   EVAL      W$XXOYY=£xxxO_yy
017300160316     C                   EVAL      W$MESS=£xxxO_M1
017400160316     C                   EVAL      W$FILE=£xxxO_M2
017500160316     C                   EVAL      W$IN35=£xxxO_M3
017600070412      *
0177000704031e   C                   ENDDO
017800070406     C                   EXSR      £TIM
017900130731      *
018000020705     C                   ENDSR
018100070412      *
018200940409      *--------------------------------------------------------------*
018300070308     D* Routine Iniziale
018400940409      *--------------------------------------------------------------*
018500940405     C     £INIZI        BEGSR
018600940405     C                   MOVEL     'V'           £DMSVS
018700940405     C                   ENDSR
018800001016      *---------------------------------------------------------------*
018900020705** £FEM
019000160316FU1       Funzione 1
019100160316FU2       Funzione 2

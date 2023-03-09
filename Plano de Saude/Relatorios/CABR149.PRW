#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'TOPCONN.CH'
/*--------------------------------------------------------------------------
| Programa  | CABR149  | Autor | Otavio Pinto         | Data |  07/08/2014  |
|---------------------------------------------------------------------------|
| Descricao | Consulta dados do Protocolo de Atendimento                    |
|           |                                                               |
|---------------------------------------------------------------------------|
| Uso       | Protocolo de Atendimento                                      | 
 --------------------------------------------------------------------------*/
user function CABR149

/*--------------------------------------------------------------------------
| Declaracao de Variaveis                                                   |
 --------------------------------------------------------------------------*/
Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := "das informações do Protocolo de Atendimento."
Local cDesc3         := ""
Local cPict          := ""
Local titulo         := "Relatório de Informações do Protocolo de Atendimento."
Local nLin           := 80

/*
PA      DATA_INI   NOME                                     PLANO                     MANIFESTA    PORTA_ENT    EMAIL                                    DEPTO            TRANSF           STATUS
999999  99/99/9999 AAAAAAAAAAAAAAAAA-40-AAAAAAAAAAAAAAAAAAA AAAAAAAAAAA-25-AAAAAAAAAA AAAA-12-AAAA AAAA-12-AAAA AAAAAAAAAAAAAAAAA-40-AAAAAAAAAAAAAAAAAAA AAAAAA-16-AAAAAA AAAAAA-16-AAAAAA AAA-10-AAA
                                                                                                   1                                                                                                   2                                                                         
         1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8         9         0         1         2         3         4         5        
123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678
999999 99/99/9999 AAAAAAAAAAAAAAAAA-40-AAAAAAAAAAAAAAAAAAA AAAAAAAAAAA-25-AAAAAAAAAA AAAA-12-AAAA AAAA-12-AAAA AAAAAAAAAAAAAAAAA-40-AAAAAAAAAAAAAAAAAAA AAAAAA-16-AAAAAA AAAAAA-16-AAAAAA AAAAAAAAAAAAAAAAAAAAAAAAA-60-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA AAA-10-AAA


                                                                                                   1                                                                                                   2                                                                         
         1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8         9         0         1         2         3         4         5        
123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678

999999 99/99/9999 AAAAAAAAAAAAAAAAA-40-AAAAAAAAAAAAAAAAAAA AAAAAAAAAAA-25-AAAAAAAAAA AAAA-12-AAAA AAAA-12-AAAA AAAAAAAAAAAAAAAAA-40-AAAAAAAAAAAAAAAAAAA AAAAAAAAAAAAA-30-AAAAAAAAAAAAA AAAAAA-16-AAAAAA AAAAAA-16-AAAAAA A
PA     DATA_INI   NOME                                     PLANO                     MANIFESTA    PORTA_ENT    EMAIL                                    SERVICO                        DEPTO            TRANSF           ST"                  
*/

Local Cabec1         := "PA     DATA_INI   NOME                                     PLANO                     MANIFESTA    PORTA_ENT    EMAIL                                    SERVICO                        DEPTO            TRANSF           ST"
Local Cabec2         := "ANOTACOES "                                                                                                                                                 
Local imprime        := .T.
Local aOrd := {}

Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite       := 220
Private tamanho      := "G"
Private nomeprog     := "CABR149" 
Private nTipo        := 18
Private aReturn      := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}
Private nLastKey     := 0
Private cbtxt        := Space(10)
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01
Private wnrel        := "CABR149" 
Private cPerg        := "CABR149"
Private cString      := "SZX"
Private cQry         := "" 
Private cCompet      := ""
Private cCodRDA      := ""
Private cAlias       := "TMP"
Private nTotRat      := 0
private cCRLF        := CHR(13)+CHR(10)
private _cPath	     := "C:\TEMP\"

ValidPerg()
IF !Pergunte(cPerg,.T.) ; return ; EndIf

wnrel := SetPrint(cString,NomeProg,"",@titulo,cDesc1,cDesc2,cDesc3,.T.,aOrd,.T.,Tamanho,,.T.)

If nLastKey == 27 ; return ; Endif
SetDefault(aReturn,cString)
If nLastKey == 27 ; return ; Endif
nTipo := If(aReturn[4]==1,15,18)

RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)

return

/*--------------------------------------------------------------------------
| Rotina de impressao...                                                    |
 --------------------------------------------------------------------------*/
Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)

local i       := 0
local nCont   := 0
	
    cQry := " SELECT DISTINCT " + cCRLF  
    cQry += "        ZX_SEQ PA " + cCRLF  
    cQry += "      , SubStr(ZX_DATDE,7,2)||'/'||SubStr(ZX_DATDE,5,2)||'/'||SubStr(ZX_DATDE,1,4)    DATA_INI " + cCRLF  
    cQry += "      , Trim(ZX_NOMUSR)   NOME " + cCRLF  
    cQry += "      , Trim(Upper(ZX_YPLANO))   PLANO " + cCRLF  
    cQry += "      , (SELECT Trim(PBL_YDSSRV) FROM "+RetSqlName("PBL")+ " PB WHERE PB.D_E_L_E_T_ = ' ' AND PBL_YCDSRV = ZY_TIPOSV AND PBL_YDEPTO = ZX_YAGENC ) SERVICO " + cCRLF  
    cQry += "      , ( SELECT Trim(X5_DESCRI) " + cCRLF  
    cQry += "          FROM "+RetSqlName("SX5")+ " X5 " + cCRLF  
    cQry += "          WHERE TRIM(D_E_L_E_T_) IS NULL " + cCRLF  
    cQry += "            AND X5_TABELA  = 'ZT' " + cCRLF  
    cQry += "            AND Trim(X5_CHAVE)   = Trim(ZX_TPDEM) " + cCRLF  
    cQry += "                  )          MANIFESTA " + cCRLF  
    cQry += "      , ( SELECT Trim(X5_DESCRI) " + cCRLF  
    cQry += "          FROM "+RetSqlName("SX5")+ " X5 " + cCRLF  
    cQry += "          WHERE TRIM(D_E_L_E_T_) IS NULL " + cCRLF  
    cQry += "            AND X5_TABELA  = 'ZU' " + cCRLF  
    cQry += "            AND Trim(X5_CHAVE)   = Trim(ZX_VATEND) " + cCRLF  
    cQry += "                  )          PORTA_ENT " + cCRLF  
    cQry += "      , ZX_EMAIL EMAIL " + cCRLF  
    cQry += "      , ZX_YAGENC   DEPTO " + cCRLF  

    cQry += "      , (SELECT Trim(CTT_DESC01) FROM "+RetSqlName("CTT")+ " CTT WHERE CTT.D_E_L_E_T_ = ' ' AND CTT_CUSTO = ZY_YCUSTO ) TRANSF " + cCRLF  

    cQry += "      , ( SELECT Trim(ZY_OBS)||'.'||(SELECT Trim(ZY_OBS)||'.'||(SELECT Trim(ZY_OBS)||'.'||(SELECT Trim(ZY_OBS) " + cCRLF  
    cQry += "                                                                                           FROM "+RetSqlName("SZY")+ " ZY " + cCRLF  
    cQry += "                                                                                           WHERE D_E_L_E_T_ = ' ' " + cCRLF  
    cQry += "                                                                                             AND ZY_FILIAL  = '  ' " + cCRLF  
    cQry += "                                                                                             AND ZY_SEQBA   = ZX_SEQ " + cCRLF  
    cQry += "                                                                                             AND ZY_DTSERV  = ZX_DATDE " + cCRLF  
    cQry += "                                                                                             AND ZY_SEQSERV = '000004') " + cCRLF  
    cQry += "                                                                 FROM "+RetSqlName("SZY")+ " ZY " + cCRLF  
    cQry += "                                                                 WHERE D_E_L_E_T_ = ' ' " + cCRLF  
    cQry += "                                                                   AND ZY_FILIAL  = '  ' " + cCRLF  
    cQry += "                                                                   AND ZY_SEQBA   = ZX_SEQ " + cCRLF  
    cQry += "                                                                   AND ZY_DTSERV  = ZX_DATDE " + cCRLF  
    cQry += "                                                                   AND ZY_SEQSERV = '000003') " + cCRLF  
    cQry += "                                      FROM "+RetSqlName("SZY")+ " ZY " + cCRLF  
    cQry += "                                      WHERE D_E_L_E_T_ = ' ' " + cCRLF  
    cQry += "                                        AND ZY_FILIAL  = '  ' " + cCRLF  
    cQry += "                                        AND ZY_SEQBA   = ZX_SEQ " + cCRLF  
    cQry += "                                        AND ZY_DTSERV  = ZX_DATDE " + cCRLF  
    cQry += "                                        AND ZY_SEQSERV = '000002') " + cCRLF  
    cQry += "          FROM "+RetSqlName("SZY")+ " ZY " + cCRLF  
    cQry += "          WHERE D_E_L_E_T_ = ' ' " + cCRLF  
    cQry += "            AND ZY_FILIAL  = '  ' " + cCRLF  
    cQry += "            AND ZY_SEQBA   = ZX_SEQ " + cCRLF  
    cQry += "            AND ZY_DTSERV  = ZX_DATDE " + cCRLF  
    cQry += "            AND ZY_SEQSERV = '000001' " + cCRLF  
    cQry += "              )                                           ANOTACOES " + cCRLF  
    cQry += "      , Decode(ZX_TPINTEL,'1','Pendente','2','Encerrado')  STATUS " + cCRLF  

    cQry += "      , ZX_YAGENC " + cCRLF  
    cQry += "      , ZX_DATDE " + cCRLF  

    cQry += " FROM "+RetSqlName("SZX")+ " ZX " + cCRLF  
    cQry += "    , "+RetSqlName("SZY")+ " ZY " + cCRLF  
    cQry += " WHERE  zx_seq = zy_seqba " + cCRLF  
    cQry += "   AND zx.d_e_l_e_t_ = ' ' " + cCRLF  
    cQry += "   AND zy.d_e_l_e_t_ = ' ' " + cCRLF  
    cQry += "   AND ZX_FILIAL BETWEEN  '"+mv_par01+"'  AND '"+mv_par02+"'            -- FILIAL " + cCRLF  
    cQry += "   AND ZX_DATDE  BETWEEN '"+DTOS(mv_par03)+"'  AND '"+DTOS(mv_par04)+"' -- DATA INICIAL " + cCRLF  
    if !empty(mv_par05) .and. !empty(mv_par06) 
       cQry += "   AND ZX_SEQ  BETWEEN '"+mv_par05+"' AND '"+mv_par06+"'                -- PA " + cCRLF  
    endif   
    if !empty(mv_par07) 
       cQry += "   AND ZX_NOMUSR  LIKE '"+mv_par07+"%'                                  -- NOME " + cCRLF  
    endif
    if !empty(mv_par08) 
       cQry += "   AND Trim(ZY_TIPOSV)  = '"+mv_par08+"'                                -- SERVIÇO " + cCRLF  
    endif
    if !empty(mv_par09) 
       cQry += "   AND Trim(ZX_TPDEM)   = '"+mv_par09+"'                                -- MANIFESTA  (C=CONSULTA ; R=RECLAMACAO ; ...) " + cCRLF  
    endif
    if !empty(mv_par10) 
       cQry += "   AND ZX_VATEND  = '"+mv_par10+"'                                      -- PORTA_ENT (1=Fale Conosco ; 3=Telefone ; ...) " + cCRLF  
    endif
    if !empty(mv_par11) .and. !empty(mv_par12)     
       cQry += "   AND ZX_YCUSTO BETWEEN '"+mv_par11+"'  AND '"+mv_par12+"'             -- DEPTO " + cCRLF  
    endif
    if !empty(mv_par13) .and. !empty(mv_par14)    
       cQry += "   AND ZY_YCUSTO  BETWEEN '"+mv_par13+"'  AND '"+mv_par14+"'            -- TRANSF " + cCRLF  
    endif
    if mv_par15 < 3
       cQry += "   AND ZX_TPINTEL = '"+strzero(mv_par15,1)+"'                           -- STATUS    (1=Pendente ; 2=Encerrado) " + cCRLF  
    endif   

    cQry += " ORDER BY ZX_YAGENC, ZX_DATDE, NOME " + cCRLF  
    
MemoWrite(Alltrim(_cPath)+"CABR149.SQL", cQry)    
    
If Select(cAlias)>0
	(cAlias)->(DbCloseArea())
EndIf
			
DbUseArea(.T.,"TopConn",TcGenQry(,,cQry),cAlias,.T.,.T.)
		
DbSelectArea(cAlias)
(cAlias)->( DbGoTop() )

COUNT TO nCont

SetRegua(nCont)        

(cAlias)->(DbGoTop())

While !((cAlias)->(Eof()))
   /*--------------------------------------------------------------------------
   | Verifica o cancelamento pelo usuario...                                   |
    --------------------------------------------------------------------------*/
    If lAbortPrint
      @nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
      Exit
   Endif
 
   /*--------------------------------------------------------------------------
   | Impressao do cabecalho do relatorio. . .                                  |
    --------------------------------------------------------------------------*/
    If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
      Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
      nLin := 8
    Endif

    nLin := nLin + 1 // Avanca a linha de impressao
	@nLin,00  PSAY (cAlias)->PA
	@nLin,08  PSAY (cAlias)->DATA_INI
	@nLin,19  PSAY SUBSTR((cAlias)->NOME,1,40)
	@nLin,60  PSAY SUBSTR((cAlias)->PLANO,1,25)
	@nLin,86  PSAY SUBSTR((cAlias)->MANIFESTA,1,12)
	@nLin,99  PSAY SUBSTR((cAlias)->PORTA_ENT,1,12)
	@nLin,112 PSAY SUBSTR((cAlias)->EMAIL,1,40)
    @nLin,153 PSAY SUBSTR((cAlias)->SERVICO,1,30)
    @nLin,184 PSAY SUBSTR((cAlias)->DEPTO,1,16)
    @nLin,201 PSAY SUBSTR((cAlias)->TRANSF,1,16)    
    @nLin,219 PSAY SUBSTR((cAlias)->STATUS,1,1)
    nLin := nLin + 1 // Avanca a linha de impressao    
    @nLin,00  PSAY SUBSTR((cAlias)->ANOTACOES,1,220)
    nLin := nLin + 1 // Avanca a linha de impressao
    @nLin,00  PSAY REPLICATE("-",220)

    (cAlias)->(DbSkip())
    
EndDo

SET DEVICE TO SCREEN

If aReturn[5]==1
   dbCommitAll()
   SET PRINTER TO
   OurSpool(wnrel)
Endif

MS_FLUSH()

Return


/*--------------------------------------------------------------------------
| Cria perguntas se não existir ...                                         |
 --------------------------------------------------------------------------*/
Static Function ValidPerg

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
Local j := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

_sAlias := Alias()
aRegs   := {}

dbSelectArea("SX1")
dbSetOrder(1)
cPerg := PadR(cPerg,Len(SX1->X1_GRUPO))

// Grupo/Ordem/Pergunta/PerEsp/PerIng/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01///Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05

/*
+--------------------------------------------------+
| PARAMETROS UTILIZADOS                            |
+--------------------------------------------------+
|  01  |  Da Filial           | mv_par01           |
|  02  |  Ate Filial          | mv_par02           |
|  03  |  Da Data             | mv_par03           |
|  04  |  Ate Data            | mv_par04           |
|  05  |  Da Sequencia        | mv_par05           |
|  06  |  Ate Sequencia       | mv_par06           |
|  07  |  Nome                | mv_par07           |
|  08  |  Tipo Servico        | mv_par08           |
|  09  |  Tipo Manifestacao   | mv_par09           |
|  10  |  Porta Entrada       | mv_par10           |
|  11  |  Do Depto            | mv_par11           |
|  12  |  Ate Depto           | mv_par12           |
|  13  |  Da Transferencia    | mv_par13           |
|  14  |  Ate Transferencia   | mv_par14           |
|  15  |  Status              | mv_par15           |
+--------------------------------------------------+
*/

AAdd(aRegs,{cPerg , "01" , "Da Filial                ?" ,"","", "mv_ch1" , "C" , 02 , 0 ,0 , "G" , "" , "mv_par01" , ""        , "" , "" , "" , "" , ""          , "" , "" , "" , "" , ""      , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "SM0"   , "" })
AAdd(aRegs,{cPerg , "02" , "Ate Filial               ?" ,"","", "mv_ch2" , "C" , 02 , 0 ,0 , "G" , "" , "mv_par02" , ""        , "" , "" , "" , "" , ""          , "" , "" , "" , "" , ""      , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "SM0"   , "" })
AAdd(aRegs,{cPerg , "03" , "Da Data                  ?" ,"","", "mv_ch3" , "D" , 08 , 0 ,0 , "G" , "" , "mv_par03" , ""        , "" , "" , "" , "" , ""          , "" , "" , "" , "" , ""      , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , ""      , "" })
AAdd(aRegs,{cPerg , "04" , "Ate Data                 ?" ,"","", "mv_ch4" , "D" , 08 , 0 ,0 , "G" , "" , "mv_par04" , ""        , "" , "" , "" , "" , ""          , "" , "" , "" , "" , ""      , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , ""      , "" })
AAdd(aRegs,{cPerg , "05" , "Do PA                    ?" ,"","", "mv_ch5" , "C" , 06 , 0 ,0 , "G" , "" , "mv_par05" , ""        , "" , "" , "" , "" , ""          , "" , "" , "" , "" , ""      , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , ""      , "" })
Aadd(aRegs,{cPerg , "06" , "Ate PA                   ?" ,"","", "mv_ch6" , "C" , 06 , 0 ,0 , "G" , "" , "mv_par06" , ""        , "" , "" , "" , "" , ""          , "" , "" , "" , "" , ""      , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , ""      , "" })
Aadd(aRegs,{cPerg , "07" , "Nome                     ?" ,"","", "mv_ch7" , "C" , 30 , 0 ,0 , "G" , "" , "mv_par07" , ""        , "" , "" , "" , "" , ""          , "" , "" , "" , "" , ""      , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , ""      , "" })
AAdd(aRegs,{cPerg , "08" , "Tipo Servico             ?" ,"","", "mv_ch8" , "C" , 03 , 0 ,0 , "G" , "" , "mv_par08" , ""        , "" , "" , "" , "" , ""          , "" , "" , "" , "" , ""      , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , ""      , "" })
AAdd(aRegs,{cPerg , "09" , "Tipo Manifestacao        ?" ,"","", "mv_ch9" , "C" , 01 , 0 ,0 , "G" , "" , "mv_par09" , ""        , "" , "" , "" , "" , ""          , "" , "" , "" , "" , ""      , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "SZXX5" , "" })
AAdd(aRegs,{cPerg , "10" , "Porta Entrada            ?" ,"","", "mv_ch0" , "C" , 01 , 0 ,0 , "G" , "" , "mv_par10" , ""        , "" , "" , "" , "" , ""          , "" , "" , "" , "" , ""      , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "SX5ZU" , "" })
AAdd(aRegs,{cPerg , "11" , "Do Depto                 ?" ,"","", "mv_chA" , "C" , 03 , 0 ,0 , "G" , "" , "mv_par11" , ""        , "" , "" , "" , "" , ""          , "" , "" , "" , "" , ""      , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "CTTBA" , "" })
AAdd(aRegs,{cPerg , "12" , "Ate Depto                ?" ,"","", "mv_chB" , "C" , 03 , 0 ,0 , "G" , "" , "mv_par12" , ""        , "" , "" , "" , "" , ""          , "" , "" , "" , "" , ""      , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "CTTBA" , "" })
Aadd(aRegs,{cPerg , "13" , "Da Transferencia         ?" ,"","", "mv_chC" , "C" , 03 , 0 ,0 , "G" , "" , "mv_par13" , ""        , "" , "" , "" , "" , ""          , "" , "" , "" , "" , ""      , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "CTTBA" , "" })
Aadd(aRegs,{cPerg , "14" , "Ate Transferencia        ?" ,"","", "mv_chD" , "C" , 02 , 0 ,0 , "G" , "" , "mv_par14" , ""        , "" , "" , "" , "" , ""          , "" , "" , "" , "" , ""      , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "CTTBA" , "" })
Aadd(aRegs,{cPerg , "15" , "Status                   ?" ,"","", "mv_chE" , "C" , 01 , 0 ,0 , "C" , "" , "mv_par15" , "Pendente", "" , "" , "" , "" , "Encerrado" , "" , "" , "" , "" , "Ambos" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , ""      , "" })
For i:=1 to Len(aRegs)
    If !dbSeek(cPerg+aRegs[i,2])
        RecLock("SX1",.T.)
        For j:=1 to FCount()
            If j <= Len(aRegs[i])
                FieldPut(j,aRegs[i,j])
            Endif
        Next
        MsUnlock()
    Endif
Next
dbSelectArea(_sAlias)
Return


// Fim do Programa CABR149.PRW






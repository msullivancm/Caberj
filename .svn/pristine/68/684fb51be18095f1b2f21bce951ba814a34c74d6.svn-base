#Include "protheus.ch"
#Include "rwmake.ch"
#Include "topconn.ch"

//#define  24ANOS   8766   // 24 anos * 365.25 dias no ano = 8766 dias
//#define  6MESES   152.5  //( 182.5 -> 6 meses ; 152,5 -> 5 meses )
#define  CABERJ   '01'
#define  INTEGRAL '02'

/*------------------------------------------------------------------------- 
| Programa  | Manut032  |Autor  | Otavio Pinto        | Data |  14/10/2013 |
|--------------------------------------------------------------------------|
| Desc.     | calcula data limite do usuario conforme os parametros        |
|           | definidos                                                    |
|--------------------------------------------------------------------------|
| Uso       | inclusao de usuario   '05','06','12','13','23','24'          |
 -------------------------------------------------------------------------*/

user function CABAM32()
private cQry   := ""
private cPerg  := "CABAM32"
private nLidos := 0 
private nAlterados := 0

ValidPerg()

	If Pergunte(cPerg,.T.) ; Processa({ ||FProcess()},"Gerando Arquivo ... ","",.T.) ; EndIf    
If nLidos > 0  
   MsgStop("Lidos : "+StrZero(nLidos,6)+"  /  Alterados : "+StrZero(nAlterados,6)  )
endif

Return Nil

/*
  Processa
  Rotina de impressao
*/

static function FPROCESS()
 
dbSelectArea("BA1") 
BA1->( dbSetOrder(1) )
/*
+--------------------------------------------------+
| PARAMETROS UTILIZADOS                            |
+--------------------------------------------------+
|  01  |  Da Operadora        | mv_par01           |
|  02  |  Ate Operadora       | mv_par02           |
|  03  |  Da Empresa          | mv_par03           |
|  04  |  Ate Empresa         | mv_par04           |
|  05  |  Do Contrato         | mv_par05           |
|  06  |  Ate Contrato        | mv_par06           |
|  07  |  Do SubContrato      | mv_par07           |
|  08  |  Ate SubContrato     | mv_par08           |
|  09  |  So Data Limite      | mv_par09           |
+--------------------------------------------------+
*/
 
cQry := " SELECT * "
cQry += " FROM "+RetSQLName("BA1")+" BA1 "
cQry += "    , "+RetSQLName("BA3")+" BA3 "
cQry += " WHERE BA1_FILIAL = ' ' "

cQry += "   AND BA1_DATBLO = ' ' "

cQry += "   AND BA1_CODINT BETWEEN '" + mv_par01 + "' AND '" + mv_par02 +"'"
cQry += "   AND BA1_CODEMP BETWEEN '" + mv_par03 + "' AND '" + mv_par04 +"'"
cQry += "   AND BA1_CONEMP BETWEEN '" + mv_par05 + "' AND '" + mv_par06 +"'"
cQry += "   AND BA1_SUBCON BETWEEN '" + mv_par07 + "' AND '" + mv_par08 +"'" 
cQry += "   AND BA1_MATRIC BETWEEN '" + mv_par09 + "' AND '" + mv_par10 +"'"

Do Case 
   Case mv_par11 == 1 ; cQry += "   AND BA1_YDTLIM = ' ' "
   Case mv_par11 == 2 ; cQry += "   AND BA1_YDTLIM <> ' ' "
Endcase

cQry += "   AND BA3_FILIAL = BA1_FILIAL "
cQry += "   AND BA3_CODINT = BA1_CODINT "
cQry += "   AND BA3_CODEMP = BA1_CODEMP "
cQry += "   AND BA3_MATRIC = BA1_MATRIC "
cQry += "   AND BA3_DATBLO = ' '  "

cQry += "   AND BA1.D_E_L_E_T_ = ' ' "
cQry += "   AND BA3.D_E_L_E_T_ = ' ' "   

cQry += " ORDER BY BA1_CODINT, BA1_CODEMP, BA1_MATRIC, BA1_TIPREG  "

if Select("TRAB") > 0 ; dbSelectArea("TRAB") ; TRAB->( dbCloseArea() ) ; endif
//+----------------------------------------------------------------+
//| Cria tabela temporaria conforme Query                          |
//+----------------------------------------------------------------+
dbUseArea(.T., "TOPCONN", TcGenQry(,, cQry ),"TRAB" , .T., .F.)
dbSelectArea("TRAB" )
ProcRegua( TRAB->( RecCount() ) )
TRAB->( dbGoTop() )
// Varre o TMP ate o final do arquivo

do while TRAB->( !Eof() ) 

   IncProc( TRAB->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO+" "+BA1_NOMUSR) ) 
   nLidos ++ 
   if BA1->( dbSeek( xFilial("BA1")+TRAB->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPUSU+BA1_TIPREG+BA1_DIGITO) )  )

      RecLock("BA1",.F.) 
      fCalDtLim()   
      nAlterados ++
	  MsUnlock()         
	  
   endif	  
   
   TRAB->( dbSkip() ) 
  
enddo

return //dDatLimite


/*------------------------------------------------------------------------- 
| Programa  | ValidPerg |Autor  | Otavio Pinto        | Data |  02/09/2014 |
|--------------------------------------------------------------------------|
| Desc.     | Verifica a existencia das perguntas criando-as caso seja     |
|           | necessario (caso nao existam).                               |
 -------------------------------------------------------------------------*/
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
|  01  |  Da Operadora        | mv_par01           |
|  02  |  Ate Operadora       | mv_par02           |
|  03  |  Da Empresa          | mv_par03           |
|  04  |  Ate Empresa         | mv_par04           |
|  05  |  Do Contrato         | mv_par05           |
|  06  |  Ate Contrato        | mv_par06           |
|  05  |  Do SubContrato      | mv_par07           |
|  06  |  Ate SubContrato     | mv_par08           |
|  06  |  So Data Limite      | mv_par09           |
+--------------------------------------------------+
*/

AAdd(aRegs,{cPerg , "01" , "Da Operadora             ?" ,"","", "mv_ch1" , "C" , 4  ,0 ,0 , "G" , "" , "mv_par01" , ""     , "" , "" , "" , "" , ""           , "" , "" , "" , "" , ""      , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "B89PLS", "" })
AAdd(aRegs,{cPerg , "02" , "Ate Operadora            ?" ,"","", "mv_ch2" , "C" , 4  ,0 ,0 , "G" , "" , "mv_par02" , ""     , "" , "" , "" , "" , ""           , "" , "" , "" , "" , ""      , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "B89PLS", "" })
AAdd(aRegs,{cPerg , "03" , "Da Empresa               ?" ,"","", "mv_ch3" , "C" , 4  ,0 ,0 , "G" , "" , "mv_par03" , ""     , "" , "" , "" , "" , ""           , "" , "" , "" , "" , ""      , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "BJLPLS", "" })
AAdd(aRegs,{cPerg , "04" , "Ate Empresa              ?" ,"","", "mv_ch4" , "C" , 4  ,0 ,0 , "G" , "" , "mv_par04" , ""     , "" , "" , "" , "" , ""           , "" , "" , "" , "" , ""      , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "BJLPLS", "" })
AAdd(aRegs,{cPerg , "05" , "Do Contrato              ?" ,"","", "mv_ch5" , "C" , 12 ,0 ,0 , "G" , "" , "mv_par05" , ""     , "" , "" , "" , "" , ""           , "" , "" , "" , "" , ""      , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "B7BPLS", "" })
Aadd(aRegs,{cPerg , "06" , "Ate Contrato             ?" ,"","", "mv_ch6" , "C" , 12 ,0 ,0 , "G" , "" , "mv_par06" , ""     , "" , "" , "" , "" , ""           , "" , "" , "" , "" , ""      , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "B7BPLS", "" })
Aadd(aRegs,{cPerg , "07" , "Do SubContrato           ?" ,"","", "mv_ch7" , "C" , 9  ,0 ,0 , "G" , "" , "mv_par07" , ""     , "" , "" , "" , "" , ""           , "" , "" , "" , "" , ""      , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "B7CPLS", "" })
Aadd(aRegs,{cPerg , "08" , "Ate SubContrato          ?" ,"","", "mv_ch8" , "C" , 9  ,0 ,0 , "G" , "" , "mv_par08" , ""     , "" , "" , "" , "" , ""           , "" , "" , "" , "" , ""      , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "B7CPLS", "" })
Aadd(aRegs,{cPerg , "09" , "Da Matricula             ?" ,"","", "mv_ch9" , "C" , 6  ,0 ,0 , "G" , "" , "mv_par09" , ""     , "" , "" , "" , "" , ""           , "" , "" , "" , "" , ""      , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , ""      , "" })
Aadd(aRegs,{cPerg , "10" , "Ate Matricula            ?" ,"","", "mv_chA" , "C" , 6  ,0 ,0 , "G" , "" , "mv_par10" , ""     , "" , "" , "" , "" , ""           , "" , "" , "" , "" , ""      , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , ""      , "" })
Aadd(aRegs,{cPerg , "11" , "Data Limite              ?" ,"","", "mv_chB" , "C" , 1  ,0 ,0 , "C" , "" , "mv_par11" , "Vazia", "" , "" , "" , "" , "Preenchida" , "" , "" , "" , "" , "Ambos" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , "" , ""      , "" })
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


/*------------------------------------------------------------------------- 
| Programa  | fcaldtlim |Autor  | Otavio Pinto        | Data |  01/10/2012 |
|--------------------------------------------------------------------------|
| Desc.     | Calcula Data Limite do usuario.                              |
|           | Usados a TABELA: ZDL                                         |
|           | Chamada : no campo BA1_DATINC                                |
|--------------------------------------------------------------------------|
|           |            *** N O V A     V E R S A O ****                  | 
|--------------------------------------------------------------------------|
| Uso       | inclusao/alteracao de beneficiario                           |
|--------------------------------------------------------------------------|
|Formulas   | nZDLANOS  := INT( 24 anos * 365.25 dias ) = 8766 dias        |
|Exemplo    | nZDLMESES := INT( 6 meses * 30) - 28 = 152,5 -> 5 meses      | 
|--------------------------------------------------------------------------|
|           | Eu estava usando o campo BA1_CONEMP como sendo Contrato,     |
|           | porem o Bianchini me mostrou que na CABERJ o Contrato eh     |
|           | lido pelo campo BA1_CODEMP.                                  |
|           |                                                              | 
|           | Regra:                                                       |
|           |------------------------------------------------------------- |
|           |     TODOS     |  AGREGADOS  |    ART.30    |     ART.31      |
|           |------------------------------------------------------------- |
|           |    24 anos    |             |              |    24 anos      |
|           |      Dep      |      0      |   Mensagem   |      Dep        |
|           |                                                              | 
|--------------------------------------------------------------------------|
|26/09/2014 | Reescrita a rotina de calculo da Data Limite, de modo a per- |
|   OSP     | mitir ser parametrizada pela tabela ZDL. Assim,novas empresas|
|           | serão configuradas pelo proprio usuário.                     |
 -------------------------------------------------------------------------*/

static function fCalDtLim()      

local fdia           := {'31','28','31','30','31','30','31','31','30','31','30','31'}                    

private cCRLF        := chr(13)+chr(10)
private cEmpresa     := SM0->M0_CODIGO

private dDatInic     := BA1->BA1_DATINC
private cBA1_CODINT  := BA1->BA1_CODINT 
private cBA1_CODEMP  := BA1->BA1_CODEMP
private cBA1_CONEMP  := BA1->BA1_CONEMP
private cBA1_VERCON  := BA1->BA1_VERCON
private cBA1_SUBCON  := BA1->BA1_SUBCON
private cBA1_VERSUB  := BA1->BA1_VERSUB
private cBA1_TIPUSU  := BA1->BA1_TIPUSU

private dDatNasc     := CtoD("")

private _cAviso      := "Atencao !"

private cNReduz      := ""
private cArt30_31    := ""

private _aTexto      := {}         
private nIdade       := 0

private cLinha       := ""
private cSql         := ""
private cAlias       := "TMP"
private dDatLimite   := CtoD("")
private cTexto       := ""

/*NOVAS VARIAVEIS*/
private nZDLANOS    := 0
private nZDLMESES   := 0
private dMeses      := CtoD("")
private dAanos      := CtoD("") 
private dSegGar     := CtoD("")

private cArea        := Alias()
private dDatNasc     := CtoD("")

dbSelectArea ("BTS")
("BTS")->( DbSetOrder(1) )
if ("BTS")->( dbSeek(xFilial("BTS")+BA1->BA1_MATVID) )
   dDatNasc := ("BTS")->BTS_DATNAS
endif

dbSelectArea ("BQC")
("BQC")->( DbSetOrder(1) )
if ("BQC")->( dbSeek(xFilial("BQC")+BA1->( BA1_CODINT+BA1_CODEMP+BA1_CONEMP+BA1_VERCON+BA1_SUBCON+BA1_VERSUB ) ) )
   cNReduz   := ("BQC")->BQC_DESCRI
   cArt30_31 := ("BQC")->BQC_YSTSCO
endif

dbSelectArea(cArea)

nIdade   := int( (dDataBase - dDatNasc) / 365 )

begin sequence

if Empty(dDatNasc)
   Alerta("Este associado está sem a data de nascimento no Cadastro de VIDAS... Verificar !!", "A T E N C A O") 
   break
endif   
  
cSql := ' SELECT ZDL_FILIAL ' + cCRLF
cSql += '      , ZDL_CODINT ' + cCRLF
cSql += '      , ZDL_CODEMP ' + cCRLF
cSql += '      , ZDL_CONEMP ' + cCRLF
cSql += '      , ZDL_VERCON ' + cCRLF
cSql += '      , ZDL_SUBCON ' + cCRLF
cSql += '      , ZDL_VERSUB ' + cCRLF
cSql += '      , ZDL_TIPUSU ' + cCRLF 
cSql += '      , ZDL_GRAUPA ' + cCRLF
cSql += '      , ZDL_ANO    ' + cCRLF 
cSql += '      , ZDL_MESES  ' + cCRLF
cSql += '      , ZDL_DTLIM ' + cCRLF
cSql += '      , ZDL_ART30 ' + cCRLF
cSql += '      , ZDL_ART31 ' + cCRLF
cSql += '      , ZDL_AGREG ' + cCRLF
cSql += '      , ZDL_MENSAG ' + cCRLF
cSql += ' FROM '+RetSqlName("ZDL") + cCRLF 
cSql += " WHERE D_E_L_E_T_ = ' ' " + cCRLF
cSql += "   AND ZDL_FILIAL = ' ' " + cCRLF
cSql += "   AND ZDL_CODINT = '"+ cBA1_CODINT +"' " + cCRLF
cSql += "   AND ZDL_CODEMP = '"+ cBA1_CODEMP +"' " + cCRLF
cSql += "   AND ZDL_CONEMP = '"+ cBA1_CONEMP +"' " + cCRLF
cSql += "   AND ZDL_VERCON = '"+ cBA1_VERCON +"' " + cCRLF
cSql += "   AND ZDL_SUBCON = '"+ cBA1_SUBCON +"' " + cCRLF
cSql += "   AND ZDL_VERSUB = '"+ cBA1_VERSUB +"' " + cCRLF 
cSql += "   AND ZDL_TIPUSU = '"+ cBA1_TIPUSU +"' " + cCRLF
cSql += " ORDER BY ZDL_FILIAL , ZDL_CODINT , ZDL_CODEMP , ZDL_CONEMP , ZDL_VERCON , ZDL_SUBCON , ZDL_VERSUB "

Memowrit( "C:\TEMP\CALCDTLIM.sql", cSQL )

If Select(cAlias) > 0 
   dbSelectArea(cAlias) 
   (cAlias)->( dbCloseArea() ) 
Endif
dbUseArea(.T., "TOPCONN", TcGenQry(,, cSQL), cAlias, .T., .F.)                        
X:= TMP->( RECCOUNT() )

(cAlias)->( dbGotop() )


While (cAlias)->( !Eof() )

   /*NOVAS VARIAVEIS*/
   nZDLANOS     := INT( (cAlias)->ZDL_ANO * 365.25 )
   nZDLMESES    := INT( (cAlias)->ZDL_MESES * 30 ) //- 28 


    do case
       /*-----------------------------------------------------------------------
       | C A B E R J                                                            |
        -----------------------------------------------------------------------*/
       case cEmpresa == CABERJ

            do case
               case (cAlias)->ZDL_TIPUSU == cBA1_TIPUSU
                    If (cAlias)->ZDL_DTLIM == "1"
                       Do Case
                          Case (cAlias)->ZDL_ANO > 0 .AND. (cAlias)->ZDL_MESES == 0 .AND. (cAlias)->ZDL_ART30  <> "1" .AND. (cAlias)->ZDL_ART31  <> "1" .and. (cAlias)->ZDL_AGREG <> "1"
						       if BA1->BA1_GRAUPA $ Alltrim((cAlias)->ZDL_GRAUPA) .AND. nIdade < (cAlias)->ZDL_ANO
							      dDatLimite := CTOD( If( Mod(Year((dDatNasc + nZDLANOS)),4)=0 .And. Month( (dDatNasc + nZDLANOS) ) = 2 , '29', fdia[Month( (dDatNasc + nZDLANOS) )] )+ "/" +;
											    strzero(month((dDatNasc + nZDLANOS)),2) +"/"+strzero(year((dDatNasc + nZDLANOS)),4) ) 
                               endif 
                               If !Empty( (cAlias)->ZDL_MENSAG )
                                  MsgAlert( (cAlias)->ZDL_MENSAG , _cAviso )
                               Endif   
                          
                          Case (cAlias)->ZDL_ANO == 0 .AND. (cAlias)->ZDL_MESES > 0 .AND. (cAlias)->ZDL_ART30  <> "1" .AND. (cAlias)->ZDL_ART31 <> "1" .and. (cAlias)->ZDL_AGREG <> "1" 
                               dDatLimite := CTOD( If( Mod(Year(dDatInic + nZDLMESES),4)=0 .And. Month( dDatInic + nZDLMESES ) = 2 , '29', fdia[Month( dDatInic + nZDLMESES )] )+ "/" +;
                                             strzero(month(dDatInic + nZDLMESES),2) +"/"+strzero(year(dDatInic + nZDLMESES),4) ) 
                               If !Empty( (cAlias)->ZDL_MENSAG )
                                  MsgAlert( (cAlias)->ZDL_MENSAG , _cAviso )
                               Endif   
                           //
                          Case (cAlias)->ZDL_ANO == 0 .AND. (cAlias)->ZDL_MESES > 0 .AND. (cAlias)->ZDL_ART30  <> "1" .AND. (cAlias)->ZDL_ART31  == "1" .and. (cAlias)->ZDL_AGREG <> "1" 
			                   if BA1->BA1_GRAUPA $ Alltrim((cAlias)->ZDL_GRAUPA) 
                                  dSegGar    := CTOD(  SUBSTR(DTOS(dDatInic),7,2)+"/"+SUBSTR(DTOS(dDatInic),5,2)+"/"+SUBSTR(DTOS(dDatInic),1,4)  ) + nZDLMESES
                                  dDatLimite := CTOD( If( Mod(Year(dSegGar),4)=0 .And. Month( dSegGar ) = 2 , '29', fdia[Month( dSegGar )] )+ "/" +;
								                      strzero(month(dSegGar),2) +"/"+strzero(year(dSegGar),4) ) 																				
                               Endif   
                               If !Empty( (cAlias)->ZDL_MENSAG )
                                  MsgAlert( (cAlias)->ZDL_MENSAG , _cAviso )
                               Endif   
                                             
                          Case (cAlias)->ZDL_ANO > 0 .AND. (cAlias)->ZDL_MESES > 0 .AND. (cAlias)->ZDL_ART30  <> "1" .AND. (cAlias)->ZDL_ART31  <> "1" .and. (cAlias)->ZDL_AGREG <> "1" 
			                   if BA1->BA1_GRAUPA $ Alltrim((cAlias)->ZDL_GRAUPA) .AND. nIdade < (cAlias)->ZDL_ANO
                                  dMESES  := CTOD(  SUBSTR(DTOS(dDatInic),7,2)+"/"+SUBSTR(DTOS(dDatInic),5,2)+"/"+SUBSTR(DTOS(dDatInic),1,4)  ) + nZDLMESES
                                  dANOS   := dDatNasc + nZDLANOS
                                  dSegGar := if (dMESES < dANOS, dMESES, dANOS )			 							   
                                  dDatLimite := CTOD( If( Mod(Year(dSegGar),4)=0 .And. Month( dSegGar ) = 2 , '29', fdia[Month( dSegGar )] )+ "/" +;
								                      strzero(month(dSegGar),2) +"/"+strzero(year(dSegGar),4) ) 																				
                               Endif   
                               If !Empty( (cAlias)->ZDL_MENSAG )
                                  MsgAlert( (cAlias)->ZDL_MENSAG , _cAviso )
                               Endif   
                                
                          Case (cAlias)->ZDL_ANO == 0 .AND. (cAlias)->ZDL_MESES == 0 .AND. (cAlias)->ZDL_ART30  == "1" .AND. (cAlias)->ZDL_ART31  <> "1" .and. (cAlias)->ZDL_AGREG <> "1" 
                               If !Empty( (cAlias)->ZDL_MENSAG )
                                  MsgAlert( (cAlias)->ZDL_MENSAG , _cAviso )
                               Endif   
                               If !Empty( (cAlias)->ZDL_MENSAG )
                                  MsgAlert( (cAlias)->ZDL_MENSAG , _cAviso )
                               Endif   

                          Case (cAlias)->ZDL_ANO > 0 .AND. (cAlias)->ZDL_MESES == 0 .AND. (cAlias)->ZDL_ART30  <> "1" .AND. (cAlias)->ZDL_ART31  == "1" .and. (cAlias)->ZDL_AGREG <> "1" 
						       if BA1->BA1_GRAUPA $ Alltrim((cAlias)->ZDL_GRAUPA) .AND. nIdade < (cAlias)->ZDL_ANO
							      dDatLimite := CTOD( If( Mod(Year((dDatNasc + nZDLANOS)),4)=0 .And. Month( (dDatNasc + nZDLANOS) ) = 2 , '29', fdia[Month( (dDatNasc + nZDLANOS) )] )+ "/" +;
											    strzero(month((dDatNasc + nZDLANOS)),2) +"/"+strzero(year((dDatNasc + nZDLANOS)),4) ) 
                               endif 
                               If !Empty( (cAlias)->ZDL_MENSAG )
                                  MsgAlert( (cAlias)->ZDL_MENSAG , _cAviso )
                               Endif   

                          Case (cAlias)->ZDL_ANO == 0 .AND. (cAlias)->ZDL_MESES == 0 .AND. (cAlias)->ZDL_ART30  <> "1" .AND. (cAlias)->ZDL_ART31  <> "1" .and. (cAlias)->ZDL_AGREG == "1" 
                               If AT( "AGREG", cNReduz ) > 0 
                                  dDatLimite := CtoD("")
                               endif                    
                               If !Empty( (cAlias)->ZDL_MENSAG )
                                  MsgAlert( (cAlias)->ZDL_MENSAG , _cAviso )
                               Endif   
                               
                       Endcase
                    Else    
                       dDatLimite := CtoD("")
                    Endif
            Otherwise                    
                 dDatLimite := CtoD("")
            Endcase

       /*-----------------------------------------------------------------------
       | I N T E G R A L                                                        |
        -----------------------------------------------------------------------*/           
       case cEmpresa == INTEGRAL
            do case              
                case (cAlias)->ZDL_TIPUSU == cBA1_TIPUSU
                    If (cAlias)->ZDL_DTLIM == "1"
                        Do Case
                           Case (cAlias)->ZDL_ANO == 0 .AND. (cAlias)->ZDL_MESES == 0 .AND. (cAlias)->ZDL_ART30  == "1" .AND. cArt30_31 == "01" 
                                If !Empty( (cAlias)->ZDL_MENSAG )
                                   MsgAlert( (cAlias)->ZDL_MENSAG , _cAviso )
                                Endif   
                                dDatLimite := CtoD("") 
                                
                           Case (cAlias)->ZDL_ANO > 0 .AND. (cAlias)->ZDL_MESES == 0 .AND. (cAlias)->ZDL_ART31  == "1" .AND. cArt30_31 <> "01" 
                                if BA1->BA1_GRAUPA $ Alltrim((cAlias)->ZDL_GRAUPA) .AND. nIdade < (cAlias)->ZDL_ANO
                                   dDatLimite := CTOD( If( Mod(Year((dDatNasc + nZDLANOS)),4)=0 .And. Month( (dDatNasc + nZDLANOS) ) = 2 , '29', fdia[Month( (dDatNasc + nZDLANOS) )] )+ "/" +;
                                                 strzero(month((dDatNasc + nZDLANOS)),2) +"/"+strzero(year((dDatNasc + nZDLANOS)),4) ) 
                                endif 						                                                                           
                                If !Empty( (cAlias)->ZDL_MENSAG )
                                   MsgAlert( (cAlias)->ZDL_MENSAG , _cAviso )
                                Endif   

                           Case (cAlias)->ZDL_ANO > 0 .AND. (cAlias)->ZDL_MESES == 0 .AND. (cAlias)->ZDL_ART31  <> "1" .AND. (cAlias)->ZDL_ART30  <> "1" .AND. (cAlias)->ZDL_AGREG <> "1"
                                if BA1->BA1_GRAUPA $ Alltrim((cAlias)->ZDL_GRAUPA) .AND. nIdade < (cAlias)->ZDL_ANO
                                   dDatLimite := CTOD( If( Mod(Year((dDatNasc + nZDLANOS)),4)=0 .And. Month( (dDatNasc + nZDLANOS) ) = 2 , '29', fdia[Month( (dDatNasc + nZDLANOS) )] )+ "/" +;
                                                 strzero(month((dDatNasc + nZDLANOS)),2) +"/"+strzero(year((dDatNasc + nZDLANOS)),4) ) 
                                endif 						                                                                           
                                If !Empty( (cAlias)->ZDL_MENSAG )
                                   MsgAlert( (cAlias)->ZDL_MENSAG , _cAviso )
                                Endif   

                           Case (cAlias)->ZDL_ANO > 0 .AND. (cAlias)->ZDL_MESES == 0 .AND. !cArt30_31 $ "01,02,"  .and. (cAlias)->ZDL_AGREG <> "1" .AND. (cAlias)->ZDL_ART30 <> "1" .AND. (cAlias)->ZDL_ART31 <> "1"
                                if BA1->BA1_GRAUPA $ Alltrim((cAlias)->ZDL_GRAUPA) .AND. nIdade < (cAlias)->ZDL_ANO
                                   dDatLimite := CTOD( If( Mod(Year((dDatNasc + nZDLANOS)),4)=0 .And. Month( (dDatNasc + nZDLANOS) ) = 2 , '29', fdia[Month( (dDatNasc + nZDLANOS) )] )+ "/" +;
                                                 strzero(month((dDatNasc + nZDLANOS)),2) +"/"+strzero(year((dDatNasc + nZDLANOS)),4) ) 
                                endif 						                                 
                                If !Empty( (cAlias)->ZDL_MENSAG )
                                   MsgAlert( (cAlias)->ZDL_MENSAG , _cAviso )
                                Endif   
                                
                           Case (cAlias)->ZDL_ANO == 0 .AND. (cAlias)->ZDL_MESES == 0 .and. (cAlias)->ZDL_ART30  <> "1" .AND. (cAlias)->ZDL_ART31  <> "1" .AND. !cArt30_31 $ "01,02" .and. (cAlias)->ZDL_AGREG == "1"
                                If AT( "AGREG", cNReduz ) > 0 
                                   dDatLimite := CtoD("")
                                endif                   
                                If !Empty( (cAlias)->ZDL_MENSAG )
                                   MsgAlert( (cAlias)->ZDL_MENSAG , _cAviso )
                                Endif   
                                
                        Otherwise        
                             dDatLimite := CtoD("")   
                        Endcase
                    Else    
                       dDatLimite := CtoD("")
                    Endif
            Otherwise                    
                 dDatLimite := CtoD("")
            Endcase

    Endcase       
    (cAlias)->( dbSkip() )
End    
    
end sequence

BA1->BA1_YDTLIM := dDatLimite 

return .t.




// Fim da rotina CALDTLIM.PRW

/*---------------------------------------------------------------------------------------------------------------- 
| Alterar na tabela SX3010 e SX3020, os campos abaixo:                                                            | 
|                                                                                                                 |
| X3_ARQUIVO = BA1                                                                                                |
| X3_CAMPO   = BA1_GRAUPA                                                                                         |
| X3_ORDERM  = 25                                                                                                 |
| X3_VLDUSER = U_VldGrauPar(TRAB->BA1_GRAUPA)                                                                        |                                   
|                                                                                                                 |
| X3_ARQUIVO = BA1                                                                                                |
| X3_CAMPO   = BA1_DATINC                                                                                         |
| X3_ORDERM  = 27                                                                                                 |
| X3_VLDUSER = IIF(Inclui,IIF(TRAB->BA1_DATINC<((DDATABASE+1)-DAY(DDATABASE)),.F.,.T.),.T.)  .And. U_CalcDtLim()     |
|                                                                                                                 |
|                                                                                                                 |
 ----------------------------------------------------------------------------------------------------------------*/




 
 

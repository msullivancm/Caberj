#INCLUDE "PROTHEUS.CH"
#Include "TOPCONN.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR163   º Autor ³Altamiro              º Data ³ 30/03/15  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³Este programa ira fazer listagem da Critica do SIB          º±±
±±º          ³ conforme parametros                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                  

User Function CABR163

Local cMsg			:= ""
Private lAbortPrint :=.F.
Private cPerg       := "CABR163"
Private cTitulo     := "Listagem da Critica do SIB "        

Private cAliastmp 	:= GetNextAlias()  

Private cAliastmp1	:= GetNextAlias()        

Private cAliastmp2	:= GetNextAlias()       

Private lCritica    :=.F.
Private x           := 0  
private a           := ' '   
private dDtBase     := dtos(dDataBase)

                                                                         
//SetPrvt("oDlg1","oGrp1","oSay1","oSBtn1","oSBtn2","oSBtn3")

cMsg += " Este programa ira fazer listagem da Critica do SIB conforme parametros" 

***************************************************************************    
 
Private aDados1    := {}       
Private acabec1    := {"Matricula","Nome Usuario", "Data Nasc." , "Cpf usuario ","Nome Mãe ","Telefone ","Celilar ","Cod. Plano","Nome Plano","Municipio", "E_mail" }

Private aDados2    := {}       
Private acabec2    := {"Usuario1","Nivel Cobr1", "Data Nasc.1","Idade1" , "Cpf usuario1 ","Bloq1","Matr. Vida1","<<<----->>> ",;
                        "Usuario2","Nivel Cobr2", "Data Nasc.2","Idade2" , "Cpf usuario2 ","Bloq2","Matr. Vida2"}               
                        
Private acabec3    := {"Nome Usuario1","Nivel Cobr1", "Data Nasc.1","Idade1" , "Cpf usuario1 ","Bloq1","Matr. Vida1","Tp Usuario "}   
Private aDados3    := {}  

private Descric     := ' '   
private ctraco      := replicate("_",220)                                                                                                          
 	
  	  
AjustaSX1(cPerg)

//Pergunte(cPerg,.T.) 

cDtIniSib      := dtos(mv_par01)
cDtFimSib  	   := dtos(mv_par02)   
cInclSib       := mv_par03 
cAltSib        := mv_par04
cExcSib        := mv_par05 
cListSCri      := mv_par06  
cEmpDe         := mv_par07  
cEmpAte        := mv_par08  

cGeraprod  	   := mv_par09   
cusuario       := mv_par10

cGeraEx  	   := mv_par11  

dDatRef  := dtos(mv_par02)

cCpfMI16       := 1 
cCpfDupl       := 0     
cCpfBranco     := 0 
Processa({||Processa1()}, cTitulo, "", .T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Libera impressao                                                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
   
// faz ecxel   
if len(aDados1) > 0 
   if cGeraEx == 1    
      //If cInclSib  == 1 .or. cAltSib  == 1 
         DlgToExcel({{"ARRAY","Listagem maior 16 anos sem CPF" ,aCabec1,aDados1}})   
     // EndIf        
    EndIF 
    If cCpfMI16  == 1 
       fGeraRel2()    
    EndIf    
    If cCpfDupl == 1 
       fGeraRe22()    
    EndIf    
    If cCpfBranco == 1 
       fGeraRe33()    
    EndIf 
EndIf
      
MsgInfo("Processo finalizado")

Return                 

**************************************************************************

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³ PROCESSA1º Autor ³ Jean Schulz        º Data ³  11/11/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao auxiliar chamada pela PROCESSA.  A funcao PROCESSA  º±±
±±º          ³ monta a janela com a regua de processamento.               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function Processa1()        

ProcRegua(FT_FLASTREC()) 

nCont := 0
IncProc('Processando...')      
////////////////////////////////////   
cquery := CRLF+" SELECT decode (bx1_alias,'BA1' ,'USUARIO' , 'BA3' , 'FAMILIA' , 'BTS' , 'VIDA' , ' ' ) cADASTRO,  bx1_tipo , " 
cquery += CRLF+"        decode (BX1_TIPO, 'I' , 'I - Inclusao ',  'E' , 'E - Exclusão ', 'A' , 'A - Alteração',' ') BX1TIPO , BX1_USUARI, substr(BX1_DATA,7,2)||'/'||substr(BX1_DATA,5,2)||'/'|| substr(BX1_DATA,1,4)||'-'||BX1_HORA BX1_DTH, BX1_ROTINA , "  
cquery += CRLF+"        BA1.R_E_C_N_O_ BA1RECNO, BA1_PLPOR, BA1_INCANS, BA1_EXCANS, BA1_CODINT, BA1_CODEMP, BA1_MATRIC, BA1_TIPREG, BA1_DIGITO,"
cquery += CRLF+"        BA1_NOMUSR, BA1_OPEORI, BA1_INFANS, BA1_ATUSIB, BA1_LOCSIB, BA1_MATANT,BA1_MATUSB, BA1_CONEMP, BA1_VERCON, BA1_SUBCON, BA1_VERSUB,"
cquery += CRLF+"        BA1_INFSIB, BA1_CODPLA, BA1_VERSAO, BA1_DATBLO, BA1_DATNAS, BA1_SEXO, BA1_CPFUSR, BA1_MAE, BA1_TIPUSU, BA1_ENDERE, BA1_CEPUSR, BA1_TRADES, BA1_TRAORI,"
cquery += CRLF+"        BA1_MUNICI, BA1_ESTADO, BA1_DATINC, BA1_DATTRA, BA1_CODCLI, BA1_LOJA, BA1_COBNIV, BA1_NR_END, BA1_COMEND, BA1_BAIRRO, BA1_CODMUN,"
cquery += CRLF+"        BA1_GRAUPA, BA1_MATVID, BA1_CPFMAE, BA1_CPFPRE, BA1_CODCCO, BTS_DRGUSR, BTS_ORGEM, BTS_RGEST,BTS_PISPAS, BTS_NRCRNA, BTS_DENAVI,"
cquery += CRLF+"        BA3_TIPOUS, BA3_PLPOR, BA3_CODPLA, BA3_VERSAO, BA3_CODCLI, BA3_LOJA, BA3_COBNIV , " 

cquery += CRLF+"        BA3_TIPOUS, BA3_PLPOR, BA3_CODPLA, BA3_VERSAO, BA3_CODCLI, BA3_LOJA, BA3_COBNIV  "

cquery += CRLF+"   FROM "+ RetSqlName("BA1") + " BA1 , " + RetSqlName("BTS") + " BTS , " + RetSqlName("BA3")+" BA3 , " + RetSqlName("BX1") +" BX1"
cquery += CRLF+"  WHERE BA1_FILIAL = '" + xFilial("BA1") + "' AND BA1.D_E_L_E_T_ = ' '"
cquery += CRLF+"    AND BTS_FILIAL = '" + xFilial("BTS") + "' AND BTS.D_E_L_E_T_ = ' '"
cquery += CRLF+"    AND BA3_FILIAL = '" + xFilial("BA3") + "' AND BA3.D_E_L_E_T_ = ' '"  
cquery += CRLF+"    AND BX1_FILIAL = '" + xFilial("BX1") + "' AND BX1.D_E_L_E_T_ = ' '"
cquery += CRLF+"    AND BA1_MATVID = BTS_MATVID AND BA1_CODINT = BA3_CODINT AND BA1_CODEMP = BA3_CODEMP AND BA1_MATRIC = BA3_MATRIC"

//cquery += CRLF+" AND BA1_CODINT = '" + cCodInt + "' AND BA1_OPEORI = '" + cCodInt + "'"    

cquery += CRLF+" AND BA1_CODEMP >= '" + cEmpDe + "' AND BA1_CODEMP <= '" + cEmpAte + "'"

cquery += CRLF+"        AND BA1.R_E_C_N_O_ = BX1_RECNO AND bx1_alias = 'BA1'"      
  If !empty(cusuario)
       cquery += CRLF+"        AND BX1_USUARI = '" + cusuario+"'  " 
  EndIf  
  
  If ( cInclSib == 1 .and. cAltSib == 1 .and. cExcSib == 1 ) .or. (cGeraprod == 1)
      cquery += CRLF+"        AND ( BX1_TIPO ='I' or BX1_TIPO ='A' or BX1_TIPO ='E' ) " 
  Elseif ( cInclSib == 1 .and. cAltSib == 1 )
      cquery += CRLF+"        AND ( BX1_TIPO ='I' or BX1_TIPO ='A' ) "       
  Elseif ( cInclSib == 1 .and. cExcSib == 1 )
      cquery += CRLF+"        AND ( BX1_TIPO ='I' or BX1_TIPO ='E' ) " 
  Elseif ( cAltSib == 1 .and. cExcSib == 1 )
      cquery += CRLF+"        AND ( BX1_TIPO ='A' or BX1_TIPO ='E' ) "  
  elseIf cInclSib == 1 
      cquery += CRLF+"        AND BX1_TIPO ='I' " 
  elseIf cAltSib == 1  
      cquery += CRLF+"        AND BX1_TIPO ='A' " 
  elseIf cExcSib == 1 
      cquery += CRLF+"        AND BX1_TIPO ='E' " 
  EndIf 
   
cquery += CRLF+"        AND bx1_data >= '"+cDtIniSib+"' and bx1_data < '"+cDtFimSib+"' "

cquery += CRLF+"        AND BA1_INFANS <> '0' AND BA1_ATUSIB <> '0' AND BA1_INFSIB <> '0' AND BA1_LOCSIB IN ('0','1','2','6','7','8','B','C')" // Atualiza SIB ? Considera SIB ?
// Preciso do order by pois ocorreu de ir no arquivo inclusao de dependente antes do titular, isso da critica na ANS
 If cGeraprod == 1
    cquery += CRLF+"        ORDER BY BX1_TIPO,BX1_USUARI,BX1_DATA " 
 else 
    cquery += CRLF+"        ORDER BY BA1_FILIAL, BA1_CODINT, BA1_CODEMP, BA1_MATRIC, CASE WHEN BA1_TIPUSU = 'T' THEN '1' ELSE '2' END, BA1_TIPREG, BA1_DIGITO"
 EndIf         
//////
If Select((cAliastmp)) <> 0 
  (cAliastmp)->(DbCloseArea()) 
Endif
  
 TCQuery cQuery New Alias (cAliastmp)  
    
 dbSelectArea(cAliastmp)
   
 (cAliastmp)->(dbGoTop())   
 

While (cAliastmp)->(!Eof())                     
/***********************/   
   if cGeraprod == 1
        aaDD(aDados1,{  (cAliastmp)->cADASTRO  ,;
                   (cAliastmp)->BX1TIPO  ,;
                    substr((cAliastmp)->BX1_USUARI,1,30),; 
                    substr((cAliastmp)->BX1_DTH,1,22) ,; 
                    substr((cAliastmp)->BX1_ROTINA,1,30) })
                     
   Elseif (cInclSib == 1 .and. (cAliastmp)->BX1_TIPO = 'I') .or. (cAltSib == 1 .and. (cAliastmp)->BX1_TIPO = 'A') 
   lCritica:= .F. 
   aaDD(aDados1,{  (cAliastmp)->cADASTRO  ,;
                        (cAliastmp)->BX1TIPO  ,;
                        substr((cAliastmp)->BX1_USUARI,1,30),; 
                        substr((cAliastmp)->BX1_DTH,1,22) ,; 
                        substr((cAliastmp)->BX1_ROTINA,1,30) ,; 
                         PI_MatTD()   ,;
                         PI_NomUsr()  ,;                             
                         PI_DtNUsr()  ,;
                         PI_Cpf()     ,; 
                         PI_sexo()    ,;
                         PI_NomMae()  ,;                          
                         PI_Pispas()  ,;
                         PI_NasViv()  ,; 
                         PI_cns()     ,;
                         PI_END1()    ,;
                         PI_END2()    ,;
                         PI_END3()    ,;
                         PI_END4()    ,;
                         PI_END5()    ,;
                         PI_PlOrg()   ,;
                         PI_DtIPl()   ,;
                         PI_DtCanc()  ,; 
                         PI_FamTit()  ,;
                         lCritica     })
/*
*/
  
  ElseIf (cExcSib == 1 .and. (cAliastmp)->BX1_TIPO = 'E' ) 
 lCritica:= .F. 
   aaDD(aDados1,{  (cAliastmp)->cADASTRO  ,;
                        (cAliastmp)->BX1TIPO  ,;
                        substr((cAliastmp)->BX1_USUARI,1,30),; 
                        substr((cAliastmp)->BX1_DTH,1,22) ,; 
                        substr((cAliastmp)->BX1_ROTINA,1,30) ,; 
                         PI_DtCanc()    ,;
                         lCritica()    })
  EndIf
       (cAliastmp)->(dbSkip()) 	   
EndDo	                   
                                          
/////////////////////////////////////////*        

Return    
                
*************************************************************************************************************   
//16  anos ou maior  sem cpf
Static Function fGeraRel2

Local oReport 
Private cPerg		:= "CABR163"  
Private aOrdem 		:= {}//{'RDA','Ano/Mes'}

//aSort( aDados1,,,{|x,y| x[10] < y[10]} )

oReport:= ReportDef2()
oReport:PrintDialog()

Return

*************************************************************************************************************
//cpf em duplicidade 
Static Function fGeraRe22

Local oReport 
Private cPerg		:= "CABR163"  
Private aOrdem 		:= {}//{'RDA','Ano/Mes'}

//aSort( aDados1,,,{|x,y| x[10] < y[10]} )

oReport:= ReportDef3()
oReport:PrintDialog()

Return    
*************************************************************************************************************
//cpf em branco  
Static Function fGeraRe33

Local oReport 
Private cPerg		:= "CABR163"  
Private aOrdem 		:= {}//{'RDA','Ano/Mes'}

//aSort( aDados1,,,{|x,y| x[10] < y[10]} )

oReport:= ReportDef4()
oReport:PrintDialog()

Return
/********************************************************************************************************************************
/*
16  anos ou maior  sem cpf
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Leonardo Portella                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatorio                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                         
Static Function ReportDef2()

Local oReport 
Local oDPJ    
oReport	:= TReport():New("CABR163","Listagem da Critica do SIB " ,, {|oReport| ReportPrt(oReport)},"Listagem da Critica do SIB " )
oReport:SetTotalInLine(.F.)//Imprime na linha: .F. - Imprime abaixo da linha com o titulo de cada coluna: .T.
//oReport:SetTotalText('Total Geral') 

*'-----------------------------------------------------------------------------------'*
*'Solucao para impressao em que as colunas se truncam: "SetColSpace" e "SetLandScape"'* 
*'-----------------------------------------------------------------------------------'*

oReport:SetColSpace(1) //Espacamento entre colunas. 
oReport:SetLandscape() //Impressao em paisagem.  
//oReport:SetPortrait() //Impressao em retrato.  

oDPJ := TRSection():New(oReport,"Listagem da Critica do SIB " ,,aOrdem)             


   TRCell():New(oDPJ ,'MATRIC'	    		,/*TABELA*/	,'Matricula' 	   ,/*Picture*/   	    ,220				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
 
//oBreak01 		:= TRBreak():New(oDPJ,oDPJ:Cell("MATRIC"),"Total por Ação "	,.F.)  

lTotSecBrk01	:= .F.//Indica se totalizador sera impresso na quebra de secao
lTotFimBrk01	:= .F.//Indica se totalizador sera impresso no final do relatorio - Como o total eh o mesmo, basta que apenas um esteja ativado

                                                                   
// TRFunction():New(oDPJ:Cell("MUNICI")    	    ,NIL,"COUNT"		,oBreak01,,"@E 999,999,999"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 
// TRFunction():New(oDPJ:Cell("VLGLO")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 
// TRFunction():New(oDPJ:Cell("VLPRO")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)  
// TRFunction():New(oDPJ:Cell("VLCOP")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 

Return(oReport)

/********************************************************************************************************************************
/* 16  anos ou maior  sem cpf
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint³ Autor ³ Leonardo Portella                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function ReportPrt(oReport)

Local   cImp    :='Não'

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Private oDPJ 	:= oReport:Section(1)

Private nCont	:= 0   

nCont := Len(aDados1)

//Se nao tiver esta linha, nao imprime os dados
oDPJ:init()

oReport:SetMeter(nCont) 

cTot	:= AllTrim(Transform(nCont,'@E 999,999,999,999'))
nCont 	:= 0       

For i := 1 To Len(aDados1)    
     If cGeraprod != 1
        if !ADados1[i][24] .and. cListSCri == 1  
           loop 
        endIf 
     endIf                      

	oReport:SetMsgPrint("Imprimindo linha " + AllTrim(Transform(++nCont,'@E 999,999,999,999')) + ' de ' + cTot)

	oReport:IncMeter()

	If oReport:Cancel()  
	    
	    oReport:FatLine()     
	    oReport:PrintText('Cancelado pelo operador!!!',,,CLR_RED,,,.T.)
		
	    exit
	    
	EndIf           
	if cGeraprod == 2      	
       oDPJ:Cell('MATRIC'	 		):SetValue(ctraco)      
    EndIf   
    oDPJ:PrintLine() 
    oDPJ:Cell('MATRIC'	 		):SetValue('Origem - ' + ADados1[i][1]+ 'Tipo - ' + ADados1[i][2]+'Usuario - ' + ADados1[i][3]+'Data Hora - ' + ADados1[i][4]+'Rotina - ' + ADados1[i][5])     
    oDPJ:PrintLine()
   if cGeraprod == 2 
      oDPJ:Cell('MATRIC'	 		):SetValue(ctraco)         
      oDPJ:PrintLine()
      For X := 6 To 23
         oDPJ:Cell('MATRIC'	 		):SetValue(ADados1[i][X])   
         oDPJ:PrintLine()
      Next X 
   EndIf      
Next i       
 oDPJ:Finish()
Return   
/********************************************************************************************************************************                                                                                           
/*
cpf em dudplicidade 
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Leonardo Portella                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatorio                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                         
Static Function ReportDef3()

Local oReport 
Local oDPJ1    
oReport	:= TReport():New("CABR163","Listagem da Critica do SIB " ,, {|oReport| ReportPrt2(oReport)},"Relação de CPF em Duplicidade  ")
oReport:SetTotalInLine(.F.)//Imprime na linha: .F. - Imprime abaixo da linha com o titulo de cada coluna: .T.
//oReport:SetTotalText('Total Geral') 

*'-----------------------------------------------------------------------------------'*
*'Solucao para impressao em que as colunas se truncam: "SetColSpace" e "SetLandScape"'* 
*'-----------------------------------------------------------------------------------'*

oReport:SetColSpace(1) //Espacamento entre colunas. 
oReport:SetLandscape() //Impressao em paisagem.  
//oReport:SetPortrait() //Impressao em retrato.  

oDPJ1 := TRSection():New(oReport,"Relação de CPF em Duplicidade   ",,aOrdem)             
       
 //  TRCell():New(oDPJ1 ,'MATRIC1'	    	,/*TABELA*/	,'Matricula' 	   ,/*Picture*/   	    ,20				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
   TRCell():New(oDPJ1 ,'NOMUSR1'	     	,/*TABELA*/	,'Nome Usuario'	   ,/*Picture*/ 	    ,60				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
   TRCell():New(oDPJ1 ,'NCOBRA1'           ,/*TABELA*/	,'nivel cobraca1'  ,/*Picture*/ 	    ,12			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  
   TRCell():New(oDPJ1 ,'DATNAS1'	      	,/*TABELA*/	,'Dt. Nasc '       ,/*Picture*/ 	    ,10			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  
   TRCell():New(oDPJ1 ,'IDADE1'	      	    ,/*TABELA*/	,'Idade  '         ,/*Picture*/ 	    ,02			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  
   TRCell():New(oDPJ1 ,'CPF1'		    	,/*TABELA*/	,'CPF '            ,/*Picture*/ 	    ,11			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)   
   TRCell():New(oDPJ1 ,'bloq1'		    	,/*TABELA*/	,'bloq '           ,/*Picture*/ 	    ,10			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)   
   TRCell():New(oDPJ1 ,'MATVID1'		   	,/*TABELA*/	,'MatVida '        ,/*Picture*/ 	    ,10			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)   
   TRCell():New(oDPJ1 ,'<<<----->>>'	   	,/*TABELA*/	,'<<<----->>>'      ,/*Picture*/ 	    ,11			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
 //  TRCell():New(oDPJ1 ,'MATRIC2'	    	,/*TABELA*/	,'Matricula' 	   ,/*Picture*/   	    ,20				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
   TRCell():New(oDPJ1 ,'NOMUSR2'	     	,/*TABELA*/	,'Nome Usuario'	   ,/*Picture*/ 	    ,60				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
   TRCell():New(oDPJ1 ,'NCOBRA2'           ,/*TABELA*/	,'nivel cobraca1'  ,/*Picture*/ 	    ,12			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  
   TRCell():New(oDPJ1 ,'DATNAS2'	      	,/*TABELA*/	,'Dt. Nasc '       ,/*Picture*/ 	    ,10			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  
   TRCell():New(oDPJ1 ,'IDADE2'	      	    ,/*TABELA*/	,'Idade  '         ,/*Picture*/ 	    ,02			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  
   TRCell():New(oDPJ1 ,'CPF2'		    	,/*TABELA*/	,'CPF '            ,/*Picture*/ 	    ,11			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)   
   TRCell():New(oDPJ1 ,'bloq2'		    	,/*TABELA*/	,'bloq '           ,/*Picture*/ 	    ,10			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)   
   TRCell():New(oDPJ1 ,'MATVID2'		   	,/*TABELA*/	,'MatVida '        ,/*Picture*/ 	    ,10			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)   
 
oBreak01 		:= TRBreak():New(oDPJ1,oDPJ1:Cell("CPF1"),"Total  "	,.F.)  

lTotSecBrk01	:= .T.//Indica se totalizador sera impresso na quebra de secao
lTotFimBrk01	:= .T.//Indica se totalizador sera impresso no final do relatorio - Como o total eh o mesmo, basta que apenas um esteja ativado

                                                                    
   TRFunction():New(oDPJ1:Cell("CPF1")         ,NIL,"COUNT"		,oBreak01,,"@E 999,999,999"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 
// TRFunction():New(oDPJ:Cell("VLGLO")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 
// TRFunction():New(oDPJ:Cell("VLPRO")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)  
// TRFunction():New(oDPJ:Cell("VLCOP")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 

Return(oReport)


/******************************************************************************************
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint³ Autor ³ Leonardo Portella                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function ReportPrt2(oReport)

Local   cImp    :='Não'

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Private oDPJ1 	:= oReport:Section(1)

Private nCont	:= 0   

nCont := Len(aDados2)

//Se nao tiver esta linha, nao imprime os dados
oDPJ1:init()

oReport:SetMeter(nCont) 

cTot	:= AllTrim(Transform(nCont,'@E 999,999,999,999'))
nCont 	:= 0       

For i := 1 To Len(aDados2)

	oReport:SetMsgPrint("Imprimindo linha " + AllTrim(Transform(++nCont,'@E 999,999,999,999')) + ' de ' + cTot)

	oReport:IncMeter()

	If oReport:Cancel()  
	    
	    oReport:FatLine()     
	    oReport:PrintText('Cancelado pelo operador!!!',,,CLR_RED,,,.T.)
		
	    exit
	    
	EndIf  
		
       oDPJ1:Cell('NOMUSR1'	 		):SetValue((aDados2[i][1]))        
       oDPJ1:Cell('NCOBRA1'  	  	):SetValue((aDados2[i][2]))   
       oDPJ1:Cell('DATNAS1'	 		):SetValue((aDados2[i][3]))   
	   oDPJ1:Cell('IDADE1'	 		):SetValue((aDados2[i][4]))         
	   oDPJ1:Cell('CPF1'	 	    ):SetValue((aDados2[i][5]))           
	   oDPJ1:Cell('bloq1'	 		):SetValue((aDados2[i][6]))           
	   oDPJ1:Cell('MATVID1'	 		):SetValue((aDados2[i][7]))        
       oDPJ1:Cell('<<<----->>>'		):SetValue((aDados2[i][8]))               
       oDPJ1:Cell('NOMUSR2'	 		):SetValue((aDados2[i][9]))       
       oDPJ1:Cell('NCOBRA2'	        ):SetValue((aDados2[i][10])) 
	   oDPJ1:Cell('DATNAS2'	 		):SetValue((aDados2[i][11])) 
	   oDPJ1:Cell('IDADE2'	 		):SetValue((aDados2[i][12]))        
	   oDPJ1:Cell('CPF2'	 		):SetValue((aDados2[i][13]))          
	   oDPJ1:Cell('bloq2'	 		):SetValue((aDados2[i][14])) 
	   oDPJ1:Cell('MATVID2'	 		):SetValue((aDados2[i][15]))      
	
   oDPJ1:PrintLine()
   
Next i

oDPJ1:Finish()

Return   

/********************************************************************************************************************************                                                                                           
/*
cpf em branco  
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Leonardo Portella                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatorio                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/                         
Static Function ReportDef4()

Local oReport 
Local oDPJ2  
oReport	:= TReport():New("CABR163","Listagem da Critica do SIB " ,, {|oReport| ReportPrt4(oReport)},"Listagem da Critica do SIB " )
oReport:SetTotalInLine(.F.)//Imprime na linha: .F. - Imprime abaixo da linha com o titulo de cada coluna: .T.
//oReport:SetTotalText('Total Geral') 

*'-----------------------------------------------------------------------------------'*
*'Solucao para impressao em que as colunas se truncam: "SetColSpace" e "SetLandScape"'* 
*'-----------------------------------------------------------------------------------'*

oReport:SetColSpace(1) //Espacamento entre colunas. 
oReport:SetLandscape() //Impressao em paisagem.  
//oReport:SetPortrait() //Impressao em retrato.  

oDPJ2 := TRSection():New(oReport,"Relação de CPF CPF em diuplicidade   ",,aOrdem)             
       
   TRCell():New(oDPJ2 ,'NOMUSR1'	     	,/*TABELA*/	,'Nome Usuario'	   ,/*Picture*/ 	    ,60				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
   TRCell():New(oDPJ2 ,'NCOBRA1'           ,/*TABELA*/	,'Nivel Cobraca'   ,/*Picture*/ 	    ,12			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  
   TRCell():New(oDPJ2 ,'DATNAS1'	      	,/*TABELA*/	,'Dt. Nasc '       ,/*Picture*/ 	    ,10			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  
   TRCell():New(oDPJ2 ,'IDADE1'	      	    ,/*TABELA*/	,'Idade  '         ,/*Picture*/ 	    ,02			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)  
   TRCell():New(oDPJ2 ,'CPF1'		    	,/*TABELA*/	,'CPF '            ,/*Picture*/ 	    ,11			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)   
   TRCell():New(oDPJ2 ,'bloq1'		    	,/*TABELA*/	,'bloq '           ,/*Picture*/ 	    ,10			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)   
   TRCell():New(oDPJ2 ,'MATVID1'		   	,/*TABELA*/	,'MatVida '        ,/*Picture*/ 	    ,10			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)   
   TRCell():New(oDPJ2 ,'TPUSR'	        	,/*TABELA*/	,'TPUSR'           ,/*Picture*/ 	    ,11			  	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
 
oBreak01 		:= TRBreak():New(oDPJ2,oDPJ2:Cell("CPF1"),"Total  "	,.F.)  

lTotSecBrk01	:= .T.//Indica se totalizador sera impresso na quebra de secao
lTotFimBrk01	:= .T.//Indica se totalizador sera impresso no final do relatorio - Como o total eh o mesmo, basta que apenas um esteja ativado

                                                                    
   TRFunction():New(oDPJ2:Cell("CPF1")         ,NIL,"COUNT"		,oBreak01,,"@E 999,999,999"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 
// TRFunction():New(oDPJ:Cell("VLGLO")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 
// TRFunction():New(oDPJ:Cell("VLPRO")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01)  
// TRFunction():New(oDPJ:Cell("VLCOP")  		,NIL,"SUM"			,oBreak01,,"@E 999,999,999.99"	,/*uFormula*/	,lTotSecBrk01,lTotFimBrk01) 

Return(oReport)   
/******************************************************************************************
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint³ Autor ³ Leonardo Portella                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function ReportPrt4(oReport)

Local   cImp    :='Não'

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Private oDPJ2 	:= oReport:Section(1)

Private nCont	:= 0   

nCont := Len(aDados3)

//Se nao tiver esta linha, nao imprime os dados
oDPJ2:init()

oReport:SetMeter(nCont) 

cTot	:= AllTrim(Transform(nCont,'@E 999,999,999,999'))
nCont 	:= 0       

For i := 1 To Len(aDados3)

	oReport:SetMsgPrint("Imprimindo linha " + AllTrim(Transform(++nCont,'@E 999,999,999,999')) + ' de ' + cTot)

	oReport:IncMeter()

	If oReport:Cancel()  
	    
	    oReport:FatLine()     
	    oReport:PrintText('Cancelado pelo operador!!!',,,CLR_RED,,,.T.)
		
	    exit
	    
	EndIf  
		
       oDPJ2:Cell('NOMUSR1'	 		):SetValue((aDados3[i][1]))        
       oDPJ2:Cell('NCOBRA1'  	  	):SetValue((aDados3[i][2]))   
       oDPJ2:Cell('DATNAS1'	 		):SetValue((aDados3[i][3]))   
	   oDPJ2:Cell('IDADE1'	 		):SetValue((aDados3[i][4]))         
	   oDPJ2:Cell('CPF1'	 	    ):SetValue((aDados3[i][5]))           
	   oDPJ2:Cell('bloq1'	 		):SetValue((aDados3[i][6]))           
	   oDPJ2:Cell('MATVID1'	 		):SetValue((aDados3[i][7]))        
       oDPJ2:Cell('TPUSR'	    	):SetValue((aDados3[i][8]))               
           
	
   oDPJ2:PrintLine()
   
Next i

oDPJ2:Finish()

Return   
******************************************************************************************
Static Function PI_sexo() 
// Sexo do beneficiario                                                   
private cMens := ' ' 
     	cMens := "Sexo do usuario , cadastro Usuario --> "+ Iif((cAliastmp)->BA1_SEXO == "1","1-Masculino","3-Feminino")
return(Cmens)                                                             
                       
/*********************                                                        
// CPF - Cadastro de Pessoas Fisicas - do beneficiario
*********************/
Static Function PI_Cpf()   
private cMens := ' '   

If !Empty((cAliastmp)->BA1_CPFUSR)
	cMens := "Cpf Preenchido , Valido , Cadastro Usuario --> "+(cAliastmp)->BA1_CPFUSR
Else
	If Calc_Idade(Ctod(dDatRef),Ctod((cAliastmp)->BA1_DATNAS)) < 18 .And. (cAliastmp)->BA1_TIPUSU <> 'T'
	   cMens := "Cpf em Branco , Valido , Cadastro Usuario --> "+(cAliastmp)->BA1_CPFUSR
	Else
		If !Empty((cAliastmp)->BA1_CPFMAE)               
   		   cMens := "Cpf da Mãe , Valido , Cadastro Usuario --> "+(cAliastmp)->BA1_CPFMAE
		Else
			If !Empty((cAliastmp)->BA1_CPFPRE)
			   cMens := "Cpf do Preposto , Valido , Cadastro Usuario --> "+ (cAliastmp)->BA1_CPFPRE
			Else
			   cMens := "Cpf Em Branco , InValido , Cadastro Usuario , T "   
			   lCritica := .T. 
			EndIf
		EndIf
	EndIf
EndIf    
return(Cmens) 
                                                                   
/*********************                                                        
// Numero do PIS/PASEP do beneficiario ou Numero de Identificacao do Trabalhador - NIT
*********************/
Static Function PI_Pispas()
private cMens := ' '                                                       
       a:= ' '
    If Empty((cAliastmp)->BTS_PISPAS) .and. Empty((cAliastmp)->BA1_MAE)  
       a:= 'Pis em Branco e Nome da Mãe em Branco, T '
       lcritica := .T.
    EndIf   
        cMens:= 'Numero do PisPasep --> '+ AllTrim((cAliastmp)->BTS_PISPAS) + ' - ' + a 
return(Cmens)                                                                    

/*********************                                                        
// Nome da mae do beneficiario                                                
*********************/
Static Function PI_NomMae()   
private         x:= 1  
private         a:=''  
private cMens := ' ' 

while x <= len((cAliastmp)->BA1_MAE)    
        if (X+3) <= len((cAliastmp)->BA1_MAE) .and. (substr((cAliastmp)->BA1_MAE ,x , 1)) = ' ' .and. (substr((cAliastmp)->BA1_MAE ,x+1 , 2)) != ' ' .and. (substr((cAliastmp)->BA1_MAE ,x+2 , 3)) = ' ' 
            a:= 'Abreviação identificadas , T ' 
            lCritica:= .T.                       
        EndIf    
        if (substr((cAliastmp)->BA1_MAE ,x , 1)) $ ".|-|_|/|'|=|:"  
            a :='Caracter Especial   ,T ' 
            lCritica:= .T.   
        elseif (substr((cAliastmp)->BA1_MAE ,x , 1)) $ "0"  
            a:= 'Caracter Especial 0  , T '
            lCritica:= .T.   
       endIf       
     x++
enddo                                  
if empty ((cAliastmp)->BA1_MAE)      
   a:='Em Branco , T ' 
   lCritica:= .T.   
EndIf     
        cMens := "Nome da Mãe,  Cadastro Usuario --> " + AllTrim(SubStr((cAliastmp)->BA1_MAE+Space(70),1,70)) +  ' - ' + a   
return(Cmens)

/*********************    
// Numero da Declaracao de Nascido Vivo
*********************/
Static Function PI_NasViv()   
private cMens := ' '        
if (cAliastmp)->BA1_DATNAS >= "20100101"
    If empty(BTS->BTS_DENAVI) 
       cMens := "Numero da Declaracao de Nascido Vivo , Nascidos apartir de 01/01/2010 --> Em Branco , T " 
       lCritica:= .T.          
    else     	
       cMens := "Numero da Declaracao de Nascido Vivo , Nascidos apartir de 01/01/2010 --> " + AllTrim((cAliastmp)->BTS_DENAVI)     
    EndIf    
Else
	cMens := "Numero da Declaraçãoo de Nascido Vivo, Nascidos antes 01/01/2010  , em branco "
EndIf
return(Cmens)
                          
/*********************    
// Numero do Cartao Nacional de Saude
*********************/
Static Function PI_cns
private cMens := ' ' 
     	cMens := "Numero do Cartao Nacional de Saude --> " + AllTrim((cAliastmp)->BTS_NRCRNA)
return(Cmens)                                                             

/*********************    
// Codigo de identificacao do beneficiario titular na operadora para beneficiarios informados como dependentes
*********************/
Static Function PI_MatTD
private cMens := ' ' 
If (cAliastmp)->BA1_TIPUSU <> 'T'
   cMens := "Matricula atual do Dependente  , Cadastro Usuario --> " + (cAliastmp)->BA1_CODINT+'.'+(cAliastmp)->BA1_CODEMP+'.'+(cAliastmp)->BA1_MATRIC+'.'+(cAliastmp)->BA1_tipreg+'.'+(cAliastmp)->BA1_digito 
   if !Empty((cAliastmp)->BA1_MATANT)
      cMens := "Matricula Anterior do Dependente , Cadastro Usuario --> " + (cAliastmp)->BA1_MATANT
   EndIf  
   If (cAliastmp)->BA1_tipreg == '00'
      a:= " - Tipreg igual 00 - T "
      lCritica:= .T.  
   EndIf   
ElseIf (cAliastmp)->BA1_TIPUSU == 'T'
   cMens := "Matricula atual do titular , Cadastro Usuario --> " + (cAliastmp)->BA1_CODINT+'.'+(cAliastmp)->BA1_CODEMP+'.'+(cAliastmp)->BA1_MATRIC+'.'+(cAliastmp)->BA1_tipreg+'.'+(cAliastmp)->BA1_digito 
   if !Empty((cAliastmp)->BA1_MATANT)
	  cMens := "Matricula Anterior do Titular , Cadastro Usuario --> " + (cAliastmp)->BA1_MATANT
   EndIf   
   If (cAliastmp)->BA1_tipreg != '00'
      a:= " - Tipreg diferente de  00 - T "
      lCritica:= .T.  
   EndIf      
EndIf    
return(Cmens+a)

/*********************    
/* IDENTIFICACAO DE ENDERECO 
*********************/

Static Function PI_END1
// Indicacao de endereco residencial ou profissional 2,1
//aRegInc[nRegInc,11] := "2"
// Logradouro do beneficiario
private cMens := 'endereco residencial , Cadastro Usuario --> '     
a:= ' '   
if empty ((cAliastmp)->BA1_ENDERE)      
   a:='Em Branco , T ' 
   lCritica:= .T.   
EndIf              

cMens += AllTrim(SubStr((cAliastmp)->BA1_ENDERE + Space(50),1,50))+AllTrim(SubStr((cAliastmp)->BA1_NR_END + Space(05),1,05)) +' - '+ a     
        
return(Cmens)

/**********************************/
Static Function PI_END2
// Numero do logradouro
private cMens := 'logradouro , Cadastro Usuario --> '    
a:= ' ' 
if empty((cAliastmp)->BA1_COMEND)      
     a:='Em Branco '    
EndIf              
  cMens += AllTrim(SubStr((cAliastmp)->BA1_COMEND + Space(15),1,15)) +' - '+ a 
return(Cmens)   

/***********************/
Static Function PI_END3
// Bairro do logradouro do beneficiario           
private cMens := 'Bairro  , Cadastro Usuario --> '     
 a:=' ' 
if empty((cAliastmp)->BA1_BAIRRO)      
   a:='Em Branco  , T ' 
   lCritica:= .T.
EndIf   
   cMens += AllTrim(SubStr((cAliastmp)->BA1_BAIRRO + Space(30),1,30))+' - '+ a
        
return(Cmens)   
        
/**********************************/
Static Function PI_END4
// Codigo do municipio do logradouro indicado     
private cMens := 'Codigo do municipio , Cadastro Usuario --> ' 
 a:=' ' 
if empty((cAliastmp)->BA1_CODMUN)      
   a:='Em Branco , T ' 
   lCritica:= .T.
EndIf  
   cMens += AllTrim((cAliastmp)->BA1_CODMUN)+' - '+ a
return(Cmens)                     

/**********************************/
Static Function PI_END5
// CEP                              
/**********************************/                       
private cMens := 'Codigo do CEP  , Cadastro Usuario --> ' 
if empty((cAliastmp)->BA1_CEPUSR)      
   a:='Em Branco , T ' 
   lCritica:= .T.
EndIf  
   cMens += AllTrim((cAliastmp)->BA1_CEPUSR)+' - '+ a
return(Cmens)                                            
 
/**********************************/                       


/**********************************/                       
Static Function PI_PlOrg
// Numero do plano origem RPS (portabilidade)
private cMens := 'Numero do plano origem RPS , Cadastro Usuario --> ' 
cMens +=  AllTrim(If( !Empty((cAliastmp)->BA3_PLPOR) .Or. !Empty((cAliastmp)->BA1_PLPOR),;
                  If(!Empty((cAliastmp)->BA1_PLPOR),(cAliastmp)->BA1_PLPOR,(cAliastmp)->BA3_PLPOR),''))
return(Cmens)  

/**********************************/                        
Static Function PI_DtIPl
// Data de contratacao do plano
private cMens := 'Data de contratacao do plano , cadastro Usuario --> '   
a:= ' '  
//If dDtBase <(cAliastmp)->BA1_DATINC
//   a := " - Data Incluão maior que data de atual , T "  
//    lCritica:= .T.  
//EndIf
cMens += SubStr((cAliastmp)->BA1_DATINC,7,2) + "/" + SubStr((cAliastmp)->BA1_DATINC,5,2) + "/" + SubStr((cAliastmp)->BA1_DATINC,1,4) + a
return(Cmens)  

/**********************************/                        
Static Function PI_NomUsr                                              
// Nome do Beneficiario                                                
private cMens := 'Nome Beneficiario  , cadastro Usuario --> '   
 a:= ' '  
 x:= 1
while x <= len((cAliastmp)->BA1_NOMUSR)  
               
        if (X+3) <= len((cAliastmp)->BA1_NOMUSR) .and. (substr((cAliastmp)->BA1_NOMUSR ,x , 1)) = ' ' .and. (substr((cAliastmp)->BA1_NOMUSR ,x+1 , 2)) != ' ' .and. (substr((cAliastmp)->BA1_NOMUSR ,x+2 , 3)) = ' ' 
            a:= 'Abreviação identificadas , T  ' 
            lCritica:= .T.                       
        EndIf    
        If (substr((cAliastmp)->BA1_NOMUSR ,x , 1)) $ ".|-|_|/|'|=|:"  
            a:= 'Caracter Especial  , T ' 
            lCritica:= .T.   
        elseif (substr((cAliastmp)->BA1_NOMUSR ,x , 1)) $ "0"  
            a:= 'Caracter Especial 0 , T  '
            lCritica:= .T.   
        endIf     
      x++
enddo    
                              
if empty ((cAliastmp)->BA1_NOMUSR)      
   a:='Em Branco , T ' 
   lCritica:= .T.   
EndIf     

cMens += AllTrim(SubStr((cAliastmp)->BA1_NOMUSR + Space(70),1,70)) +' - '+ a   
return(Cmens) 
                                                                        
/**********************************/                        
Static Function PI_DtNUsr                                              
// Data de nascimento do beneficiario                        
private cMens := 'Data Nascimento do Beneficiario  , cadastro Usuario --> '      
// SOLITADO PELA LUCIA A INCLUÇÃO DA CRITICA  DE MES ANO , SENDO IGNORADO O DIA DO NACISMENTO 
a:= ' '
if SUBSTR((cAliastmp)->BA1_DATNAS,1,6) > SUBSTR((cAliastmp)->BA1_DATINC,1,6)
  a:= ' Mes/Ano de nascimento maior que o mes/ano de inclussao , T '
  lCritica:= .T. 
else  
  a:= ' '
EndIf     
  cMens +=  SubStr((cAliastmp)->BA1_DATNAS,7,2) +"/" + SubStr((cAliastmp)->BA1_DATNAS,5,2) + "/" +  SubStr((cAliastmp)->BA1_DATNAS,1,4) + a      

return(Cmens) 
             
/**********************************/                        
Static Function PI_DtCanc                                              
// Data de nascimento do beneficiario                        
private cMens := 'Data Bloqueio do Beneficiario  , cadastro Usuario --> '      
// SOLITADO PELA LUCIA A INCLUÇÃO DA CRITICA  DE MES ANO , SENDO IGNORADO O DIA DO NACISMENTO 
a:= ' '
if !empty((cAliastmp)->BA1_DATBLO)  .and.(cAliastmp)->BA1_DATBLO < (cAliastmp)->BA1_DATINC
  a:= ' Data do Bçloqueio menor que a de Inclussao , T '
  lCritica:= .T. 
else 
  a:= ' ' 
EndIf   
cMens +=  "Dt do Inclussão " +SubStr((cAliastmp)->BA1_DATINC,7,2) +"/" + SubStr((cAliastmp)->BA1_DATINC,5,2) + "/" +  SubStr((cAliastmp)->BA1_DATINC,1,4)  
cMens +=  "Dt do Bloquido " +SubStr((cAliastmp)->BA1_DATBLO,7,2) +"/" + SubStr((cAliastmp)->BA1_DATBLO,5,2) + "/" +  SubStr((cAliastmp)->BA1_DATBLO,1,4) + a     

return(Cmens) 



/**********************************/                        
Static Function PI_FamTit                                                       

private cMens := "Familia do  Beneficiario  , cadastro Usuario --> "+(cAliastmp)->BA1_CODINT+"."+(cAliastmp)->BA1_CODEMP+"."+(cAliastmp)->BA1_MATRIC+" "                                                                   
private cSQL  := ' '      
                          
cSQL += "   SELECT Count(R_E_C_N_O_) QTDA "
cSQL += "     FROM "+ RetSqlName("BA1") + " BA1
//cSQL += "   FROM BA1010 "
cSQL += "   WHERE BA1_FILIAL = '" + xFilial("BA1") + "' "
//cSQL += "   WHERE BA1_FILIAL = '  ' "
cSQL += "   AND BA1_CODINT = '"+(cAliastmp)->BA1_CODINT+"'" 
cSQL += "   AND BA1_CODEMP = '"+(cAliastmp)->BA1_CODEMP+"'"
cSQL += "   AND BA1_MATRIC = '"+(cAliastmp)->BA1_MATRIC+"'"  
cSQL += "   AND BA1_TIPREG = '00' " 
cSQL += "   AND BA1_TIPUSU = 'T'  "
                                   
If Select((cAliastmp1)) <> 0 
  (cAliastmp1)->(DbCloseArea()) 
Endif
  
 TCQuery cSQL New Alias (cAliastmp1)  
    
 dbSelectArea(cAliastmp1)
   
 If (cAliastmp1)->QTDA == 0   
    a:= ' - Familia sem Titular - T ' 
    lCritica:= .T. 
 Else                                 
    a:= ' '
 EndIf    
              
return(Cmens + a ) 


/**********************************/                        
/*
// Indicacao de cobertura parcial temporaria
private cMens := 
aRegInc[nRegInc,24] := PLSIBCPT(dDatRef,TRBSIB->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG))

// Indicacao de itens de procedimentos excluidos da cobertura
aRegInc[nRegInc,25] := "0"
                        
 /**********************************                        
Static Function PI_CNPJC
// Numero do CNPJ da pessoa juridica contratante do plano coletivo
private cMens :='Numero do CNPJ da pessoa juridica contratante do plano coletivo '
If (cAliastmp)->BA3_TIPOUS <> "1" //Beneficiario PJ
	If !Empty(BQC->BQC_CNPJ)
		aRegInc[nRegInc,26] := BQC->BQC_CNPJ
	Else
		If SA1->(dbSeek(xFilial("SA1")+BQC->(BQC_CODCLI+BQC_LOJA)))
			aRegInc[nRegInc,26] := SA1->A1_CGC
		Else
			aRetCli := PLSRETNCB(TRBSIB->BA1_CODINT,TRBSIB->BA1_CODEMP,TRBSIB->BA1_MATRIC,TRBSIB->BA1_OPEORI)
			If aRetCli[1]
				If SA1->(msSeek(xFilial("SA1")+TRBSIB->(BA3_CODCLI+BA3_LOJA)))
					aRegInc[nRegInc,26] := SA1->A1_CGC
				EndIf
			EndIf
		EndIf
	EndIf
Else
	aRegInc[nRegInc,26] := ""
EndIf

// Numero do CEI do contratante do plano coletivo
If aRetPla[3] $ "3,4" .And. Empty(BQC->BQC_CNPJ) .And. !Empty(SA1->A1_CEINSS)
	aRegInc[nRegInc,26] := "" // Vou informar o CEI e nao o CNPJ
	aRegInc[nRegInc,27] := AllTrim(SA1->A1_CEINSS)
Else
	aRegInc[nRegInc,27] := ""
EndIf

// Relacao de dependencia
nPos := aScan(aGraPar,{|x| x[1] == TRBSIB->BA1_GRAUPA})
If nPos > 0
	aRegInc[nRegInc,28] := aGraPar[nPos,2]
Else
	aRegInc[nRegInc,28] := "10"
EndIf

aRegInc[nRegInc,29] := .T. //Indica que o registro sera escrito no arquivo SBX

If lCriaLog
	PlsLogFil(Transform(TRBSIB->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO),MATRIPLS) +"  "+ ;
	SubStr(AllTrim(TRBSIB->BA1_NOMUSR)+Space(30),1,30)+ " - Inclusão ",cArqLog)
EndIf
*/
Return .T.
******************************************************************************************

Static Function AjustaSX1(cPerg)         

Local aHelpPor := {} 

PutSx1(cPerg,"01",OemToAnsi("Data Inicio SIB   ") 		,"","","mv_ch1","D",10,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",aHelpPor,{},{})
PutSx1(cPerg,"02",OemToAnsi("Data Fim SIB      ") 		,"","","mv_ch2","D",10,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",aHelpPor,{},{})
PutSx1(cPerg,"03",OemToAnsi("Critica Inclusao  ")    	,"","","mv_ch3","N",01,0,0,"C","","","","","mv_par03","Sim","","","","Não","","","","","","","","","","","",{},{},{})   
PutSx1(cPerg,"04",OemToAnsi("Critica Alteraçõa ")   	,"","","mv_ch4","N",01,0,0,"C","","","","","mv_par04","Sim","","","","Não","","","","","","","","","","","",{},{},{})  
PutSx1(cPerg,"05",OemToAnsi("Critica Exclussão ")       ,"","","mv_ch5","N",01,0,0,"C","","","","","mv_par05","Sim","","","","Não","","","","","","","","","","","",{},{},{})  

PutSx1(cPerg,"06",OemToAnsi("Listar Só Criticados ? ")	,"","","mv_ch6","N",01,0,0,"C","","","","","mv_par06","Sim","","","","Não","","","","","","","","","","","",{},{},{})   

PutSx1(cPerg,"07",OemToAnsi("Empresa de   ") 		    ,"","","mv_ch7","C",04,0,0,"G","","","","","mv_par07","","","","","","","","","","","","","","","","","",{},{})
PutSx1(cPerg,"08",OemToAnsi("Empresa Ate  ") 		    ,"","","mv_ch8","C",04,0,0,"G","","","","","mv_par08","","","","","","","","","","","","","","","","","",{},{})

PutSx1(cPerg,"09",OemToAnsi("Produtividade ")          ,"","","mv_ch9","N",01,0,0,"C","","","","","mv_par09","Sim","","","","Não","","","","","","","","","","","",{},{},{})  
PutSx1(cPerg,"10",OemToAnsi("Usuaria Prod. ") 		    ,"","","mv_ch10","C",20,0,0,"G","","","","","mv_par10","","","","","","","","","","","","","","","","","",{},{})

PutSx1(cPerg,"11",OemToAnsi("Gerar Excel       ") 	    ,"","","mv_ch11","N",01,0,0,"C","","","","","mv_par11","Sim","","","","Não","","","","","","","","","","","",{},{},{}) 

Pergunte(cPerg,.T.)

Return



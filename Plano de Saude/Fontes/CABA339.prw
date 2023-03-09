#include "PLSA090.ch" 
#include "PROTHEUS.CH"
#Include 'PLSMGER.CH'
#include "PLSMGER2.CH"
#include "PLSMCCR.CH"                                               
#include "topconn.ch"
#INCLUDE "TOTVS.CH"
#INCLUDE "UTILIDADES.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³NOVO2     ºAutor  ³Marcela Coimbra     º Data ³  06/17/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Rotina de Faturamento Prefeitura                           º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/


User Function CA_BA339d()

ImpFat()  

//ImpConsig()

Return   

*'------------------------------------------------------------------'*
*'-- Importa Fatura                                               --'*
*'------------------------------------------------------------------'*
Static Function ImpFat()     
*'------------------------------------------------------------------'*


Local l_Erro := .F.
                        
Private cTitRotina 		:= "Importa arquivo de fatura"
Private lLayout    		:= .T.
Private oDlg
Private c_dirimp   		:= space(100)
Private _nOpc	  		:= 0
Private c_Separador 	:= ""
Private a_Erro 			:= {}
Private l_Deleta 		:= .F.

Define FONT oFont1 	NAME "Arial" SIZE 0,15  Bold

DEFINE MSDIALOG oDlg TITLE cTitRotina FROM 000,000 TO 175,320 PIXEL

@ 003,009 Say cTitRotina          Size 121,012 FONT oFont1 COLOR CLR_HBLUE PIXEL OF oDlg
@ 018,009 Say  "Diretorio"        Size 045,008 PIXEL OF oDlg
@ 026,009 MSGET c_dirimp          Size 130,010 WHEN .F. PIXEL OF oDlg

c_Separador := ';'

@ 026,140 BUTTON "..."            SIZE 013,013 PIXEL OF oDlg   Action(c_dirimp := cGetFile("TXT|*.txt|CSV|*.csv","Importacao de Dados",0, ,.T.,16/*GETF_LocalHARD*/))
@ 045,009 Say  "Delimitador: [ " + c_Separador + " ]" Size 045,008 PIXEL OF oDlg   
@ 70,088 Button "OK"       Size 030,012 PIXEL OF oDlg Action(_nOpc := 1,oDlg:End())
@ 70,123 Button "Cancelar" Size 030,012 PIXEL OF oDlg Action oDlg:end()

ACTIVATE MSDIALOG oDlg CENTERED

If _nOpc == 1
	Processa({||l_Erro := fImpFat()},"Importa arquivo de fatura...")
EndIf

Return
	
*'------------------------------------------------------------------'*
*'-- Insere PC0                                                   --'*
*'------------------------------------------------------------------'*
Static Function fImpFat()
*'------------------------------------------------------------------'*

Local c_Arq		:= c_dirimp
Local n_QtdLin	:= 0
Local n_TotLin	:= 0
Local nInserido	:= 0
Local aBuffer	:= {}
Local l_Erro	:= .F.
Local cMsg 		:= ''
Local cBusca	:= ''
Local cTEC		:= ''
Local lHasFile	:= .T.
Local cMatric	:= ''
Local cNomePro	:= ''

DbSelectArea('PC0')   


If !Empty(c_Arq)

	ProcRegua(0)
	
	For n_TotLin := 1 to 5
		IncProc('Abrindo o arquivo...')
	Next

	FT_FUSE(c_Arq)
	FT_FGOTOP()

Else

	cMsg := "Arquivo a ser importado não localizado!" + CRLF
	MsgStop(cMsg,AllTrim(SM0->M0_NOMECOM))
	lHasFile	:= .F.
	
EndIf 

If !l_Erro .and. lHasFile

	n_TotLin := FT_FLASTREC()
	c_QtdLin := AllTrim(Transform(n_TotLin,'@E 999,999,999'))   
	
	ProcRegua(n_TotLin)
		
	While !FT_FEOF()
		
		IncProc('Processando linha ' + AllTrim(Transform(++n_QtdLin,'@E 999,999,999')) + ' de ' + c_QtdLin) //incrementa a regua de processamento...
	
		c_Buffer   := FT_FREADLN()
		
		aBuffer := Separa(c_Buffer,';',.T.)
		
		If n_QtdLin == 1 .or. empty(aBuffer)//Header 
			FT_FSKIP()
			Loop
		EndIf 
		
		c_Cpf 		:= StrZero(Val(aBuffer[2]),11)    
		c_MatPref 	:= replace(aBuffer[3], '.', '')   
		c_MatPref 	:= replace(c_MatPref, '-', '')   
		c_PlanoPref	:= aBuffer[4]   
		n_QtdMat    := val(aBuffer[5])   
		n_Cota		:= val(replace(aBuffer[6], ',', '.')  ) 
		c_Condic	:= aBuffer[7]   	
		n_VlDental  := val(replace(aBuffer[8], ',', '.')  )   	
		c_Orgao		:= aBuffer[9]   
		c_Faixa		:= aBuffer[10]   

		n_VlPlan	:= replace(aBuffer[11], '.', '')  
		n_VlPlan	:= val(replace(n_VlPlan, ',', '.')  )   
	
		n_VlFass    := replace(aBuffer[12], '.', '')     
		n_VlFass    := val(replace(n_VlFass, ',', '.')  )   
 
		n_Compl		:= val(replace(aBuffer[13], ',', '.')  )   
		
					
		ZRL->(Reclock('PC0',.T.))
		
			PC0->PC0_CPF    	:= c_Cpf
			PC0->PC0_MATPRE    	:= c_MatPref
			PC0->PC0_PADRAO    	:= c_PlanoPref
			PC0->PC0_QTDMAT    	:= n_QtdMat
			PC0->PC0_VLCOTA    	:= n_Cota
			PC0->PC0_VLDENT    	:= n_VlDental
			PC0->PC0_VLPLAN    	:= n_VlPlan
			PC0->PC0_VLFASS    	:= n_VlFass
			PC0->PC0_VLCOMP    	:= n_Compl
			PC0->PC0_CONDIC    	:= c_Condic
			PC0->PC0_ORGAO     	:= c_Orgao
			PC0->PC0_FXETAR    	:= c_Faixa
		
  		PC0->(MsUnlock())
		
		nInserido++
		
		FT_FSKIP()
			
	EndDo
	
	FT_FUSE()
	
EndIf

If !l_Erro .and. lHasFile
	MsgAlert("Inseridos " + AllTrim(Transform(nInserido,'@E 999,999,999')) + " registros na tabela " + RetSqlName('PC0'),AllTrim(SM0->M0_NOMECOM))
EndIf

Return l_Erro   


*'------------------------------------------------------------------'*
*'-- Importa Consig                                               --'*
*'------------------------------------------------------------------'*
Static Function ImpConsig()
*'------------------------------------------------------------------'*

Local l_Erro := .F.
                        
Private cTitRotina 		:= "Importa arquivo de consignações"
Private lLayout    		:= .T.
Private oDlg
Private c_dirimp   		:= space(100)
Private _nOpc	  		:= 0
Private c_Separador 	:= ""
Private a_Erro 			:= {}
Private l_Deleta 		:= .F.

Define FONT oFont1 	NAME "Arial" SIZE 0,15  Bold

DEFINE MSDIALOG oDlg TITLE cTitRotina FROM 000,000 TO 175,320 PIXEL

@ 003,009 Say cTitRotina          Size 121,012 FONT oFont1 COLOR CLR_HBLUE PIXEL OF oDlg
@ 018,009 Say  "Diretorio"        Size 045,008 PIXEL OF oDlg
@ 026,009 MSGET c_dirimp          Size 130,010 WHEN .F. PIXEL OF oDlg

c_Separador := ';'

@ 026,140 BUTTON "..."            SIZE 013,013 PIXEL OF oDlg   Action(c_dirimp := cGetFile("TXT|*.txt|CSV|*.csv","Importacao de Dados",0, ,.T.,16/*GETF_LocalHARD*/))
@ 045,009 Say  "Delimitador: [ " + c_Separador + " ]" Size 045,008 PIXEL OF oDlg   
@ 70,088 Button "OK"       Size 030,012 PIXEL OF oDlg Action(_nOpc := 1,oDlg:End())
@ 70,123 Button "Cancelar" Size 030,012 PIXEL OF oDlg Action oDlg:end()

ACTIVATE MSDIALOG oDlg CENTERED

If _nOpc == 1
	Processa({||l_Erro := fImpConsig()},"Importa arquivo de consignados...")
EndIf

Return
	
*'------------------------------------------------------------------'*
*'-- Insere PC2                                                   --'*
*'------------------------------------------------------------------'*
Static Function fImpConsig()
*'------------------------------------------------------------------'*
    
	Local c_Arq		:= c_dirimp
	Local n_QtdLin	:= 0
	Local n_TotLin	:= 0
	Local nInserido	:= 0
	Local aBuffer	:= {}
	Local l_Erro	:= .F.
	Local cMsg 		:= ''
	Local cBusca	:= ''
	Local cTEC		:= ''
	Local lHasFile	:= .T.
	Local cMatric	:= ''
	Local cNomePro	:= ''
	

	Local c_Cpf 		:= ""
	Local c_MatPref 	:= ""
	Local c_MatPref 	:= ""
	Local c_QtdPen		:= ""
	Local c_Fonte     	:= ""
	Local c_Rubrica		:= ""
	Local c_Especie		:= ""
	Local n_VlComand  	:= 0
	Local n_VlComand  	:= 0
	Local c_Situac		:= ""
	Local c_Motivo		:= ""
	Local c_PosFoll		:= ""
	Local d_Compet		:= dDataBase

DbSelectArea('PC2')   


If !Empty(c_Arq)

	ProcRegua(0)
	
	For n_TotLin := 1 to 5
		IncProc('Abrindo o arquivo...')
	Next

	FT_FUSE(c_Arq)
	FT_FGOTOP()

Else

	cMsg := "Arquivo a ser importado não localizado!" + CRLF
	MsgStop(cMsg,AllTrim(SM0->M0_NOMECOM))
	lHasFile	:= .F.
	
EndIf 

If !l_Erro .and. lHasFile

	n_TotLin := FT_FLASTREC()
	c_QtdLin := AllTrim(Transform(n_TotLin,'@E 999,999,999'))   
	
	ProcRegua(n_TotLin)
		
	While !FT_FEOF()
		
		IncProc('Processando linha ' + AllTrim(Transform(++n_QtdLin,'@E 999,999,999')) + ' de ' + c_QtdLin) //incrementa a regua de processamento...
	
		c_Buffer   := FT_FREADLN()
		
		aBuffer := Separa(c_Buffer,';',.T.)
		
		If n_QtdLin == 1 .or. empty(aBuffer)//Header 
			FT_FSKIP()
			Loop
		EndIf 
		
		
		c_Cpf 		:= StrZero(Val(aBuffer[3]),11)    
		c_MatPref 	:= replace(aBuffer[4], '.', '')   
		c_MatPref 	:= replace(c_MatPref, '-', '')   
		c_QtdPen	:= aBuffer[5]   
		c_Fonte     := aBuffer[1]   
		c_Rubrica	:= aBuffer[6]
		c_Especie	:= aBuffer[11]   	
		n_VlComand  := replace(aBuffer[9], '.', '')  
		n_VlComand  := val(replace(n_VlComand, ',', '.')  )   	
		
		If upper( substr(aBuffer[13], 1, 1)) == 'P'
		     
		n_VlDescon  := replace(aBuffer[12], '.', '')  
		n_VlDescon  := val(replace(n_VlDescon, ',', '.')  )   	
		
		Else

			n_VlDescon  := 0

		EndIf
		
	
		c_Situac	:= aBuffer[14]   
		c_Motivo	:= aBuffer[15]   
		c_PosFoll	:= aBuffer[11]   
		d_Compet	:= ctod( aBuffer[7] )
		
					
		PC2->(Reclock('PC2',.T.))
		
			PC2->PC2_CPFTIT    	:= c_Cpf
			PC2->PC2_MATRIC    	:= c_MatPref
			PC2->PC2_NUMPEN    	:= c_QtdPen
			PC2->PC2_FONTEP    	:= c_Fonte
			PC2->PC2_RUBLIC    	:= c_Rubrica
			PC2->PC2_TIPUSU    	:= c_Especie
			PC2->PC2_VLRCOM    	:= n_VlComand
			PC2->PC2_VLDESC    	:= n_VlDescon
			PC2->PC2_SITUAC    	:= c_Situac
			PC2->PC2_MOTIVO    	:= c_Motivo
			PC2->PC2_POSFOL     := c_PosFoll
			PC2->PC2_COMPET    	:= d_Compet
		
  		PC2->(MsUnlock())
		
		nInserido++
		
		FT_FSKIP()
			
	EndDo
	
	FT_FUSE()
	
EndIf

If !l_Erro .and. lHasFile
	MsgAlert("Inseridos " + AllTrim(Transform(nInserido,'@E 999,999,999')) + " registros na tabela " + RetSqlName('PC0'),AllTrim(SM0->M0_NOMECOM))
EndIf

Return l_Erro   

***************************************************************************************************************     
***************************************************************************************************************

**'Marcela - Importa arquivo de baixa'**

User Function ImpOrgPref(cAlias,nReg)
                        
Local cPerg	       		:= "COMPFAI"
Local l_Erro			:= .F.

Private cComboBx1                                        
Private cTitRotina 		:= "Imp. arq. baixa (Layout QW60)"
Private lLayout    		:= .T.
Private oDlg
Private c_dirimp   		:= space(100)
Private _nOpc	  		:= 0
Private c_Separador 	:= ""
Private a_Erro 		:= {}
Private l_Importa := .F.

Define FONT oFont1 	NAME "Arial" SIZE 0,15  Bold

DEFINE MSDIALOG oDlg TITLE "Importação de arquivo de baixa (Layout QW60)" FROM 000,000 TO 175,320 PIXEL

@ 003,009 Say cTitRotina          Size 121,012 FONT oFont1 COLOR CLR_HBLUE PIXEL OF oDlg  //015
@ 018,009 Say  "Diretorio"        Size 045,008 PIXEL OF oDlg   //030   008
@ 026,009 MSGET c_dirimp          Size 130,010 WHEN .F. PIXEL OF oDlg  //038

*-----------------------------------------------------------------------------------------------------------------*
*Buscar o arquivo no diretorio desejado.                                                                          *
*Comando para selecionar um arquivo.                                                                              *
*Parametro: GETF_LocalFLOPPY - Inclui o floppy drive Local.                                                       *
*           GETF_LocalHARD   - Inclui o Harddisk Local.                                                           *
*-----------------------------------------------------------------------------------------------------------------* 

@ 026,140 BUTTON "..."            SIZE 013,013 PIXEL OF oDlg   Action(c_dirimp := cGetFile("TXT|*.txt|CSV|*.csv","Importacao de Dados",0, ,.T.,16/*GETF_LocalHARD*/))
@ 045,009 Say  "Delimitador"      Size 045,008 PIXEL OF oDlg   

//aCombo := {"Somente relatorio","Executar atualização"}  
//cCombo := space(1)      
                                      
//@ 045,038 COMBOBOX oCombo VAR cCombo ITEMS aCombo SIZE 20,10 PIXEL OF oDlg

*-----------------------------------------------------------------------------------------------------------------*
@ 70,088 Button "OK"       Size 030,012 PIXEL OF oDlg Action(_nOpc := 1,oDlg:End())
@ 70,123 Button "Cancelar" Size 030,012 PIXEL OF oDlg Action oDlg:End()

ACTIVATE MSDIALOG oDlg CENTERED

If _nOpc == 1
	
	c_Separador := ';'
	     
	Processa({|| l_Erro := IMPORG(PBR->PBR_ANOREM + PBR->PBR_MESREM)},"Importando de arquivo de baixa...", "", .T.)
		
EndIf

Return 

*------------------------------------------------------------------*
Static Function IMPORG(cAnoMes)
*------------------------------------------------------------------*
* função para importar o arquivo                                          
*------------------------------------------------------------------*

Local c_Arq		:= c_dirimp
Local n_Lin   	:= 0
Local c_Qry    	:= ""
Local n_QtdLin	:= 0 
Local l_Erro	:= .F.
          
Private A_ERRO := {}

If !Empty(c_Arq)

	FT_FUSE(c_Arq)
	FT_FGOTOP()

Else
	Alert("Informe o arquivo a ser importado!")
	Return
EndIf     

n_QtdLin := FT_FLASTREC()
c_QtdLin := AllTrim(Transform( n_QtdLin,'@E 999,999,999'))   

ProcRegua( n_QtdLin )

n_QtdLin := 0
	
aDados := {}
	
While !FT_FEOF()
	
	IncProc('Processando linha ' + AllTrim(Transform(++n_QtdLin,'@E 999,999,999')) + ' de ' + c_QtdLin) //incrementa a regua de processamento...

	c_Buffer   := FT_FREADLN()
	n_Loop     := 0
	
	//00 = "Sem retorno da folha"; 01 = "Descontado"; 02 = "Não descontado"; 03 = "Desconto parcial"; 04 = "Não enviado p/ desconto"
	//Situação do desconto tem que ser Descontado ou Desconto Parcial para baixa
   /*	If !( cDesconto $ '01|03' )
		FT_FSKIP()
		Loop
	EndIf
	 */	                                                           
	a_TmpDados := {}
	aAdd (a_TmpDados , {"","","","","","",""} )
	

	c_Script := "INSERT INTO pref_cpf_orgao ( empresa,cpf,matricula,nome ) VALUES ( " 
  		aBuffer := Separa(c_Buffer,';',.T.)
		
		If n_QtdLin == 1 .or. empty(aBuffer)//Header 
			FT_FSKIP()
			Loop
		EndIf 
		
		c_Script 	+= "'" + aBuffer[1] + "',"  
		c_Script 	+= "'" + StrZero( Val(aBuffer[2]),11 ) + "',"   
	   	c_Script 	+= "'" + replace( replace(aBuffer[3], '.', ''), '-', '') + "',"    
		c_Script 	+= "'" + aBuffer[4] + "')" 
	
  	
	If TcSqlExec(c_Script) < 0 
		LogErros("Falha ao inserir o registro da linha " + cValToChar(n_QtdLin) + " na tabela AN_PREVI" + CRLF;
				+ "Script executado: " + c_Script + CRLF;
				+ "Erro: " + TcSQLError();
				,AllTrim(SM0->M0_NOMECOM),.T.)	
		l_Erro	:= .T.
		Exit
	EndIf 

	FT_FSKIP()
		
Enddo

FT_FUSE()

Return l_Erro

User Function BXPARPRE()
            
Local n_TotBx := 0
                                                                                                   
	c_Qry := " select max(E5_LOTE)  LOTE  "
	c_Qry += " from se5010            "
	c_Qry += " where e5_filial = '01' "
	c_Qry += " and E5_RECPAG = 'R'    "
	c_Qry += " and LENGTH(TRIM(E5_LOTE)) = 8 "
	c_Qry += " and d_e_l_e_t_ = ' ' "
	
	TcQuery c_Qry ALIAS "TMPLOTE" NEW     
	
	While !tmplote->( EOF() ) 
	    
	    c_Lote := soma1( tmplote->LOTE )
	
		tmplote->( dbSkip() )
	
	EndDo      
		
	c_Qry := " SELECT distinct t.*        "
	c_Qry += " FROM tmpsalse1 T, SE1010 E "
	c_Qry += " WHERE SALDO > 17.95        "
	c_Qry += " AND E1_FILIAL = '01'       "
	c_Qry += " AND E1_PREFIXO = 'PLS'     "
	c_Qry += " AND E1_ANOBASE = '2015'    "
	c_Qry += " AND E1_MESBASE = '08'      "
	c_Qry += " AND T.E1_NUM = E.E1_NUM    "
   //	c_Qry += " AND T.E1_NUM NOT IN ( SELECT E5_NUMERO FROM SE5010 WHERE E5_FILIAL = '01' AND E5_LOTE = '00008893' )"
	c_Qry += " ORDER BY SALDO             "
	
		      
	TCQUERY c_Qry ALIAS "TMPEX" NEW 
	                     
	While !TMPEX->(EOF())
	                     
	     BaixaTitulo( "NOR","PLS", TMPEX->E1_NUM ,' ','DP',dDataBase,"BX. AUTOM. PREFEITURA",TMPEX->e1_valor - TMPEX->saldo,  , c_Lote) 
	     n_TotBx+= TMPEX->e1_valor - TMPEX->saldo
	     
		TMPEX->( dbSkip() )
	
	EndDo                                         
	
			Reclock( "SE5" , .T. )
				SE5->E5_FILIAL	:= xFilial()
				SE5->E5_BANCO	:= "033"
				SE5->E5_AGENCIA	:= "3003 "
				SE5->E5_CONTA	:= "13081236  "
				SE5->E5_VALOR	:= n_TotBx
				SE5->E5_RECPAG	:= "R"
				SE5->E5_HISTOR	:= "BX. AUTOM. PREF. IND." + c_Lote
				SE5->E5_DTDIGIT	:= dDataBase
				SE5->E5_DATA	:= dDataBase
				SE5->E5_NATUREZ	:= "BX.PREF"
				SE5->E5_LOTE	:= c_Lote
				SE5->E5_TIPODOC := "BL"
				SE5->E5_DTDISPO	:= dDataBase
			
				MsUnlock()			
	
Return


Static Function BaixaTitulo(cMotBx,cPrefixo,cNumero,cParcela,cTipo,dDtBaixa,cHisBaixa,nVlrBaixa, n_TotBx, c_Lote)
	
Local lRet := .F.

Private lmsErroAuto := .f.
Private lmsHelpAuto := .t. // para mostrar os erros na tela     

nTpMov := 1  

dbSelectArea("SE1")                                    
dbSetOrder(1)
If SE1->(MsSeek(xFilial("SE1")+cPrefixo+cNumero+cParcela+cTipo)) .and. cNumero <> '002324762'

	If SE1->E1_SALDO > 0
		nVlrBaixa := If(nVlrBaixa > SE1->E1_SALDO, SE1->E1_SALDO, nVlrBaixa)
		SA6->(DbSetOrder(1)) //A6_FILIAL+A6_COD+A6_AGENCIA+A6_NUMCON
		SA6->(MsSeek(xFilial("SA6")+"0333003 13081236  "))

		aCamposSE5 := {}
		aAdd(aCamposSE5, {"E1_FILIAL"	, xFilial("SE1")	, Nil})
		aAdd(aCamposSE5, {"E1_PREFIXO"	, cPrefixo			, Nil})
		aAdd(aCamposSE5, {"E1_NUM"		, cNumero			, Nil})
		aAdd(aCamposSE5, {"E1_PARCELA"	, cParcela			, Nil})
		aAdd(aCamposSE5, {"E1_TIPO"		, cTipo				, Nil})
     	aAdd(aCamposSE5, {"E1_LOTE"		, c_Lote			, Nil})
		aAdd(aCamposSE5, {"AUTMOTBX"	, cMotBx			, Nil})
		aAdd(aCamposSE5, {"AUTBANCO"	, SA6->A6_COD		, Nil})
		aAdd(aCamposSE5, {"AUTAGENCIA"	, SA6->A6_AGENCIA	, Nil})
		aAdd(aCamposSE5, {"AUTCONTA"	, SA6->A6_NUMCON	, Nil})

		aAdd(aCamposSE5, {"AUTDTBAIXA"	, dDtBaixa			, Nil})
		aAdd(aCamposSE5, {"AUTDTCREDITO", dDtBaixa			, Nil})
		aAdd(aCamposSE5, {"AUTHIST"		, cHisBaixa			, Nil})
		aAdd(aCamposSE5, {"AUTVALREC"	, nVlrBaixa			, Nil})

		msExecAuto({|x,y| Fina070(x,y)}, aCamposSE5, 3)

		If lMsErroAuto
		   	lRet := .F.
		   //	aadd(aErrImp,{"Ocorreu um erro na baixa do titulo "+cPrefixo+" " +cNumero+" "+cParcela+" "+cTipo})
		  	MostraErro()
		   	SE1->(Reclock("SE1",.F.))
			SE1->E1_YTPEXP	:= "F" // RETORNO RIO PREVIDENCIA - ERRO - TABELA K1
			SE1->E1_YTPEDSC	:= Posicione("SX5", 1, xFilial("SX5")+"K1"+"F", "X5_DESCRI")
			SE1->(MsUnlock()) 
			
		Else 
		    
			SE1->(Reclock("SE1",.F.))
			SE1->E1_YTPEXP	:= "E" // RETORNO RIO PREVIDENCIA - OK - TABELA K1
			SE1->E1_YTPEDSC	:= Posicione("SX5", 1, xFilial("SX5")+"K1"+"E", "X5_DESCRI")
			SE1->(MsUnlock())
		 	//Informa o lote no movimento totalizador
			If nTpMov == 1
					SE5->(Reclock("SE5",.F.))
					SE5->E5_TIPODOC	:= "BA"
					SE5->E5_LOTE	:= c_Lote
					SE5->(MsUnlock())			
			EndIf 
			  
		   //	n_TotBx+= nVlrBaixa
			
		//	lRet := .T.
		EndIf
	Else
  //		aadd(aErrImp,{"O titulo encontra-se baixado. "+cPrefixo+" " +cNumero+" "+cParcela+" "+cTipo})
	EndIf

EndIf     
	
Return lRet   
  
  
User Function ind_____epa() 

	Local cQry := " "
//	Local cQry := "select * from rda_x_an" 

	cQry := " SELECT distinct t.*        "
	cQry += " FROM tmpsalse1 T, SE1010 E "
	cQry += " WHERE SALDO > 17.95        "
	cQry += " AND E1_FILIAL = '01'       "
	cQry += " AND E1_PREFIXO = 'PLS'     "
	cQry += " AND E1_ANOBASE = '2015'    "
	cQry += " AND E1_MESBASE = '07'      "
	cQry += " AND T.E1_NUM = E.E1_NUM    "
	cQry += " ORDER BY SALDO             "
	

	TCQUERY c_Qry ALIAS "RDAAN" NEW 
      
    While !RDAAN->( EOF())
		Reclock( "SZN" , .T. )
			
			SZN->ZN_CODINT:='0001'
			SZN->ZN_NOMINT:='CAIXA DE ASSISTENCIA A SAUDE - CABERJ.'
			SZN->ZN_OPERDA:='0001'
			SZN->ZN_VIGINI:='082015'
			SZN->ZN_ATIVO:='0' 
			SZN->ZN_CODRDA := RDAAN->RDA
			SZN->ZN_CODANA:= RDAAN->ANALISTA
	
		MsUnlock()	
      	RDAAN->(dbSkip())
  EndDo
  
Return  
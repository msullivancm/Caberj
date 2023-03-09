#INCLUDE "TOTVS.CH"
#INCLUDE "RWMAKE.CH"

#DEFINE CRLF CHR(13) + CHR(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA340   ºAutor  ³Angelo Henrique     º Data ³  12/08/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina para manutenção da Tabela ZRR - Votação Conselho     º±±
±±º          ³CABERJ                                                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABA340
	
	Private cCadastro 	:= "Manutenção de Votação Conselho CABERJ"
	Private cString 		:= "ZRR"
	Private _cMvTrn		:= GetMv("MV_XTURNO")
	Private _cMvAno		:= GetMv("MV_XANOEL")
	Private cFiltro 		:= "ZRR_TURNO == '" + _cMvTrn + "' .AND. ZRR_ANOELE == '" + _cMvAno + "'" //Expressao do Filtro
	Private aIndex 		:= {}
	Private bFiltraBrw 	:= {||FilBrowse(cString, @aIndex, @cFiltro)} //Determina a Expressao do Filtro
	Private aRotina 		:= { 	{"Pesquisar"	,"PesqBrw"	,0,1} ,;
		{"Visualizar"	,"AxVisual"	,0,2} ,;
		{"Pistolar"		,"U_CABA340C"	,0,3} ,;
		{"Legenda"		,"U_CABA340A"	,0,3} ,;
		{"Votos"		,"U_CABA340E"	,0,3} ,;
		{"Contas"		,"U_CABA340I"	,0,3} ,;
		{"Painel"		,"U_CABA340H"	,0,3} ,;
		{"Alterar"		,"U_CABA340B"	,0,4} }
	
	Private aCdCores		:= { 	{ 'BR_VERDE'    ,'Processo Em Espera'  },;
		{"BR_VERMELHO", "Processo  Recebido"}}
	
	Private aCores		:= {	{'Empty(ZRR_DTRET)', aCdCores[1,1]},;
		{"!Empty(ZRR_DTRET)", aCdCores[2,1] }}
	
	dbSelectArea(cString)
	
	//Efetiva o Filtro antes da Chamada a mBrowse
	Eval(bFiltraBrw)
	
	mBrowse( 6,1,22,75,cString,,,,,Nil,aCores)
	
	//Finaliza o Filtro
EndFilBrw(cString,@aIndex)

Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA340A  ºAutor  ³Angelo Henrique     º Data ³  17/08/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina de legenda.                                          º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABA340A
	
	Local aLegenda := {}
	
	aLegenda := {{ aCdCores[1,1],aCdCores[1,2] },;
		{ aCdCores[2,1],aCdCores[2,2] } }
	
	BrwLegenda(cCadastro,"Status" ,aLegenda)
	
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA340A  ºAutor  ³Angelo Henrique     º Data ³  17/08/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina responsável pela alteração                           º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CABA340B(cString, nReg, nOpc)
	
	Local aArea    	:= GetArea()
	Local aAreaZRR 	:= ZRR->(GetArea())
	Local _nOpc		:= 0
	Local _lDtRet		:= .F.
	
	If Altera .And. Empty(ZRR->ZRR_DTRET)
		
		_lDtRet := .T.
		
		ZRR->ZRR_DTRET := GetNewPar("MV_XDTRET", STOD("20151006"))
		
	EndIf
	
	_nOpc := AxAltera(cString, nReg, nOpc, , , , , ".T.")
	
	//-----------------------------------------------------------------------------
	//Se clicar em cancelar é necessário desfazer o conteúdo do campo ZRR_DTRET
	//uma vez que ao iniciar/clicar em alterar não temos as variáveis de memória
	//que seria M->ZRR_DTRET, sendo assim, quando colocamos ZRR->ZRR_DTRET
	//estamos dando um reclock na tabela
	//-----------------------------------------------------------------------------
	If _nOpc == 3 .And. _lDtRet
		
		RecLock("ZRR", .F.)
		ZRR->ZRR_DTRET := STOD(" / /")
		ZRR->(MsUnLock())
		
	EndIf
	
	RestArea(aAreaZRR)
	RestArea(aArea)
	
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA340C  ºAutor  ³Angelo Henrique     º Data ³  08/09/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina responsável pelo processo de "pistolar" os           º±±
±±º          ³recebimentos.                                               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CABA340C
	
	Private _oDlg		:= Nil
	Private oGtMat	:= Nil
	Private cGtMat	:= SPACE(17)
	Private _oBtn		:= Nil
	Private _oSay		:= Nil
	Private _oGroup	:= Nil
	Private _oBtn		:= Nil
	
	DEFINE MSDIALOG _oDlg FROM 0,0 TO 110,500 PIXEL TITLE 'Confirmação de Recebimento'
	
	_oGroup:= tGroup():New(10,10,50,230,'Dados do Beneficiário',_oDlg,,,.T.)
	
	_oSay:= tSay():New(19,16,{||'Matricula'},_oDlg,,,,,,.T.,CLR_RED,CLR_WHITE,100,20)
	@ 30,16 MSGET oGtMat VAR cGtMat SIZE 70,10 OF _oGroup PIXEL VALID (IIF(!Empty(cGtMat),U_CABA340D(),""))
	
	_oBtn := TButton():New( 27,170,"Fechar",_oDlg,{||_oDlg:End()},040,012,,,,.T.,,"",,,,.F. )
	
	ACTIVATE MSDIALOG _oDlg CENTERED
	
Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA340D  ºAutor  ³Angelo Henrique     º Data ³  08/09/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina por alimentar os dados do beneficiário e atualizar   º±±
±±º          ³seu registro na tabela.                                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABA340D
	
	Local _aArea 	:= GetArea()
	Local _aArZRR	:= ZRR->(GetArea())
	Local _cMsg	:= ""
	
	DbSelectArea("ZRR")
	DbSetORder(1)
	If DbSeek(xFilial("ZRR") + PADR(AllTrim(cGtMat),TAMSX3("ZRR_MATGER")[1]))
		
		_cMsg += "Matricula: " + ZRR->ZRR_MATGER + CRLF
		_cMsg += "Nome: " + ZRR->ZRR_NOME + CRLF
		_cMsg += "CEP: " + ZRR->ZRR_CEP + CRLF
		_cMsg += "Endereço: " + ZRR->ZRR_ENDERE + CRLF
		
	/*	////altamiro 26/09/2019 - teste de pistolagem 
		If ZRR->ZRR_DTRET <> ' '  
		
		    Alert(" Beneficiário já Pistolado  " )
  		   _cMsg +=  CRLF + CRLF + "Votante já Pistolado " +  CRLF
  		   _cMsg += "Data e Hora : " + ZRR->ZRR_DTRET  + " - "+ ZRR->ZRR_HRARET  + CRLF
  		   
//  		   MsgInfo(_cMsg,"Beneficiário já Pistolado")
 		
 		Else  */
		//// termino altamiro 26/09/2019
		While !EOF() .And. PADR(AllTrim(cGtMat),TAMSX3("ZRR_MATGER")[1]) == ZRR->ZRR_MATGER
			
			//--------------------------------------------
			//Pegando assim somente o turno correspondente
			//--------------------------------------------
			If ZRR->ZRR_TURNO == AllTrim(_cMvTrn) .and. ZRR->ZRR_ANOELE == _cMvAno
			
   	    	   If !empty(ZRR->ZRR_DTRET)  
		
        		  Alert(" Beneficiário já Pistolado  " )

		          MsgInfo(_cMsg,"Dados Não Atualizados com sucesso")
		       Else 
		        		
				  RecLock("ZRR", .F.)
				
			  	  ZRR->ZRR_DTRET 	:= DDATABASE
				  ZRR->ZRR_HRARET 	:= SUBSTR(TIME(),1,5)
				
				  ZRR->(MsUnLock())
				  
				  MsgInfo(_cMsg,"Dados Atualizados com sucesso")
			   
			   EndIf	  
				
			EndIf
			
			ZRR->(DbSkip())
			
		EndDo
		
		
		
	Else
		
		Alert("Beneficiário não encontrado no sistema" )
		
	EndIf
	
	//-----------------------------------
	//zerando as variáveis por precaução
	//-----------------------------------
	cGtMat	:= SPACE(17)
	
	_oDlg:Refresh()
	oGtMat:SetFocus()
	
	RestArea(_aArZRR)
	RestArea(_aArea)
	
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA340E  ºAutor  ³Angelo Henrique     º Data ³  02/10/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina responsável pelo processo de cadastrar os votos      º±±
±±º          ³efetuados.                                                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CABA340E
	
	Local _aArea := GetArea()
	Local _oBtn1	:= Nil
	Local _oBtn2	:= Nil
	
	//------------------------------------
	//Variáveis estaticas da tela
	//------------------------------------
	Private _oDlg1	:= Nil
	Private _oBtn1	:= Nil
	Private _oSay1	:= Nil
	Private _oGroup1 	:= Nil
	Private _oFont1	:= TFont():New("Times New Roman",,-18,.T.)
	Private _nRadio1 	:= 1
	Private _oRadio1	:= Nil
	
	//------------------------------------
	//Variaveris de valores
	//------------------------------------
	Private _cNmLot	:= ""
	Private _nTotDl	:= 0
	Private _nCh1Dl	:= 0
	Private _nCh2Dl	:= 0
	Private _nBrnDl	:= 0
	Private _nNulDl	:= 0
	Private _nTDiDl	:= 0
	Private _nTotFs	:= 0
	Private _nCh1Fs	:= 0
	Private _nCh2Fs	:= 0
	Private _nBrnFs	:= 0
	Private _nNulFs	:= 0
	Private _nTDiFs	:= 0
	
	//------------------------------------
	//Objetos dos valores
	//------------------------------------
	Private _oTotDl	:= Nil
	Private _oCh1Dl	:= Nil
	Private _oCh2Dl	:= Nil
	Private _oBrnDl	:= Nil
	Private _oNulDl	:= Nil
	Private _oTDiDl	:= Nil
	Private _oTotFs	:= Nil
	Private _oCh1Fs	:= Nil
	Private _oCh2Fs	:= Nil
	Private _oBrnFs	:= Nil
	Private _oNulFs	:= Nil
	Private _oTDiFs	:= Nil
	
	//------------------------------------
	//Variaveis para o Combo
	//------------------------------------
	Private _aItems	:= {'','ALBINO SANTOS RAMOS DE SOUSA','ANGELINA ELVIRA GRECO PEREIRA','DOUGLAS AUGUSTO GOMES MACEDO'}
	Private _cCombo	:= _aItems[1]
	Private _oCombo	:= Nil
	
	DEFINE MSDIALOG _oDlg1 FROM 0,0 TO 450,650 PIXEL TITLE "Digitação dos Votos"
	
	//-------------------------------------------------------
	//Cabeçalho do primeiro Grupo Parte Superior
	//-------------------------------------------------------
	_oGroup1:= tGroup():New(05,10,30,150,"Lote",_oDlg1,,,.T.)
	
	_oSay1:= tSay():New(10,30,{||"Nº do Lote: "	},_oDlg1,,_oFont1,,,,.T.,CLR_RED,CLR_WHITE,100,20)
	_oSay1:= tSay():New(10,80,{||_cNmLot := U_CABA340F()		},_oDlg1,,_oFont1,,,,.T.,CLR_RED,CLR_WHITE,100,20)
	
	//-------------------------------------------------------
	//Cabeçalho do Segundo Grupo Parte Superior
	//-------------------------------------------------------
	_oGroup1:= tGroup():New(05,170,30,310,"Tipo de Lote",_oDlg1,,,.T.)
	
	_oRadio1 := TRadMenu():New(11,180,{"Aberto","Fechado"},,_oDlg1,,,,,,,,35,200,,,,.T.)
	
	// Seta Eventos
	_oRadio1:bSetGet 		:= {|u|IIF(PCount()== 0, _nRadio1, _nRadio1 := u)}
	
	//-------------------------------------------------------
	//Cabeçalho do Primeiro Grupo Parte de Inferior
	//-------------------------------------------------------
	_oSay1:= tSay():New(31,30,{||"Conselho Deliberativo"},_oDlg1,,_oFont1,,,,.T.,CLR_RED,CLR_WHITE,100,20)
	
	_oGroup1:= tGroup():New(40,10,170,150,"",_oDlg1,,,.T.)
	
	_oSay1:= tSay():New(049,16,{||"Total"		},_oDlg1,,_oFont1,,,,.T.,CLR_RED,CLR_WHITE,100,20)
	@ 049,60 MSGET _oTotDl VAR IIF(_nRadio1 != 1,_nTotDl := 100,_nTotDl := 0) Picture "@E 999,999,999" SIZE 70,10 OF _oGroup1 PIXEL WHEN _nRadio1 = 1
	
	_oSay1:= tSay():New(069,16,{||"CH 1 SIM"	},_oDlg1,,_oFont1,,,,.T.,CLR_RED,CLR_WHITE,100,20)
	@ 069,60 MSGET _oCh1Dl VAR _nCh1Dl Picture "@E 999,999,999" SIZE 70,10 OF _oGroup1 PIXEL Valid (_nTDiDl := _nCh1Dl + _nCh2Dl + _nBrnDl + _nNulDl)
		
	_oSay1:= tSay():New(089,16,{||"CH 1 NAO"	},_oDlg1,,_oFont1,,,,.T.,CLR_RED,CLR_WHITE,100,20)
	@ 089,60 MSGET _oCh2Dl VAR _nCh2Dl Picture "@E 999,999,999" SIZE 70,10 OF _oGroup1 PIXEL Valid (_nTDiDl := _nCh1Dl + _nCh2Dl + _nBrnDl + _nNulDl) //WHEN .F.
	
	_oSay1:= tSay():New(109,16,{||"Branco"		},_oDlg1,,_oFont1,,,,.T.,CLR_RED,CLR_WHITE,100,20)
	@ 109,60 MSGET _oBrnDl VAR _nBrnDl Picture "@E 999,999,999" SIZE 70,10 OF _oGroup1 PIXEL Valid (_nTDiDl := _nCh1Dl + _nCh2Dl + _nBrnDl + _nNulDl)
	
	_oSay1:= tSay():New(129,16,{||"Nulo"		},_oDlg1,,_oFont1,,,,.T.,CLR_RED,CLR_WHITE,100,20)
	@ 129,60 MSGET _oNulDl VAR _nNulDl Picture "@E 999,999,999" SIZE 70,10 OF _oGroup1 PIXEL Valid (_nTDiDl := _nCh1Dl + _nCh2Dl + _nBrnDl + _nNulDl)
	
	_oSay1:= tSay():New(149,16,{||"Total Dig"	},_oDlg1,,_oFont1,,,,.T.,CLR_RED,CLR_WHITE,100,20)
	@ 149,60 MSGET _oTDiDl VAR _nTDiDl Picture "@E 999,999,999" SIZE 70,10 OF _oGroup1 PIXEL WHEN .F.
	
	//-------------------------------------------------------
	//Cabeçalho do Segundo Grupo Parte de Inferior
	//-------------------------------------------------------
	_oSay1:= tSay():New(31,200,{||"Conselho Fiscal"},_oDlg1,,_oFont1,,,,.T.,CLR_RED,CLR_WHITE,100,20)
	
	_oGroup1:= tGroup():New(40,170,170,310,"",_oDlg1,,,.T.)
	
	_oSay1:= tSay():New(049,176,{||"Total"			},_oDlg1,,_oFont1,,,,.T.,CLR_RED,CLR_WHITE,100,20)
	@ 049,220 MSGET _oTotFs VAR IIF(_nRadio1 != 1,_nTotFs := 100,_nTotFs := 0) Picture "@E 999,999,999" SIZE 70,10 OF _oGroup1 PIXEL WHEN _nRadio1 = 1
	
	_oSay1:= tSay():New(069,176,{||"CH 1 SIM"		},_oDlg1,,_oFont1,,,,.T.,CLR_RED,CLR_WHITE,100,20)
	@ 069,220 MSGET _oCh1Fs VAR _nCh1Fs Picture "@E 999,999,999" SIZE 70,10 OF _oGroup1 PIXEL Valid (_nTDiFs := _nCh1Fs + _nCh2Fs + _nBrnFs + _nNulFs)
		
	_oSay1:= tSay():New(089,176,{||"CH 1 NAO"		},_oDlg1,,_oFont1,,,,.T.,CLR_RED,CLR_WHITE,100,20)
	@ 089,220 MSGET _oCh2Fs VAR _nCh2Fs Picture "@E 999,999,999" SIZE 70,10 OF _oGroup1 PIXEL Valid (_nTDiFs := _nCh1Fs + _nCh2Fs + _nBrnFs + _nNulFs) //WHEN .F.
	
	_oSay1:= tSay():New(109,176,{||"Branco"		},_oDlg1,,_oFont1,,,,.T.,CLR_RED,CLR_WHITE,100,20)
	@ 109,220 MSGET _oBrnFs VAR _nBrnFs Picture "@E 999,999,999" SIZE 70,10 OF _oGroup1 PIXEL Valid (_nTDiFs := _nCh1Fs + _nCh2Fs + _nBrnFs + _nNulFs)
	
	_oSay1:= tSay():New(129,176,{||"Nulo"			},_oDlg1,,_oFont1,,,,.T.,CLR_RED,CLR_WHITE,100,20)
	@ 129,220 MSGET _oNulFs VAR _nNulFs Picture "@E 999,999,999" SIZE 70,10 OF _oGroup1 PIXEL Valid (_nTDiFs := _nCh1Fs + _nCh2Fs + _nBrnFs + _nNulFs)
	
	_oSay1:= tSay():New(149,176,{||"Total Dig"	},_oDlg1,,_oFont1,,,,.T.,CLR_RED,CLR_WHITE,100,20)
	@ 149,220 MSGET _oTDiFs VAR _nTDiFs Picture "@E 999,999,999" SIZE 70,10  OF _oGroup1 PIXEL WHEN .F.
	
	//-------------------------------------------------------
	//Cabeçalho do Rodape
	//-------------------------------------------------------
	_oSay1:= tSay():New(175,10,{||"Escrutinador"	},_oDlg1,,_oFont1,,,,.T.,CLR_RED,CLR_WHITE,100,20)
	
	_oCombo:= tComboBox():New(185,10,{|u|if(PCount()>0,_cCombo:=u,_cCombo)},_aItems,302,20,_oDlg1,,,,,,.T.,,,,,,,,,'_cCombo')
	
	_oBtn1 := TButton():New(205,10,"Confirmar",_oDlg1,{||u_CABA340G()},040,012,,,,.T.,,"",,,,.F. )
	_oBtn2 := TButton():New(205,60,"Fechar"	,_oDlg1,{||_oDlg1:End()},040,012,,,,.T.,,"",,,,.F. )
	
	ACTIVATE MSDIALOG _oDlg1 CENTERED
	
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA340F  ºAutor  ³Angelo Henrique     º Data ³  05/10/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina responsável por trazer o número do lote correto      º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABA340F()
	
	Local _aArea	:= GetArea()
	Local _aArea1	:= GetNextAlias()
	Local _cNmLt	:= ""
	Local _cQuery	:= ""
	
	Private _cMvAno	:= GetMv("MV_XANOEL")
	
	_cQuery := " SELECT COUNT(ZRU_NUMLOT) TOTAL "
	_cQuery += " FROM " +RetSqlName("ZRU") + " ZRU "
	_cQuery += " WHERE ZRU_FILIAL = '" + xFilial("ZRU") + "' "
	_cQuery += " AND ZRU_ANOELE = '" + _cMvAno + "' "
	
	If Select(_aArea1) > 0
		(_aArea1)->(DbCloseArea())
	Endif
	
	DbUseArea(.T., 'TOPCONN', TCGenQry(,,_cQuery), _aArea1, .F., .T.)
	
	If !(_aArea1)->(Eof())
		
		_cNmLt := SOMA1(STRZERO((_aArea1)->TOTAL,8/*TAMSX3("ZRU_NUMLOT")[1]*/))
		
	EndIf
	
	If Select(_aArea1) > 0
		(_aArea1)->(DbCloseArea())
	Endif
	
Return _cNmLt

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA340G  ºAutor  ³Angelo Henrique     º Data ³  19/10/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina responsável por gravar as informações na tabela.     º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABA340G
	
	Local _aArea 	:= GetArea()
	Local _aArZRU	:= ZRU->(GetArea())
	
	RecLock("ZRU", .T.)
	
	ZRU->ZRU_FILIAL := xFilial("ZRU")
	ZRU->ZRU_NUMLOT := _cNmLot
	ZRU->ZRU_TPLOTE := CVALTOCHAR(_nRadio1)
	ZRU->ZRU_TOTDEL := _nTotDl
	ZRU->ZRU_CP1DEL := _nCh1Dl
	ZRU->ZRU_CP2DEL := _nCh2Dl
	ZRU->ZRU_BRCDEL := _nBrnDl
	ZRU->ZRU_NULDEL := _nNulDl
	ZRU->ZRU_TDGDEL := _nTDiDl
	ZRU->ZRU_TOTFIS := _nTotFs
	ZRU->ZRU_CP1FIS := _nCh1Fs
	ZRU->ZRU_CP2FIS := _nCh2Fs
	ZRU->ZRU_BRCFIS := _nBrnFs
	ZRU->ZRU_NULFIS := _nNulFs
	ZRU->ZRU_TDGFIS := _nTDiFs
	ZRU->ZRU_ANOELE := CVALTOCHAR(YEAR(dDataBase))
	ZRU->ZRU_ESCRUT := _cCombo
	
	ZRU->(MsUnLock())
	
	//------------------------------------------
	//Zerando as varíaveis editáveis da tela
	//------------------------------------------
	_nTotDl	:= 0
	_nCh1Dl	:= 0
	_nCh2Dl	:= 0
	_nBrnDl	:= 0
	_nNulDl	:= 0
	_nTDiDl	:= 0
	_nTotFs	:= 0
	_nCh1Fs	:= 0
	_nCh2Fs	:= 0
	_nBrnFs	:= 0
	_nNulFs	:= 0
	_nTDiFs	:= 0
	
	//---------------------
	//Atualizando Tela
	//---------------------
	_oDlg1:Refresh()
	
	RestArea(_aArZRU)
	RestArea(_aArea)
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA340H  ºAutor  ³Angelo Henrique     º Data ³  20/10/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina responsável por exibir o painel eletronico dos votos º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABA340H
	
	Local aSize		:= MsAdvSize()
	
	
	DEFINE DIALOG oDlg TITLE "Painel" FROM aSize[7],0 To aSize[6],aSize[5] PIXEL
	
	oTIBrowser := TIBrowser():New(0,0,aSize[3],aSize[5]/3.0, 'http://www.caberj.com.br/votacoes/eleicao/',oDlg ) //contvotos.asp
	
	TButton():New((aSize[6]/2.10),aSize[3] - 130, "Imprimir", oDlg,;
		{|| oTIBrowser:Print() },50,010,,,.F.,.T.,.F.,,.F.,,,.F. )
	
	TButton():New((aSize[6]/2.10),aSize[3] - 70, "Voltar", oDlg,;
		{|| oDlg:End()},50,010,,,.F.,.T.,.F.,,.F.,,,.F. )
	
	ACTIVATE DIALOG oDlg CENTERED
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABA340I  ºAutor  ³Angelo Henrique     º Data ³  26/04/16   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina responsável por exibir a tela de aprovação de contas º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABA340I
	
	Local _aArea := GetArea()
	Local _oBtn1	:= Nil
	Local _oBtn2	:= Nil
	
	//------------------------------------
	//Variáveis estaticas da tela
	//------------------------------------
	Private _oDlg1	:= Nil
	Private _oBtn1	:= Nil
	Private _oSay1	:= Nil
	Private _oGroup1 	:= Nil
	Private _oFont1	:= TFont():New("Times New Roman",,-18,.T.)
	Private _nRadio1 	:= 1
	Private _oRadio1	:= Nil
	
	//------------------------------------
	//Variaveris de valores
	//------------------------------------
	Private _cNmLot	:= ""
	Private _nTotDl	:= 0
	Private _nCh1Dl	:= 0
	Private _nCh2Dl	:= 0
	Private _nBrnDl	:= 0
	Private _nNulDl	:= 0
	Private _nTDiDl	:= 0
	Private _nTotFs	:= 0
	Private _nCh1Fs	:= 0
	Private _nCh2Fs	:= 0
	Private _nBrnFs	:= 0
	Private _nNulFs	:= 0
	Private _nTDiFs	:= 0
	
	//------------------------------------
	//Objetos dos valores
	//------------------------------------
	Private _oTotDl	:= Nil
	Private _oCh1Dl	:= Nil
	Private _oCh2Dl	:= Nil
	Private _oBrnDl	:= Nil
	Private _oNulDl	:= Nil
	Private _oTDiDl	:= Nil
	Private _oTotFs	:= Nil
	Private _oCh1Fs	:= Nil
	Private _oCh2Fs	:= Nil
	Private _oBrnFs	:= Nil
	Private _oNulFs	:= Nil
	Private _oTDiFs	:= Nil
	
	//------------------------------------
	//Variaveis para o Combo
	//------------------------------------
	Private _aItems	:= {'','ALBINO SANTOS RAMOS DE SOUSA','ANGELINA ELVIRA GRECO PEREIRA','DOUGLAS AUGUSTO GOMES MACEDO'}
	Private _cCombo	:= _aItems[1]
	Private _oCombo	:= Nil
	
	DEFINE MSDIALOG _oDlg1 FROM 0,0 TO 450,650 PIXEL TITLE "Aprovação de Contas"
	
	//-------------------------------------------------------
	//Cabeçalho do primeiro Grupo Parte Superior
	//-------------------------------------------------------
	_oGroup1:= tGroup():New(05,10,30,150,"Lote",_oDlg1,,,.T.)
	
	_oSay1:= tSay():New(10,30,{||"Nº do Lote: "	},_oDlg1,,_oFont1,,,,.T.,CLR_RED,CLR_WHITE,100,20)
	_oSay1:= tSay():New(10,80,{||_cNmLot := U_CABA340F()		},_oDlg1,,_oFont1,,,,.T.,CLR_RED,CLR_WHITE,100,20)
	
	//-------------------------------------------------------
	//Cabeçalho do Segundo Grupo Parte Superior
	//-------------------------------------------------------
	_oGroup1:= tGroup():New(05,170,30,310,"Tipo de Lote",_oDlg1,,,.T.)
	
	_oRadio1 := TRadMenu():New(11,180,{"Aberto","Fechado"},,_oDlg1,,,,,,,,35,200,,,,.T.)
	
	// Seta Eventos
	_oRadio1:bSetGet 		:= {|u|IIF(PCount()== 0, _nRadio1, _nRadio1 := u)}
	
	//-------------------------------------------------------
	//Cabeçalho do Primeiro Grupo Parte de Inferior
	//-------------------------------------------------------
	_oSay1:= tSay():New(31,30,{||"Tipo de Voto"},_oDlg1,,_oFont1,,,,.T.,CLR_RED,CLR_WHITE,100,20)
	
	_oGroup1:= tGroup():New(40,10,170,150,"",_oDlg1,,,.T.)
	
	_oSay1:= tSay():New(049,16,{||"Total"		},_oDlg1,,_oFont1,,,,.T.,CLR_RED,CLR_WHITE,100,20)
	@ 049,60 MSGET _oTotDl VAR IIF(_nRadio1 != 1,_nTotDl := 100,_nTotDl := 0) Picture "@E 999,999,999" SIZE 70,10 OF _oGroup1 PIXEL WHEN _nRadio1 = 1
	
	//----------------------------------------------------------------------
	//Como no processo de aprovação de contas só possui um conselho
	//foi aproveitado um campo do conselho fiscal para a opção de 
	//Não, logo não houve alteração na estrutura da tabela
	//A opção SIM foi utilizado o campo de CHAPA1
	//----------------------------------------------------------------------
	_oSay1:= tSay():New(069,16,{||"SIM"	},_oDlg1,,_oFont1,,,,.T.,CLR_RED,CLR_WHITE,100,20)
	@ 069,60 MSGET _oCh1Dl VAR _nCh1Dl Picture "@E 999,999,999" SIZE 70,10 OF _oGroup1 PIXEL Valid (_nTDiDl := _nCh1Dl + _nCh1Fs + _nBrnDl + _nNulDl)
	
	_oSay1:= tSay():New(089,16,{||"NAO"	},_oDlg1,,_oFont1,,,,.T.,CLR_RED,CLR_WHITE,100,20)
	@ 089,60 MSGET _oCh1Fs VAR _nCh1Fs Picture "@E 999,999,999" SIZE 70,10 OF _oGroup1 PIXEL Valid (_nTDiDl := _nCh1Dl + _nCh1Fs + _nBrnDl + _nNulDl)
	
	//-------------------------------------
	//No ano de 2015 não houve chapa 2
	//-------------------------------------
	//	_oSay1:= tSay():New(089,16,{||"Chapa 2"	},_oDlg1,,_oFont1,,,,.T.,CLR_RED,CLR_WHITE,100,20)
	//	@ 089,60 MSGET _oCh2Dl VAR _nCh2Dl Picture "@E 999,999,999" SIZE 70,10 OF _oGroup1 PIXEL Valid (_nTDiDl := _nCh1Dl + _nCh2Dl + _nBrnDl + _nNulDl) WHEN .F.
	
	_oSay1:= tSay():New(109,16,{||"Branco"		},_oDlg1,,_oFont1,,,,.T.,CLR_RED,CLR_WHITE,100,20)
	@ 109,60 MSGET _oBrnDl VAR _nBrnDl Picture "@E 999,999,999" SIZE 70,10 OF _oGroup1 PIXEL Valid (_nTDiDl := _nCh1Dl + _nCh1Fs + _nBrnDl + _nNulDl)
	
	_oSay1:= tSay():New(129,16,{||"Nulo"		},_oDlg1,,_oFont1,,,,.T.,CLR_RED,CLR_WHITE,100,20)
	@ 129,60 MSGET _oNulDl VAR _nNulDl Picture "@E 999,999,999" SIZE 70,10 OF _oGroup1 PIXEL Valid (_nTDiDl := _nCh1Dl + _nCh1Fs + _nBrnDl + _nNulDl)
	
	_oSay1:= tSay():New(149,16,{||"Total Dig"	},_oDlg1,,_oFont1,,,,.T.,CLR_RED,CLR_WHITE,100,20)
	@ 149,60 MSGET _oTDiDl VAR _nTDiDl Picture "@E 999,999,999" SIZE 70,10 OF _oGroup1 PIXEL WHEN .F.
		
	//-------------------------------------------------------
	//Cabeçalho do Rodape
	//-------------------------------------------------------
	_oSay1:= tSay():New(175,10,{||"Escrutinador"	},_oDlg1,,_oFont1,,,,.T.,CLR_RED,CLR_WHITE,100,20)
	
	_oCombo:= tComboBox():New(185,10,{|u|if(PCount()>0,_cCombo:=u,_cCombo)},_aItems,302,20,_oDlg1,,,,,,.T.,,,,,,,,,'_cCombo')
	
	_oBtn1 := TButton():New(205,10,"Confirmar",_oDlg1,{||u_CABA340G()},040,012,,,,.T.,,"",,,,.F. )
	_oBtn2 := TButton():New(205,60,"Fechar"	,_oDlg1,{||_oDlg1:End()},040,012,,,,.T.,,"",,,,.F. )
	
	ACTIVATE MSDIALOG _oDlg1 CENTERED
	
Return
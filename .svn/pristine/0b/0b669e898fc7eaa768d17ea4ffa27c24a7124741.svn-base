#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'PARMTYPE.CH'
#INCLUDE 'APWEBSRV.CH'
#INCLUDE 'TBICONN.CH'
#INCLUDE 'TOPCONN.CH'
#INCLUDE 'RWMAKE.CH'
#INCLUDE 'AP5MAIL.CH'
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ CABV056B ºAutor  ³SERGIO CUNHA    	 º Data ³  24/07/2019 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ALERTA DE CARENCIA NA LIBERAÇÃO DA SOLICITAÇÃO DE INTERNCAO º±±
±±º          ³ E SADT                                                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³CABERJ                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABV056(_cChvBenef)

	Local _aArea 		:= GetArea()
	Local _aArBA1 		:= BA1->(GetArea())
	Local _nCont 		:= 0
	Local _lBlq			:= .F.
	Local _cProtoc		:= ""
	Local _cMsg			:= ""
	Local _lRetorno 	:= .F. //Validacao da dialog criada oDlg
	Local _nOpca 		:= 0 //Opcao da confirmacao
	Local bCancel 		:= {|| _nOpca:=0,oDlg:End() } //botao de cancelamento
	Local _cArqEmp 		:= "" //Arquivo temporario com as empresas a serem escolhidas
	Local _cAlias 		:= GetNextAlias()
	Local _nt 			:= 0
	Local lRet			:= .F.
	local _matricula	:= _cChvBenef
	Local bOk 		    := {|| _nOpca:=1,oDlg:End() } //botao de cancelamento
	
	Local cOpera		:= 0
	Local cCodemp		:= 0
	Local cMatric		:= 0
	Local cTipReg		:= 0
	Local cDigito		:= 0
	Local cDatcar		:= 0
	Local cNomUsu		:= 0
	
		
	Private lInverte 	:= .F. //Variaveis para o MsSelect
	Private cMarca 		:= GetMark() //Variaveis para o MsSelect
	Private oBrwTrb 	:= Nil //objeto do msselect
	Private oDlg 		:= Nil //objeto do msselect
	Private _cAliTmp	:= GetNextAlias()
	Private _aStruTrb 	:= {} //estrutura do temporario
	Private _aBrowse	:= {} //array do browse para demonstracao das empresas
	Private _aEmpMigr 	:= {} //array de retorno com as empresas escolhidas

	//----------------------------------------------------------------------
	//Colocar o MsSelect para selecionar os beneficiários que serão 
	//bloqueados e terão o protocolo gerado.
	//Quando for titular a familia inteira será bloqueada e um único 
	//protocolo será gerado.
	//----------------------------------------------------------------------

	if alltrim(FUNNAME()) == "PLSA092"

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define campos do TRB ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

		aadd(_aStruTrb,{"DESCRICAO" ,"C",37,0})
	
		aadd(_aStruTrb,{"MATRICULA" ,"C",16,0})

		aadd(_aStruTrb,{"CARENCIA" 	,"N",3,0})

		aadd(_aStruTrb,{"CAREN_ATE" ,"D",8,0})

		aadd(_aStruTrb,{"SITUACAO" 	,"C",20,0})

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define campos do MsSelect ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

		aadd(_aBrowse,{"DESCRICAO"	,,"Descrição" 			})

		aadd(_aBrowse,{"CARENCIA"		,,"Carência" 	})

		aadd(_aBrowse,{"CAREN_ATE" 	,,"Carência até" 	})

		aadd(_aBrowse,{"SITUACAO"		,,"Situação" 				})

		If Select(_cAliTmp) > 0

			_cAliTmp->(DbCloseArea())

		Endif

		_cArqEmp := CriaTrab(_aStruTrb)

		dbUseArea(.T.,__LocalDriver,_cArqEmp,_cAliTmp)

		cQuery := " SELECT * FROM (    "
		cQuery += "SELECT NOMEGRUPO DESCRICAO,"
		cQuery += "OPER||'.'|| EMPRESA||'.'|| MATRIC||'-'|| TIPREG MATRICULA,"
		cQuery +=  "QTDCAR CARENCIA,"
		cQuery +=  "(TO_DATE(TRIM(DATCAR),'YYYYMMDD') + DECODE(UNCAR,'1',QTDCAR/24,QTDCAR)) CAREN_ATE,"
		cQuery +=  "(CASE WHEN TO_DATE(TRIM(DATCAR),'YYYYMMDD') + DECODE(UNCAR,'1',QTDCAR/24,QTDCAR) > SYSDATE THEN 'EM CARENCIA'"
		cQuery +=  " ELSE 'CARENCIA CUMPRIDA' END) SITUACAO"
		If cEmpAnt == '01'
			cQuery +=  " FROM V_CARENCIA_CABERJ_NV V1"
		else
			cQuery +=  "  FROM   V_CARENCIA_INTEGRAL_NV V1"
		endIf
		cQuery +=  "  WHERE  OPER 	  = '"+Subs(_matricula,1,4) + "'
		cQuery +=  "  AND    EMPRESA = '"+Subs(_matricula,5,4)+ "'
		cQuery +=  "  AND    MATRIC  = '"+Subs(_matricula,9,6)+ "'
		cQuery +=  "  AND    TIPREG  = '"+Subs(_matricula,15,2)+ "'
		cQuery +=  "  AND    PLANO NOT in ('0088','0090','0091','0092')"
		cQuery +=  "  AND    (SEXO_BAT = '3' OR SEXO_BAT = SEXO_USU) "
		cQuery +=  "  AND     NIVEL = (SELECT MAX(NIVEL) "
		If cEmpAnt =='01'
			cQuery +=  "FROM   V_CARENCIA_CABERJ_NV V2"
		else
			cQuery +=  "FROM   V_CARENCIA_INTEGRAL_NV V2"
		endIf
		cQuery +=  "                   WHERE  V2.EMPRESA = V1.EMPRESA "
		cQuery +=  "                   AND    V2.MATRIC = V1.MATRIC  "
		cQuery +=  "                   AND    V2.TIPREG = V1.TIPREG "
		cQuery +=  "                   AND    V2.CODGRUPO = V1.CODGRUPO)"
 
		cQuery +=  ")WHERE SITUACAO = 'EM CARENCIA'"
		cQuery += "  ORDER BY 3 DESC,1 "

		TCQuery cQuery new Alias (_cAlias)
		if (_cAlias)->(Eof())
			lRet := .F.
		else
			lRet := .T.
			While (_cAlias)->(!Eof())
	
				_nt ++
	
				IncProc("Analisando carência do beneficiário: " + AllTrim(Transform(_nt,"@E 9999999")))
			
				RecLock(_cAliTmp,.T.)
	
				(_cAliTmp)->DESCRICAO 	:= (_cAlias)->DESCRICAO
			
				(_cAliTmp)->CARENCIA 	:= (_cAlias)->CARENCIA
	
				(_cAliTmp)->MATRICULA 	:= (_cAlias)->MATRICULA
	
				(_cAliTmp)->CAREN_ATE 	:=  (_cAlias)->CAREN_ATE
	
				(_cAliTmp)->SITUACAO 	:= (_cAlias)->SITUACAO
	
				MsUnlock()
	
				(_cAlias)->(DbSkip())
	
			Enddo
	
			(_cAlias)->(DbCloseArea())
	
			DbSelectArea("BA1")
			DbSetOrder(2)
			If DbSeek(xFilial("BA1") + _matricula)
				cOpera		:= BA1->BA1_CODINT
				cCodemp		:= BA1->BA1_CODEMP
				cMatric		:= BA1->BA1_MATRIC
				cTipReg		:= BA1->BA1_TIPREG
				cDigito		:= BA1->BA1_DIGITO
				cNomUsu		:= BA1->BA1_NOMUSR
				cDatcar		:= BA1->BA1_DATCAR
			EndIf
			RestArea(_aArBA1)
	
			@ 001,001 TO 250,600 DIALOG oDlg TITLE OemToAnsi("Carência beneficiário "+cOpera+"."+cCodemp+"."+cMatric+"."+cTipReg+"-"+cDigito)
	
			@ 003,005 SAY OemToAnsi("Matricula: "+cOpera+"."+cCodemp+"."+cMatric+"."+cTipReg+"-"+cDigito)
			@ 013,005 SAY OemToAnsi("Beneficiário(a): "+cNomUsu)
			@ 022,005 SAY OemToAnsi("Gerado em: "+dtoc(dDataBase))
	
			oBrwTrb := MsSelect():New(_cAliTmp,"OK","",_aBrowse,@lInverte,@cMarca,{031,005,200,300})
	//	oBrwTrb:bMark := {|| Disp()}
	
			Eval(oBrwTrb:oBrowse:bGoTop)
	
			oBrwTrb:oBrowse:Refresh()
	
			Activate MsDialog  oDlg //On Init (EnchoiceBar(oDlg,bOk,bCancel,,)) Centered VALID _lRetorno
	
			(_cAliTmp)->(DbGotop())
	
		
		endIf
	
	endIf
	RestArea(_aArea)

Return .T.

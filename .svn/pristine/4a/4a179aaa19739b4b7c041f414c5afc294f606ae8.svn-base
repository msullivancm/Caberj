#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'TOPCONN.CH'
#INCLUDE 'UTILIDADES.CH'

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³DESBGUIA  ºAutor  ³Leonardo Portella   º Data ³  18/01/13   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Desbloqueia guia que tenha lote de bloqueio (BD7_LOTBLO)    º±±
±±º          ³preenchido. Solicita confirmacao com usuario.               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³CABERJ                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function DESBGUIA  

Local lContinua 	:= .T.

Private c_UsrLog	:= RetCodUsr()

While lContinua
	lContinua := PDESBGUIA()
EndDo

Return

*************************************************************************************

Static Function PDESBGUIA

Local lConf 		:= .F. 
Local a_DadBloq		:= {}
Local cMsg			:= ''
Local nI			:= 0 
Local nJ			:= 0
Local nK			:= 0

Private cCodOpe 	:= Space(4)
Private cCodPEG 	:= Space(8)
Private cCodLDP    	:= Space(4)
Private cNumGuia   	:= Space(8)
Private c_Senha   	:= Space(TamSx3('BE4_SENHA')[1])  
Private cRDA   		:= " "
Private bDisableGet	:= {||;
						If(!empty(cCodOpe) .or. !empty(cCodLDP) .or. !empty(cCodPEG) .or.  !empty(cNumGuia),oGet5:Disable(),oGet5:Enable()),;
						If(!empty(c_Senha),(oGet1:Disable(),oGet2:Disable(),oGet3:Disable(),oGet4:Disable()),(oGet1:Enable(),oGet2:Enable(),oGet3:Enable(),oGet4:Enable())),;
						}		

SetPrvt("oDlg1","oGrp1","oSay3","oSay2","oSay1","oGet3","oGet2","oGet1","oSBtn1","oSBtn2")

oDlg1      		:= MSDialog():New( 095,232,397,558,"Desbloqueio de Guias",,,.F.,,,,,,.T.,,,.T. )

	oGrp1      	:= TGroup():New( 008,004,104,156,"Desbloqueio de Guias",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )

	oSay1      	:= TSay():New( 020,008,{||"Operadora"}				,oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,052,008)
	oSay2      	:= TSay():New( 032,008,{||"Local de Digitação"}	,oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,052,008)
	oSay3      	:= TSay():New( 044,008,{||"PEG"}					,oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
	oSay4      	:= TSay():New( 056,008,{||"Número da Guia"}		,oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,048,008)
	oSay5      	:= TSay():New( 076,008,{||"Senha"}	   				,oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,048,008)

	oGet1      	:= TGet():New( 020,056,{|u| If(PCount()>0,(cCodOpe:=If(empty(u),Space(4),StrZero(Val(u),4)),oGet1:Refresh(),Eval(bDisableGet)),cCodOpe)}			,oGrp1,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cCodOpe",,)
	oGet2      	:= TGet():New( 032,056,{|u| If(PCount()>0,(cCodLDP:=If(empty(u),Space(4),StrZero(Val(u),4)),oGet2:Refresh(),Eval(bDisableGet)),cCodLDP)}			,oGrp1,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cCodLDP",,)
	oGet3      	:= TGet():New( 044,056,{|u| If(PCount()>0,(cCodPEG:=If(empty(u),Space(8),StrZero(Val(u),8)),oGet3:Refresh(),Eval(bDisableGet)),cCodPEG)} 	   		,oGrp1,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cCodPEG",,)
	oGet4      	:= TGet():New( 056,056,{|u| If(PCount()>0,(cNumGuia:=If(empty(u),Space(8),StrZero(Val(u),8)),oGet4:Refresh(),Eval(bDisableGet)),cNumGuia)}			,oGrp1,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cNumGuia",,)
   	oGet5      	:= TGet():New( 076,056,{|u| If(PCount()>0,(c_Senha:=If(empty(u),Space(TamSx3('BE4_SENHA')[1]),u),oGet5:Refresh(),Eval(bDisableGet)),c_Senha)}	  	,oGrp1,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","c_Senha",,)

	oSBtn1     	:= SButton():New( 120,100,1,{||lConf := .T.,oDlg1:End()},oDlg1,,"", )
	oSBtn2     	:= SButton():New( 120,128,2,{||lConf := .F.,oDlg1:End()},oDlg1,,"", )

oDlg1:Activate(,,,.T.)

If lConf
	a_DadBloq := DadosBloq()
	
	If !empty(a_DadBloq)      
	
		aSort(a_DadBloq,,,{|x,y| x[1] <  y[1]})
		
		cMsg := ' - Empresa [ ' + AllTrim(SM0->M0_NOMECOM) + ' ]' 				+ CRLF 
		cMsg += ' - Filial [ ' + xFilial('BD7') + ' ]' 							+ CRLF 
		cMsg += ' - Operadora [ ' + cCodOpe + ' ]' 								+ CRLF
		cMsg += ' - Local de Digitação [ ' + cCodLDP + ' ]' 					+ CRLF
		cMsg += ' - PEG [ ' + cCodPEG + ' ]' 									+ CRLF
		cMsg += ' - Guia [ ' + cNumGuia + ' ]' 									+ CRLF 
		cMsg += ' - Senha [ ' + c_Senha + ' ]' 									+ CRLF
		cMsg += ' - RDA [ ' + cRDA + ' ]' 										+ CRLF
		cMsg += CRLF

		For nI := 1 to len(a_DadBloq)
		
			cMsg += '- Lote de Bloqueio [ ' + a_DadBloq[nI,1] + ' ]'								   						+ CRLF
			cMsg += 'Valor bloqueado na guia por lote [ ' + AllTrim(Transform(a_DadBloq[nI,2],'@E 999,999,999.99')) + ' ]'	+ CRLF
			cMsg += CRLF
			
		Next
		
		LogErros(cMsg,'Guias Bloqueadas por Lote de Bloqueio')
		
		If MsgYesNo('Confirma o desbloqueio da guia e lote(s)?' + CRLF + 'Este procedimento será gravado!',AllTrim(SM0->M0_NOMECOM))
			If c_UsrLog $ (GetMV('MV_XGETIN') + GetMV('MV_XGERIN'))
				Desbloqueia(a_DadBloq)		
			Else
				MsgStop('Usuário sem acesso a esta desbloqueio de guia!',AllTrim(SM0->M0_NOMECOM))			
			EndIf
		ElseIf c_UsrLog $ (GetMV('MV_XGETIN') + GetMV('MV_XGERIN'))
			cMsg := ''
			For nJ := 1 to len(a_DadBloq)
				For nK := 1 to len(a_DadBloq[nJ,3])
					cMsg += cValToChar(a_DadBloq[nJ,3,nK]) + ','
				Next
			Next

			cMsg := Left(cMsg,len(cMsg) - 1)
			LogErros(cMsg,'RECNOS BD7 para análise - Somente GETIN - GERIN')
		EndIf
	Else

		cMsg := 'Não foram encontrados dados de bloqueio na guia informada com os parâmetros abaixo:' + CRLF
		cMsg += CRLF
		cMsg += ' - Empresa [ ' + AllTrim(SM0->M0_NOMECOM) + ' ]' 				+ CRLF 
		cMsg += ' - Filial [ ' + xFilial('BD7') + ' ]' 							+ CRLF 
		cMsg += ' - Operadora [ ' + cCodOpe + ' ]' 								+ CRLF
		cMsg += ' - Local de Digitação [ ' + cCodLDP + ' ]' 					+ CRLF
		cMsg += ' - PEG [ ' + cCodPEG + ' ]' 									+ CRLF
		cMsg += ' - Guia [ ' + cNumGuia + ' ]' 									+ CRLF
		cMsg += ' - Senha [ ' + c_Senha + ' ]' 									+ CRLF
		cMsg += ' - RDA [ ' + cRDA + ' ]' 										+ CRLF
			
		MsgInfo(cMsg,AllTrim(SM0->M0_NOMECOM))
		
	EndIf
	
EndIf

Return lConf

*******************************************************************************************************************

Static Function DadosBloq
         
Local cChaveGuia 	:= ""
Local a_DadBloq		:= {}
Local nPosLot		:= 0
Local cQry			:= ""
Local cAlias		:= GetNextAlias()
Local lContinua		:= .T.

If !empty(c_Senha)
	
	c_Senha := AllTrim(c_Senha)
	
	cQry += "SELECT BD5_CODOPE,BD5_CODLDP,BD5_CODPEG,BD5_NUMERO" 	+ CRLF
	cQry += "FROM " + RetSqlName('BD5') 							+ CRLF
	cQry += "WHERE BD5_FILIAL = '" + xFilial('BD5') + "'" 			+ CRLF
	cQry += "  AND BD5_SENHA = '" + c_Senha + "'" 					+ CRLF
	cQry += "  AND D_E_L_E_T_ = ' '" 								+ CRLF 
	
	TcQuery cQry New Alias cAlias
	
	If !cAlias->(EOF())
		cCodOpe 	:= cAlias->BD5_CODOPE
		cCodLDP		:= cAlias->BD5_CODLDP
		cCodPEG		:= cAlias->BD5_CODPEG
		cNumGuia	:= cAlias->BD5_NUMERO
	Else
		cAlias->(DbCloseArea())
		cAlias	:= GetNextAlias()
		
		cQry := "SELECT BE4_CODOPE,BE4_CODLDP,BE4_CODPEG,BE4_NUMERO" 	+ CRLF
		cQry += "FROM " + RetSqlName('BE4') 							+ CRLF
		cQry += "WHERE BE4_FILIAL = '" + xFilial('BE4') + "'" 			+ CRLF 
		cQry += "  AND BE4_SENHA = '" + c_Senha + "'" 					+ CRLF
		cQry += "  AND D_E_L_E_T_ = ' ' " 								+ CRLF
		
		TcQuery cQry New Alias cAlias

		If !cAlias->(EOF())
			cCodOpe 	:= cAlias->BE4_CODOPE
			cCodLDP		:= cAlias->BE4_CODLDP
			cCodPEG		:= cAlias->BE4_CODPEG
			cNumGuia	:= cAlias->BE4_NUMERO
		Else
			lContinua	:= .F.
		EndIf
		
	EndIf
	
	cAlias->(DbCloseArea())
	
EndIf

cChaveGuia 	:= xFilial('BD7') + cCodOpe + cCodLDP + cCodPEG + cNumGuia

BD7->(DbSetOrder(1))

If lContinua .and. BD7->(MsSeek(cChaveGuia))
    
	cRDA := BD7->BD7_CODRDA + ' - ' + AllTrim(BD7->BD7_NOMRDA)
	
	While !BD7->(EOF()) .and. ( BD7->(BD7_FILIAL + BD7_CODOPE + BD7_CODLDP + BD7_CODPEG + BD7_NUMERO) == cChaveGuia )
	
		If !empty(BD7->BD7_LOTBLO) .and. ( BD7->BD7_SITUAC == '1' ) .and. ( BD7->BD7_FASE == '3' )// .and. ( ( BD7->BD7_CONPAG == '1' ) .or. empty(BD7->BD7_CONPAG) )
			
			If ( nPosLot := aScan(a_DadBloq,{|x|x[1] == BD7->BD7_LOTBLO}) ) <= 0 
				aAdd(a_DadBloq,{BD7->BD7_LOTBLO,0,{}})
				nPosLot := Len(a_DadBloq)
			EndIf
			
			a_DadBloq[nPosLot,2] += If(BD7->BD7_BLOPAG == '1',BD7->BD7_VLRPAG,BD7->(BD7_VLRPAG + BD7_VLRGLO - BD7_VGLANT))
			aAdd(a_DadBloq[nPosLot,3],BD7->(Recno())) 
			
		EndIf
		
		BD7->(DbSkip())
	
	EndDo

EndIf

Return a_DadBloq

*******************************************************************************************************************   

Static Function Desbloqueia(a_DadBloq)

Local nJ		:= 0
Local nK		:= 0 
Local cValorOri	:= ""
Local cUpd		:= ""
Local nLiberado	:= 0 
Local lContinua	:= .T.  
Local cLotBlo	:= ''
Local nTotLib	:= 0

BeginTran()

For nJ := 1 to len(a_DadBloq)

	For nK := 1 to len(a_DadBloq[nJ,3])

		BD7->(DbGoTo(a_DadBloq[nJ,3,nK]))

        nLiberado 	:= If(BD7->BD7_BLOPAG == '1',BD7->BD7_VLRPAG,BD7->(BD7_VLRPAG + BD7_VLRGLO - BD7_VGLANT))
	    
		BD7->(Reclock('BD7',.F.))
		
		If BD7->BD7_BLOPAG <> '1'
			cValorOri := 'BD7_VLRPAG = ' + AllTrim(StrTran(Transform(BD7->BD7_VLRPAG,'@E 999999999.99'),',','.')) + ';'
			cValorOri += 'BD7_VLRGLO = ' + AllTrim(StrTran(Transform(BD7->BD7_VLRGLO,'@E 999999999.99'),',','.')) + ';'
			
			BD7->BD7_VLRPAG := BD7->(BD7_VLRPAG + BD7_VLRGLO - BD7_VGLANT)
			BD7->BD7_VLRGLO	:= BD7->BD7_VGLANT
		Else
			cValorOri := 'BD7_BLOPAG = "' + BD7->BD7_BLOPAG + '";'
			
			BD7->BD7_BLOPAG := '0'		
		EndIf  
		
		cValorOri 	+= 'BD7_LOTBLO = "' + BD7->BD7_LOTBLO + '"'
		cLotBlo		:= BD7->BD7_LOTBLO  
		
		BD7->BD7_LOTBLO := ' '

	    BD7->(MsUnlock())
	    
	    //BIANCHINI - 21/08/2019 - Se Desbloqueio Pagamento, desbloqueio Cobrança
		u_BLOCPABD6(BD7->(BD7_CODOPE+BD7_CODLDP+BD7_CODPEG+BD7_NUMERO+BD7_ORIMOV+BD7_SEQUEN),BD7->BD7_MOTBLO,BD7->BD7_DESBLO, .F.,.F.)
        
		nTotLib += nLiberado
		
	    cUpd := "INSERT INTO DESBLOQUEIO_GUIAS VALUES((SELECT NVL(MAX(ID),0) + 1 FROM DESBLOQUEIO_GUIAS),"
	    cUpd += "'" + cLotBlo + "',"
	    cUpd += cValToChar(BD7->(Recno())) + ","
	    cUpd += "'" + BD7->BD7_CODOPE + "',"
		cUpd += "'" + BD7->BD7_CODLDP + "',"
		cUpd += "'" + BD7->BD7_CODPEG + "',"
		cUpd += "'" + BD7->BD7_NUMERO + "',"
		cUpd += "'" + BD7->BD7_SEQUEN + "',"
		cUpd += "'" + cValorOri + "',"
		cUpd += StrTran(cValToChar(nLiberado),',','.') + ','
		cUpd += "'" + UsrRetName(c_UsrLog) + "',"
		cUpd += "'" + DtoS(Date()) + "',"
		cUpd += "'" + Time() + "',"
		cUpd += "'" + c_Senha + "',"
		cUpd += "'" + If(cEmpAnt == '01','CABERJ','INTEGRAL')+ "')"
		
		If ( TcSqlExec(cUpd) < 0 )
			lContinua := .F.
			Exit
		EndIf
		 
	 Next
	 
	 If !lContinua
		Exit	 
	 EndIf
	 
Next
	
If lContinua
	EndTran()
	MsgInfo("Desbloqueio finalizado!" + CRLF + "Total liberado [ " + AllTrim(Transform(nTotLib,'@E 999,999,999.99')) + " ]",AllTrim(SM0->M0_NOMECOM)) 
Else
	DisarmTransaction()
	MsgStop("Processamento interrompido. Ocorreu um erro:" + CRLF + CRLF + TcSqlError(),AllTrim(SM0->M0_NOMECOM))
	LogErros(TcSqlError(),'DETALHES DO ERRO')
EndIf
    
Return

*******************************************************************************************************************   

/*
CREATE TABLE DESBLOQUEIO_GUIAS 
(
  ID NUMBER PRIMARY KEY,
  LOTE_BLOQ VARCHAR2(6),
  RECNO NUMBER,
  OPERADORA VARCHAR2(4),
  LOCAL_DIGITACAO VARCHAR2(4),
  PEG VARCHAR2(8),
  GUIA VARCHAR2(8),
  SEQUEN VARCHAR2(3),
  VALOR_ORIGINAL VARCHAR2(300),
  LIBERADO_BD7 NUMBER,
  LOGIN VARCHAR2(25),
  DATA VARCHAR2(8),
  HORA VARCHAR2(8)
);

CREATE INDEX LOTBLO_INDEX ON DESBLOQUEIO_GUIAS (LOTE_BLOQ);
CREATE INDEX PEG_INDEX ON DESBLOQUEIO_GUIAS (OPERADORA,LOCAL_DIGITACAO,PEG,GUIA,SEQUEN);
CREATE INDEX RECNO_INDEX ON DESBLOQUEIO_GUIAS (RECNO);  

ALTER TABLE DESBLOQUEIO_GUIAS ADD SENHA VARCHAR2(20);
ALTER TABLE DESBLOQUEIO_GUIAS ADD EMPRESA VARCHAR2(20);
*/
#INCLUDE "RWMAKE.CH"
#INCLUDE "PLSMGER.CH"
#INCLUDE "COLORS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "PROTHEUS.CH"


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
���������������������������������������������������f����������������������ͻ��
���Programa  �PLSRETC2  �Autor  �Fabio Bianchini     � Data �  04/17/14   ���
�������������������������������������������������������������������������͹��
���Desc.     �Ponto de Entrada para tratar o valor de COPART de Conv.     ���
���          �Recipr. O valor de nValApr eh atribuido via PLSRETCP, e     ���
���          �eh multiplicado no PLSRETCOP(Padrao), conforme trecho 	  ���
���          �abaixo: 												      ���
���          �              											  ���
���          �             	nVlrEve := nValCop*nQtd						  ���
���          �				nVlrBPF := nValCop*nQtd						  ���
���          �				nVlrPF  := nValCop*nQtd						  ���
���          �															  ���
���          �Isto torna irreal a COPART no caso dos convenios.           ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User function PLSRETC2()

	Local aRetPto    	:= PARAMIXB
	Local nPerCop    	:= aRetPto[1]   //- Percentual de Participa��o
	Local nValCop    	:= aRetPto[2]   //- Valor da Participa��o
	Local nTaxa	   		:= aRetPto[3]   //- Valor da Taxa Administrativa
	Local nValUs     	:= aRetPto[4]   //- Valor da US
	Local cAlias     	:= aRetPto[5]   //- Alias ativo
	Local lExistia   	:= aRetPto[6]   //- Identifica se o sistema encontrou parametriza��o da participa��o financeira
	Local cPgNoAto   	:= aRetPto[7]   //- Identificador de pagamento no ato
	Local cPgDrRDA   	:= aRetPto[8]   //- identificador de pagamento direto a RDA
	Local nLimFra    	:= aRetPto[9]   //- Limite da Franquia
	Local cCodInt    	:= aRetPto[10]  //- Codigo da Operadora
	Local cCodEmp    	:= aRetPto[11]  //- Codigo do Grupo / Empresa
	Local cMatric    	:= aRetPto[12]  //- Matricula do Beneficiario
	Local cTipReg    	:= aRetPto[13]  //- Tipo de Registro do Beneficiario
	Local cCodPla    	:= aRetPto[14]  //- Codigo do Plano
	Local cVerPla    	:= aRetPto[15]  //- Vers�o do Plano
	Local cOpeOri    	:= aRetPto[16]  //- Operadora de Origem do Beneficiario
	Local dDatPro    	:= aRetPto[17]  //- Data do Procedimento
	Local nQtd 	  		:= aRetPto[18]  //- Quantidade do Procedimento
	Local cCodPad    	:= aRetPto[19]  //- Codigo da tabela de procedimentos
	Local cCodPro    	:= aRetPto[20]  //- Codigo do Procedimento
	Local cCodLoc    	:= aRetPto[21]  //- Codigo do Local de Atendimento
	Local cCodRda    	:= aRetPto[22]  //- Codigo do prestador de sa�de
	Local lCompra    	:= aRetPto[23]  //- Identificador de compra
	Local cRegAte    	:= aRetPto[24]  //- Regime de Atendimento: 1=Internacao   2=Ambulatorial
	Local cCodTabCop	:= aRetPto[25]  //- Codigo da tabela de co-participa��o
	Local nVlrEve 		:= aRetPto[26]  //- Valor do Evento
	Local cTipPre 		:= aRetPto[27]  //- Tipo de Prestador
	Local nVlrTBES 		:= aRetPto[28]  //- Valor total do evento
	Local nVlrBPF 		:= aRetPto[29]  //- Valor base da co-participacao
	Local nVlrTPF 		:= aRetPto[30]  //- Valor total da co-participacao
	Local nVlrPF 	 	:= aRetPto[31]  //- Valor da participa��o financeira
	Local nVlrTax 		:= aRetPto[32]  //- Valor total da taxa administrativa
	Local nSlvBase 		:= aRetPto[33]  //- Backup do Valor da participa��o financeira
	Local nSlvPerc 		:= aRetPto[34]  //- Backup do Valor da Taxa Administrativa
	Local nSlvTx 	 	:= aRetPto[35]  //- Backup do valor da Taxa Administrativa
	Local nSlvTotal  	:= aRetPto[36]  //- Backup do Valor da base da franquia
	Local nPerda 	 	:= aRetPto[37]  //- Percentual de perda sobre o limite da franquia
	Local cFranquia		:= aRetPto[38]  //- Identifica se houve franquia: 1=Sim; 0-N�o
	Local nPerHorEsp	:= aRetPto[39]  //- Periodo em hor�rio especial
	Local cNivAut 		:= aRetPto[40]  //- Nivel da autoriza��o do procedimento
	Local cChvAut 		:= aRetPto[41]  //- Chave da autoriza��o do procedimento
	Local aRetCom 		:= aRetPto[42]  //- Array com as criticas encontra,das durante o processo.
	Local lConvenio  	:= .F. // Marcela Coimbra - 01/12/14
	Local lMedEspec  	:= .F.	//Bianchini - 26/02/2015
	Local cProOPME   	:= GetMv("MV_XPROOPM")
	Local cAliQry2		:= GetNextAlias() //Angelo Henrique - Data: 07/01/2016
	Local cSQLCop		:= ""  //Angelo Henrique - Data: 07/01/2016
	Local cAliQry3		:= GetNextAlias() //Angelo Henrique - Data: 12/01/2017
	Local _cQuery		:= "" //Angelo Henrique - Data: 12/01/2017

	If BD6->BD6_NIVAUT <> cNivAut .OR. BD6->BD6_CHVNIV <> cChvAut
		RecLock("BD6",.F.)
		BD6->BD6_NIVAUT := cNivAut 
		BD6->BD6_CHVNIV := cChvAut
		BD6->(MsUnlock())
	Endif

	If cCodPad = '06' .and. trim(cCodPro)$cProOPME .and. BD6->BD6_CODLDP == '0013'
		lMedEspec := .T.
	EndIf

	//alert("retc2")
/*	If ((cCodEmp $ '0004|0009') .and. (cEmpAnt == '01'))
		//If (nPerCop == 100) .and. (nVlrPF > nValCop)
		//BIANCHINI - 30/11/2018 - tratamento porque tem ocorrido das posi��es de valor do aPARAMIXB virem zeradas e por isso a variavel nao � alimentada
		If nVlrTBES <> BD6->BD6_VLRPAG
		 	nVlrTBES := BD6->BD6_VLRPAG
		Endif

	 	nPercop := 100
		nValCop := nVlrTBES
		nVlrEve := nVlrTBES
		nVlrPF  := nVlrTBES 
		nVlrBPF := nVlrTBES 
		nVlrTPF := nVlrTBES 
		lConvenio  := .T.// Marcela Coimbra - 01/12/14
	EndIf  */

	If !lConvenio
		//--------------------------------------------------------------------------------------
		//Inicio - Angelo Henrique - Data:06/11/2015
		//--------------------------------------------------------------------------------------
		//Tratamento de coparticipa��o quando o procedimento estiver parametrizado no nivel do
		//usu�rio, independente do regime. - Este trecho � original do P.E. PLSMUDFS, por�m 
		//quando entra no processo de confer�ncia por motivo de glosa e etc e � feito o 
		//processo de reconsiderar estava zerando a coparticipa��o.
		//Ex: codigo: 81080042 - Di�ria global em enfermaria psiquiatrica
		//--------------------------------------------------------------------------------------

		cSQLCop := " SELECT BVM.BVM_PERCOP PERC, BVM.BVM_VALCOP VALOR "
		cSQLCop += "   FROM " + RetSqlName("BFG") + " BFG "
		cSQLCop += "      , " + RetSqlName("BVM") + " BVM "
		cSQLCop += "  WHERE BFG.BFG_FILIAL = '" + xFilial("BFG") + "' "
		cSQLCop += "    AND BVM.BVM_FILIAL = '" + xFilial("BVM") + "' "
		cSQLCop += "    AND BFG.BFG_CODINT = BVM.BVM_CODINT "
		cSQLCop += "    AND BFG.BFG_CODEMP = BVM.BVM_CODEMP "
		cSQLCop += "    AND BFG.BFG_MATRIC = BVM.BVM_MATRIC "
		cSQLCop += "    AND BFG.BFG_TIPREG = BVM.BVM_TIPREG "
		cSQLCop += "    AND BFG.BFG_CODPAD = BVM.BVM_CODPAD "
		cSQLCop += "    AND BFG.BFG_CODPSA = BVM.BVM_CODPSA "
		cSQLCop += "    AND BFG.BFG_BENUTL = '1'        "
		cSQLCop += "    AND BFG.BFG_CODINT = '" + cOpeOri + "' "
		cSQLCop += "    AND BFG.BFG_CODEMP = '" + cCodEmp + "'"
		cSQLCop += "    AND BFG.BFG_MATRIC = '" + cMatric + "'"
		cSQLCop += "    AND BFG.BFG_TIPREG = '" + cTipReg + "'"
		cSQLCop += "    AND BVM.BVM_CODPAD = '" + cCodPad + "'"
		cSQLCop += "    AND BVM.BVM_CODPSA = '" + cCodPro + "'"
		cSQLCop += "    AND ( ('" + DTOS(dDatPro) + "' BETWEEN BVM.BVM_VIGDE AND BVM.BVM_VIGATE AND BVM.BVM_VIGATE <> ' ') OR "
		cSQLCop += "          ('" + DTOS(dDatPro) + "' >= BVM.BVM_VIGDE  AND BVM.BVM_VIGATE = ' ')  OR "
		cSQLCop += "          ('" + DTOS(dDatPro) + "' <= BVM.BVM_VIGATE AND BVM.BVM_VIGDE = ' ')  OR "
		cSQLCop += "          (BVM.BVM_VIGATE = ' ' AND BVM.BVM_VIGDE = ' ')  ) "
		cSQLCop += "    AND BFG.D_E_L_E_T_ = ' ' "
		cSQLCop += "    AND BVM.D_E_L_E_T_ = ' ' "

		If Select(cAliQry2)>0
			(cAliQry2)->(DbCloseArea())
		EndIf

		DbUseArea(.T.,"TopConn",TcGenQry(,,cSQLCop),cAliQry2,.T.,.T.)

		DbSelectArea(cAliQry2)

		If !((cAliQry2)->(EOF())) 

			If (cAliQry2)->PERC <> 0 //Percentual

				_nPerc 	:= (cAliQry2)->PERC

				//Leonardo Portella / S�rgio - 22/06/17 - Alterado para pegar o valor base retornado pelo PE ao inv�s do valor na BD6 que ainda n�o foi calculado
				_nVlrPf	:= nVlrBPF * (_nPerc/100)//BD6->BD6_VLRBPF * (_nPerc/100)

			Else //Valor

				_nPerc 	:= 0
				_nVlrPf	:= (cAliQry2)->VALOR * BD6->BD6_QTDPRO

			EndIf

			//------------------------------------------------------------------------------------
			//Restauro as var�aveis para que assim realize o calculo correto da coparticipa��o
			//------------------------------------------------------------------------------------		
			nPerCop   	:= _nPerc//aRetPto[2] // Percentual de Participa��o
			nValCop   	:= _nVlrPf//aRetPto[2]   // Valor da Participa��o
			nTaxa	   	:= aRetPto[3]   // Valor da Taxa Administrativa
			nValUs    	:= aRetPto[4]   // Valor da US
			nVlrEve 	:= aRetPto[26]  // Valor do Evento
			nVlrTBES 	:= aRetPto[28]  // Valor total do evento
			nVlrBPF 	:= aRetPto[29]  // Valor base da co-participacao		
			nVlrTPF 	:= _nVlrPf//aRetPto[30]  // Valor total da co-participacao
			nVlrPF 		:= _nVlrPf//aRetPto[31]  // Valor da participa��o financeira
			nVlrTax 	:= aRetPto[32]  // Valor total da taxa administrativa
			nSlvBase 	:= _nVlrPf//aRetPto[33]  // Backup do Valor da participa��o financeira
			nSlvPerc 	:= aRetPto[34]  // Backup do Valor da Taxa Administrativa
			nSlvTx 		:= aRetPto[35]  // Backup do valor da Taxa Administrativa
			nSlvTotal 	:= aRetPto[36]  // Backup do Valor da base da franquia
			nPerda 		:= aRetPto[37]  // Percentual de perda sobre o limite da franquia		

			//Leonardo Portella / S�rgio - 22/06/17 - Crit�rio extra�do do trecho antes da query na BVM para realizar esta verifica��o somente ap�s buscar na BVM 
			// altamiro - 06/09/2017 trata caso seja empresa 0004 ou 0009 nao entre aki - cobra coparticipa��o 
		ElseIf !lMedEspec .and. ( cRegAte == '1' )//Regime interna��o
		//ElseIf !lMedEspec .and. ( cRegAte == '1' ) .and. cCodEmp !='0004' .and. cCodEmp !='0009' //Regime interna��o
		//ElseIf !lMedEspec .and. ( cRegAte == '1' ) .and. (!cEmpAnt =='01' .and. cCodEmp !='0004' .and. cCodEmp !='0009') //Regime interna��o e n�o conv�nio

			nPerCop	:= 0
			nValCop := 0
			nVlrPF  := 0
			nVlrBPF := 0
			nVlrTax := 0
			nVlrTPF := 0

		Endif

		If Select(cAliQry2)>0
			(cAliQry2)->(DbCloseArea())
		EndIf
		
		//--------------------------------------------------------------------------------------
		//Fim - Angelo Henrique - Data:07/11/2015
		//--------------------------------------------------------------------------------------

		//--------------------------------------------------------------------------------------
		//Inicio - Angelo Henrique - Data: 11/08/2017
		//--------------------------------------------------------------------------------------

		If 	cCodRda $ '125970|136204|131903'  .And. cEmpAnt = '02'//Centros M�dicos CABERJ

			_cQuery := " SELECT 											" + CRLF 
			_cQuery += " 	BG8_CODPSA, BR8_DESCRI 							" + CRLF 
			_cQuery += " FROM 												" + CRLF 
			_cQuery += " 	" + RetSqlName("BG8") + " BG8,					" + CRLF
			_cQuery += " 	" + RetSqlName("BR8") + " BR8, 					" + CRLF 
			_cQuery += " 	" + RetSqlName("BD6") + " BD6 					" + CRLF
			_cQuery += " WHERE 												" + CRLF 
			_cQuery += " 	BG8.D_E_L_E_T_ 		= ' ' 						" + CRLF 
			_cQuery += " 	AND BR8.D_E_L_E_T_	= ' ' 						" + CRLF 
			_cQuery += " 	AND BD6.D_E_L_E_T_	= ' ' 						" + CRLF
			_cQuery += " 	AND BG8_FILIAL		= '" + xFilial("BG8") + "' 	" + CRLF 
			_cQuery += " 	AND BR8_FILIAL		= '" + xFilial("BG8") + "' 	" + CRLF 
			_cQuery += " 	AND BD6_FILIAL		= '" + xFilial("BD6") + "' 	" + CRLF
			_cQuery += " 	AND BG8_CODPSA		= BR8_CODPSA 				" + CRLF 
			_cQuery += " 	AND BG8_CODGRU IN ('002','033') 				" + CRLF 
			_cQuery += " 	AND BR8_CLASSE 		= '000001' 					" + CRLF
			_cQuery += " 	AND BG8_CODPSA 		= '" + BD6->BD6_CODPRO + "' " + CRLF
			_cQuery += " 	AND BD6_CODEMP		= '0280' 					" + CRLF //BADIN
			_cQuery += " 	AND BD6_DATPRO BETWEEN '20170601' AND '20180531' " + CRLF //Per�odo Contratual

			If Select(cAliQry3)>0
				(cAliQry3)->(DbCloseArea())
			EndIf

			DbUseArea(.T.,"TopConn",TcGenQry(,,_cQuery),cAliQry3,.T.,.T.)

			DbSelectArea(cAliQry3)

			If !((cAliQry3)->(EOF()))

				nPerCop	:= 0
				nValCop := 0
				nVlrPF  := 0
				nVlrBPF := 0
				nVlrTax := 0
				nVlrTPF := 0

			EndIf					

			If Select(cAliQry3)>0
				(cAliQry3)->(DbCloseArea())
			EndIf

		EndIf
		//--------------------------------------------------------------------------------------
		//Fim - Angelo Henrique - Data: 11/08/2017
		//--------------------------------------------------------------------------------------
	Endif

	aRetPto := {nPerCop,nValCop,nTaxa,nValUs,cAlias,lExistia,cPgNoAto,cPgDrRDA,nLimFra,lCompra,cRegAte,cCodTabCop,;
	nVlrTBES,nVlrBPF,nVlrTPF,nVlrPF,nVlrTax,nSlvBase,nSlvPerc,nSlvTx,nSlvTotal,nPerda,cFranquia,nPerHorEsp}

Return(aRetPto)
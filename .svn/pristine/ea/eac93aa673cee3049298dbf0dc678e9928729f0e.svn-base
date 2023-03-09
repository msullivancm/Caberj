#Include 'Protheus.ch'

//------------------------------------------------*//
//Rotina: CABA608								   //
//------------------------------------------------*//
//Autor: Mateus Medeiros						   //
//------------------------------------------------*//
//Data: 07/02/2018								   //
//------------------------------------------------*//
//Descrição: Função para buscar as informações     //
// bancárias do cliente e será chamda na fórmula   //
// C01											   //
//------------------------------------------------*//
// Parametros: cTipo - Se retornará banco ou  	   //
// os dados da conta                               //
//------------------------------------------------*//
// Retorno: cRet - Dados Bancários - Reembolso     //
//------------------------------------------------*//

User Function caba608(cOp)
	
	Local aArea := GetArea()
	Local aAreaSA2     := SA2->(GetArea())
	Local aAreaSEA     := SEA->(GetArea())
	Local aAreaSEE     := SEE->(GetArea())
	Local aAreaSE2     := SE2->(GetArea())
	Local cRet  	   := ""
	Local cAlias 	   := GetNextAlias()
	Local cTipo        := Padr("NCC",TamSx3("E1_TIPO")[1])
	
	Default  cOp		:= '1' // 1 - Retorna o banco para pagamento - 2 - retorna os dados de conta e agência
	
	BeginSql Alias cAlias
		%noparser% // Não realiza o parser da query - tem o mesmo conceito que a função do changequery
		SELECT PCT.PCT_BANCO,PCT.PCT_NUMAGE,PCT.PCT_DVAGE,PCT.PCT_NCONTA, PCT.PCT_DVCONT,ZZQ_XTPRGT
		FROM  %table:B44% B44
		INNER JOIN %table:ZZQ%  ZZQ ON
		ZZQ_SEQUEN 		= B44_YCDPTC
		AND ZZQ_FILIAL 	= %xFilial:ZZQ%
		AND ZZQ_DATDIG <> ' '
		INNER JOIN %table:PCT% PCT ON
		PCT_CODIGO 		= ZZQ_DBANCA
		AND PCT_CLIENT  = ZZQ_CODCLI
		AND PCT_LOJA	= ZZQ_LOJCLI
		AND PCT_FILIAL 	= %xFilial:PCT%
		WHERE
		B44_FILIAL 		= %xFilial:B44%
		AND B44_PREFIX 	= %exp:SE2->E2_PREFIXO%
		AND B44_NUM   	= %exp:SE2->E2_NUM%
		AND B44_PARCEL 	= %exp:SE2->E2_PARCELA%
		AND B44_TIPO  	= %exp:cTipo%
		AND B44.D_E_L_E_T_ = ' '
		AND PCT.D_E_L_E_T_ = ' '
		AND ZZQ.D_E_L_E_T_ = ' '
	Endsql
	
	
	IF (cAlias)->(!Eof())
		IF cOp == '1'
			IF (cAlias)->ZZQ_XTPRGT = '1'
				cRet := (cAlias)->PCT_BANCO
			else 
				cRet := Space(TamSx3("PCT_BANCO")[1]) // cheque 
			endif 
		else
			
			IF (cAlias)->ZZQ_XTPRGT = '1'
					
					//Angelo Henrique - Data: 10/05/19
					//Não coloca o digito da conta conforme visto no Layout SISPAG
					//cRet := Alltrim(STRZERO(VAL(alltrim((cAlias)->PCT_NUMAGE)+alltrim((cAlias)->PCT_DVAGE)),5)+" "+STRZERO(VAL(SUBSTR((cAlias)->PCT_NCONTA,1,12)),12)+" "+(cAlias)->PCT_DVCONT)														
					cRet := Alltrim(STRZERO(VAL(alltrim((cAlias)->PCT_NUMAGE)),5)+" "+STRZERO(VAL(SUBSTR((cAlias)->PCT_NCONTA,1,12)),12)+" "+(cAlias)->PCT_DVCONT)									
				
			else // cheque 
				cRet := Alltrim(STRZERO(VAL(''),5)+" "+STRZERO(VAL(''),12)+" "+Space(TamSx3("PCT_DVCONT")[1]))  
			endif 
		endif
	else
		IF cOp == '1'
			cRet := SA2->A2_BANCO
		else
			//Angelo Henrique - Data: 10/05/19
			//Não coloca o digito da conta conforme visto no Layout SISPAG
			//cRet := STRZERO(VAL(SA2->A2_AGENCIA+SA2->A2_XDVAGE),5)+" "+STRZERO(VAL(SUBSTR(SA2->A2_NUMCON,1,12)),12)+" "+SA2->A2_YDAC
			cRet := STRZERO(VAL(SA2->A2_AGENCIA),5)+" "+STRZERO(VAL(SUBSTR(SA2->A2_NUMCON,1,12)),12)+" "+SA2->A2_YDAC
		endif
	endif
	
	if select(cAlias) > 0
		dbselectarea(cAlias)
		dbclosearea()
	Endif
	
	RestArea(aAreaSA2)
	RestArea(aAreaSEA)
	RestArea(aAreaSEE)
	RestArea(aAreaSE2)
	RestArea(aArea)
	
Return cRet
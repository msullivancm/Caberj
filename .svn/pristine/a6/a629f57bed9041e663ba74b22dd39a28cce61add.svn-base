#Include "PROTHEUS.CH"
#Include "TOPCONN.CH"
#Include "TBICONN.CH"
#Include "AP5MAIL.CH"
#include "Fileio.ch"

#define F_BLOCK  512

#DEFINE cEnt chr(10)+chr(13)

/*
#############################################################################
#############################################################################
###Programa | CABA352   |Autor: MATEUS              | Data:10/04/2018     ###
#############################################################################
##Desc.     |  ROTINA PARA ATUALIZAR CNS A PARTIR DO WS DO DATASUS        ###
##          |  ( ATUALIZA CNS NA BTS)                                     ###
#############################################################################
##Uso       | INTEGRAÇÃO PROTHEUS X DATASUS                               ###
#############################################################################
#############################################################################
#############################################################################
*/

******************************************************************************************************

// Não passar parametros na configuração do schedule - pois esta rotina
// receberá por parametro empresa e filial setadas na configuração
User Function CABA352(aSched)
	
	Private lEnd    := .F.
	Default aSched 	:= .F.
	
	conout("INÍCIO PROCESSAMENTO - SCHEDULE CABA352 - ATUALIZAÇÃO CNS - "+Time())
	
	*********************************************************
	*'Executa a busca pelos Beneficiários sem CNS das guias'*
	*********************************************************
	if aSched
		execAtuCNS(aSched)
	else
		Processa( {|lEnd| execAtuCNS(aSched) }, "Aguarde...", "Atualizando CNS...",.T.)
		
	endif
	*********************************************************
	
	conout("FIM PROCESSAMENTO - SCHEDULE CABA611 - "+Time())
	
Return


/*
#############################################################################
#############################################################################
###Programa | execAtuCNS | Autor: MATEUS            | Data:29/10/2018     ###
#############################################################################
##Desc.     |  Função para buscar os beneficiários sem CNS no cadasto     ###
#############################################################################
##Uso       | INTEGRAÇÃO PROTHEUS X OPERATIVA                             ###
#############################################################################
#############################################################################
#############################################################################
*/

Static Function execAtuCNS(xParam)
	
	Local cAlias1   := GetNextAlias()
	Local nPosNmCmp := 0
	Local nPosNmMae := 0
	Local nPosNasc  := 0
	Local nPosCNS	:= 0
	Local aVetOk 	:= {}
	Local aVetNOk	:= {}
	Local nTotal    := 0
	private aRet		:= {}
	
	Default xParam := Nil
	
	if type("xParam") == "A"
		
		RpcSetType(3)
		RpcClearEnv()
		RpcSetEnv(xParam[1],xParam[2])
		
	endif
	
	//13111337715
	// Query para buscar vidas a serem processadas e com cns inválidas
	
	BeginSql Alias cAlias1
		
		SELECT  DISTINCT BTS_MATVID ,BA1_CPFUSR , BTS_CPFUSR , BTS_NRCRNA,
		BTS_MAE,BA1_MAE, BA1_NOMUSR , BTS_DATNAS, BTS.R_E_C_N_O_ RECBTS
		FROM   %table:BA1% BA1
		INNER JOIN %table:BTS% BTS ON  BTS_FILIAL = BA1_FILIAL AND    BTS_MATVID = BA1_MATVID
		AND    (TRIM(BTS_NRCRNA) IS NULL OR  LENGTH(TRIM(BTS_NRCRNA)) < 15)
		LEFT JOIN siga.LOG_WEBSERVICE_CNS CNS ON
		CNS.SITUACAO = 'N' AND CNS.CPF = BTS_CPFUSR
		AND CNS.OBSERVACAO = 'Nome da Mãe inválido.'
		WHERE  BA1_FILIAL = ' '
		AND    BA1_CODEMP NOT IN ('0004','0009')
		AND   (BA1_CODEMP = '0024')
		AND    BA1.D_E_L_E_T_ = '  '
		AND    BTS.D_E_L_E_T_ = '  '
		order by  BA1_NOMUSR
	ENDSQL
	
	(cAlias1)->(dbeval({|| nTotal++ }))
	(cAlias1)->(dbgotop())
	ProcRegua(nTotal)
	if (cAlias1)->(!Eof())
		do while (cAlias1)->(!Eof())
			
			IncProc()
			IncProc("Atualizando CNS do CPF -  "+(cAlias1)->BTS_CPFUSR)
			
			// Chama função que retornará os dados retornados pelo serviço do datasus
			aRet := u_CNSWSDL(alltrim((cAlias1)->BTS_CPFUSR))
			//		aRet := u_CNSWSDL(alltrim('13111337715')
			aRet := iif(type("aRet") == "U",{},aRet)
			if len(aRet) > 0
				nPosNmCmp := ascan(aRet,{|x|  alltrim(UPPER(x[1]))=="CNMCOMPLE"} )
				nPosNmMae := ascan(aRet,{|x|  alltrim(UPPER(x[1]))=="CNOMEMAE" } )
				nPosNasc :=  ascan(aRet,{|x|  alltrim(UPPER(x[1]))=="CDTNASC"  } )
				
				
				nPosCNS   := ascan(aRet,{|x| alltrim(UPPER(x[1]))=="CCNS"} )
				
				if nPosNmCmp > 0 .and. 	nPosNmMae > 0
					
					if Alltrim(Upper(aRet[nPosNmCmp][2])) # Alltrim(Upper((cAlias1)->BA1_NOMUSR)) .and. Alltrim(Upper((cAlias1)->BTS_DATNAS)) # strtran(Alltrim(Upper(aRet[nPosNasc][2])),'-','')
						
						cQuery  := " insert into siga.LOG_WEBSERVICE_CNS  values ( '" + iif(cEmpAnt == "01","C","I") + "', '" + alltrim((cAlias1)->BTS_CPFUSR) + "', 'N',to_char(sysdate,'dd/mm/yyyy hh24:mi:ss'),'Nome do usuário e Data de Nascimento inválido.'  )  "
						TcSqlExec(cQuery)
						
					elseif ( !(Alltrim(Upper(aRet[nPosNmMae][2])) $ Alltrim(Upper((cAlias1)->BTS_MAE))) .and. !( Alltrim(Upper((cAlias1)->BTS_MAE)) $ Alltrim(Upper(aRet[nPosNmMae][2]))  ) .AND.  !( Alltrim(Upper((cAlias1)->BA1_MAE)) $ Alltrim(Upper(aRet[nPosNmMae][2]))  ) .AND.  !( Alltrim(Upper(aRet[nPosNmMae][2])) $  Alltrim(Upper((cAlias1)->BA1_MAE))   )  ) 
						
						cQuery  := " insert into siga.LOG_WEBSERVICE_CNS  values ( '" + iif(cEmpAnt == "01","C","I") + "', '" + alltrim((cAlias1)->BTS_CPFUSR) + "', 'N',to_char(sysdate,'dd/mm/yyyy hh24:mi:ss'),'Nome da Mãe inválido.'  )  "
						TcSqlExec(cQuery)
						
					else
						BTS->(dbgoto((cAlias1)->RECBTS))
						
						RecLock("BTS",.F.)
						BTS->BTS_NRCRNA := aRet[nPosCNS][2]
						BTS->(MsUnLock())
						
						cQuery  := " insert into siga.LOG_WEBSERVICE_CNS  values ( '" + iif(cEmpAnt == "01","C","I") + "', '" + alltrim((cAlias1)->BTS_CPFUSR) + "', 'S',to_char(sysdate,'dd/mm/yyyy hh24:mi:ss'),'Atualizado com Sucesso' )  "
						TcSqlExec(cQuery)
						
					endif
					
				else
					//				 Registro não processado
					cQuery  := " insert into siga.LOG_WEBSERVICE_CNS  values ( '" + iif(cEmpAnt == "01","C","I") + "', '" + alltrim((cAlias1)->BTS_CPFUSR) + "', 'N',to_char(sysdate,'dd/mm/yyyy hh24:mi:ss'), 'Não encontrado na base de dados do CNS' )  "
					TcSqlExec(cQuery)
					
				endif
			else
				cQuery  := " insert into siga.LOG_WEBSERVICE_CNS  values ( '" + iif(cEmpAnt == "01","C","I") + "', '" + alltrim((cAlias1)->BTS_CPFUSR) + "', 'N',to_char(sysdate,'dd/mm/yyyy hh24:mi:ss'),'Problema na consulta ao serviço do CADSUS.'  )  "
				TcSqlExec(cQuery)
				
			endif
			(cAlias1)->(dbskip())
			
		endDo
		
	endif
	
	//GeraLog(aVetOk,aVetNOk)
	
	if select(cAlias1) > 0
		dbselectarea(cAlias1)
		dbclosearea()
	endif
	
Return


// GeraLog
Static Function GeraLog(aOk, aNOk)
	
	LOCAL cBuffer  	:= SPACE(F_BLOCK)
	Local cArchive  := "log_atualizados_cns_"+time()+".txt"
	Local cArchiveNO  := "log__nao_atualizados_cns_"+time()+".txt"
	LOCAL nOutfile 	:= FCREATE("\LOG_CNS\"+cArchive, FC_NORMAL)
	LOCAL nOutfile2 	:= FCREATE("\LOG_CNS\"+cArchiveNO, FC_NORMAL)
	LOCAL lDone    	:= .F.
	LOCAL nBytesR  	:= 0
	Local nX 	   	:= 0
	
	LOCAL nInfile    := FOPEN(cArchive, FO_READWRITE)
	LOCAL nInfile2   := FOPEN(cArchiveNO, FO_READWRITE)
	
	Default aOk 	:= {}
	Default aNOk 	:= {}
	
	
	
	// OK
	for nX := 1 to len(aOk)
		
		nBytesR := FREAD(nInfile, @cBuffer, F_BLOCK)
		
		FWRITE(nInfile,  cBuffer+chr(13)+chr(10)+aOk[nX][1], nBytesR)
		
	Next nX
	
	FCLOSE(nInfile)
	
	
	nX := 0
	
	// nOK
	for nX := 1 to len(aNOk)
		
		nBytesR := FREAD(nInfile2, @cBuffer, F_BLOCK)
		
		FWRITE(nInfile2, cBuffer+chr(13)+chr(10)+aNOk[nX][1], nBytesR)
		
	Next nX
	
	
	
	FCLOSE(nInfile2)
	FCLOSE(nOutfile2)
	
	
	
RETURN NIL


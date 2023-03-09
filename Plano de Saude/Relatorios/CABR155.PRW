#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#include "TBICONN.CH"

#DEFINE c_ent CHR(13) + CHR(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  CABR155    บAutor  ณAnderson Rangel     บ Data ณ  DEZ/2021   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ RELATORIO DE INADIMPLENCIA                                 บฑฑ
ฑฑบ          ณ (REFORMULAวรO) - GLPI 60345                                บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ | INTEGRAL                                          บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function CABR155()

	Local _aArea 	:= GetArea()

	Private cPerg	:= "CAB155"
	Private cNivel	:= ""
	Private cEmpDe	:= ""
	Private cEmpAte	:= ""
	Private cConDe	:= ""
	Private cConAte	:= ""
	Private cSubDe	:= ""
	Private cSubAte	:= ""
	Private dDatDe	:= ctod("  /  /  ")
	Private dDatAte	:= ctod("  /  /  ")

	//Cria grupo de perguntas
	CABR155PERG(cPerg)
	
	If Pergunte(cPerg,.T.)
		
		If mv_par01 = 1
			cNivel := "TODOS"
		elseif mv_par01 = 2
			cNivel := "FAMILIA"
		elseif mv_par01 = 3
			cNivel := "SUBCONTRATO"
		elseif mv_par01 = 4
			cNivel := "CONTRATO"
		else
			cNivel := "EMPRESA"
		EndIf
		cEmpDe	:= mv_par02
		cEmpAte	:= mv_par03
		cConDe	:= mv_par04
		cConAte	:= mv_par05
		cSubDe	:= mv_par06
		cSubAte	:= mv_par07
		dDatDe	:= mv_par08
		dDatAte := mv_par09

		//----------------------------------------------------
		//Validando se existe o Excel instalado na mแquina
		//para nใo dar erro e o usuแrio poder visualizar em
		//outros programas como o LibreOffice
		//----------------------------------------------------
		If ApOleClient("MSExcel")
			
            Processa({||CABR155A()},'Gerando Arquivo MSExcel (.xls)')

		Else
			
			Processa({||CABR155B()},'Gerando Arquivo LIbreOffice (.csv)')
			
		EndIf
		
	EndIf
	
	RestArea(_aArea)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR155A  บAutor  ณAnderson Rangel       บ Data ณ  DEZ/2021 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina responsavel por gerar o relat๓rio em Excel           บฑฑ
ฑฑบ          ณ									                          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ | INTEGRAL                                          บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CABR155A(cAlias1)

	Local aArea 	:= GetArea()
	Local cQuery	:= ""
	Local aCabec	:= {}
	Local aDados	:= {}
	Local cTitulo	:= "Relat๓rio de Inadimpl๊ncia"
	Local nI 	  	:= 0

	Private _cAlias1	:= GetNextAlias()
	
	cQuery := CABR155QRY()
	
	If Select(_cAlias1) > 0
		(_cAlias1)->(DbCloseArea())
	EndIf
	
	DbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),_cAlias1,.T.,.T.)
	
	For nI := 1 to 5
		IncProc('Processando...')
	Next
	
	If !(_cAlias1)->(Eof())

		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Cria e grava cabecalho do Xls...							             ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		aCabec := {"Nivel"      			,;
				"Codigo da Empresa"   		,;
				"Codigo do Contrato"   		,;
				"Codigo do SubContrato"		,;
				"Matricula"       			,;
				"Descri็ใo da Empresa"    	,;
				"Descri็ใo do Subcontrato" 	,;
				"N๚mero do Cliente"  		,;
				"Cliente"  					,;
				"Prefixo"  					,;   
				"N๚mero do Tํtulo"  		,;
				"Parcela"  					,;
				"Tipo"  					,;
				"Portador"   				,;
				"Forma de Cobran็a"			,;
				"Dt. Emissใo"  				,;                           
				"Dt. Vencimento Real"  		,;
				"Vlr. Tํtulo"				,;
				"Abatimento"     			,;
				"Vlr. Nota de Cr้dito"     	,;
				"Saldo" 					,; 
				"Saldo Partida "			,;
				"Border๔"     				,;
				"Ano Base"      			,;
				"M๊s Base"      			,;
				"N๚mero da Cobran็a"      	,;
				"RPS"      					,;
				"N๚mero Nota Fiscal"      	,;
				"Status BLQ"      			,;
				"Dt. BLQ"      				,;
				"C๓digo BLQ"      			,;
				"Motivo BLQ"      			,;
				"Tipo Pessoa"      			,;
				"Endere็o"      			,;
				"Municipio"      			,;
				"Estado"      				,;
				"Bairro"      				,;
				"CEP"      					,;
				"Telefone"      			,;
				"CPF/CNPJ"      			,;
				"E-MAIL"      				,;
				"Modalidade" 				} 			   
		
		(_cAlias1)->(DbGoTop())
		
		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Cria e grava os dados do Xls...							             ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
		While !(_cAlias1)->(eof())
			IncProc()
			Aadd(aDados,{(_cAlias1)->NIVEL ,;
				"'"+(_cAlias1)->COD_EMPRESA ,;
				"'"+(_cAlias1)->COD_CONTRATO ,;
				"'"+(_cAlias1)->COD_SUBCON ,;
				(_cAlias1)->MATRICULA ,;
				(_cAlias1)->DESC_EMPRESA ,;
				(_cAlias1)->DESC_SUBCON ,;
				"'"+(_cAlias1)->NUM_CLI ,;
				(_cAlias1)->CLIENTE ,;
				(_cAlias1)->PREFIXO ,;
				"'"+(_cAlias1)->NUM_TIT ,;
				(_cAlias1)->PARCELA ,;
				(_cAlias1)->TIPO ,;
				(_cAlias1)->PORTADOR ,;
				"'"+(_cAlias1)->FORMA_COBRANCA ,;
				(_cAlias1)->DT_EMISSAO ,;
				(_cAlias1)->DT_VENCREA ,;
				(_cAlias1)->VLR_TITULO ,;
				(_cAlias1)->ABATIMENTO ,;
				(_cAlias1)->VALOR_NCC ,;
				(_cAlias1)->SALDO ,;
				(_cAlias1)->SALDO_PARTIDA ,;
				"'"+(_cAlias1)->BORDERO ,;
				(_cAlias1)->ANOBASE ,;
				(_cAlias1)->MESBASE ,;
				"'"+(_cAlias1)->NUM_COBRANCA ,;
				(_cAlias1)->RPS ,;
				(_cAlias1)->NUM_NF ,;
				(_cAlias1)->STBLOQ ,;
				(_cAlias1)->DATBLO ,;
				(_cAlias1)->CODBLOQ ,;
				(_cAlias1)->MOTBLOQ ,;
				(_cAlias1)->TP_PESSOA ,;
				(_cAlias1)->ENDERECO ,;
				(_cAlias1)->MUNICIPIO ,;
				(_cAlias1)->ESTADO ,;
				(_cAlias1)->BAIRRO ,;
				(_cAlias1)->CEP ,;
				(_cAlias1)->FONE ,;
				(_cAlias1)->CPF_CNPJ ,;
				(_cAlias1)->EMAIL ,;
				(_cAlias1)->MODALIDADE } )
			
			(_cAlias1)->( dbSkip() ) 
		End
	
	EndIf

	If len(aDados) < 2
	
		Aviso("Alerta", "Nใo hแ dados a serem gerados. Verifique os parametros informados" ,{"Continuar"})
		U_CABR155()
	
	else
	
		aAdd(aDados ,{"Fim"} )	
		DlgToExcel({{"ARRAY",cTitulo ,aCabec,aDados}}) //Gera Excel
	
	EndIf
	
	If Select(_cAlias1) > 0
		(_cAlias1)->(DbCloseArea())
	EndIf

	RestArea(aArea)
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR155B  บAutor  ณAnderson Rangel       บ Data ณ  DEZ/2021 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina responsavel por gerar o relat๓rio em CSV, pois       บฑฑ
ฑฑบ          ณalguns usuแrios nใo possuem o Excel.                        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ | INTEGRAL                                          บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CABR155B(cAlias2)
	
	Local _aArea 		:= GetArea()
	Local _cQuery		:= ""
	Local nHandle 		:= 0
	Local cNomeArq		:= ""
	Local cMontaTxt		:= ""
	Local _nI 	  		:= 0

	Private _cAlias2	:= GetNextAlias()
	
	ProcRegua(RecCount())
	
	cNomeArq := "C:\TEMP\RELATORIO_DE_INADIMPLENCIA"
	cNomeArq += "_" + SUBSTR(DTOS(DATE()),7,2)
	cNomeArq += "_" + SUBSTR(DTOS(DATE()),5,2)
	cNomeArq += "_" + SUBSTR(DTOS(DATE()),1,4)
	cNomeArq += "_" + STRTRAN(TIME(),":","_") + ".csv"
	
	_cQuery := CABR155QRY()
	
	If Select(_cAlias2) > 0
		(_cAlias2)->(DbCloseArea())
	EndIf
	
	DbUseArea(.T.,"TOPCONN",TcGenQry(,,_cQuery),_cAlias2,.T.,.T.)
	
	For _nI := 1 to 5
		IncProc('Processando...')
	Next

	While !(_cAlias2)->(EOF())
		
		IncProc()
		
		//------------------------------------------------------------------
		//Se for a primeira vez, deve ser criado o arquivo e o cabe็alho
		//------------------------------------------------------------------
		If nHandle = 0
			
			//------------------------------------------------------------------
			// criar arquivo texto vazio a partir do root path no servidor
			//------------------------------------------------------------------
			nHandle := FCREATE(cNomeArq)
			
			If nHandle > 0
				
				cMontaTxt := "NIVEL ; "
				cMontaTxt += "COD_EMPRESA ; "
				cMontaTxt += "COD_CONTRATO ; "
				cMontaTxt += "COD_SUBCON ; "
				cMontaTxt += "MATRICULA ; "
				cMontaTxt += "DESC_EMPRESA ; "
				cMontaTxt += "DESC_SUBCON ; "
				cMontaTxt += "NUM_CLI ; "
				cMontaTxt += "CLIENTE ; "
				cMontaTxt += "EMPRESA ; "
				cMontaTxt += "PREFIXO ; "
				cMontaTxt += "NUM_TIT ; "
                cMontaTxt += "PARCELA ; "
                cMontaTxt += "TIPO ; "
                cMontaTxt += "PORTADOR ; "
				cMontaTxt += "FORMA_COBRANCA ; "
				cMontaTxt += "DT_EMISSAO ; "
				cMontaTxt += "DT_VENCREA ; "
				cMontaTxt += "VLR_TITULO ; "
				cMontaTxt += "ABATIMENTO ; "
				cMontaTxt += "VALOR_NCC ; "
				cMontaTxt += "SALDO ; "
				cMontaTxt += "SALDO_PARTIDA ; "
				cMontaTxt += "BORDERO ; "
				cMontaTxt += "ANOBASE ; "
				cMontaTxt += "MESBASE ; "
				cMontaTxt += "NUM_COBRANCA ; "
				cMontaTxt += "RPS ; "
				cMontaTxt += "NUM_NF ; "
				cMontaTxt += "STBLOQ ; "
				cMontaTxt += "DATBLO ; "
				cMontaTxt += "CODBLOQ ; "
				cMontaTxt += "MOTBLOQ ; "
				cMontaTxt += "TP_PESSOA ; "
				cMontaTxt += "ENDERECO ; "
				cMontaTxt += "MUNICIPIO ; "
				cMontaTxt += "ESTADO ; "
				cMontaTxt += "BAIRRO ; "
				cMontaTxt += "CEP ; "
				cMontaTxt += "FONE ; "
				cMontaTxt += "CPF_CNPJ ; "
				cMontaTxt += "EMAIL ; "
				cMontaTxt += "MODALIDADE ; "

				cMontaTxt += CRLF // Salto de linha para .csv (excel)
				
				FWrite(nHandle,cMontaTxt)
				
			Else
				
				Aviso("Aten็ใo","Nใo foi possํvel criar o relat๓rio",{"OK"})
				Exit
				
			EndIf
			
		EndIf
		
		cMontaTxt := AllTrim((_cAlias2)->NIVEL			) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->COD_EMPRESA		) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->COD_CONTRATO		) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->COD_SUBCON		) + ";"
		cMontaTxt += AllTrim((_cAlias2)->MATRICULA	    ) + ";"
		cMontaTxt += AllTrim((_cAlias2)->DESC_EMPRESA	    ) + ";"
		cMontaTxt += AllTrim((_cAlias2)->DESC_SUBCON    	) + ";"
		cMontaTxt += AllTrim((_cAlias2)->CLIENTE			) + ";"
		cMontaTxt += AllTrim((_cAlias2)->PREFIXO			) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->NUM_TIT	    	) + ";"
        cMontaTxt += AllTrim((_cAlias2)->PARCELA			) + ";"
		cMontaTxt += AllTrim((_cAlias2)->TIPO				) + ";"
		cMontaTxt += AllTrim((_cAlias2)->PORTADOR			) + ";
		cMontaTxt += "'" + AllTrim((_cAlias2)->FORMA_COBRANCA	) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->NUM_CLI			) + ";"
		cMontaTxt += AllTrim((_cAlias2)->DT_EMISSAO		) + ";"
		cMontaTxt += AllTrim((_cAlias2)->DT_VENCREA		) + ";"
		cMontaTxt += AllTrim((_cAlias2)->VLR_TITULO		) + ";"
		cMontaTxt += AllTrim((_cAlias2)->ABATIMENTO	    ) + ";"
		cMontaTxt += AllTrim((_cAlias2)->VALOR_NCC	    ) + ";"
		cMontaTxt += AllTrim((_cAlias2)->SALDO    		) + ";"
		cMontaTxt += AllTrim((_cAlias2)->SALDO_PARTIDA	) + ";"
		cMontaTxt += "'" + AllTrim((_cAlias2)->BORDERO			) + ";"
		cMontaTxt += AllTrim((_cAlias2)->ANOBASE	    	) + ";"
        cMontaTxt += AllTrim((_cAlias2)->MESBASE			) + ";"
		cMontaTxt += AllTrim((_cAlias2)->NUM_COBRANCA		) + ";"
		cMontaTxt += AllTrim((_cAlias2)->RPS				) + ";
		cMontaTxt += AllTrim((_cAlias2)->NUM_NF			) + ";"
		cMontaTxt += AllTrim((_cAlias2)->STBLOQ			) + ";"
		cMontaTxt += AllTrim((_cAlias2)->DATBLO			) + ";"
		cMontaTxt += AllTrim((_cAlias2)->CODBLOQ			) + ";"
		cMontaTxt += AllTrim((_cAlias2)->MOTBLOQ			) + ";"
		cMontaTxt += AllTrim((_cAlias2)->TP_PESSOA	    ) + ";"
		cMontaTxt += AllTrim((_cAlias2)->ENDERECO	        ) + ";"
		cMontaTxt += AllTrim((_cAlias2)->MUNICIPIO    	) + ";"
		cMontaTxt += AllTrim((_cAlias2)->ESTADO			) + ";"
		cMontaTxt += AllTrim((_cAlias2)->BAIRRO			) + ";"
		cMontaTxt += AllTrim((_cAlias2)->CEP	    		) + ";"
        cMontaTxt += AllTrim((_cAlias2)->FONE				) + ";"
		cMontaTxt += AllTrim((_cAlias2)->CPF_CNPJ			) + ";"
		cMontaTxt += AllTrim((_cAlias2)->EMAIL			) + ";
		cMontaTxt += AllTrim((_cAlias2)->MODALIDADE		) + ";"
		
		cMontaTxt += CRLF // Salto de linha para .csv (excel)
		
		FWrite(nHandle,cMontaTxt)
		
		(_cAlias2)->(DbSkip())
		
	EndDo
	
	If Select(_cAlias2) > 0
		(_cAlias2)->(DbCloseArea())
	EndIf
	
	If nHandle > 0
		
		// encerra grava็ใo no arquivo
		FClose(nHandle)
		
		MsgAlert("Relatorio salvo em: "+ cNomeArq)

	else
	
		Aviso("Alerta", "Nใo hแ dados a serem gerados. Verifique os parametros informados" ,{"Continuar"})
		U_CABR155()
		
	EndIf
	
	RestArea(_aArea)
	
Return(.T.)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  CABR155QRY  บAutor  ณAnderson Rangel      บ Data ณ  DEZ/2021 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina responsavel por tratar a query, facilitando assim    บฑฑ
ฑฑบ          ณa manuten็ใo do fonte.                                      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ / INTEGRAL                                          บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CABR155QRY()
	
	Local cQuery 		:= ""
	
	cQuery += "SELECT NIVEL, COD_EMPRESA, COD_CONTRATO, COD_SUBCON, MATRICULA, DESC_EMPRESA, DESC_SUBCON, NUM_CLI,																" +c_ent
	cQuery += "        CLIENTE, PREFIXO, NUM_TIT, PARCELA, TIPO, PORTADOR, FORMA_COBRANCA, DT_EMISSAO,															" +c_ent
	cQuery += "        DT_VENCREA, VLR_TITULO, ABATIMENTO, VALOR_NCC, SALDO, (VLR_TITULO-ABATIMENTO-NVL(VALOR_NCC,0)) SALDO_PARTIDA,                                    " +c_ent
	cQuery += "        BORDERO, ANOBASE, MESBASE, NUM_COBRANCA, RPS, NUM_NF,                                                                                            " +c_ent
	cQuery += "        (CASE WHEN UMOTBLOQ <> ' ' OR FMOTBLOQ <> ' ' OR SMOTBLOQ <> ' ' THEN 'BLOQUEADO'                                                                " +c_ent
	cQuery += "            ELSE 'ATIVO'                                                                                                                                 " +c_ent
	cQuery += "        END) STBLOQ,                                                                                                                                     " +c_ent
	cQuery += "        (CASE WHEN NIVEL = 'FAMILIA' THEN NVL(FDATBLO,UDATBLO)                                                                                           " +c_ent
	cQuery += "            ELSE SDATBLO                                                                                                                                 " +c_ent
	cQuery += "        END) DATBLO,                                                                                                                                     " +c_ent
	cQuery += "        (CASE WHEN NIVEL = 'FAMILIA' THEN NVL(FMOTBLOQ, UMOTBLOQ)                                                                                        " +c_ent
	cQuery += "            WHEN NIVEL = 'SUBCONTRATO' THEN SMOTBLOQ                                                                                                     " +c_ent
	cQuery += "            ELSE NULL                                                                                                                                    " +c_ent
	cQuery += "        END) CODBLOQ,                                                                                                                                    " +c_ent
	
	IF cEmpAnt == '01'
		cQuery += "        (CASE WHEN NIVEL = 'FAMILIA' THEN NVL(SIGA.RETORNA_COD_DESCRI_BLOQ(NIVEL,FMOTBLOQ,'C'),SIGA.RETORNA_COD_DESCRI_BLOQ(NIVEL,UMOTBLOQ,'C'))         " +c_ent
		cQuery += "            WHEN NIVEL = 'SUBCONTRATO' THEN SIGA.RETORNA_COD_DESCRI_BLOQ(NIVEL,SMOTBLOQ,'C')                                                             " +c_ent
	Else
		cQuery += "        (CASE WHEN NIVEL = 'FAMILIA' THEN NVL(SIGA.RETORNA_COD_DESCRI_BLOQ(NIVEL,FMOTBLOQ,'I'),SIGA.RETORNA_COD_DESCRI_BLOQ(NIVEL,UMOTBLOQ,'I'))         " +c_ent
		cQuery += "            WHEN NIVEL = 'SUBCONTRATO' THEN SIGA.RETORNA_COD_DESCRI_BLOQ(NIVEL,SMOTBLOQ,'I')																" +c_ent
	EndIf
	
	cQuery += "            ELSE NULL                                                                                                                                    " +c_ent
	cQuery += "        END) MOTBLOQ,                                                                                                                                    " +c_ent
	cQuery += "        TP_PESSOA, ENDERECO, MUNICIPIO, ESTADO, BAIRRO, CEP, FONE, CPF_CNPJ, EMAIL, MODALIDADE                                                           " +c_ent
	cQuery += "FROM (                                                                                                                                                   " +c_ent
	cQuery += "    SELECT DISTINCT                                                                                                                                      " +c_ent
	cQuery += "        (CASE                                                                                                                                            " +c_ent
	cQuery += "            WHEN TRIM(BA3_VENCTO) <> ' ' THEN 'FAMILIA'                                                                                                  " +c_ent
	cQuery += "            WHEN TRIM(BQC_VENCTO) <> ' ' THEN 'SUBCONTRATO'                                                                                              " +c_ent
	cQuery += "            WHEN TRIM(BT5_VENCTO) <> ' ' THEN 'CONTRATO' ELSE 'EMPRESA'                                                                                  " +c_ent
	cQuery += "        END) NIVEL,                                                                                                                                      " +c_ent
	cQuery += "        NVL(BA1_CODEMP,SE1.E1_CODEMP) COD_EMPRESA,                                                                                                       " +c_ent
	cQuery += "        NVL(BA1_CONEMP,SE1.E1_CONEMP) COD_CONTRATO,                                                                                                      " +c_ent
	cQuery += "        NVL(BA1_SUBCON,SE1.E1_SUBCON) COD_SUBCON,                                                                                                        " +c_ent
	cQuery += "        FORMATA_MATRICULA_MS(BA1_CODINT||BA1_CODEMP||BA1_MATRIC||BA1_TIPREG||BA1_DIGITO) MATRICULA,                                                      " +c_ent
	
	IF cEmpAnt == '01'
		cQuery += "        RETORNA_DESCRI_GRUPOEMP('C',NVL(BA1_CODEMP,SE1.E1_CODEMP)) DESC_EMPRESA,                                                                         " +c_ent
		cQuery += "        RETORNA_DESC_SUBCONTRATO('C',NVL(BA1_CODEMP,SE1.E1_CODEMP),NVL(BA1_CONEMP,SE1.E1_CONEMP),NVL(BA1_SUBCON,SE1.E1_SUBCON)) DESC_SUBCON,             " +c_ent
	Else
		cQuery += "        RETORNA_DESCRI_GRUPOEMP('I',NVL(BA1_CODEMP,SE1.E1_CODEMP)) DESC_EMPRESA,                                                                         " +c_ent
		cQuery += "        RETORNA_DESC_SUBCONTRATO('I',NVL(BA1_CODEMP,SE1.E1_CODEMP),NVL(BA1_CONEMP,SE1.E1_CONEMP),NVL(BA1_SUBCON,SE1.E1_SUBCON)) DESC_SUBCON,             " +c_ent
	EndIf
	
	cQuery += "        NVL(TRIM(BA1_NOMUSR),A1_NOME) CLIENTE,                                                                                                           " +c_ent
	cQuery += "        SE1.E1_PREFIXO PREFIXO,                                                                                                                          " +c_ent
	cQuery += "        SE1.E1_NUM NUM_TIT,                                                                                                                              " +c_ent
	cQuery += "        SE1.E1_PARCELA PARCELA,                                                                                                                          " +c_ent
	cQuery += "        SE1.E1_TIPO TIPO,                                                                                                                                " +c_ent
	cQuery += "        SE1.E1_PORTADO PORTADOR,                                                                                                                         " +c_ent
	cQuery += "        SE1.E1_FORMREC FORMA_COBRANCA,                                                                                                                   " +c_ent
	cQuery += "        A1_COD NUM_CLI,                                                                                                                                  " +c_ent
	cQuery += "        TO_DATE(SE1.E1_EMISSAO,'YYYYMMDD') DT_EMISSAO,                                                                                                   " +c_ent
	cQuery += "        TO_DATE(SE1.E1_VENCREA,'YYYYMMDD') DT_VENCREA,                                                                                                   " +c_ent
	cQuery += "        SE1.E1_VALOR VLR_TITULO,                                                                                                                         " +c_ent
	cQuery += "        (SE1.E1_INSS + SE1.E1_ISS + SE1.E1_IRRF + SE1.E1_PIS + SE1.E1_COFINS + SE1.E1_CSLL) ABATIMENTO,                                                  " +c_ent
	cQuery += "        SE1_NCC.E1_VALOR VALOR_NCC,                                                                                                                      " +c_ent
	cQuery += "        SE1.E1_SALDO SALDO,                                                                                                                              " +c_ent
	cQuery += "        SE1.E1_NUMBOR BORDERO,                                                                                                                           " +c_ent
	cQuery += "        SE1.E1_ANOBASE ANOBASE,                                                                                                                          " +c_ent
	cQuery += "        SE1.E1_MESBASE MESBASE,                                                                                                                          " +c_ent
	cQuery += "        SE1.E1_PLNUCOB NUM_COBRANCA,                                                                                                                     " +c_ent
	cQuery += "        SE1.E1_XDOCNF RPS,                                                                                                                               " +c_ent
	
	IF cEmpAnt == '01'
		cQuery += "        RETORNA_NF_SAIDA('C', SE1.E1_XDOCNF, SE1.E1_XSERNF, SE1.E1_CLIENTE, SE1.E1_LOJA) NUM_NF,                                                         " +c_ent
		cQuery += "        RETORNA_NIVEL_BLOQ(BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG,BA1_DATBLO,'C') NIVBLOQ,															" +c_ent
	Else
		cQuery += "        RETORNA_NF_SAIDA('I', SE1.E1_XDOCNF, SE1.E1_XSERNF, SE1.E1_CLIENTE, SE1.E1_LOJA) NUM_NF,                                                         " +c_ent
		cQuery += "        RETORNA_NIVEL_BLOQ(BA1_CODINT,BA1_CODEMP,BA1_MATRIC,BA1_TIPREG,BA1_DATBLO,'I') NIVBLOQ,															" +c_ent
	EndIf

	cQuery += "        TO_DATE(TRIM(BA1_DATBLO),'YYYYMMDD') UDATBLO, TO_DATE(TRIM(BA3_DATBLO),'YYYYMMDD') FDATBLO, TO_DATE(TRIM(BQC_DATBLO),'YYYYMMDD') SDATBLO,        " +c_ent                                                          
	cQuery += "        BA1_MOTBLO UMOTBLOQ,                                                                                                                             " +c_ent
	cQuery += "        BA3_MOTBLO FMOTBLOQ,                                                                                                                             " +c_ent
	cQuery += "        BQC_CODBLO SMOTBLOQ,                                                                                                                             " +c_ent
	cQuery += "        DECODE(A1_PESSOA,'F','FISICA','JURIDICA') TP_PESSOA,                                                                                             " +c_ent
	cQuery += "        TRIM(A1_END) ENDERECO,                                                                                                                           " +c_ent
	cQuery += "        TRIM(A1_MUN) MUNICIPIO,                                                                                                                          " +c_ent
	cQuery += "        TRIM(A1_EST) ESTADO,                                                                                                                             " +c_ent
	cQuery += "        TRIM(A1_BAIRRO) BAIRRO,                                                                                                                          " +c_ent
	cQuery += "        TRIM(A1_CEP) CEP,                                                                                                                                " +c_ent
	cQuery += "        TRIM(A1_DDD)||' '||TRIM(A1_TEL)||' / '||TRIM(A1_TELEX) FONE,                                                                                     " +c_ent
	cQuery += "        FORMATA_CPF_CNPJ(A1_CGC) CPF_CNPJ,                                                                                                               " +c_ent
	cQuery += "        LOWER(TRIM(A1_EMAIL)) EMAIL,                                                                                                                     " +c_ent
	cQuery += "        DECODE(RET_EMPRESA_PLANO_COPART('C',NVL(TRIM(BA1_CODPLA),BA3_CODPLA),BA1_CODEMP, BA1_CONEMP, BA1_SUBCON), 'S','COPART', 'MENSAL') MODALIDADE     " +c_ent                      
	cQuery += "    FROM " + RetSqlName("SE1") + " SE1                                                                                                                   " +c_ent
	cQuery += "                                                                                                                                                         " +c_ent
	cQuery += "    INNER JOIN " + RetSqlName("SA1") + "  SA1 ON A1_FILIAL = ' '                                                                                         " +c_ent
	cQuery += "    AND A1_COD = SE1.E1_CLIENTE                                                                                                                          " +c_ent
	cQuery += "    AND SA1.D_E_L_E_T_ = ' '                                                                                                                             " +c_ent
	cQuery += "                                                                                                                                                         " +c_ent
	cQuery += "    LEFT JOIN " + RetSqlName("BG9") + " BG9 ON BG9_FILIAL = ' '                                                                                         " +c_ent
	cQuery += "    AND BG9_CODINT = '0001'                                                                                                                              " +c_ent
	cQuery += "    AND BG9_CODIGO = SE1.E1_CODEMP                                                                                                                       " +c_ent
	cQuery += "    AND BG9.D_E_L_E_T_ = ' '                                                                                                                             " +c_ent
	cQuery += "                                                                                                                                                         " +c_ent
	cQuery += "    LEFT JOIN " + RetSqlName("BT5") + " BT5 ON BT5_FILIAL = ' '                                                                                         " +c_ent
	cQuery += "    AND BT5_CODINT = SE1.E1_CODINT                                                                                                                       " +c_ent
	cQuery += "    AND BT5_CODIGO = SE1.E1_CODEMP                                                                                                                       " +c_ent
	cQuery += "    AND BT5_NUMCON = SE1.E1_CONEMP                                                                                                                       " +c_ent
	cQuery += "    AND BT5.D_E_L_E_T_ = ' '                                                                                                                             " +c_ent
	cQuery += "                                                                                                                                                         " +c_ent
	cQuery += "    LEFT JOIN " + RetSqlName("BQC") + " BQC ON BQC_FILIAL = ' '                                                                                          " +c_ent
	cQuery += "    AND BQC_CODIGO = SE1.E1_CODINT||SE1.E1_CODEMP                                                                                                        " +c_ent
	cQuery += "    AND BQC_NUMCON = SE1.E1_CONEMP                                                                                                                       " +c_ent
	cQuery += "    AND BQC_SUBCON = SE1.E1_SUBCON                                                                                                                       " +c_ent
	cQuery += "    AND BQC.D_E_L_E_T_ = ' '                                                                                                                             " +c_ent
	cQuery += "                                                                                                                                                         " +c_ent
	cQuery += "    LEFT JOIN " + RetSqlName("BA3") + " BA3 ON BA3_FILIAL = ' '                                                                                          " +c_ent
	cQuery += "    AND BA3_CODINT = SE1.E1_CODINT                                                                                                                       " +c_ent
	cQuery += "    AND BA3_CODEMP = SE1.E1_CODEMP                                                                                                                       " +c_ent
	cQuery += "    AND BA3_MATRIC = SE1.E1_MATRIC                                                                                                                       " +c_ent
	cQuery += "    AND BA3.D_E_L_E_T_ = ' '                                                                                                                             " +c_ent
	cQuery += "                                                                                                                                                         " +c_ent
	cQuery += "    LEFT JOIN " + RetSqlName("BA1") + " BA1 ON BA1_FILIAL = ' '                                                                                          " +c_ent
	cQuery += "    AND BA1_CODINT = SE1.E1_CODINT 	                                                                                                                    " +c_ent
	cQuery += "    AND BA1_CODEMP = SE1.E1_CODEMP 	                                                                                                                    " +c_ent
	cQuery += "    AND BA1_MATRIC = SE1.E1_MATRIC 	                                                                                                                    " +c_ent
	cQuery += "    AND BA1_TIPUSU = 'T'  		                                                                                                                        " +c_ent
	cQuery += "    AND BA1.D_E_L_E_T_ = ' ' 	                                                                                                                        " +c_ent
	cQuery += "                                                                                                                                                         " +c_ent
	cQuery += "    LEFT JOIN " + RetSqlName("SE5") + " SE5 ON 				                                                                                            " +c_ent
	cQuery += "    SE5.E5_FILIAL 		= SE1.E1_FILIAL		                                                                                                            " +c_ent
	cQuery += "    AND SE5.E5_PREFIXO 	= SE1.E1_PREFIXO	                                                                                                            " +c_ent
	cQuery += "    AND SE5.E5_NUMERO 	= SE1.E1_NUM		                                                                                                            " +c_ent
	cQuery += "    AND SE5.E5_PARCELA 	= SE1.E1_PARCELA	                                                                                                            " +c_ent
	cQuery += "    AND SE5.E5_TIPO 	= SE1.E1_TIPO		                                                                                                                " +c_ent
	cQuery += "    AND SE5.E5_CLIFOR 	= SE1.E1_CLIENTE	                                                                                                            " +c_ent
	cQuery += "    AND SE5.E5_LOJA 	= SE1.E1_LOJA		                                                                                                                " +c_ent
	cQuery += "    AND SE5.D_E_L_E_T_ 	= ' ' 				                                                                                                            " +c_ent
	cQuery += "                                                                                                                                                         " +c_ent
	cQuery += "    LEFT JOIN " + RetSqlName("SE1") + " SE1_NCC ON 					                                                                                    " +c_ent
	cQuery += "    SE1_NCC.E1_FILIAL       = SE1.E1_FILIAL                                                                                                              " +c_ent
	cQuery += "    AND SE1_NCC.E1_PREFIXO  = SE1.E1_PREFIXO                                                                                                             " +c_ent
	cQuery += "    AND SE1_NCC.E1_NUM      = SE1.E1_NUM                                                                                                                 " +c_ent
	cQuery += "    AND SE1_NCC.E1_PARCELA  = SE1.E1_PARCELA                                                                                                             " +c_ent
	cQuery += "    AND SE1_NCC.E1_TIPO     = 'NCC'                                                                                                                      " +c_ent
	cQuery += "    AND SE1_NCC.E1_CLIENTE  = SE1.E1_CLIENTE                                                                                                             " +c_ent
	cQuery += "    AND SE1_NCC.E1_LOJA     = SE1.E1_LOJA                                                                                                                " +c_ent
	cQuery += "    AND SE1_NCC.D_E_L_E_T_  = ' '                                                                                                                        " +c_ent
	cQuery += "                                                                                                                                                         " +c_ent
	cQuery += "    WHERE  SE1.E1_FILIAL = '01'                                                                                                                          " +c_ent
	cQuery += "    AND    SE1.D_E_L_E_T_  = ' '                                                                                                                         " +c_ent
	cQuery += "    AND    SE1.E1_SALDO > 0                                                                                                                              " +c_ent
	
	If !EMPTY(dDatAte)
		
		cQuery += "    AND    SE1.E1_VENCREA BETWEEN '" +alltrim(dTos(dDatDe))+ "' AND '" +alltrim(dTos(dDatAte))+ "'                                                   " +c_ent
	
	EndIf

	If cNivel != "TODOS"
	
		cQuery += ") WHERE NIVEL = '"+cNivel+"'      																													" +c_ent			

		If !EMPTY(cEmpDe)
		
			cQuery += "AND COD_EMPRESA BETWEEN '"+cEmpDe+"' AND '"+cEmpAte+"'                                                                                          	" +c_ent
			
			If !EMPTY(cConDe)
			
				cQuery += "AND COD_CONTRATO BETWEEN '"+cConDe+"' AND '"+cConAte+"' 																						" +c_ent

				If !EMPTY(cSubDe)

				cQuery += "AND COD_SUBCON BETWEEN '"+cSubDe+"' AND '"+cSubAte+"'                                                                                        " +c_ent
				
				EndIf
			
			EndIf
		
		EndIf

	Else

		cQuery += " )                                                                                             														" +c_ent

		If !EMPTY(cEmpDe)
		
			cQuery += "WHERE COD_EMPRESA BETWEEN '"+cEmpDe+"' AND '"+cEmpAte+"'                                                                                         " +c_ent
			
			If !EMPTY(cConDe)
			
				cQuery += "AND COD_CONTRATO BETWEEN '"+cConDe+"' AND '"+cConAte+"' 																						" +c_ent

				If !EMPTY(cSubDe)

				cQuery += "AND COD_SUBCON BETWEEN '"+cSubDe+"' AND '"+cSubAte+"'                                                                                        " +c_ent
				
				EndIf
			
			EndIf
		
		EndIf         																																					

	EndIf
	
	cQuery += "ORDER BY 1,2,3,4,5,17                                                                                                                                    " +c_ent
	
	memowrite("C:\temp\CABR155.sql",cQuery)
	
Return cQuery

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma ณCABR155PERG  บAutor  ณAnderson Rangel     บ Data ณ  DEZ/2021 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina responsavel pela gera็ใo das perguntas no relat๓rio  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ | INTEGRAL                                          บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CABR155PERG(_cPerg)

	u_CABASX1(_cPerg,"01","Nivel:  "  		,"","","mv_ch01","C",1,0,0,"C",""		,"","","","mv_par01","TODOS"    ,"","","","FAMILIA"  ,"","","SUBCONTRATO","","","CONTRATO","","","EMPRESA","","",{},{},{})
	u_CABASX1(_cPerg,"02","Empresa de:  "  	,"","","mv_ch02","C",04,0,0,"G","BG9PLS","","","","mv_par02","","","","","","","","","","","","","","","","",{},{},{})
	u_CABASX1(_cPerg,"03","Empresa ate:  "  ,"","","mv_ch03","C",04,0,0,"G","BG9PLS","","","","mv_par03","","","","","","","","","","","","","","","","",{},{},{})
	u_CABASX1(_cPerg,"04","Contrato de:  "  ,"","","mv_ch04","C",12,0,0,"G","BT5PLS","","","","mv_par04","","","","","","","","","","","","","","","","",{},{},{})
	u_CABASX1(_cPerg,"05","Contrato ate:  " ,"","","mv_ch05","C",12,0,0,"G","BT5PLS","","","","mv_par05","","","","","","","","","","","","","","","","",{},{},{})
	u_CABASX1(_cPerg,"06","SubContrato de:" ,"","","mv_ch06","C",09,0,0,"G","BQCPLS","","","","mv_par06","","","","","","","","","","","","","","","","",{},{},{})
	u_CABASX1(_cPerg,"07","SubContrato ate:","","","mv_ch07","C",09,0,0,"G","BQCPLS","","","","mv_par07","","","","","","","","","","","","","","","","",{},{},{})
	u_CABASX1(_cPerg,"08","Vencimento de:  ","","","mv_ch08","D",08,0,0,"C",""		,"","","","mv_par08","","","","","","","","","","","","","","","","",{},{},{})
	u_CABASX1(_cPerg,"09","Vencimento ate: ","","","mv_ch09","D",08,0,0,"C",""		,"","","","mv_par09","","","","","","","","","","","","","","","","",{},{},{})

Return

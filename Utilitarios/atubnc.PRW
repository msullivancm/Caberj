#include "Tbiconn.ch"
#include "rwmake.ch"
#include "Topconn.ch"
#include "protheus.ch"
#include "Fileio.ch"

/*
Programa ATUBNC
Autor: Mateus
Data: 20/08/2018
Descrição: Programa criado para atualizar todas as tabelas do banco de dados conforme o padrão estabelecido no dicionário de dados.
*/

//Exemplo de chamada da rotina:  u_ATUBNC()

User function ATUBNC            
	Private aEmpresa := {"02"} // Caso haja mais empresas, inclua-as separado por vírgula. Ex.: {"01","02","03"}
	Private cCaminho := "\Data\" // Necessário copiar a SX3 antiga para esse caminho antes de executar a rotina
	Private cDriver	 := "CTREECDX" // Driver de conexão com a tabela. Pode ser "CTREECDX" para CTree ou "DBFCDX" para ADS.
	Private cExt	 := ".DTC" // Extensão da tabela. Pode ser ".DTC" para CTree ou ".DBF" para ADS.
	Private cSystem	 := "/system/" // Atenção, pode haver cliente que utiliza sigaadv ao invés de system
	Private cE	 	 := "" // Variáve para armazenar o número da empresa atual.
	
	For nY := 1 To Len(aEmpresa)
		RpcSetType(3)
		RpcSetEnv(aEmpresa[nY])
			cE := aEmpresa[nY]
			Processa( {|| APATUBNC() }, "Aguarde...", "Atualizando tabelas no banco de dados",.F.)
		RpcClearEnv()
	Next nY

Return

Static Function APATUBNC()

	Local aLinha 	:= {}
	Local cNome 	:= "ATUBNC"
	Local cLog 		:= cCaminho + cNome + cE + ".log"
                    		
	Local cAreaTMP := ""  
	cAreaTMP := GetArea()
	
	QOut(cNome+": " + DtoC(Date()) + " " + Time())

		If File(cLog)
			QOut("Já executado: " + DtoC(Date()) + " " + Time())
		Else
		
			// Como a SX2 já está aberta, somente pontera para o primeiro registro. 
			SX2->(dbSetOrder(1)) // Ordena tabela por X2_CHAVE
			SX2->(dbGoTop())      
			
			ProcRegua(SX2->(RECCOUNT()))
			While SX2->(!eOF())
				
				IncProc("Processando " + SX2->X2_ARQUIVO)
				
					If Select((SX2->X2_CHAVE)) > 0
						DbCloseArea((SX2->X2_CHAVE))
					EndIf
					
					if substr(ALLTRIM(SX2->X2_CHAVE), 1, 1) == 'S'
						QOut("ALIAS= " + PADR(ALLTRIM(SX2->X2_CHAVE), 6, ' ') + " TABELA= " + PADR(ALLTRIM(SX2->X2_ARQUIVO), 6, ' '))
							X31UPDTABLE((SX2->X2_CHAVE))
						QOut( "ALIAS= " + PADR(ALLTRIM(SX2->X2_CHAVE), 6, ' ') + " TABELA= " + PADR(ALLTRIM(SX2->X2_ARQUIVO), 6, ' ') )  
					endif 
					
				SX2->(DBSkip())

			
			EndDo
			
			SX2->(DBCloseArea())   
		                   
			//fLog(aLinha,cLog,cNome)
	
		EndIf    

	RestArea(cAreaTMP)
	
	MsgInfo("TABELAS ATUALIZADAS NO BANCO DE DADOS. Log da operação no caminho: " + cLog)	

Return

Static Function fLog(aLinha,cLog,cNome)
	Default	cLog := cCaminho + cNome + cE + ".log"

	If File(cLog)
		QOut("Já executado: " + DtoC(Date()) + " " + Time())
		Return
	Else
		nArquivo := fcreate(cLog, FC_NORMAL)
	EndIf
	if ferror() # 0
		msgalert ("ERRO AO CRIAR O ARQUIVO, ERRO: " + str(ferror()))
		lFalha := .t.
	else
		for nLinha := 1 to len(aLinha)
			fwrite(nArquivo, aLinha[nLinha] + chr(13) + chr(10))
			if ferror() # 0
				msgalert ("ERRO GRAVANDO ARQUIVO, ERRO: " + str(ferror()))
				lFalha := .t.
			endif
		next
	endif
	fclose(nArquivo)
Return           

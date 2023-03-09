#include "Tbiconn.ch"
#include "rwmake.ch"
#include "Topconn.ch"
#include "protheus.ch"
#include "Fileio.ch"

/*
Programa VolSX3
Autor: Sullivan
Data: 30/01/2014
Descrição: Programa criado para voltar os ajustes da SX3 no campo GRPSXG após o migrador.
*/

//Exemplo de chamada da rotina:  u_volSX3()

User function VolSX3            
	Private aEmpresa := {"01"}
		
	Private cCaminho := "\Data\" 
	
	For nY := 1 To Len(aEmpresa)
		RpcSetType(3)
		RpcSetEnv(aEmpresa[nY])
			Processa( {|| app() }, "Aguarde...", "Restaurando grupos de campo da SX3",.F.)
		RpcClearEnv()
	Next nY
	
	MsgInfo("Processo concluído!")
Return

Static Function app()
	Processa( {|| APLerSX3() }, "Aguarde...", "Restaurando grupos de campo da SX3",.F.)
Return

Static Function APLerSX3()   
	Local aLinha := {}
	
	Local cLog := cCaminho + "CorSX3" + cEmpAnt + ".log"

	If File(cLog)
		aLinha := fLeLog(cLog)
	
		dbSelectArea("SX3")
		
		ProcRegua(Len(aLinha))
		For nI := 1 To Len(aLinha)         
					
			SX3->(dbGoTop()) 	
			SX3->(dbSetOrder(2)) // Ordena por campo 
				
			If SX3->(dbSeek(aLinha[nI][1])) //  campo
					IncProc("Processando registro: " + aLinha[nI][1]+","+aLinha[nI][2]+","+aLinha[nI][3])
					RecLock("SX3", .F.) // Se conseguiu lockar a tabela executa
					SX3->X3_GRPSXG := aLinha[nI][3] // Volta com o valor corrigido
					SX3->(MsUnLock()) //Confirma e finaliza a operação
			Endif
			SX3->(DBSkip())
			
		Next 
		SX3->(DBCloseArea())
	Else 
		Alert("Arquivo não encontrado.")
	EndIf
		
Return

Static Function fLeLog(cLog)
	Local aLinha := {}
	// Abre o arquivo
	nHandle := FT_FUse(cLog) // Se houver erro de abertura abandona processamento
/*	if ferror() # 0
		msgalert ("ERRO AO ABRIR O ARQUIVO, ERRO: " + str(ferror()))
		return    
	endif */
	// Posiciona na primeria linha
	FT_FGoTop()
	// Retorna o número de linhas do arquivo
	nLast := FT_FLastRec()

	While !FT_FEOF()   
		cLine  := FT_FReadLn() // Retorna a linha corrente  
		aAdd(aLinha, Separa(cLine,',',.f.) )
		// Pula para próxima linha  
		FT_FSKIP()
	EndDo// Fecha o Arquivo
	FT_FUSE()
Return aLinha
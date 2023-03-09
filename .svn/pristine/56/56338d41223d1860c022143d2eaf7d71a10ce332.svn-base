#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"

User Function UpdBD7  

Private cPath := cGetFile('Arquivos CSV|*.CSV','CSV',1,, .F., GETF_LOCALHARD+GETF_LOCALFLOPPY+GETF_NETWORKDRIVE ,.T., .T.)

Processa({||AtuBD7()},'Processando...')

Return

***********************************************

Static Function AtuBD7   

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

dbSelectArea('BD7')

Begin Transaction 

// Abre o arquivo
nHandle := FT_FUSE(cPath)

// Posiciona na primeira linha
FT_FGoTop()  

ProcRegua(0) 
           
For i := 1 to 5
	IncProc("Abrindo arquivo...")
Next

// Retorna o numero de linhas do arquivo
nLinhas := FT_FLastRec() 
nCont 	:= 0             
nAtu	:= 0

ProcRegua(nLinhas) 

IncProc(allTrim(Transform(++nCont,"@E 999,999,999,999")) + '/' + allTrim(Transform(nLinhas,"@E 999,999,999,999")))

aCabec 		:= limpaAspas(strTokArr(FT_FReadLn(),';'))

nPosRecno 	:= aScan(aCabec,"R_E_C_N_O_")
nPosDelet 	:= aScan(aCabec,"D_E_L_E_T_")
nPosVLRPAG	:= aScan(aCabec,"BD7_VLRPAG")         
nPosVLRGLO	:= aScan(aCabec,"BD7_VLRGLO")
nPosLOTBLO	:= aScan(aCabec,"BD7_LOTBLO")
nPosVGLANT	:= aScan(aCabec,"BD7_VGLANT")

FT_FSKIP()

While !FT_FEOF()

	aLinha	:= strTokArr(FT_FReadLn(),';')
    
	//Se estiver deletado -> loop
	If !empty(aLinha[nPosDelet]) 
		IncProc(allTrim(Transform(++nCont,"@E 999,999,999,999")) + '/' + allTrim(Transform(nLinhas,"@E 999,999,999,999")) + '- Pulando...')
		FT_FSKIP()
		loop	
	EndIf

  	BD7->(dbGoTo(val(aLinha[nPosRecno])))
  	
  	If BD7->BD7_CODRDA == '111406'//Bronstein
    
    	IncProc(allTrim(Transform(++nCont,"@E 999,999,999,999")) + '/' + allTrim(Transform(nLinhas,"@E 999,999,999,999")) + '- Atualizando...')
    	
	   	BD7->(RecLock("BD7",.F.))
	    	
	  	BD7->BD7_VLRPAG := val(aLinha[nPosVLRPAG])
	   	BD7->BD7_VLRGLO := val(aLinha[nPosVLRGLO])
	   	BD7->BD7_LOTBLO := aLinha[nPosLOTBLO]
	   	BD7->BD7_VGLANT := val(aLinha[nPosVGLANT])
	   		
	   	BD7->(MsUnlock())
	   	
	   	nAtu++
	   	
	Else
	
		IncProc(allTrim(Transform(++nCont,"@E 999,999,999,999")) + '/' + allTrim(Transform(nLinhas,"@E 999,999,999,999")) + '- Pulando...')
	
	EndIf

	FT_FSKIP()
  	
EndDo

// Fecha o Arquivo
FCLOSE(nHandle)
FT_FUSE()

End Transaction

MsgInfo('Atualizados: ' + allTrim(Transform(nAtu,"@E 999,999,999,999")) + ' de ' + allTrim(Transform(nLinhas,"@E 999,999,999,999")))

Return    

*******************************************************

Static Function limpaAspas(aLimpar)

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
           
Local aRet := {}

For i := 1 to len(aLimpar)
    
	aAdd(aRet,allTrim(upper(strTran(aLimpar[i],'"',''))))

Next

Return aRet
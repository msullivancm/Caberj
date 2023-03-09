#INCLUDE "rwmake.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABA015   บ Autor ณ Luzio Tavares      บ Data ณ  08/02/2010 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ IMPORTA TABELA DE ENDERECOS DO ITAU                        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

User Function CABA015()
Local cPath := GetNewPar("MV_YPATHCR","\interface\importa\itaubenef\recebidos\")
Local cDirLido  := GetNewPar("MV_XPATHCL","\interface\importa\itaubenef\processados\")
Local cFileDest := Space(0) 
Local nTipArq   := 0
Local _aArea    := GetArea()
Local cArqTmp	:= Space(0)
Local nCont		:= 0  
Local cChar     := Space(0)
Local cBuffer   := ''
Local nHandle

Private cArquivo := Space(0)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de Variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
cString := "TRB"
cPerg	:= "CABA15"

CRIASX1(cPerg)

//ValidPerg()

If !Pergunte(cPerg, .T.)
	Return
EndIf

cArquivo := AllTrim(mv_par02)
nPos := AT(".EN",Upper(cArquivo))
If !File(cArquivo)
	MsgBox('Arquivo '+cArquivo+' nao encontrado. Verifique.','Erro no Processo','ALERT')
	Return
EndIf
If nPos == 0
	MsgBox('Arquivo '+cArquivo+' invalido. So eh possivel importar arquivo com a extensao EN. Verifique.','Erro no Processo','ALERT')
	Return
EndIf

If !MsgBox('Este programa ira importar a tabela de enderecos dos orgaos do Itau e Unibanco. '+CHR(13)+'Deseja Continuar?', "Confirma processamento?","YESNO")
	Return
EndIf

If Substr(cPath,Len(cPath),1) <> "\"
	cPath := cPath + "\"
Endif
                  
While .T.
	nPos := AT("\",Upper(cArquivo))
	If nPos > 0
	    nPos += 1
		cArquivo := SubStr(cArquivo,nPos)
	Else 
	   Exit	
	EndIf	
EndDo

cFile     := Alltrim(cPath + cArquivo)
cFileDest := Alltrim(cDirLido + cArquivo)

If (nHandle := FT_FUse( cFile )) == -1
	Help(" ",1,"NOFLEIMPOR")
//		Return(nRet)
	Return()
Endif
FT_FGOTOP()

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Processamento da importacao...                                           ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Processa({|| CABA015IMP()},'Importando Arquivo...')

FT_FUSE()

COPY FILE &cArquivo TO &cFileDest

// Apaga fisicamente arquivo da pasta de origem apos ser copiado.
fErase(cArquivo)

MsgBox('Importacao concluida','Fim do Processamento','ALERT')

RestArea(_aArea)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABA015IMPบAutor  ณLuzio Tavares       บ Data ณ  12/08/2009 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณExecucao da rotina de atualizacao de TDE, composicao de     บฑฑ
ฑฑบ          ณvalores e tabela padrao.                                    บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CABA015IMP()
Local cOper	    := mv_par01
Local cSQL      := Space(0)

cSQL := "DELETE FROM " + Z01->(RetSQLName("Z01"))+" "
cSQL += "WHERE Z01_FILIAL = '"+xFilial("Z01")+"' AND D_E_L_E_T_ = ' '"
PLSSQLEXEC(cSQL)

Z01->( dbSetOrder(1) )

dbGoTop()

//Begin Transaction

While ( ! FT_FEOF() )
	
	cBuffer := AllTrim(FT_FREADLN())
	
	Z01->(RecLock("Z01",.T.))
	Z01->Z01_IDTEMP  := Substr(cBuffer,  1, 1)
	Z01->Z01_EMPCOL  := Substr(cBuffer,  2, 4)
	Z01->Z01_CODLOT  := Substr(cBuffer,  6,17)
	Z01->Z01_DESLOT  := Substr(cBuffer, 70,30)
	Z01->Z01_CDSORG  := Substr(cBuffer, 23, 7)
	Z01->Z01_ENDERE  := Substr(cBuffer, 30,40)
	Z01->Z01_CIDADE  := Substr(cBuffer,100,20)
	Z01->Z01_ESTADO  := Substr(cBuffer,120, 2)
	Z01->Z01_NOMLOT  := Substr(cBuffer,122,40)
	Z01->Z01_RESERV  := Substr(cBuffer,162,39)
	Z01->(MsUnlock())
		
	FT_FSKIP()
	
Enddo

//End Transaction

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ CriaSX1  บAutor  ณLuzio Tavares       บ Data ณ  15.01.2010 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Cria pergunta                                              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CriaSX1()

PutSx1(cPerg,"01","Operadora        ","","","mv_ch1","C",04,0,0,"G","NaoVazio()","B89PLS","S","","mv_par01","         ","","","0001","      ","","","       ","","","","","","","","",{},{},{},"")
PutSx1(cPerg,"02","Arquivo          ","","","mv_ch2","C",99,0,0,"G","NaoVazio()","DIR   ","S","","mv_par02","         ","","","    ","      ","","","       ","","","","","","","","",{},{},{},"")

Return
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �CABA591   �Autor  �                    � Data �  13/06/16   ���
�������������������������������������������������������������������������͹��
���Desc.     �Projeto controle de custo n�o solicitado por RDA            ���
�������������������������������������������������������������������������͹��
���Uso       �CABERJ                                                      ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

******************************************************************************************************************

Static cUsrAcesso := GetNewPar('MV_XCONCUS','000823') + "|" + GetMv('MV_XGETIN')+ "|" + GetMv('MV_XGERIN')

******************************************************************************************************************

User Function UsrConCus

If 	RetCodUsr() $ cUsrAcesso

	AxCadastro('ZRY','Acesso rotina controle custo n�o solicitado por RDA',;
					"Eval({||MsgStop('N�o � permitido excluir registros. Ao inv�s disso, bloqueie o registro desejado.',AllTrim(SM0->M0_NOMECOM)),.F.})")
	
Else

	MsgStop('Usu�rio sem acesso a rotina.',AllTrim(SM0->M0_NOMECOM))

EndIf

Return

******************************************************************************************************************

User Function CABA591

Private cPerg 		:= 'CABA591'
Private cPergIni	:= 'CB591IN'
Private cPergRet	:= 'CB591RE'
Private cCadastro 	:= 'Controle custo n�o solicitado por RDA'
Private aRotina 	:= {}  
Private aCores		:= {}
Private aSizeAut 	:= MsAdvSize(.T.)//Vai usar Enchoice 

If 	( RetCodUsr() $ cUsrAcesso )
 		
	aAdd(aCores,{"ZRZ->ZRZ_STATUS == 'N'" 	,"BR_BRANCO" 	})
	aAdd(aCores,{"ZRZ->ZRZ_TIPO == 'C'" 	,"BR_PRETO" 	})
	aAdd(aCores,{"ZRZ->ZRZ_TIPO == 'G'" 	,"BR_MARROM" 	})
	aAdd(aCores,{"ZRZ->ZRZ_TIPO == 'P'" 	,"BR_LARANJA" 	})
	aAdd(aCores,{"ZRZ->ZRZ_TIPO == 'H'" 	,"BR_VERMELHO" 	})
	aAdd(aCores,{"ZRZ->ZRZ_TIPO == 'G'" 	,"BR_VERDE" 	})
	
	aAdd(aRotina,{ "Adiamento"	,"U_AdiaCus"	,0,3})
 	aAdd(aRotina,{ "Retorno"	,"U_RetCus" 	,0,3})
 	aAdd(aRotina,{ "Legenda"	,"U_CB591Leg"	,0,3})  
 	
	AjustaSX1()
	
	If FilBrCC()

		mBrowse(aSizeAut[2],aSizeAut[1],aSizeAut[6],aSizeAut[5],'ZRZ',,,,,2,aCores)
		
		SET FILTER TO
		
	EndIf
		
Else

	MsgStop('Usu�rio sem acesso a rotina.',AllTrim(SM0->M0_NOMECOM))

EndIf

Return

******************************************************************************************************************

User Function AdiaCus

Local lContinua := .T.

Private cTipo	:= ''

If Pergunte(cPerg,.T.)

	If empty(mv_par02) .or. empty(mv_par03)
		MsgStop("Informe o ano e o m�s",AllTrim(SM0->M0_NOMECOM))	
		lContinua := .F.
	EndIf
	
	Do Case
	
		Case ( mv_par01 == 1 )
		
			cTipo := "PEG"
		
			If empty(mv_par04) .or. empty(mv_par05) .or. empty(mv_par06)
				MsgStop("Para adiamento do tipo [ " + cTipo + " ] dever� informar RDA, Local de digita��o e PEG.",AllTrim(SM0->M0_NOMECOM))	
				lContinua := .F.
			ElseIf !empty(mv_par07)
				MsgStop("Para adiamento do tipo [ " + cTipo + " ] n�o dever� informar n�mero da guia.",AllTrim(SM0->M0_NOMECOM))	
				lContinua := .F.
			EndIf
			
		Case ( mv_par01 == 2 )
		
			cTipo := "GUIA"
			
			If empty(mv_par04) .or. empty(mv_par05) .or. empty(mv_par06) .or. empty(mv_par07)
				MsgStop("Para adiamento do tipo [ " + cTipo + " ] dever� informar RDA, Local de digita��o, PEG e n�mero da guia.",AllTrim(SM0->M0_NOMECOM))	
				lContinua := .F.
			EndIf
				
		Case ( mv_par01 == 3 )
		
			cTipo := "RDA"
			
			If empty(mv_par04) .or. empty(mv_par05)
				MsgStop("Para adiamento do tipo [ " + cTipo + " ] dever� informar RDA e Local de digita��o.",AllTrim(SM0->M0_NOMECOM))	
				lContinua := .F.
			ElseIf !empty(mv_par06) .or. !empty(mv_par07)
				MsgStop("Para adiamento do tipo [ " + cTipo + " ] n�o dever� informar PEG nem n�mero da guia.",AllTrim(SM0->M0_NOMECOM))	
				lContinua := .F.
			EndIf
			
	End Case

	If lContinua
		Processa({||u_PAdiaCus()},"Adiamento de custo")
	EndIf
	
EndIf

Return

******************************************************************************************************************

User Function PAdiaCus

Local lSemaforo 	:= .F.
Local aRetSP		:= {}
Local nI			:= 0

ProcRegua(0)

For nI := 1 to 5
	IncProc('Processando adiamento de custo n�o solicitado...')
Next

While !( lSemaforo := LockByName("CABA591.SMF",.T.,.F.) )
	
	If ( Aviso(AllTrim(SM0->M0_NOMECOM),'Existe outro usu�rio acessando esta rotina...',{'Aguardar','Cancelar'}) == 2 )
		Exit
	Else
		Sleep(1000)
	EndIf
	
EndDo

If lSemaforo

	aRetSP := TcSPExec(	'CONTROLE_CUSTO_NAO_SOLICITADO',;
						If(cEmpAnt == '01','CABERJ','INTEGRAL'),;
						cTipo,;
						mv_par02,;
						StrZero(Val(mv_par03),2),;
						StrZero(Val(mv_par04),6),;
						StrZero(Val(mv_par05),4),;
						If(!empty(mv_par06),StrZero(Val(mv_par06),8),'-'),;
						If(!empty(mv_par07),StrZero(Val(mv_par07),8),'-'),;
						"PROTHEUS" )
	
	If Empty(aRetSP)
		MsgStop("Erro ao executar a procedure CONTROLE_CUSTO_NAO_SOLICITADO",AllTrim(SM0->M0_NOMECOM))
	Else
		
		If aRetSP[1] == 0
			MsgAlert("N�o foram localizadas guias com custo n�o solicitado para adiar.",AllTrim(SM0->M0_NOMECOM))
		Else
			MsgInfo("Custo n�o solicitado de [ " + cValToChar(aRetSP[1]) + " ] guia" + If(aRetSP[1] > 1,"s","") + " foi adiado.",AllTrim(SM0->M0_NOMECOM))
		EndIf
		
	EndIf

EndIf

UnLockByName("CABA591.SMF",.T.,.F.)

Return

******************************************************************************************************************

Static Function AjustaSX1

Local aHelp := {}

aAdd(aHelp, "Informe a o tipo de adiamento que deseja:")
aAdd(aHelp, "PEG, Guia ou RDA.")
aAdd(aHelp, "- Guia: Somente 1 �nica guia informada")
aAdd(aHelp, "- PEG: Todas as guias de 1 PEG informada")
aAdd(aHelp, "- RDA: Todas as PEGs e Guias do RDA informado")
aAdd(aHelp, "       na compet�ncia informada.")
PutSX1(cPerg , "01" , "Tipo","","","mv_ch1","C",1,0,0,"C","","","","","mv_par01","PEG","","","","Guia","","","RDA","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o ano (Obrigat�rio):")
PutSX1(cPerg , "02" , "Ano","","","mv_ch2","C",4,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o m�s (Obrigat�rio):")
PutSX1(cPerg , "03" , "M�s","","","mv_ch3","C",2,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o RDA (Obrigat�rio):")
PutSX1(cPerg , "04" , "RDA","","","mv_ch4","C",6,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o local de digita��o (Obrigat�rio):")
PutSX1(cPerg , "05" , "Local","","","mv_ch5","C",4,0,0,"G","","","","","mv_par05","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe a PEG (Opcional):")
aAdd(aHelp, "( V�lido apenas se o primeiro par�metro")
aAdd(aHelp, "  for PEG ou Guia )")
PutSX1(cPerg , "06" , "PEG","","","mv_ch6","C",8,0,0,"G","","","","","mv_par06","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe a guia (Opcional):")
aAdd(aHelp, "( V�lido apenas se o primeiro par�metro")
aAdd(aHelp, "  for PEG ou Guia )")
PutSX1(cPerg , "07" , "Guia","","","mv_ch7","C",8,0,0,"G","","","","","mv_par07","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

*'**************************************************************************************************************'*

aHelp := {}
aAdd(aHelp, "Visualiza PEG?")
PutSX1(cPergIni , "01" , "Vis. PEG"		,"","","mv_ch1","C",1,0,0,"C","","","","","mv_par01","Sim","","","","","","",,"","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Visualiza Guia?")
PutSX1(cPergIni , "02" , "Vis. Guia"	,"","","mv_ch2","C",1,0,0,"C","","","","","mv_par02","Sim","","","","","","",,"","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Visualiza Procedimento?")
PutSX1(cPergIni , "03" , "Vis. Proc."	,"","","mv_ch3","C",1,0,0,"C","","","","","mv_par03","Sim","","","","N�o","","",,"","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Visualiza Honor�rio?")
PutSX1(cPergIni , "04" , "Vis. Hon."	,"","","mv_ch4","C",1,0,0,"C","","","","","mv_par04","Sim","","","","N�o","","",,"","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Visualiza hist�rico de glosa?")
PutSX1(cPergIni , "05" , "Vis. Glosa"	,"","","mv_ch5","C",1,0,0,"C","","","","","mv_par05","Sim","","","","N�o","","",,"","","","","","","","",aHelp,aHelp,aHelp)

*'**************************************************************************************************************'*

aHelp := {}
aAdd(aHelp, "Informe a o tipo de retorno que deseja:")
aAdd(aHelp, "PEG, Guia ou RDA.")
aAdd(aHelp, "- Guia: Somente 1 �nica guia informada")
aAdd(aHelp, "- PEG: Todas as guias de 1 PEG informada")
aAdd(aHelp, "- RDA: Todas as PEGs e Guias do RDA informado")
aAdd(aHelp, "       na compet�ncia informada.")
PutSX1(cPergRet , "01" , "Tipo","","","mv_ch1","C",1,0,0,"C","","","","","mv_par01","PEG","","","","Guia","","","RDA","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o ano (Obrigat�rio):")
PutSX1(cPergRet , "02" , "Ano","","","mv_ch2","C",4,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o m�s (Obrigat�rio):")
PutSX1(cPergRet , "03" , "M�s","","","mv_ch3","C",2,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o RDA (Obrigat�rio):")
PutSX1(cPergRet , "04" , "RDA","","","mv_ch4","C",6,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o local de digita��o (Obrigat�rio):")
PutSX1(cPergRet , "05" , "Local","","","mv_ch5","C",4,0,0,"G","","","","","mv_par05","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe a PEG (Opcional):")
aAdd(aHelp, "( V�lido apenas se o primeiro par�metro")
aAdd(aHelp, "  for PEG ou Guia )")
PutSX1(cPergRet , "06" , "PEG","","","mv_ch6","C",8,0,0,"G","","","","","mv_par06","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe a guia (Opcional):")
aAdd(aHelp, "( V�lido apenas se o primeiro par�metro")
aAdd(aHelp, "  for PEG ou Guia )")
PutSX1(cPergRet , "07" , "Guia","","","mv_ch7","C",8,0,0,"G","","","","","mv_par07","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

*'**************************************************************************************************************'*

Return

******************************************************************************************************************

User Function CB591Leg

BrwLegenda(cCadastro, "Legenda", {	{"BR_BRANCO"	, "Custo Normal (que n�o est� adiado)"	},;
									{"BR_PRETO"   	, "Cabecalho da Peg"       				},;
									{"BR_MARROM"	, "Guia"                   				},;
									{"BR_LARANJA" 	, "Procedimento"						},;
									{"BR_VERMELHO"  , "Honorario"  							},;
									{"BR_VERDE" 	, "Historico de glosa"}  				})
									
Return

******************************************************************************************************************

User Function RetCus

Local lContinua := .T.

Private cTipo	:= ''

If Pergunte(cPergRet,.T.)

	If empty(mv_par02) .or. empty(mv_par03)
		MsgStop("Informe o ano e o m�s",AllTrim(SM0->M0_NOMECOM))	
		lContinua := .F.
	EndIf
	
	Do Case
	
		Case ( mv_par01 == 1 )
		
			cTipo := "PEG"
		
			If empty(mv_par04) .or. empty(mv_par05) .or. empty(mv_par06)
				MsgStop("Para retorno do tipo [ " + cTipo + " ] dever� informar RDA, Local de digita��o e PEG.",AllTrim(SM0->M0_NOMECOM))	
				lContinua := .F.
			ElseIf !empty(mv_par07)
				MsgStop("Para retorno do tipo [ " + cTipo + " ] n�o dever� informar n�mero da guia.",AllTrim(SM0->M0_NOMECOM))	
				lContinua := .F.
			EndIf
			
		Case ( mv_par01 == 2 )
		
			cTipo := "GUIA"
			
			If empty(mv_par04) .or. empty(mv_par05) .or. empty(mv_par06) .or. empty(mv_par07)
				MsgStop("Para retorno do tipo [ " + cTipo + " ] dever� informar RDA, Local de digita��o, PEG e n�mero da guia.",AllTrim(SM0->M0_NOMECOM))	
				lContinua := .F.
			EndIf
				
		Case ( mv_par01 == 3 )
		
			cTipo := "RDA"
			
			If empty(mv_par04) .or. empty(mv_par05)
				MsgStop("Para retorno do tipo [ " + cTipo + " ] dever� informar RDA e Local de digita��o.",AllTrim(SM0->M0_NOMECOM))	
				lContinua := .F.
			ElseIf !empty(mv_par06) .or. !empty(mv_par07)
				MsgStop("Para retorno do tipo [ " + cTipo + " ] n�o dever� informar PEG nem n�mero da guia.",AllTrim(SM0->M0_NOMECOM))	
				lContinua := .F.
			EndIf
			
	End Case
	
	If lContinua
		Processa({||u_PRetCus()},"Retorno de custo")
	EndIf
	
EndIf

Return

******************************************************************************************************************

User Function PRetCus

Local lSemaforo 	:= .F.
Local aRetSP		:= {}
Local nI			:= 0

ProcRegua(0)

For nI := 1 to 5
	IncProc('Processando retorno de custo n�o solicitado...')
Next

While !( lSemaforo := LockByName("CABA591.SMF",.T.,.F.) )
	
	If ( Aviso(AllTrim(SM0->M0_NOMECOM),'Existe outro usu�rio acessando esta rotina...',{'Aguardar','Cancelar'}) == 2 )
		Exit
	Else
		Sleep(1000)
	EndIf
	
EndDo

If lSemaforo

	aRetSP := TcSPExec(	'RETORNO_CUSTO_NAO_SOLICITADO',;
						If(cEmpAnt == '01','CABERJ','INTEGRAL'),;
						cTipo	,;
						mv_par02,;
						StrZero(Val(mv_par03),2),;
						StrZero(Val(mv_par04),6),;
						StrZero(Val(mv_par05),4),;
						If(!empty(mv_par06),StrZero(Val(mv_par06),8),'-'),;
						If(!empty(mv_par07),StrZero(Val(mv_par07),8),'-'),;
						"PROTHEUS" )
	
	If Empty(aRetSP)
		MsgStop("Erro ao executar a procedure RETORNO_CUSTO_NAO_SOLICITADO",AllTrim(SM0->M0_NOMECOM))
	Else
		
		If aRetSP[1] == 0
			MsgAlert("N�o foram localizadas guias com custo n�o solicitado para retornar.",AllTrim(SM0->M0_NOMECOM))
		Else
			MsgInfo("Custo n�o solicitado de [ " + cValToChar(aRetSP[1]) + " ] registro" + If(aRetSP[1] > 1,"s","") + " retornado.",AllTrim(SM0->M0_NOMECOM))
		EndIf
		
	EndIf

EndIf

UnLockByName("CABA591.SMF",.T.,.F.)

Return

******************************************************************************************************************

Static Function FilBrCC

Local cExprFil		:= ''

If !Pergunte(cPergIni,.T.)
	Return .F.
Else

	cExprFil += 'CG' //Sempre exibir cabecalho da PEG e guia
	
	If mv_par03 == 1
		cExprFil += 'P'
	EndIf
	
	If mv_par04 == 1
		cExprFil += 'H'
	EndIf
	
	If mv_par05 == 1
		cExprFil += 'G'
	EndIf
	
	DbSelectArea('ZRZ')
	
	DbSetOrder(1)
	
	If !empty(cExprFil)
		SET FILTER TO &( "ZRZ->ZRZ_TIPO $ '" + cExprFil + "'" )
	Else
		SET FILTER TO
	EndIf
	
EndIf

Return .T.

User Function tstPACK(TAB, EVE, RDA, ESPEC)

Local cNomeProc := 'EXEC_DADOS_PAGAMENTO'
aRetSP := TcSPExec(	cNomeProc,;
					TAB,;
					EVE,;
					'0001',;
					RDA,;
					'001',;
					'001',;
					ESPEC,;
					DTOS(DDATABASE) )
	
	If Empty(aRetSP)
		MsgStop("Erro ao executar a procedure "  + cNomeProc + " [ " + CRLF + TcSqlError() + CRLF + " ]",AllTrim(SM0->M0_NOMECOM))
	Else
		MsgAlert("Valor [ " + cValToChar(aRetSP[1]) + " ] Local [ " + aRetSP[2] + " ]",AllTrim(SM0->M0_NOMECOM))
	EndIf

Return




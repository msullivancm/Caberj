#Include 'RWMAKE.CH'
#Include 'PLSMGER.CH'
#Include 'COLORS.CH'
#Include 'TOPCONN.CH'
/*/
������������������������������������������������������������������������������������
������������������������������������������������������������������������������������
��������������������������������������������������������������������������������ͻ��
���Programa  �IMPCTSMED 		  � Autor � Jean Schulz     � Data �  19/08/06   ���
��������������������������������������������������������������������������������͹��
���Descricao � Importa o contas medicas conforme layout pre-definido pelo cliente���
��������������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                            ���
��������������������������������������������������������������������������������ͼ��
������������������������������������������������������������������������������������
������������������������������������������������������������������������������������
/*/

User Function IMPCTSMED()

Private cCadastro	:= "Importa movimenta��o de guias"
Private cPerg		:= "IPCTMD"
Private aSays 		:= {}
Private aButtons 	:= {}

//���������������������������������������������������������������������Ŀ
//� Parametros para relatorio...                                        �
//�����������������������������������������������������������������������
Private cNomeProg   := "IMPCTSMED"
Private nQtdLin     := 68
Private nLimite     := 132
Private nControle   := 15
Private cAlias      := "BD5"
Private cTamanho    := "M"
Private cTitulo     := "Importacao Contas M�dicas"
Private cDesc1      := ""
Private cDesc2      := ""
Private cDesc3      := ""
Private nRel        := "IMPCTSMED"
Private nLin        := 100
Private nOrdSel     := 1
Private m_pag       := 1
Private lCompres    := .F.
Private lDicion     := .F.
Private lFiltro     := .T.
Private lCrystal    := .F.
Private aOrdens     := {} 
Private aReturn     := { "", 1,"", 1, 1, 1, "",1 }
Private lAbortPrint := .F.
Private cCabec1     := PADC("Relat�rio geral de importa��o do contas m�dicas",nLimite)
Private cCabec2     := ""
Private nColuna     := 00
Private nOrdSel     := 0

Private oLeTxt

//���������������������������������������������������������������������Ŀ
//� Abertura de arquivos                                                �
//�����������������������������������������������������������������������
BEA->(DbSetOrder(1))
BCI->(DbSetOrder(1))
BE4->(DbSetOrder(1))
BD5->(DbSetOrder(1))
BD6->(DbSetOrder(1))
BD7->(DbSetOrder(1))
BIY->(DbSetOrder(1))
BI3->(DbSetOrder(1))
BA8->(DbSetOrder(4))
BA9->(DbSetOrder(1))


//��������������������������������������������������������������������������Ŀ
//� Ajusta perguntas...                                                      �
//����������������������������������������������������������������������������
AjustaSX1(cPerg)

Pergunte(cPerg,.F.)       


//��������������������������������������������������������������������������Ŀ
//� Monta texto para janela de processamento                                 �
//����������������������������������������������������������������������������
@ 200,1 TO 380,380 DIALOG oLeTxt TITLE OemToAnsi("Importacao Cts. Medicas")
@ 02,10 TO 65,180
@ 10,018 Say " Este programa ir� fazer a leitura do arquivo texto enviado pelo"
@ 18,018 Say " cliente, importando as guias e criando as PEGs necessarias.    "
@ 70,098 BMPBUTTON TYPE 05 ACTION AjustaSX1(cPerg)
@ 70,128 BMPBUTTON TYPE 01 ACTION BtnOk()
@ 70,158 BMPBUTTON TYPE 02 ACTION Close(oLeTxt)

Activate Dialog oLeTxt Centered 

Return


/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �BtnOk      � Autor � Jean Schulz       � Data �  19/08/06   ���
�������������������������������������������������������������������������͹��
���Descricao � Chama a importacao das guias...                            ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

Static Function BtnOk()

Pergunte(cPerg,.F.) 
Processa({|| Importa() }, "Validando o movimento ...", "", .T.)

Return


/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �Importa    � Autor � Jean Schulz       � Data �  19/08/06   ���
�������������������������������������������������������������������������͹��
���Descricao � Executa a importacao das guias...                          ���
�������������������������������������������������������������������������͹��
���Uso       � CABERJ                                                     ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Static Function Importa

//���������������������������������������������������������������������Ŀ
//� Definicao de variaveis para uso geral...                            �
//�����������������������������������������������������������������������
Local cTipo			:= ""
Local cTipReg		:= ""
Local cChGuiAnt		:= ""
Local nRegs			:= 0
Local aStruc		:= {}
Local nTotRegC		:= 0

Local cMatUsrTmp := ""
Local cMatAntTmp := ""

Local aRetCod		:= {}

Private lHouveErr	:= .F.
Private aErr		:= {}
Private nQtdItem	:= 0
Private nVlrTotP	:= 0
Private aGuiImp		:= {}

Private cLinha		:= ""

//���������������������������������������������������������������������Ŀ
//� Variaveis para o uso / HEADER...                                    �
//�����������������������������������������������������������������������
Private cHCodCre := ""
Private nHQtdGui := 0
Private nHVlrGui := 0


//���������������������������������������������������������������������Ŀ
//� Variaveis para o uso / Guias (BD5 ou BE4)	                        �
//�����������������������������������������������������������������������
Private cGTipGui	:= ""
Private cGNroImp	:= ""
Private cGCid		:= ""
Private dGDtAtend	:= CtoD("")
Private cGMatAnt	:= ""
Private cGCodSol	:= ""
Private cGCodExe	:= ""
Private cRDATmp		:= ""
Private dGDtAlta	:= CtoD("")
Private cGMatAtu	:= ""
Private cGSenha		:= ""
Private cDtTmp		:= ""
Private cGHorPro	:= ""
Private cGHorAlt	:= ""
Private cGTipAlt	:= ""
Private cGTipNas	:= ""
Private cMatUsa		:= ""
Private cGEstSol	:= ""
Private cGCRSol		:= ""
Private cGPSaude	:= ""
Private cGHorAte	:= ""
Private cGHorSai	:= ""
Private cGTipAlt	:= ""
Private cGTipAco	:= ""
Private cGGrpInt	:= ""
Private cGTipInt	:= ""
Private cGTipPar	:= ""
Private cGTipNas	:= ""
Private cGTipPac	:= ""
Private cGAteNRN	:= ""
Private cChaveAnt	:= ""
Private cChaveGuia	:= space(15)
Private lGravaGuia	:= .F.

//���������������������������������������������������������������������Ŀ
//� Variaveis para o uso / Itens das guias (BD6)	                    �
//�����������������������������������������������������������������������
Private cINroImp	:= ""
Private cICodProc	:= ""
Private dIDatProc	:= StoD("")
Private cIHorProc	:= ""
Private nIQtdProc	:= 0
Private nIVlrUni	:= 0
Private nIVlrApr	:= 0
Private cIViaProc	:= ""
Private nIPerProc	:= 0


//���������������������������������������������������������������������Ŀ
//� Variaveis obtidas nos parametros de sistema...	                    �
//�����������������������������������������������������������������������
Private cCodOpe	:= mv_par01
Private nTipImp	:= mv_par02
Private cMes	:= ""
Private cAno	:= ""
Private cCodRda := ""



//���������������������������������������������������������������������Ŀ
//� Variaveis privadas de uso da rotina de importacao.                  �
//�����������������������������������������������������������������������
Private _cPeg   := ""
Private cCodLdp := ""
Private cNumero := ""
Private cOriMov := ""
Private cNumDoc := ""

//���������������������������������������������������������������������Ŀ
//� Selecao de arquivo para importacao...                               �
//�����������������������������������������������������������������������
cTipo    := "Txt     (*.Txt)            | *.Txt | "
cNomeArq := AllTrim(cGetFile(cTipo,"Selecione o Arquivo Texto para importar"))
//cNomeArq := "M:\AP_DATA"+cNomeArq

If !File(cNomeArq)
	MsgStop("Arquivo invalido. Programa encerrado.")
	Close(oLeTxt)
	Return
End

//���������������������������������������������������������������������Ŀ
//� Estrutura do arquivo temporario...                                  �
//�����������������������������������������������������������������������
aStruc := {	{"NUMREG","C",  006,0},{"DATENV","D",  8,0},{"CODRDA","C",  008,0},{"LOTE","C",  007,0},{"DOC","C",  007,0},{"CAMPO","C",  400,0}}

cTRB := CriaTrab(aStruc,.T.)
If Select("TRB") <> 0
	TRB->(DbCloseArea())
End
DbUseArea(.T.,,cTRB,"TRB",.T.)
IndRegua("TRB",cTRB,"LOTE+DOC",,,"Ordenando Registros...")

MsgRun("Atualizando Arquivo...",,{|| U_PLSAppendTmp(cNomeArq),CLR_HBLUE})

DbSelectArea("TRB")

//���������������������������������������������������������������������Ŀ
//� Verifica se o arquivo esta vazio...                                 �
//�����������������������������������������������������������������������
TRB->(DbGoTop())
If TRB->(EOF())
	MsgStop("Arquivo vazio! Importa��o cancelada!")
	TRB->(DBCLoseArea())
	Close(oLeTxt)
	Return
End

//���������������������������������������������������������������������Ŀ
//� Analise e importacao das guias...                                   �
//�����������������������������������������������������������������������
nTotRegC := TRB->(Reccount())
ProcRegua(nTotRegC)
nRegs := 0

//���������������������������������������������������������������������Ŀ
//� Controle de transacao para garantir a gravacao dos dados            �
//�����������������������������������������������������������������������
Begin Transaction

While ! TRB->(Eof())

	cTipReg	:= Substr(cLinha,1,1)
	lGravaGuia := .F.
	nRegs++
	
	cLinha := TRB->(NUMREG+DtoS(DATENV)+CODRDA+LOTE+DOC+CAMPO)
	
	cTipReg := VeTipGui(TRB->LOTE, TRB->DOC, cLinha)
	cGTipGui := "0"+cTipReg 
	cAno := Substr(cLinha,047,004)
	cMes := Substr(cLinha,051,002)
	cGMatAnt	:= Substr(cLinha,290,011)
	cGMatAtu	:= "0"+Substr(cLinha,086,015)+Modulo11("0"+Substr(cLinha,086,015))	
	
	IncProc("Processando "+StrZero(nRegs,6)+" de "+StrZero(nTotRegC,6))
	
	If TRB->(LOTE+DOC)+cGMatAtu+cGMatAnt <> cChaveAnt
	
		If cGTipGui == "03"
			BE4->(DbSetOrder(1))
			If BE4->(MsSeek(xFilial("BE4")+PLSINTPAD()+cChaveGuia))
				BE4->(RecLock("BE4",.F.))
				BE4->BE4_QTDEVE := nQtdItem
				BE4->BE4_VLRPAG	:= nVlrTotP
				BE4->(MsUnlock())
			Endif
		Else     
			If BD5->(MsSeek(xFilial("BD5")+PLSINTPAD()+cChaveGuia))
				BD5->(RecLock("BD5",.F.))
				BD5->BD5_QTDEVE	:= nQtdItem
				BD5->BD5_VLRPAG	:= nVlrTotP
				BD5->(MsUnlock())
			Endif
		Endif
		
		nQtdItem := 0
		nVlrTotP := 0
		cChaveGuia := space(15)
	
		//���������������������������������������������������������������������Ŀ
		//� Cabecalho das guias de consultas, servicos ou internacao            �
		//�����������������������������������������������������������������������		
   		cGNroImp	:= Substr(cLinha,037,007)
		cDtTmp		:= Substr(cLinha,054,008)
		//dGDtAtend	:= StoD(Substr(cDtTmp,005,004)+Substr(cDtTmp,003,002)+Substr(cDtTmp,001,002))
		dGDtAtend	:= StoD(cDtTmp)

		cGCid	    := Substr(cLinha,147,007)
		cGEstSol	:= Substr(cLinha,130,002)
		cGCRSol		:= Substr(cLinha,132,008)
		
		cGNomUsr	:= ""
		dGDatNas	:= CtoD("")

		//���������������������������������������������������������������������Ŀ
		//� Buscar dados do usuario (matricula antiga)                          �
		//�����������������������������������������������������������������������
		If !Empty(cGMatAnt)
			BA1->(DbSetOrder(5)) //Matricula anterior
			If BA1->(MsSeek(xFilial("BA1")+	cGMatAnt))
				cGNomUsr := BA1->BA1_NOMUSR
				dGDatNas := BA1->BA1_DATNAS
				cGMatAtu := BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)
				cMatUsa := "2"
			Else
				BA1->(DbSetOrder(10)) //Matricula antiga do sistema antigo
				If BA1->(MsSeek(xFilial("BA1")+	cGMatAnt))
					cGNomUsr := BA1->BA1_NOMUSR
					dGDatNas := BA1->BA1_DATNAS
					cGMatAtu := BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)
					cMatUsa := "2"
				Endif
			Endif
		Endif

		//���������������������������������������������������������������������Ŀ
		//� Caso nao encontre pela matr. antiga, utilizar matricula atual...    �
		//�����������������������������������������������������������������������
		If !Empty(cGMatAtu) .And. Empty(cGNomUsr)
			BA1->(DbSetOrder(2))
			If BA1->(MsSeek(xFilial("BA1")+	cGMatAtu))
				cGNomUsr := BA1->BA1_NOMUSR
				dGDatNas := BA1->BA1_DATNAS
				cGMatAtu := BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)
				cMatUsa := "1"
			Else
				aadd(aErr,{"Usu�rio n�o encontrado. Mat. Atual: "+cGMatAtu+" Mat. Anterior: "+cGMatAnt,TRB->(NUMREG)})
				TRB->(DbSkip())
				Loop
			Endif				
		Endif
		
		//���������������������������������������������������������������������Ŀ
		//� Validar se a familia existe no sistema...                           �
		//�����������������������������������������������������������������������		
		If BA1->(Found())
			BA3->(DbSetOrder(1))
			If !BA3->(MsSeek(xFilial("BA3")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC)))	
				aadd(aErr,{"Usu�rio sem fam�lia cadastrada! C�digo: "+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC),TRB->(NUMREC)})
				TRB->(DbSkip())
				Loop
			Endif
		Endif

		//���������������������������������������������������������������������Ŀ
		//� Buscar codigo de RDA solicitante atraves profissional de saude...	�
		//�����������������������������������������������������������������������
		
		BB0->(DbSetOrder(4))			
		If BB0->(MsSeek(xFilial("BB0")+cGEstSol+"00"+cGCRSol))
			cGPSaude := BB0->BB0_CODIGO	
		Else
			If AllTrim(GetNewPar("MV_PLSOSOL","1")) == "1" 
				aadd(aErr,{"Solicitante n�o encontrado. Estado+CR:"+cGEstSol+"00"+cGCRSol,TRB->(NUMREG)})
				TRB->(DbSkip())
				Loop
			Endif
     		cGEstSol := ""
			cGCRSol := ""
			cGPSaude := ""
		Endif
		
		BAU->(DbSetOrder(5))				
		If BAU->(MsSeek(xFilial("BAU")+cGPSaude))          
			While BAU->BAU_CODBB0 == cGPSaude .And. !BAU->(Eof())
				If BAU->BAU_ESTCR == cGEstSol
					cGCodSol := BAU->BAU_CODIGO
					Exit
				Endif  
				BAU->(DbSkip())			
			Enddo
						
		Endif

		BAU->(DbSetOrder(1))
		
		cGHorAte := Iif(Empty(Substr(cLinha,078,004)),"0800",Substr(cLinha,078,004))
		cRDATmp	:= Substr(cLinha,017,006)
		
		//���������������������������������������������������������������������Ŀ
		//� Buscar codigo de RDA executante atraves do local de atendimento...	�
		//�����������������������������������������������������������������������	   				
		BB8->(DbSetOrder(1)) //Buscar por matricula atual da RDA
		If BB8->(MsSeek(xFilial("BB8")+cRDATmp))
			cGCodExe := BB8->BB8_CODIGO	
		Else
			aadd(aErr,{"Executante n�o encontrado/Sem local de atendimento. C�digo: "+cRDATmp,TRB->(NUMREG)})
			TRB->(DbSkip())
			Loop
		Endif
		
		dGDtAlta	:= CtoD("")		
    	cGSenha		:= Substr(cLinha,231,009)    	

		If !Empty(cGCid)   	    	
	    	If BA9->(MsSeek(xFilial("BA9")+AllTrim(cGCid)))
		    	cGCid 		:= BA9->BA9_CODDOE
	    	Endif
	 	Endif

		If cTipReg == "3"
			cDtTmp		:= Substr(cLinha,070,008)
			//dGDtAlta	:= StoD(Substr(cDtTmp,005,004)+Substr(cDtTmp,003,002)+Substr(cDtTmp,001,002))
			dGDtAlta	:= StoD(cDtTmp)
			cGHorSai	:= Iif(Empty(Substr(cLinha,082,004)),"0800",Substr(cLinha,082,004))
			cGTipAlt	:= Posicione("BIY",1,xFilial("BIY")+PLSINTPAD()+Substr(cLinha,154,001),"BIY_CODSAI")
			cGTipAco	:= Posicione("BI4",1,xFilial("BI4")+Substr(cLinha,178,001),"BI4_CODACO")
			cGTipPar	:= Posicione("BWS",1,xFilial("BWS")+PLSINTPAD()+Substr(cLinha,205,001),"BWS_CODPAR")
			cGTipNas	:= Posicione("BEW",1,xFilial("BEW")+PLSINTPAD()+Substr(cLinha,240,001),"BEW_CODNAS")			
			cGTipPac	:= Posicione("BGY",1,xFilial("BGY")+PLSINTPAD()+Substr(cLinha,241,001),"BGY_CODTPA")			
			cGAteNRN	:= Substr(cLinha,320,001)
			
			cTipInt		:= Substr(cLinha,179,001)
			
			Do Case
				Case cTipInt == "1" //Clinica
					cGGrpInt := "1"
					cGTipInt := "01"

				Case cTipInt == "2" //Cirurgica
					cGGrpInt := "2"
					cGTipInt := "06"
					
				Case cTipInt == "3" //Obstetrica
					cGGrpInt := "2"
					cGTipInt := "08"

				Case cTipInt == "4" //Psiquiatrica
					cGGrpInt := "2"
					cGTipInt := "03"											
				
				OtherWise	
					aadd(aErr,{"Tipo de Interna��o inv�lido! Tipo: "+cTipInt,TRB->(NUMREG)})
					TRB->(DbSkip())
					Loop
					
									
			EndCase

			//���������������������������������������������������������������������Ŀ
			//� Validacoes, criticas e analises dos itens de internacao...          �
			//�����������������������������������������������������������������������	    	   				
			If Empty(dGDtAlta)
				aadd(aErr,{"Data de alta n�o encontrada! ",TRB->(NUMREG)})
				TRB->(DbSkip())
				Loop			
			Endif
			
			If Empty(Alltrim(cGTipAco))
				aadd(aErr,{"Tipo de acomoda��o n�o encontrado! Tipo: "+Substr(cLinha,175,001),TRB->(NUMREG)})
			Endif
			
			If Empty(Alltrim(cGTipAlt))
				aadd(aErr,{"Tipo de alta n�o encontrado para a interna��o! Tipo: "+Substr(cLinha,154,001),TRB->(NUMREG)})
			Endif
					
			If Empty(Alltrim(cGTipPac))
				aadd(aErr,{"Tipo de atendimento inv�lido! Tipo: "+Substr(cLinha,241,001),TRB->(NUMREG)})
			Endif
			
			If Empty(Alltrim(cGCid))
				aadd(aErr,{"Tipo de atendimento inv�lido! Tipo: "+Substr(cLinha,241,001),TRB->(NUMREG)})
				TRB->(DbSkip())
				Loop
			Endif
			
			
							    			
		Endif

		lGravaGuia := .T.					
		
	Endif
	
	cChaveAnt	:= TRB->(LOTE+DOC)+cGMatAtu+cGMatAnt   		

	//���������������������������������������������������������������������Ŀ
	//� Inserir itens da guia...                                            �
	//�����������������������������������������������������������������������	    	   	
	cICodProc	:= Substr(cLinha,206,008)
	nIQtdProc	:= Val(Substr(cLinha,214,008))
	nIVlrUni	:= Val(Substr(cLinha,222,008))/100
	nIVlrApr	:= Val(Substr(cLinha,312,008))/100
	dIDatProc	:= StoD(Substr(cLinha,181,008))
	cIHorProc	:= Substr(cLinha,189,008)
	cIViaProc	:= Substr(cLinha,230,001)
	nIPerProc	:= Posicione("BGR",1,PLSINTPAD()+cIViaProc,"BGR_PERC")
	
	BR8->(DbSetOrder(3))
	If !BR8->(MsSeek(xFilial("BR8")+cICodProc))
	
		//���������������������������������������������������������������������Ŀ
		//� Realizar a troca de codigo antigo por codigo novo, caso exista...   �
		//�����������������������������������������������������������������������
		aRetCod := TrCdAnt(cICodProc)
		cICodProc := aRetCod[2]
		If !aRetCod[1] .Or. !BR8->(MsSeek(xFilial("BR8")+cICodProc))
			aadd(aErr,{"C�digo n�o encontrado na tabela padr�o. C�digo: "+cICodProc,TRB->(NUMREG)})
			TRB->(DbSkip())
			Loop
		Endif                 
		/*
		aadd(aErr,{"C�digo n�o encontrado na tabela padr�o. C�digo: "+cICodProc,TRB->(NUMREG)})
		TRB->(DbSkip())
		Loop
		*/
	
		
	EndIf
	
	nQtdItem += nIQtdProc
	nVlrTotP += nIVlrUni
	
	If lGravaGuia
		Grava_Peg("I",cGTipGui,cGNroImp,cGSenha,cGCodExe)				
		cChaveGuia := Grava_Guia(cGTipGui,BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO),cGSenha,dGDtAtend,BA1->BA1_NOMUSR)			
		aadd(aGuiImp,{cGTipGui,cGSenha,dGDtAtend,BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO),Substr(BA1->BA1_NOMUSR,1,25),cChaveGuia})		
	Endif
	
	Grava_Item()	
			
    TRB->(DbSkip())
Enddo


//���������������������������������������������������������������������Ŀ
//� Atualizar a quant. de eventos na ultima guia...                     �
//�����������������������������������������������������������������������	    	   	
If nQtdItem > 0 .And. !Empty(Alltrim(cChaveGuia))
	If cGTipGui == "03"
		BE4->(DbSetOrder(1))
		If BE4->(MsSeek(xFilial("BE4")+PLSINTPAD()+cChaveGuia))
			BE4->(RecLock("BE4",.F.))
			BE4->BE4_QTDEVE	:= nQtdItem
			BE4->BE4_VLRPAG	:= nVlrTotP
			BE4->(MsUnlock())
		Endif
	Else     
		If BD5->(MsSeek(xFilial("BD5")+PLSINTPAD()+cChaveGuia))
			BD5->(RecLock("BD5",.F.))
			BD5->BD5_QTDEVE := nQtdItem
			BD5->BD5_VLRPAG	:= nVlrTotP
			BD5->(MsUnlock())
		Endif
	Endif
	nQtdItem := 0
	nVlrTotP := 0
	cChaveGuia := space(15)
Endif

//��������������������������������������������������������������������������Ŀ
//� Fecha o arquivo temporario, e finaliza o ctr. de transacao...            �
//����������������������������������������������������������������������������
TRB->(DbCLoseArea("TRB"))
End Transaction

//��������������������������������������������������������������������������Ŀ
//� Impressao do relatorio de inconsistencias / importacao.                  �
//����������������������������������������������������������������������������
WnRel   := SetPrint(cAlias,nRel,cPerg,cTitulo,cDesc1,cDesc2,cDesc3,lDicion,aOrdens,lCompres,cTamanho,{},lFiltro,lCrystal)

If nLastKey == 27
	Set Printer To
	Ourspool(nRel)
	MS_FLUSH()
	Return
Endif              

SetDefault(aReturn,"BD5")

MsAguarde({|| Imprime() }, cTitulo, "", .T.)

//��������������������������������������������������������������������������Ŀ
//� Libera impressao                                                         �
//����������������������������������������������������������������������������
If  aReturn[5] == 1
	Set Printer To
	Ourspool(nRel)
End
MS_FLUSH()

Return




/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    � Grava_Peg� Autor � Jean Schulz           � Data � 08/04/05 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Grava BCI - PEG									          ���
�������������������������������������������������������������������������Ĵ��
���Retorno   � nenhum                                                     ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Static Function Grava_Peg(cOpcao,cTipGui,cNroImp,cSenha,cCodRDA)

Local cChaBCI := ""
Local cLdpPad := GetNewPar("MV_YHISLDP","0003")
Local lTemBCI := .F.
Local lAchou  := .F.
Local nLock   := PLSAbreSem("IMPCTSMED.SMF")
Local cPegCod := ""
Local lCriPeg := .F.

cOriMov := ""
cNumero	:= ""

//�����������������������������������������������������������������������Ŀ
//� Grava BCI-PEG                                                         �
//�������������������������������������������������������������������������
If cOpcao == "I"

	If cTipGui == "03"

		lAchou := .F.
		
		//��������������������������������������������������������������������������Ŀ
		//� Posiciona cfme senha SIGA liberacao (Valida usuario)					 �
		//����������������������������������������������������������������������������
		If Val(cSenha) > 0
			BE4->(DbSetOrder(7))
			If BE4->(MsSeek(xFilial("BE4")+cSenha))		
			
				While BE4->BE4_SENHA == cSenha .And. !BE4->(Eof())
				
					If BE4->(BE4_OPEUSR+BE4_CODEMP+BE4_MATRIC+BE4_TIPREG) == BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG)
						If BE4->BE4_SITUAC <> "2" //Cancelada
							lAchou := .T.
							Exit
						Endif
						
					Endif		
					
					BE4->(DbSkip())
				Enddo
				
			Endif
		Endif
		
		If !lAchou	
			//��������������������������������������������������������������������������Ŀ
			//� Posiciona cfme nro impresso (sistema antigo Caberj - valida usuario)	 �
			//����������������������������������������������������������������������������
			BE4->(DbSetOrder(6))
			If BE4->(MsSeek(xFilial("BE4")+cNroImp))		
				
				While Alltrim(BE4->BE4_NUMIMP) == cNroImp .And. !BE4->(Eof())
				
					If BE4->(BE4_OPEUSR+BE4_CODEMP+BE4_MATRIC+BE4_TIPREG) == BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG)
						lAchou := .T.
						Exit
					Endif					
					
					BE4->(DbSkip())
					
				Enddo
				
			Endif		
		Endif
		
		If lAchou		
			_cPeg   	:= BE4->BE4_CODPEG
			cCodLdp 	:= BE4->BE4_CODLDP
			cNumero 	:= BE4->BE4_NUMERO
			cOriMov		:= BE4->BE4_ORIMOV
			cGNroImp	:= BE4->BE4_NUMIMP
		
			BCI->(DbSetOrder(1))
			BCI->(MsSeek(xFilial("BCI")+BE4->(BE4_CODOPE+BE4_CODLDP+BE4_CODPEG)))
			
			BD6->(DbsetOrder(6))
			BD6->(MsSeek(xFilial("BD6")+BE4->(BE4_CODOPE+BE4_CODLDP+BE4_CODPEG+BE4_NUMERO+BE4_ORIMOV)))
	
		Else
			lCriPeg := .T.
		Endif	
	Else
		
		lAchou := .F.
		
		//���������������������������������������������������������������������Ŀ
		//� Verifica Senha + Usuario...											�
		//�����������������������������������������������������������������������
		If Val(cSenha) > 0	

			BD5->(DbSetOrder(7))
			BD5->(MsSeek(xFilial("BD5")+cSenha))
	
			While BD5->(BD5_FILIAL+BD5_SENHA)==(xFilial("BD5")+cSenha) .and. ! BD5->(Eof())
	
				If BD5->BD5_SITUAC <> "2" //Cancelada
					If BD5->(BD5_OPEUSR+BD5_CODEMP+BD5_MATRIC+BD5_TIPREG) == BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG)
						lAchou := .T.
						Exit
					EndIf
		        Endif
	        
				BD5->(DbSkip())     
				
			EndDo
		    
		Endif
		
		
		//��������������������������������������������������������������������������Ŀ
		//� Posiciona cfme nro impresso (sistema antigo Caberj - valida usuario)	 �
		//����������������������������������������������������������������������������
		If !lAchou
			
			BD5->(DbSetOrder(6))
			BD5->(MsSeek(xFilial("BD5")+cNroImp))
		
			While Alltrim(BD5->BD5_NUMIMP) == Alltrim(cNroImp) .And. ! BD5->(Eof())
				
				If BD5->BD5_SITUAC <> "2" //Cancelada
					If BD5->(BD5_OPEUSR+BD5_CODEMP+BD5_MATRIC+BD5_TIPREG) == BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG)
						lAchou := .T.
						Exit
					EndIf
				Endif
				
				BD5->(DbSkip())
			EndDo
        Endif
       
		
		If lAchou

			_cPeg   := BD5->BD5_CODPEG
			cCodLdp := BD5->BD5_CODLDP
			cNumero := BD5->BD5_NUMERO
			cOriMov := BD5->BD5_ORIMOV
			cGNroImp := BD5->BD5_NUMIMP
			
			BCI->(DbSetOrder(1))
			BCI->(MsSeek(xFilial("BCI")+BD5->(BD5_CODOPE+BD5_CODLDP+BD5_CODPEG)))
			
			BD6->(DbsetOrder(6))
			BD6->(MsSeek(xFilial("BD6")+BD5->(BD5_CODOPE+BD5_CODLDP+BD5_CODPEG+BD5_NUMERO+BD5_ORIMOV)))

		Else       
			lCriPeg := .T.
		Endif

	EndIf
	
Else
	BCI->(RecLock("BCI",.F.))
	BCI->BCI_QTDEVE := BCI->BCI_QTDEVE + nQtdGrv
	BCI->BCI_QTDEVD := BCI->BCI_QTDEVE + nQtdGrv
	BCI->(MsUnlock())
EndIf

//�����������������������������������������������������������������������Ŀ
//� Cria PEG...             							      			  �
//�������������������������������������������������������������������������
If lCriPeg

	//�����������������������������������������������������������������������Ŀ
	//� Verifica se cria PEG...             							      �
	//�������������������������������������������������������������������������	
	cChaBCI := cCodOpe+cCodRda+cAno+cMes+"2" //Incluido eletronicamente via importacao
	
	BCI->(DbSetOrder(4))
	BCI->(MsSeek(xFilial("BCI")+cChaBCI))
	
	While BCI->(BCI_OPERDA+BCI_CODRDA+BCI_ANO+BCI_MES+BCI_TIPO)==cChaBCI .and. ! BCI->(Eof())
		
		If BCI->BCI_TIPGUI == cTipGui .and. BCI->BCI_CODLDP == cLdpPad .and. BCI->BCI_SITUAC == "1" .and. BCI->BCI_FASE <= "4"
			lTemBCI := .T.
			Exit
		Endif
		
		BCI->(DbSkip())
	EndDo
	
	If lTemBCI
		
		If BCI->BCI_FASE == "3"
			BCI->(RecLock("BCI",.F.))
			BCI->BCI_FASE := "4"
			BCI->(MsUnlock())
		Endif
		
	Else
		   
		cPegCod := PLSA175COD(PLSINTPAD(),cLdpPad)

		BCI->(RecLock("BCI",.T.))
		BCI->BCI_FILIAL := xFilial("BCI")
		BCI->BCI_CODOPE := PLSINTPAD()
		BCI->BCI_CODLDP := cLdpPad
		BCI->BCI_CODPEG := cPegCod
		BCI->BCI_OPERDA := PLSINTPAD()
		BCI->BCI_CODRDA := cCodRDA
		BCI->BCI_NOMRDA := Posicione("BAU",1,xFilial("BAU")+cCodRDA,"BAU_NOME")
		BCI->BCI_MES    := cMes
		BCI->BCI_ANO    := cAno
		BCI->BCI_TIPGUI := cTipGui
		BCI->BCI_CODCOR := Posicione("BCL",1,xFilial("BCL")+PLSINTPAD()+cTipGui,"BCL_CODCOR")
		BCI->BCI_TIPSER := GetNewPar("MV_PLSTPSP","01")
		BCI->BCI_DATREC := dDataBase
		BCI->BCI_DTDIGI := dDataBase
		BCI->BCI_STATUS := "1"
		BCI->BCI_FASE   := "4"
		BCI->BCI_SITUAC := "1"
		BCI->BCI_TIPO   := "2"
		BCI->BCI_QTDEVE := 0
		BCI->BCI_QTDEVD := 0
		BCI->(MsUnlock())
		
	EndIf
	
	_cPeg   := BCI->BCI_CODPEG
	cCodLdp := BCI->BCI_CODLDP
	If cTipGui == "03"
		cOriMov := "2"
		cNumero := ProxBE4(BCI->BCI_CODOPE,BCI->BCI_CODLDP,BCI->BCI_CODPEG)
	Else
		cOriMov := "1"
		cNumero := ProxBD5(BCI->BCI_CODOPE,BCI->BCI_CODLDP,BCI->BCI_CODPEG)
	Endif
Endif

PLSFechaSem(nLock,"IMPCTSMED.SMF")
TcRefresh("BCI")

//���������������������������������������������������������������������Ŀ
//� Fim da funcao                                                       �
//�����������������������������������������������������������������������
Return 


/*/
�������������������������������������������������������������������������������
�������������������������������������������������������������������������������
���������������������������������������������������������������������������Ŀ��
���Fun��o    � Grava_Guia � Autor � Jean Schulz           � Data � 27/04/06 ���
���������������������������������������������������������������������������Ĵ��
���Descri��o � Grava Guia - BE4 (Internacao) ou BD5 (Consultas/Servicos)    ���
���������������������������������������������������������������������������Ĵ��
���Retorno   � nenhum                                                       ���
����������������������������������������������������������������������������ٱ�
�������������������������������������������������������������������������������
�������������������������������������������������������������������������������
/*/
Static Function Grava_Guia(cTipGui,cCodUsr,cSenha,dDatEmi,cNomUsr)

Local cCodLdp := GetNewPar("MV_YHISLDP","0003")
Local cCC     := PLSUSRCC(cCodUsr)
Local cCodPad := ""
Local cCodPro := ""
Local cChave  := ""
Local cTipPar := ""
Local cVia    := ""
Local cCodPre := ""
Local cTipAdm := GetNewPar("MV_PLSTPAD","6")
Local cGrpInt := "1"
Local cTipInt := "01"
Local nDiaInt := 1
Local nPosCir := 0
Local nTemp   := 1
Local nTmp    := 0
Local nTmpAnt := 0
Local nClaHos := 0
Local aProCir := {}
Local aTotPro := {}
Local aVetRet := {}
Local aPorte  := {}
Local aTaxObs := {}
Local aVldPrt := {}    
Local nQtdDia := 0

Local cChaveGui := ""



//���������������������������������������������������������������������Ŀ
//� Posicionar tabelas para uso da funcao...                    		�
//�����������������������������������������������������������������������
BAU->(DbSetOrder(1))
BAU->(MsSeek(xFilial("BAU")+cGCodExe))

BB8->(DbSetOrder(1))
BB8->(MsSeek(xFilial("BB8")+BAU->BAU_CODIGO+PLSINTPAD()))

BAX->(DbSetOrder(1))
BAX->(MsSeek(xFilial("BAX")+BAU->BAU_CODIGO+PLSINTPAD()+BB8->BB8_CODLOC))


//���������������������������������������������������������������������Ŀ
//� Grava Cabecalho da Guia somente para as guias importadas...			�
//�����������������������������������������������������������������������
If BCI->BCI_CODLDP == cCodLdp

	If cTipGui == "03"

		BE4->(DbSetOrder(1))
		If BE4->(MsSeek(xFilial("BE4")+PLSINTPAD()+BCI->(BCI_CODLDP+BCI_CODPEG)+cNumero))

           If nTipImp > 1
				cTipAco := BE4->BE4_PADINT
				cTipAdm := BE4->BE4_TIPADM
				cTipInt := BE4->BE4_TIPINT
				cGrpInt := BE4->BE4_GRPINT
				nDiaInt := BE4->BE4_DIASIN
    	    
				BE4->(RecLock("BE4",.F.))
				BE4->BE4_DATPRO := dDatEmi		
				BE4->BE4_HORPRO := Iif(Empty(Alltrim(cGHorPro)),"0800",cGHorPro)
				BE4->BE4_DTALTA := dGDtAlta
				BE4->BE4_HRALTA := Iif(Empty(cGHorAlt),"0800",cGHorAlt)
				BE4->BE4_TIPALT := Iif(Empty(cGTipAlt),"1",cGTipAlt)
				BE4->BE4_TIPNAS := Iif(Empty(cGTipNas),"0",cGTipNas)
				BE4->BE4_TIPPAR := cGTipPar
				BE4->BE4_PADINT := Posicione("BI3",1,xFilial("BI3")+PLSINTPAD()+Iif(Empty(BA1->BA1_CODPLA),BA3->(BA3_CODPLA+BA3_VERSAO),BA1->(BA1_CODPLA+BA1_VERSAO)),"BI3_CODACO") 
				BE4->BE4_FASE	:= "4"
				BE4->BE4_NUMFAT := "IMP.HIST"
				BE4->BE4_SEQPF	:= "IMP.HIST"
				BE4->(MsUnlock())
				cChaveGui := BE4->(BE4_CODLDP+BE4_CODPEG+BE4_NUMERO)
			EndIf
		Else
			BE4->(RecLock("BE4",.T.))
			BE4->BE4_FILIAL := xFilial("BE4")
			BE4->BE4_CODOPE	:= PLSINTPAD()
			BE4->BE4_CODLDP := cCodLdp
			BE4->BE4_CODPEG := _cPeg
			BE4->BE4_NUMERO := cNumero
			BE4->BE4_NUMIMP := cGNroImp
			BE4->BE4_GUIIMP := "1"
			BE4->BE4_DATPRO := dDatEmi
			BE4->BE4_HORPRO := Iif(Empty(Alltrim(cGHorPro)),"0800",cGHorPro)
			BE4->BE4_PRVINT := dDatEmi
			BE4->BE4_DATVAL := dDatEmi+GetNewPar("MV_PLPRZLB",30)
			BE4->BE4_TIPUSR := BA3->(Posicione("BA3",1,xFilial("BA3")+BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC),"BA3_TIPOUS"))
			BE4->BE4_MATANT := BA1->BA1_MATANT
			BE4->BE4_NOMUSR := BA1->BA1_NOMUSR
			BE4->BE4_CODRDA := BAU->BAU_CODIGO
			BE4->BE4_OPERDA := PLSINTPAD()
			BE4->BE4_NOMRDA := BAU->BAU_NOME
			BE4->BE4_CODESP := BAX->BAX_CODESP
			BE4->BE4_CID    := cGCid
			BE4->BE4_DESCID := BA9->(Posicione("BA9",1,xFilial("BA9")+cGCid,"BA9_DOENCA"))
			BE4->BE4_OPESOL := PLSINTPAD()
			BE4->BE4_TIPGUI := cGTipGui
			BE4->BE4_OPEUSR := BA1->BA1_CODINT
			BE4->BE4_CODEMP := BA1->BA1_CODEMP
			BE4->BE4_MATRIC := BA1->BA1_MATRIC
			BE4->BE4_TIPREG := BA1->BA1_TIPREG
			BE4->BE4_CPFUSR := BA1->BA1_CPFUSR
			BE4->BE4_IDUSR  := BA1->BA1_DRGUSR
			BE4->BE4_DATNAS := BA1->BA1_DATNAS
			BE4->BE4_DIGITO := BA1->BA1_DIGITO
			BE4->BE4_CONEMP := BA1->BA1_CONEMP
			BE4->BE4_VERCON := BA1->BA1_VERCON
			BE4->BE4_SUBCON := BA1->BA1_SUBCON
			BE4->BE4_VERSUB := BA1->BA1_VERSUB
			BE4->BE4_FASE   := "4"
			BE4->BE4_SITUAC := "1"
			BE4->BE4_STATUS := "1"
			BE4->BE4_LOCAL  := BB8->BB8_LOCAL
			BE4->BE4_CODLOC := BB8->BB8_CODLOC
			BE4->BE4_MATVID := BA1->BA1_MATVID
			BE4->BE4_DTDIGI := dDataBase
			BE4->BE4_ANOINT := cAno
			BE4->BE4_MESINT := cMes
			BE4->BE4_NUMINT := PLNUMINT(PLSINTPAD(),cAno,cMes)
			BE4->BE4_MESPAG := cMes
			BE4->BE4_ANOPAG := cAno
			BE4->BE4_MATUSA := cMatUsa
			BE4->BE4_PACOTE := "0"
			BE4->BE4_SENHA  := ""
			BE4->BE4_ORIMOV := "2"
			BE4->BE4_CC     := ""
			BE4->BE4_TIPPRE := BAU->BAU_TIPPRE
			BE4->BE4_RGIMP  := "1"
			BE4->BE4_ESTSOL := Posicione("BB0",1,xFilial("BB0")+Iif(Empty(cGCodSol),cGPSaude,cGCodSol),"BB0_ESTADO")
			BE4->BE4_SIGLA  := Posicione("BB0",1,xFilial("BB0")+Iif(Empty(cGCodSol),cGPSaude,cGCodSol),"BB0_CODSIG")
			BE4->BE4_REGSOL := Posicione("BB0",1,xFilial("BB0")+Iif(Empty(cGCodSol),cGPSaude,cGCodSol),"BB0_NUMCR")
			BE4->BE4_NOMSOL := Posicione("BB0",1,xFilial("BB0")+Iif(Empty(cGCodSol),cGPSaude,cGCodSol),"BB0_NOME")
			BE4->BE4_CDPFSO := Iif(Empty(cGCodSol),cGPSaude,cGCodSol)
			
			/*
			BE4->BE4_REGEXE := BAU->BAU_CODIGO
			BE4->BE4_CDPFRE := BAU->BAU_CODBB0
			BE4->BE4_ESTEXE := BAU->BAU_ESTCR		
			*/
			BE4->BE4_TIPADM := cTipAdm
			BE4->BE4_TIPINT := cGTipInt
			BE4->BE4_GRPINT := cGGrpInt
			BE4->BE4_TIPPAR := cGTipPar
			nQtdDia := Iif((dGDtAlta-dDatEmi)<=0,1,(dGDtAlta-dDatEmi))			
			BE4->BE4_DIASIN := Iif(nQtdDia > 99,99,nQtdDia)
			BE4->BE4_DTALTA := dGDtAlta
			BE4->BE4_HRALTA := Iif(Empty(cGHorAlt),"0800",cGHorAlt)
			BE4->BE4_TIPALT := Iif(Empty(cGTipAlt),"1",cGTipAlt)
			BE4->BE4_TIPNAS := Iif(Empty(cGTipNas),"0",cGTipNas)
			BE4->BE4_PADINT := Posicione("BI3",1,xFilial("BI3")+PLSINTPAD()+Iif(Empty(BA1->BA1_CODPLA),BA3->(BA3_CODPLA+BA3_VERSAO),BA1->(BA1_CODPLA+BA1_VERSAO)),"BI3_CODACO") 
			BE4->BE4_NUMFAT := "IMP.HIST"
			BE4->BE4_SEQPF	:= "IMP.HIST"		
			BE4->(MsUnLock())					
			cChaveGui := BE4->(BE4_CODLDP+BE4_CODPEG+BE4_NUMERO)
        Endif
	Else
	
		BD5->(DbSetOrder(1))
		If ! BD5->(MsSeek(xFilial("BD5")+PLSINTPAD()+BCI->(BCI_CODLDP+BCI_CODPEG)+cNumero))
		
			BAX->(DbSetOrder(1))
			If BAX->(MsSeek(xFilial("BAX")+cGCodExe+PLSINTPAD()))
			
				BAU->(DbSetOrder(1))
				If BAU->(MsSeek(xFilial("BAU")+cGCodExe))
				
		            If nTipImp > 1
						BD5->(RecLock("BD5",.T.))
						BD5->BD5_FILIAL := xFilial("BD5")
						BD5->BD5_CODOPE := PLSINTPAD()
						BD5->BD5_TIPPAC := "1"
						BD5->BD5_CODLDP := cCodLdp
						BD5->BD5_CODPEG := _cPeg
						BD5->BD5_NUMERO := cNumero					
						BD5->BD5_NUMIMP := cGNroImp
						BD5->BD5_DATPRO := dDatEmi
						BD5->BD5_HORPRO := Iif(Empty(Alltrim(cGHorPro)),"0800",cGHorPro)
						BD5->BD5_MATANT := BA1->BA1_MATANT
						BD5->BD5_NOMUSR := BA1->BA1_NOMUSR
						BD5->BD5_CODRDA := cGCodExe
						BD5->BD5_OPERDA := PLSINTPAD()
						BD5->BD5_TIPRDA := BAU->BAU_TIPPE
						BD5->BD5_NOMRDA := BAU->BAU_NOME
						BD5->BD5_DESLOC := BB8->BB8_DESLOC
						BD5->BD5_ENDLOC := BB8->BB8_END
						BD5->BD5_CODESP := BAX->BAX_CODESP
						BD5->BD5_CID    := cGCid
						BD5->BD5_ESTSOL := Posicione("BB0",1,xFilial("BB0")+Iif(Empty(cGCodSol),cGPSaude,cGCodSol),"BB0_ESTADO")
						BD5->BD5_OPESOL := PLSINTPAD()
						BD5->BD5_SIGLA  := Posicione("BB0",1,xFilial("BB0")+Iif(Empty(cGCodSol),cGPSaude,cGCodSol),"BB0_CODSIG")
						BD5->BD5_REGSOL := Posicione("BB0",1,xFilial("BB0")+Iif(Empty(cGCodSol),cGPSaude,cGCodSol),"BB0_NUMCR")
						BD5->BD5_NOMSOL := Posicione("BB0",1,xFilial("BB0")+Iif(Empty(cGCodSol),cGPSaude,cGCodSol),"BB0_NOME")
						BD5->BD5_TIPCON := "1"
						BD5->BD5_TIPGUI := cTipGui
						BD5->BD5_ATEAMB := "1"
						BD5->BD5_CDPFSO := Iif(Empty(cGCodSol),cGPSaude,cGCodSol)
						BD5->BD5_OPEUSR := BA1->BA1_CODINT
						BD5->BD5_CODEMP := BA1->BA1_CODEMP
						BD5->BD5_MATRIC := BA1->BA1_MATRIC
						BD5->BD5_TIPREG := BA1->BA1_TIPREG
						BD5->BD5_CPFUSR := BA1->BA1_CPFUSR
						BD5->BD5_IDUSR  := BA1->BA1_DRGUSR
						BD5->BD5_DATNAS := BA1->BA1_DATNAS
						BD5->BD5_CPFRDA := BAU->BAU_CPFCGC
						BD5->BD5_FASE   := "4"
						BD5->BD5_SITUAC := "1"
						BD5->BD5_DIGITO := BA1->BA1_DIGITO
						BD5->BD5_CONEMP := BA1->BA1_CONEMP
						BD5->BD5_VERCON := BA1->BA1_VERCON
						BD5->BD5_SUBCON := BA1->BA1_SUBCON
						BD5->BD5_VERSUB := BA1->BA1_VERSUB
						BD5->BD5_LOCAL  := BB8->BB8_LOCAL
						BD5->BD5_CODLOC := BB8->BB8_CODLOC
						BD5->BD5_MATVID := BA1->BA1_MATVID
						BD5->BD5_DTDIGI := dDataBase
						BD5->BD5_MATUSA := cMatUsa
						BD5->BD5_QTDEVE := 0
						BD5->BD5_REGEXE := ""
						BD5->BD5_CDPFRE := BAU->BAU_CODBB0
						BD5->BD5_ESTEXE := BAU->BAU_ESTCR
						BD5->BD5_SIGEXE := BAU->BAU_SIGLCR
						BD5->BD5_ORIMOV := IIF(cTipGui ="03","2","1")
						BD5->BD5_MESPAG := cMes
						BD5->BD5_ANOPAG := cAno
						BD5->BD5_GUIACO := "0"
						BD5->BD5_ESTEXE := GetNewPar("MV_PLSESPD","SP")
						BD5->BD5_NUMFAT := "IMP.HIST"
						BD5->BD5_SEQPF	:= "IMP.HIST"						
						BD5->(MsUnlock())
						cChaveGui := BD5->(BD5_CODLDP+BD5_CODPEG+BD5_NUMERO)
					EndIf
				Endif
			Else
				Aadd(aErr,{"Especialidade para RDA "+cGCodExe+" nao encontrada! N. Guia:"+cINroImp,TRB->(NUMREG)})
			Endif
		Else
            If nTipImp > 1
				BD5->(RecLock("BD5",.F.))
				BD5->BD5_DATPRO := dDatEmi
				BD5->(MsUnlock())
				cChaveGui := BD5->(BD5_CODLDP+BD5_CODPEG+BD5_NUMERO)
			EndIf
		EndIf             
		
	Endif
	
Else
	
	If cTipGui == "03"
		
		BE4->(DbSetOrder(1))
		If BE4->(MsSeek(xFilial("BE4")+PLSINTPAD()+BCI->(BCI_CODLDP+BCI_CODPEG)+cNumero))
            If nTipImp > 1
				BE4->(RecLock("BE4",.F.))
				BE4->BE4_DATPRO := dDatEmi
				BE4->BE4_HORPRO := Iif(Empty(Alltrim(cGHorPro)),"0800",cGHorPro)
				BE4->BE4_DTALTA := dGDtAlta
				BE4->BE4_HRALTA := Iif(Empty(cGHorAlt),"0800",cGHorAlt)
				BE4->BE4_TIPALT := Iif(Empty(cGTipAlt),"1",cGTipAlt)		
				BE4->BE4_PADINT := Posicione("BI3",1,xFilial("BI3")+PLSINTPAD()+Iif(Empty(BA1->BA1_CODPLA),BA3->(BA3_CODPLA+BA3_VERSAO),BA1->(BA1_CODPLA+BA1_VERSAO)),"BI3_CODACO") 
				BE4->BE4_TIPNAS := Iif(Empty(cGTipNas),"0",cGTipNas)
				BE4->BE4_NUMFAT := "IMP.HIST"
				BE4->BE4_SEQPF	:= "HISTOR"						
				
				BE4->(MsUnlock())
				
				cChaveGui := BE4->(BE4_CODLDP+BE4_CODPEG+BE4_NUMERO)
			EndIf
		EndIf
		
	Else
		BD5->(DbSetOrder(1))
		If BD5->(MsSeek(xFilial("BD5")+PLSINTPAD()+BCI->(BCI_CODLDP+BCI_CODPEG)+cNumero))
            If nTipImp > 1
				BD5->(RecLock("BD5",.F.))
				BD5->BD5_DATPRO := dDatEmi
				BD5->(MsUnlock())
				cChaveGui := BD5->(BD5_CODLDP+BD5_CODPEG+BD5_NUMERO)
			EndIf
		Endif
	Endif
	
EndIf

If nTipImp > 1
	BCI->(RecLock("BCI",.F.))
	BCI->BCI_STATUS := "1"
	BCI->BCI_FASE   := "4"
	BCI->BCI_SITUAC := "1"
	BCI->(MsUnlock())
EndIf

Return cChaveGui



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �Grava_Item�Autor  � Jean Schulz        � Data �  27/04/06   ���
�������������������������������������������������������������������������͹��
���Desc.     �Grava item da guia e composicao de cobranca/pagamento.      ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function Grava_Item

Local cSeq		:= ""
Local cTabTde	:= ""
Local aCodTab	:= {}
Local lGravaItem:= .F.

BR8->(DbSetOrder(3))

If BR8->(MsSeek(xFilial("BR8")+cICodProc))
   
    If !Empty(Substr(cLinha,028,020))
	    cGCid	:= Substr(cLinha,028,020)
	Else
	    cGCid	:= "Y99"
	EndIf				    
   
	BD6->(DbSetOrder(6))//BD6_FILIAL + BD6_CODOPE + BD6_CODLDP + BD6_CODPEG + BD6_NUMERO + BD6_ORIMOV+ + BD6_CODPAD + BD6_CODPRO
	BD6->(MsSeek(xFilial("BD6")+PLSINTPAD()+cCodLdp+_cPeg+cNumero+cOriMov+BR8->(BR8_CODPAD+BR8_CODPSA)))
	
	//If ! BD6->(Found()) .Or. (BD6->(Found()) .And. BD6->BD6_SITUAC == "2") 
	
	lGravaItem := .F.
	
	If ! BD6->(Found())
		lGravaItem := .T.
	Else
		While !BD6->(Eof()) .And. BD6->(BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_CODPAD+BD6_CODPRO) == PLSINTPAD()+cCodLdp+_cPeg+cNumero+cOriMov+BR8->(BR8_CODPAD+BR8_CODPSA)
		
			If BD6->BD6_DATPRO < Iif(Empty(dIDatProc),dGDtAtend,dIDatProc)
				lGravaItem := .T.
				Exit						
			Endif
			
			BD6->(DbSkip())
			
		Enddo
	Endif
	
	If lGravaItem
	
        If nTipImp > 1
			cSeq := ProxSeq(PLSINTPAD(), cCodLdp, _cPeg, cNumero, cOriMov)						
		
			BD6->(Reclock("BD6",.T.))
			BD6->BD6_FILIAL := xFilial("BD6")
			BD6->BD6_CODOPE := PLSINTPAD()
			BD6->BD6_CODLDP := cCodLdp
			BD6->BD6_CODPEG := _cPeg
			BD6->BD6_NUMERO := cNumero
			BD6->BD6_SEQUEN := cSeq
			BD6->BD6_NUMIMP := cGNroImp
			BD6->BD6_CODPAD := BR8->BR8_CODPAD
			BD6->BD6_CODPRO := BR8->BR8_CODPSA
			BD6->BD6_QTDPRO := nIQtdProc
			//BD6->BD6_QTDAPR := nIQtdProc      //DESCONTINUADO P12
			BD6->BD6_VLRAPR := (nIVlrApr/nIQtdProc)
			BD6->BD6_VLRPAG := nIVlrUni
			BD6->BD6_DESPRO := BR8->BR8_DESCRI
			BD6->BD6_LOCAL  := BB8->BB8_LOCAL
			BD6->BD6_CODESP := BAX->BAX_CODESP
			BD6->BD6_OPEUSR := BA1->BA1_CODINT
			BD6->BD6_CODEMP := BA1->BA1_CODEMP
			BD6->BD6_MATRIC := BA1->BA1_MATRIC
			BD6->BD6_TIPREG := BA1->BA1_TIPREG
			BD6->BD6_CONEMP := BA1->BA1_CONEMP
			BD6->BD6_MATVID := BA1->BA1_MATVID
			BD6->BD6_FASE   := "4"
			BD6->BD6_SITUAC := "1"
			If cCodLdp == "0000"
				If cGTipGui == "03"
			    	BE4->(DbSetOrder(1))
		    		If BE4->(MsSeek(xFilial("BE4")+PLSINTPAD()+cCodLdp+_cPeg+cNumero))
						BD6->BD6_MESPAG := BE4->BE4_MESPAG
						BD6->BD6_ANOPAG := BE4->BE4_ANOPAG
					Else
						BD6->BD6_MESPAG := cMes
						BD6->BD6_ANOPAG := cAno
					Endif
				Else
			    	BD5->(DbSetOrder(1))   		
					If BD5->(MsSeek(xFilial("BD5")+PLSINTPAD()+cCodLdp+_cPeg+cNumero))
						BD6->BD6_MESPAG := BD5->BD5_MESPAG
						BD6->BD6_ANOPAG := BD5->BD5_ANOPAG
					Else
						BD6->BD6_MESPAG := cMes
						BD6->BD6_ANOPAG := cAno
					Endif
				Endif
			Else
				BD6->BD6_MESPAG := cMes
				BD6->BD6_ANOPAG := cAno
			Endif
			BD6->BD6_OPERDA := PLSINTPAD()
			BD6->BD6_CODRDA := cGCodSol
			BD6->BD6_DATPRO := Iif(Empty(dIDatProc),dGDtAtend,dIDatProc)
			BD6->BD6_HORPRO := Iif(Empty(Alltrim(cIHorProc)),cGHorPro,cIHorProc)
			BD6->BD6_DTDIGI := dDataBase
		    If cGTipGui == "03"
		    	BE4->(DbSetOrder(1))
		    	BE4->(MsSeek(xFilial("BE4")+PLSINTPAD()+cCodLdp+_cPeg+cNumero))
				BD6->BD6_ANOINT := BE4->BE4_ANOINT
				BD6->BD6_MESINT := BE4->BE4_MESINT
				BD6->BD6_NUMINT := BE4->BE4_NUMINT
				BD6->BD6_OPEINT := BE4->BE4_CODOPE
			Endif
			BD6->BD6_TPGRV  := "4"
			BD6->BD6_STATUS := "1"
			

			
			BD6->BD6_SIGLA  := Posicione("BB0",1,xFilial("BB0")+Iif(Empty(cGCodSol),cGPSaude,cGCodSol),"BB0_CODSIG")
			BD6->BD6_ESTSOL := Posicione("BB0",1,xFilial("BB0")+Iif(Empty(cGCodSol),cGPSaude,cGCodSol),"BB0_ESTADO")
			BD6->BD6_NOMSOL := Posicione("BB0",1,xFilial("BB0")+Iif(Empty(cGCodSol),cGPSaude,cGCodSol),"BB0_NOME")
			BD6->BD6_REGSOL := Posicione("BB0",1,xFilial("BB0")+Iif(Empty(cGCodSol),cGPSaude,cGCodSol),"BB0_NUMCR")
			BD6->BD6_CODLOC := BB8->BB8_CODLOC
			BD6->BD6_CDPFSO := cGCodSol
			BD6->BD6_DIGITO := BA1->BA1_DIGITO
			BD6->BD6_ATEAMB := IIF(cGTipGui=="03","0","1")
			If ! Empty(cGCid)
				BD6->BD6_CID := cGCid
			Endif
			BD6->BD6_CPFRDA := BAU->BAU_CPFCGC
			BD6->BD6_DATNAS := BA1->BA1_DATNAS
			BD6->BD6_DESLOC := BB8->BB8_DESLOC
			BD6->BD6_ENDLOC := BB8->BB8_END
			BD6->BD6_IDUSR  := BA1->BA1_DRGUSR
			BD6->BD6_NOMRDA := BAU->BAU_NOME
			BD6->BD6_NOMUSR := BA1->BA1_NOMUSR
		
			BD6->BD6_TIPGUI := cGTipGui
			BD6->BD6_TIPRDA := BAU->BAU_TIPPE
			BD6->BD6_MATUSA := cMatUsa
			BD6->BD6_MATANT := BA1->BA1_MATANT
			BD6->BD6_CODPLA := Iif(Empty(BA1->BA1_CODPLA),BA3->BA3_CODPLA,BA1->BA1_CODPLA)
			BD6->BD6_GUIORI := cGNroImp
			BD6->BD6_REGEXE := BAU->BAU_CONREG
			BD6->BD6_CDPFRE := BAU->BAU_CODBB0
			BD6->BD6_ESTEXE := BAU->BAU_ESTCR
			BD6->BD6_SIGEXE := BAU->BAU_SIGLCR
			BD6->BD6_ORIMOV := IIF(cgTipGui ="03","2","1")
			BD6->BD6_GUIACO := "0"
			BD6->BD6_NIVEL  := BR8->BR8_NIVEL
			BD6->BD6_TIPUSR := BA3->BA3_TIPOUS
			BD6->BD6_MODCOB := BA3->BA3_MODPAG
			BD6->BD6_INTERC := IIF(BA1->BA1_CODEMP == GetNewPar("MV_PLSGEIN","9999"),"1","0")
			BD6->BD6_TIPINT := IIF(BD6->BD6_INTERC=="1","1","")
			BD6->BD6_PROCCI := IIF(BR8->BR8_TIPEVE=="2","1","0")
			If BR8->BR8_CTREQU=="1"
				BD6->BD6_VIA    := cIViaProc
				BD6->BD6_PERVIA := nIPerProc
			Endif
			BD6->BD6_CDPDRC := BR8->BR8_CODPAD
			M->BD6_CDNV01   := ""
			M->BD6_CDNV02   := ""
			M->BD6_CDNV03   := ""
			M->BD6_CDNV04   := ""
			PLSGatNiv(BR8->BR8_CODPAD,BR8->BR8_CODPSA,"BD6")
			BD6->BD6_CDNV01 := M->BD6_CDNV01
			BD6->BD6_CDNV02 := M->BD6_CDNV02
			BD6->BD6_CDNV03 := M->BD6_CDNV03
			BD6->BD6_CDNV04 := M->BD6_CDNV04
			aCodTab := (BD6->BD6_CODPAD,BD6->BD6_CODPRO,BD6->BD6_DATPRO,;
			BD6->BD6_CODOPE,BD6->BD6_CODRDA,BD6->BD6_CODESP,BD6->BD6_SUBESP,BD6->(BD6_CODLOC+BD6_LOCAL))
			/*
			If aCodTab[1]
				BD6->BD6_ALIATB := aCodTab[4]
			EndIf
			*/
			cTabTde := Posicione("BA8",4,xFilial("BA8")+BR8->BR8_CODPSA,"BA8_CODTAB")
			BD6->BD6_CODTAB := substr(cTabTde,5,3)
			BD6->BD6_CONEMP := BA1->BA1_CONEMP
			BD6->BD6_VERCON := BA1->BA1_VERCON
			BD6->BD6_SUBCON := BA1->BA1_SUBCON
			BD6->BD6_VERSUB := BA1->BA1_VERSUB
			BD6->BD6_OPEORI := BA1->BA1_OPEORI
			/*
			If BD6->BD6_QTD1 = 0
				BD6->BD6_QTD1  := 1
				BD6->BD6_PERC1 := 100
			EndIf
			*/
			BD6->(MsUnlock())
	   
			//���������������������������������������������������������������������Ŀ
			//� Grava BD7                                                           �
			//�����������������������������������������������������������������������
			cRda := BD6->BD6_CODRDA
			cCrm := BAU->BAU_CONREG
			cBB0 := BAU->BAU_CODBB0
	
			PLS720IBD7("0",BD6->BD6_VLPGMA,BR8->BR8_CODPAD,BR8->BR8_CODPSA,substr(cTabTde,5,3),;
			PLSINTPAD(),cGCodExe,BAU->BAU_CONREG,BAU->BAU_SIGLCR,;
			BAU->BAU_ESTCR,BAU->BAU_CODBB0,BAX->BAX_CODESP,BB8->BB8_CODLOC,;
			"1",cSeq,IIF(cGTipGui ="03","2","1"),cGTipGui)
	
		EndIf
		
	Endif
	
Endif

Return
/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  � ProxBE4  � Autor � Thiago Machado Correa � Data � 20/10/05 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Retorna o proximo numero disponivel                        ���
�������������������������������������������������������������������������Ĵ��
���Uso       � Unimed Tubarao		                                      ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Static Function ProxBE4(cCodOpe,cCodLdp,cCodPeg)

Local cRet := ""

BE4->(DbSetOrder(1))
BE4->(MsSeek(xFilial("BE4")+cCodOpe+cCodLDP+cCodPeg+"99999999",.T.))
BE4->(DbSkip(-1))

If BE4->(BE4_FILIAL+BE4_CODOPE+BE4_CODLDP+BE4_CODPEG) == (xFilial("BE4")+cCodOpe+cCodLdp+cCodPeg)
	cRet := Strzero(Val(BE4->BE4_NUMERO)+1,8)
Else
	cRet := StrZero(1,8)
Endif

Return cRet


/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  � ProxBD5  � Autor � Thiago Machado Correa � Data � 08/04/05 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Retorna o proximo numero disponivel                        ���
�������������������������������������������������������������������������Ĵ��
���Uso       � Unimed Tubarao		                                      ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Static Function ProxBD5(cCodOpe,cCodLdp,cCodPeg)

Local cRet := ""

BD5->(DbSetOrder(1))
BD5->(DbSeek(xFilial("BD5")+cCodOpe+cCodLDP+cCodPeg+"99999999",.T.))
BD5->(DbSkip(-1))

If BD5->(BD5_FILIAL+BD5_CODOPE+BD5_CODLDP+BD5_CODPEG) == (xFilial("BD5")+cCodOpe+cCodLdp+cCodPeg)
	cRet := Strzero(Val(BD5->BD5_NUMERO)+1,8)
Else
	cRet := StrZero(1,8)
Endif

Return cRet

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  � ProxSeq  � Autor � Thiago Machado Correa � Data � 08/04/05 ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Retorna o proximo numero disponivel                        ���
�������������������������������������������������������������������������Ĵ��
���Uso       � Unimed Tubarao		                                      ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/
Static Function ProxSeq(cCodOpe, cCodLdp, cCodPeg, cNumero, cOriMov)

Local cRet := ""

BD6->(DbSetOrder(1))
BD6->(DbSeek(xFilial("BD6")+cCodOpe+cCodLdp+cCodPeg+cNumero+cOriMov+"999",.T.))
BD6->(DbSkip(-1))

If BD6->(BD6_FILIAL+BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV) == (xFilial("BD6")+cCodOpe+cCodLdp+cCodPeg+cNumero+cOriMov)
	cRet := Strzero(Val(BD6->BD6_SEQUEN)+1,3)
Else
	cRet := StrZero(1,3)
Endif

Return cRet


Return lGravou



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �Imprime   �Autor  � Jean Schulz        � Data �  28/04/06   ���
�������������������������������������������������������������������������͹��
���Desc.     �Imprime relatorio cfme solicitado pela rotina.              ���
�������������������������������������������������������������������������͹��
���Uso       � IMPCTSMED                                                  ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function Imprime
Local nCont		:= 0
Local nTotImp	:= 0

//���������������������������������������������������������������������Ŀ
//� Impressao de erros e inconsistencias encontradas...                 �
//�����������������������������������������������������������������������
cCabec2 := PADC("Relat�rio de inconsist�ncias",nLimite) 
Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nControle)  
nLin := 9

For nCont := 1 to Len(aErr)

	If nLin > nQtdLin
		Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nControle)  
		nLin := 9
	Endif 
	
	@ nLin, 000 PSay aErr[nCont,1]+Iif(Val(aErr[nCont,2])>0," Linha: "+aErr[nCont,2],"")
	nLin++

Next

@ nLin, 000 PSay Replicate("-",nLimite)
nLin++
@ nLin, 000 PSay "Total de inconsist�ncias: "+Transform(Len(aErr),"@E 999,999.99")
nLin++                                                          


//���������������������������������������������������������������������Ŀ
//� Impressao de guias importadas corretamente.... 		                �
//�����������������������������������������������������������������������
nTotImp := 0

//���������������������������������������������������������������������Ŀ
//� Impressao de guias importadas...                                    �
//�����������������������������������������������������������������������
cCabec2 := PADC("Relat�rio de guias importadas",nLimite) 
Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nControle)  
nLin := 9

For nCont := 1 to Len(aGuiImp)
	
	If nLin > nQtdLin
		Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nControle)
		nLin := 9
	Endif 
	
	@ nLin, 000 PSay "Senha: "+aGuiImp[nCont,2]+" Dt.Atend: "+DtoC(aGuiImp[nCont,3])+ " Cod.Usr: "+aGuiImp[nCont,4]+" Nome Usr: "+aGuiImp[nCont,5]+" Chave: "+aGuiImp[nCont,6]
	nLin++	
	
	nTotImp++		
	
Next	
@ nLin, 000 PSay Replicate("-",nLimite)
nLin++
@ nLin, 000 PSay "Total de guias importadas: "+Transform(nTotImp,"@E 999,999.99")
nLin++

Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �VeTipGui  �Autor  �Microsiga           � Data �  19/08/06   ���
�������������������������������������������������������������������������͹��
���Desc.     �Retorna o tipo de guia que devera ser importado o documento.���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function VeTipGui(cLote, cDoc, cLinha)
Local cTipGui	:= ""
Local nRecno	:= 0

nRecno := TRB->(RECNO())

If Substr(cLinha,53,1) == "I" //Internacao
	cTipGui := "3"
Else
	If Substr(cLinha,248,8) $ ("00010014,00010073,10101012,10101039")
		cTipGui := "1"
		TRB->(DbSkip())
		cLinha := TRB->(NUMREG+DtoS(DATENV)+CODRDA+LOTE+DOC+CAMPO)
		
		If cLote+cDoc==Substr(cLinha,26,14)
			cTipGui := "2"
		Endif
		
		TRB->(DbSkip(-1))
	Else
		cTipGui := "2"
	Endif

Endif

TRB->(DbGoto(nRecno))

Return cTipGui


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �AjustaSX1 �Autor  � Thiago Machado Correa� Data � 08/04/05  ���
�������������������������������������������������������������������������͹��
���Desc.     � Cria / ajusta as perguntas da rotina                       ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function AjustaSX1(cPerg)

Local aHelpPor := {}
Local aHelpEng := {}
Local aHelpSpa := {}
Local aTam

aHelpPor := {}
aAdd( aHelpPor, "Informe a operadora.                    " )
aAdd( aHelpPor, "Utilize F3 para pesquisar.              " )
aAdd( aHelpPor, "                                        " )
aTam := {04,00}
PutSx1(cPerg,"01","Operadora"           ,"","","mv_ch1","C",aTam[1],aTam[2],0,"G","","B89","","","mv_par01","","","","","","","","","","","","","","","","",aHelpPor,{},{})

aHelpPor := {}
aAdd( aHelpPor, "Opcao para Consistir e Importar         " )
aAdd( aHelpPor, "a guias do arquivo.                     " )
aAdd( aHelpPor, "                                        " )
aTam := {01,00}
PutSx1(cPerg,"02","Consitir ou Importar?" ,"","","mv_ch2","C",aTam[1],aTam[2],1,"C","","","","","mv_par02","Consistir","","","","Cons./Importar","","","","","","","","","","","",aHelpPor,{},{})

Pergunte(cPerg,.T.)

Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �TrCdAnt   �Autor  �Microsiga           � Data �  25/10/06   ���
�������������������������������������������������������������������������͹��
���Desc.     �Troca codigo antigo pelo novo, conforme cadastro em BA8.    ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � Microsiga.                                                 ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function TrCdAnt(cCodAnt)
Local aRet		:= {.F.,cCodAnt}
Local cSQL		:= ""

cSQL := " SELECT BA8_CODPAD, BA8_CODPRO FROM "+RetSQLName("BA8")
cSQL += " WHERE BA8_CODANT = '"+cCodAnt+"' "
cSQL += " AND D_E_L_E_T_ = ' ' "
PlsQuery(cSQL,"TRB1")

If !Empty(TRB1->BA8_CODPRO)
	aRet[1] := .T.
	aRet[2] := TRB1->BA8_CODPRO
Endif

TRB1->(DbCloseArea())

Return aRet

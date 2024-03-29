#Include 'RWMAKE.CH'
#Include 'PLSMGER.CH'
#Include 'COLORS.CH'
#Include 'TOPCONN.CH'

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �EXPANITA  �Autor  �Jean Schulz         � Data �  22/01/07   ���
�������������������������������������������������������������������������͹��
���Desc.     �Exportacao de analitico de faturas Itau.                    ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � MP8                                                        ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
User Function EXPANITA  

Local cNomeArq	:= ""

//���������������������������������������������������������������������Ŀ
//� Declaracao de Variaveis                                             �
//�����������������������������������������������������������������������
PRIVATE cNomeProg   := "EXPANITA"
PRIVATE nQtdLin     := 50
PRIVATE nLimite     := 132
PRIVATE cControle   := 15
PRIVATE cTamanho    := "M"
PRIVATE cTitulo     := "Exportacao Anlt. Itau"
PRIVATE cDesc1      := ""
PRIVATE cDesc2      := ""
PRIVATE cDesc3      := ""
PRIVATE cAlias      := "BM1"
PRIVATE cPerg       := "YANITA"
PRIVATE nRel        := "EXPANITA"
PRIVATE nlin        := 100
PRIVATE nOrdSel     := 1
PRIVATE m_pag       := 1
PRIVATE lCompres    := .F.
PRIVATE lDicion     := .F.
PRIVATE lFiltro     := .T.
PRIVATE lCrystal    := .F.
PRIVATE aOrdens     := {} 
PRIVATE aReturn     := { "", 1,"", 1, 1, 1, "",1 }
PRIVATE lAbortPrint := .F.
PRIVATE cCabec1     := "Protocolo de exporta��o de usu�rios / layout Itau."
PRIVATE cCabec2     := ""
PRIVATE nColuna     := 00
PRIVATE nOrdSel     := 0
PRIVATE cString     := "BA1"
PRIVATE nTipo		:= GetMv("MV_COMP")
PRIVATE aUtiliza	:= {}
PRIVATE nHdl

//���������������������������������������������������������������������Ŀ
//� Variaveis de parametros do relatorio.                               �
//�����������������������������������������������������������������������
PRIVATE cPrefDe	:= ""
PRIVATE cPrefAte:= ""
PRIVATE cTitDe	:= ""
PRIVATE cTitAte	:= ""
PRIVATE cCodFTM	:= ""
PRIVATE cMesDem	:= ""
PRIVATE cAnoDem := ""
PRIVATE nTotReg	:= 0

//Raios
//MsgAlert("Aten��o! Nao estao sendo gerados todos os registros! Avise a informatica!")

ParSX1()
If !Pergunte(cPerg,.T.)
	MsgAlert("Exporta��o abortada!")
	Return
Endif

WnRel := SetPrint(cString,nrel,cPerg,cTitulo,cDesc1,cDesc2,cDesc3,lDicion,aOrdens,lCompres,cTamanho,{},lFiltro,lCrystal)

SetDefault(aReturn,cString)

If nLastKey == 27
   Return
End

Processa({|| ImpRel() }, "Gerando arquivo de dados...", "", .T.)

If  aReturn[5] == 1
	Set Printer To
	Ourspool(nRel)
End
MS_FLUSH()

Return




/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �ImpRel    �Autor  �Jean Schulz         � Data �  22/01/07   ���
�������������������������������������������������������������������������͹��
���Desc.     �Funcao chamada pela funcao processa para imprimir protocolo ���
���          �e gerar texto para empresa.                                 ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function ImpRel

Local nCont1 	:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
Local nCont 	:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

//���������������������������������������������������������������������Ŀ
//� Variaveis de utilizacao da rotina exp Farmacia...                   �
//�����������������������������������������������������������������������
Local nLin		:= 100
Local cSQL      := ""
Local cDirExp	:= GETNEWPAR("MV_YANITA","\Exporta\ANLITAU\")
Local cEOL		:= CHR(13)+CHR(10)
Local cCpo		:= ""
Local cAno		:= ""
Local cMes		:= ""
Local nReg		:= 0
Local nPos		:= 0
Local nDelIni	:= 0
Local nDelFim	:= 0
Local cMatEmpAnt:=""
Local lRednPos	:= .F.
Local cMsg01	:= "'*' INDICA INCIDENCIA DE FATOR MODERADOR"
Local cEndereco	:= ""
Local cCompet	:= ""
Local cElemImp	:= ""
Local aNomeMes	:= { "Janeiro", "Fevereiro", "Mar�o", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro" }
Local _cMatUsr	:= ""
Local aAreaTMPBA1 := {}
Local aAreaBA1	:= {}

Local aImp		:= {}
PRIVATE aImpCA4	:= {}
PRIVATE aImpCA3S:= {}
PRIVATE aImpCA3D:= {}
PRIVATE aImpIA4	:= {}
PRIVATE aImpIA3S:= {}
PRIVATE aImpIA3D:= {}
PRIVATE aMatUti	:= {}

PRIVATE cArray	:= ""
PRIVATE nCont	:= 0
PRIVATE nCont1	:= 0


//���������������������������������������������������������������������Ŀ
//� Atualiza variaveis a partir dos parametros do pergunte.             �
//�����������������������������������������������������������������������
Atu_Var()

//���������������������������������������������������������������������Ŀ
//� Define indices e tabelas para uso.                                  �
//�����������������������������������������������������������������������
BR8->(DbSetOrder(3))
BD6->(DbSetOrder(1))
BCI->(DbSetOrder(1))
BD5->(DbSetOrder(1))
BE4->(DbSetOrder(1))
BKD->(DbSetOrder(1))
BKE->(DbSetOrder(1))
BK6->(DbSetOrder(1))
ZZH->(DbSetOrder(1)) //ZZH_FILIAL+ZZH_CODIGO+ZZH_ANO+ZZH_MES
BA3->(DbSetOrder(1))
BI3->(DbSetOrder(1))
BI4->(DbSetOrder(1))
BA1->(DbSetOrder(2))


//���������������������������������������������������������������������Ŀ
//� Controles para nao geracao do arquivo...                            �
//�����������������������������������������������������������������������
If ZZH->(MsSeek(xFilial("ZZH")+cCodFTM))
	If ZZH->ZZH_STATUS <> "2"
		MsgAlert("Arquivo de retorno Fator Moderador Ita� n�o foi importado. Imposs�vel gerar exporta��o de anal�tico","Aten��o!")
		Return	
	Else
		cAno := ZZH->ZZH_ANO
		cMes := ZZH->ZZH_MES
	Endif
Else 
	MsgAlert("Exporta��o Fator Moderador Ita� n�o encontrada. Opera��o Abortada!","Aten��o!")
	Return
Endif

MsgRun("Aguarde... Selecionando Registros de Utiliza��o...",,{|| BuscaRegs(),CLR_HBLUE})
MsgRun("Aguarde... Selecionando Registros de Mensalidade...",,{|| BuscaTit(),CLR_HBLUE})

If nTotReg <= 0
	MsgAlert("Nenhum t�tulo selecionado. Imposs�vel gerar arquivo! Opera��o abortada","Aten��o!")
	Return
Endif

ProcRegua(nTotReg)


//���������������������������������������������������������������������Ŀ
//� Baseado nos usuarios cobrados no mes, gerar exportacao mens+co-part.�
//�����������������������������������������������������������������������				
While ! TRB->(EOF())

	nCont++

	IncProc("Registro: "+StrZero(nCont,6))	
			
	//���������������������������������������������������������������������Ŀ
	//� Imprime cabecalho e caso exista utilizacao, imprime a mesma.        �
	//�����������������������������������������������������������������������
	If Substr(cMatEmpAnt,1,9) <> Substr(Alltrim(TRB->BA1_MATEMP),1,9)
		
		//���������������������������������������������������������������������Ŀ
		//� Verificacao de existencia de utilizacao (FTM).                      �
		//�����������������������������������������������������������������������			
		nPos := ascan(aUtiliza, { |x| Substr(AllTrim(x[1]),1,9) == Substr(Alltrim(cMatEmpAnt),1,9) })
		
		If nPos > 0
		
			nDelIni := nPos
			While nPos <= Len(aUtiliza) .And. Substr(Alltrim(aUtiliza[nPos,1]),1,9) == Substr(Alltrim(cMatEmpAnt),1,9)
			
				//���������������������������������������������������������������������Ŀ
				//� Impressao do fator moderador.                                       �
				//�����������������������������������������������������������������������			
				_cMatUsr := Substr(aUtiliza[nPos,4],1,4)+"."+Substr(aUtiliza[nPos,4],5,4)+"."+Substr(aUtiliza[nPos,4],9,6)+"."+Substr(aUtiliza[nPos,4],15,2)+"-"+Substr(aUtiliza[nPos,4],17,1)
				
				If GetNewPar("MV_YMATANT",'0') == "1" //matricula_antiga
					//Posicionar BA1 e buscar matricula antiga...
					aAreaTMPBA1 := BA1->(GetArea())
					BA1->(DbSetOrder(2))
					BA1->(MsSeek(xFilial("BA1")+aUtiliza[nPos,4]))
															
					_cMatUsr := Iif(!Empty(BA1->BA1_MATANT),(SubStr(BA1->BA1_MATANT,1,3)+"."+SubStr(BA1->BA1_MATANT,4,5)+"."+SubStr(BA1->BA1_MATANT,9,2)+"."+SubStr(BA1->BA1_MATANT,11,1)+space(7)),_cMatUsr)
					
					RestArea(aAreaTMPBA1)
				Endif				
				
				If Empty(Substr(_cMatUsr,1,2))
					MsgAlert("Matricula em branco!")
				Endif
				
				cLin := Space(1)+cEOL
				cCpo :=	"3"+;
						"2"+;
						_cMatUsr+;
						aUtiliza[nPos,5]+;
						aUtiliza[nPos,6]+;
						aUtiliza[nPos,7]+;
						aUtiliza[nPos,8]+;
						Space(10)+;
						Space(10)+;
						aUtiliza[nPos,9]+;
						Space(416)						
																	
				aadd(aImp[Len(aImp),7],cCpo)
				
				nPos++ 
				
			Enddo
			
			nDelFim := nPos-1
			nPos := nDelIni

			//���������������������������������������������������������������������Ŀ
			//� Remover registros de utilizacao ja impressos, evitando re-impressao.�
			//�����������������������������������������������������������������������							
			For nDelIni := nPos to nDelFim				
				adel(aUtiliza,nPos)
				asize(aUtiliza,Len(aUtiliza)-1)
			Next
			
		Endif

		
		//���������������������������������������������������������������������Ŀ
		//� Conforme definicao em 31/08/07, no registro 1 sempre enviar titular.�
		//�����������������������������������������������������������������������											
		aAreaBA1 := BA1->(GetArea())
		
		BA1->(DbSetOrder(2))
		BA1->(MsSeek(xFilial("BA1")+TRB->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC+"00")))
		
		If !BA1->(Found())
			BA1->(MsSeek(xFilial("BA1")+TRB->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC+BM1_TIPREG)))
		Endif
		
		//���������������������������������������������������������������������Ŀ
		//� Trocar matricula antiga/nova, conforme parametro...                 �
		//�����������������������������������������������������������������������											
		_cMatUsr := BA1->BA1_CODINT+"."+BA1->BA1_CODEMP+"."+BA1->BA1_MATRIC+"."+BA1->BA1_TIPREG+"-"+BA1->BA1_DIGITO
		If GetNewPar("MV_YMATANT",'0') == "1" //matricula_antiga
			_cMatUsr := Iif(!Empty(BA1->BA1_MATANT),(SubStr(BA1->BA1_MATANT,1,3)+"."+SubStr(BA1->BA1_MATANT,4,5)+"."+SubStr(BA1->BA1_MATANT,9,2)+"."+SubStr(BA1->BA1_MATANT,11,1)+Space(7)),_cMatUsr)
		Endif								
		
		If Empty(Substr(_cMatUsr,1,2))
			MsgAlert("Matricula em branco!")
		Endif		
			
		cEndereco := Alltrim(BA1->BA1_ENDERE)+Space(1)+Alltrim(BA1->BA1_NR_END)+Space(1)+Alltrim(BA1->BA1_COMEND)

		//���������������������������������������������������������������������Ŀ
		//� Cfme regras Itau, caso lotac == "I" tratar endereco especificamente.�
		//�����������������������������������������������������������������������									
		If Alltrim(BA1->BA1_YINDEN) == "I"
			cEndereco := Alltrim(BA1->BA1_YLOTAC)+" - "+BA1->BA1_YNOMLO
		Endif		
		cEndereco := Substr(cEndereco,1,40)
		cCompet := aNomeMes[Val(cMesDem)]+" de "+cAnoDem
		
		//���������������������������������������������������������������������Ŀ
		//� Impressao do cabecalho...                                           �
		//�����������������������������������������������������������������������			
		cLin := Space(1)+cEOL
		cCpo :=	"1"+;
				"2"+;
				_cMatUsr+;
				StrZero(Val(BA1->BA1_MATEMP),18)+;
				Substr(BA1->BA1_NOMUSR,1,30)+;
				cEndereco+Space(40-Len(cEndereco))+;
				Substr(BA1->BA1_BAIRRO,1,20)+;
				Substr(BA1->BA1_MUNICI,1,20)+;
				Substr(BA1->BA1_CEPUSR,1,5)+"-"+Substr(BA1->BA1_CEPUSR,6,3)+;
				BA1->BA1_ESTADO+;
				cCompet+Space(30-Len(cCompet))+;
				Space(12)+;
				Space(12)+;
				Space(12)+;
				Space(12)+;
				cMsg01+Space(100-Len(cMsg01))+;
				Space(100)+;
				Space(100)
				
		aadd(aImp,{Substr(BA1->BA1_CEPUSR,1,5)+"-"+Substr(BA1->BA1_CEPUSR,6,3),BA1->BA1_YINDEN, BA1->BA1_YLOTAC, Substr(Alltrim(BA1->BA1_MATEMP),1,9), cCpo,{},{}})
				
		RestArea(aAreaBA1)
				
	Endif

	//���������������������������������������������������������������������Ŀ
	//� Imprime usuarios com mensalidade do Itau.                           �
	//�����������������������������������������������������������������������		
	cCodPla := TRB->BA1_CODPLA
	cVersao := TRB->BA1_VERSAO
	
	If Empty(cCodPla)
		BA3->(MsSeek(xFilial("BA3")+TRB->(BM1_CODINT+BM1_CODEMP+BM1_MATRIC)))		
		cCodPla := BA3->BA3_CODPLA
		cVersao := BA3->BA3_VERSAO			
	Endif
	
	BI3->(MsSeek(xFilial("BI3")+PLSINTPAD()+cCodPla+cVersao))
	cDesAco := BI3->(BI3_NREDUZ)
	
	//���������������������������������������������������������������������Ŀ
	//� Identificar se o usuario eh titular, dep. ou agregado, cfme itau... �
	//�����������������������������������������������������������������������				
	cConBen	:= Iif(U_BusTipUsu(TRB->BA1_CODINT, TRB->BA1_CODEMP, TRB->BA1_MATRIC, TRB->BA1_TIPREG)=="T","T","A")
	
	If cConBen == "T"
		If TRB->BA1_TIPUSU <> "T"
			cConBen := "LEGAL"+Space(5)
		Else
			cConBen := "TITULAR"+Space(3)
		Endif
	Else
		cConBen := "AGREGADO"+Space(2)
	Endif
	
	//���������������������������������������������������������������������Ŀ
	//� Trocar matricula antiga/nova, conforme parametro...                 �
	//�����������������������������������������������������������������������											
	_cMatUsr := TRB->BM1_CODINT+"."+TRB->BM1_CODEMP+"."+TRB->BM1_MATRIC+"."+TRB->BM1_TIPREG+"-"+TRB->BM1_DIGITO
	If GetNewPar("MV_YMATANT",'0') == "1" //matricula_antiga
		_cMatUsr := Iif(!Empty(TRB->BA1_MATANT),(SubStr(TRB->BA1_MATANT,1,3)+"."+SubStr(TRB->BA1_MATANT,4,5)+"."+SubStr(TRB->BA1_MATANT,9,2)+"."+SubStr(TRB->BA1_MATANT,11,1)+Space(7)),_cMatUsr)
	Endif						
	
	If Empty(Substr(_cMatUsr,1,2))
		MsgAlert("Matricula em branco!")
	Endif
	
	
	cLin := Space(1)+cEOL
	cCpo :=	"2"+;
			"2"+;
			_cMatUsr+;
			Substr(TRB->BM1_NOMUSR,1,30)+;
			cConBen+;
			StrZero(Iif(Calc_Idade(dDataBase,TRB->BA1_DATNAS)>99,99,Calc_Idade(dDataBase,TRB->BA1_DATNAS)),2)+;
			Substr(cDesAco,1,20)+;				
			Space(12)+;
			Space(12)+;
			Space(431)
							
			aadd(aImp[Len(aImp),6],cCpo)
			
	cMatEmpAnt := Substr(Alltrim(TRB->BA1_MATEMP),1,9)+Substr(TRB->BA1_MATEMP,Len(Alltrim(TRB->BA1_MATEMP))-1,2)
	TRB->(DbSkip())
	
EndDo


//���������������������������������������������������������������������Ŀ
//� Buscar pelo ultima mensalidade...                                   �
//�����������������������������������������������������������������������			
nPos := ascan(aUtiliza, { |x| Substr(AllTrim(x[1]),1,9) == Substr(Alltrim(cMatEmpAnt),1,9) })

If nPos > 0

	nDelIni := nPos
	While nPos <= Len(aUtiliza) .And. Substr(Alltrim(aUtiliza[nPos,1]),1,9) == Substr(Alltrim(cMatEmpAnt),1,9)
	
		//���������������������������������������������������������������������Ŀ
		//� Impressao do fator moderador.                                       �
		//�����������������������������������������������������������������������			
		_cMatUsr := Substr(aUtiliza[nPos,4],1,4)+"."+Substr(aUtiliza[nPos,4],5,4)+"."+Substr(aUtiliza[nPos,4],9,6)+"."+Substr(aUtiliza[nPos,4],15,2)+"-"+Substr(aUtiliza[nPos,4],17,1)
		
		If GetNewPar("MV_YMATANT",'0') == "1" //matricula_antiga
			//Posicionar BA1 e buscar matricula antiga...
			aAreaTMPBA1 := BA1->(GetArea())
			BA1->(DbSetOrder(2))
			BA1->(MsSeek(xFilial("BA1")+aUtiliza[nPos,4]))
			
			_cMatUsr := Iif(!Empty(BA1->BA1_MATANT),(SubStr(BA1->BA1_MATANT,1,3)+"."+SubStr(BA1->BA1_MATANT,4,5)+"."+SubStr(BA1->BA1_MATANT,9,2)+"."+SubStr(BA1->BA1_MATANT,11,1)+Space(7)),_cMatUsr)
			
			RestArea(aAreaTMPBA1)
		Endif						

		If Empty(Substr(_cMatUsr,1,2))
			MsgAlert("Matricula em branco!")
		Endif
				
		cLin := Space(1)+cEOL
		cCpo :=	"3"+;
				"2"+;
				_cMatUsr+;
				aUtiliza[nPos,5]+;
				aUtiliza[nPos,6]+;
				aUtiliza[nPos,7]+;
				aUtiliza[nPos,8]+;
				Space(10)+;
				Space(10)+;
				aUtiliza[nPos,9]+;
				Space(416)
															
		aadd(aImp[Len(aImp),7],cCpo)
		
		nPos++ 
		
	Enddo
		
	nDelFim := nPos-1
	nPos := nDelIni

	//���������������������������������������������������������������������Ŀ
	//� Remover registros de utilizacao ja impressos, evitando re-impressao.�
	//�����������������������������������������������������������������������							
	For nDelIni := nPos to nDelFim				
		adel(aUtiliza,nPos)
		asize(aUtiliza,Len(aUtiliza)-1)
	Next
	
Endif


//��������������������������������������������������������������������������Ŀ
//� Apos finalizacao da impressao dos ativos, imprimir demais utilizacoes... �
//����������������������������������������������������������������������������			
cMatEmpAnt := ""
For nPos := 1 to Len(aUtiliza)

	//��������������������������������������������������������������������������Ŀ
	//� Imprimir cabecalho para posteriormente imprimir utilizacao.              �
	//����������������������������������������������������������������������������				
	If Substr(cMatEmpAnt,1,9) <> Substr(Alltrim(aUtiliza[nPos,1]),1,9)	
			
		BA1->(MsSeek(xFilial("BA1")+aUtiliza[nPos,4]))		
		
		//���������������������������������������������������������������������Ŀ
		//� Conforme definicao em 31/08/07, no registro 1 sempre enviar titular.�
		//�����������������������������������������������������������������������											
		aAreaBA1 := BA1->(GetArea())
		
		BA1->(DbSetOrder(2))
		BA1->(MsSeek(xFilial("BA1")+Substr(aUtiliza[nPos,4],1,14)+"00"))
		
		If !BA1->(Found())
			BA1->(MsSeek(xFilial("BA1")+Substr(aUtiliza[nPos,4],1,16)))
		Endif		
		
		//���������������������������������������������������������������������Ŀ
		//� Trocar matricula antiga/nova, conforme parametro...                 �
		//�����������������������������������������������������������������������											
		_cMatUsr := BA1->BA1_CODINT+"."+BA1->BA1_CODEMP+"."+BA1->BA1_MATRIC+"."+BA1->BA1_TIPREG+"-"+BA1->BA1_DIGITO
		If GetNewPar("MV_YMATANT",'0') == "1" //matricula_antiga
			_cMatUsr := Iif(!Empty(BA1->BA1_MATANT),(SubStr(BA1->BA1_MATANT,1,3)+"."+SubStr(BA1->BA1_MATANT,4,5)+"."+SubStr(BA1->BA1_MATANT,9,2)+"."+SubStr(BA1->BA1_MATANT,11,1)+Space(7)),_cMatUsr)
		Endif										
		
		If Empty(Substr(_cMatUsr,1,2))
			MsgAlert("Matricula em branco!")
		Endif		
		
		//���������������������������������������������������������������������Ŀ
		//� Cfme regras Itau, caso lotac == "I" tratar endereco especificamente.�
		//�����������������������������������������������������������������������									
		cEndereco := Alltrim(BA1->BA1_ENDERE)+Space(1)+Alltrim(BA1->BA1_NR_END)+Space(1)+Alltrim(BA1->BA1_COMEND)
		If Alltrim(BA1->BA1_YINDEN) == "I"
			cEndereco := Alltrim(BA1->BA1_YLOTAC)+" - "+BA1->BA1_YNOMLO
		Endif
		cEndereco := Substr(cEndereco,1,40)
		cCompet := aNomeMes[Val(cMes)]+" de "+cAno
		
		cLin := Space(1)+cEOL
		cCpo :=	"1"+;
				"2"+;
				_cMatUsr+;
				StrZero(Val(BA1->BA1_MATEMP),18)+;
				Substr(BA1->BA1_NOMUSR,1,30)+;
				cEndereco+Space(40-Len(cEndereco))+;
				Substr(BA1->BA1_BAIRRO,1,20)+;
				Substr(BA1->BA1_MUNICI,1,20)+;
				Substr(BA1->BA1_CEPUSR,1,5)+"-"+Substr(BA1->BA1_CEPUSR,6,3)+;
				BA1->BA1_ESTADO+;
				cCompet+Space(30-Len(cCompet))+;
				Space(12)+;
				Space(12)+;
				Space(12)+;
				Space(12)+;
				cMsg01+Space(100-Len(cMsg01))+;
				Space(100)+;
				Space(100)
				
		aadd(aImp,{Substr(BA1->BA1_CEPUSR,1,5)+"-"+Substr(BA1->BA1_CEPUSR,6,3),BA1->BA1_YINDEN, BA1->BA1_YLOTAC, Substr(Alltrim(BA1->BA1_MATEMP),1,9), cCpo,{},{}})
		
		RestArea(aAreaBA1)
						
	Endif
	
	//��������������������������������������������������������������������������Ŀ
	//� Imprimir utilizacao para usuarios sem mensalidade...                     �
	//����������������������������������������������������������������������������						
	cLin := Space(1)+cEOL
	cCpo :=	"3"+;
			"2"+;
			_cMatUsr+;
			aUtiliza[nPos,5]+;
			aUtiliza[nPos,6]+;
			aUtiliza[nPos,7]+;
			aUtiliza[nPos,8]+;
			Space(10)+;
			Space(10)+;
			aUtiliza[nPos,9]+;
			Space(416)
			
	aadd(aImp[Len(aImp),7],cCpo)
	
	cMatEmpAnt := aUtiliza[nPos,1]
				
Next		

aSort(aImp,,, { |x,y| x[1]+x[2]+x[3]+x[4] < y[1]+y[2]+y[3]+y[4] })
nReg := 1
For nCont := 1 to Len(aImp)

	//��������������������������������������������������������������������������Ŀ
	//� Somente exportar quando existir utilizacao...                            �
	//����������������������������������������������������������������������������	
	If Len(aImp[nCont,7]) > 0

		//��������������������������������������������������������������������������Ŀ
		//� Realizar controle de matriz x qtd linhas, necessario para o arquivo...   �
		//����������������������������������������������������������������������������	
		cNomArr := "aImp"+Iif(Empty(aImp[nCont,2]),"C",aImp[nCont,2])
		
		Do Case
		
			Case Len(aImp[nCont,7]) <= 50
				cNomArr += "A4"
			
			Case Len(aImp[nCont,7]) > 50 .And. Len(aImp[nCont,7]) <= 120
				cNomArr += "A3S"
			
			Case Len(aImp[nCont,7]) > 120
				cNomArr += "A3D"
		
		EndCase						
	
		//��������������������������������������������������������������������������Ŀ
		//� Incluir array utilizado na matriz de utilizacao...                       �
		//����������������������������������������������������������������������������	
		If ascan(aMatUti,cNomArr) == 0
			aadd(aMatUti,cNomArr)
		Endif
		
		//��������������������������������������������������������������������������Ŀ
		//� Atribuir conteudo da matriz para impressao posterior...                  �
		//����������������������������������������������������������������������������
		aadd(&cNomArr,aImp[nCont,5])
	
		For nCont1 := 1 To Len(aImp[nCont,6])
			aadd(&cNomArr,aImp[nCont,6,nCont1])
		Next
	
		For nCont1 := 1 To Len(aImp[nCont,7]) 
			aadd(&cNomArr,aImp[nCont,7,nCont1])
		Next  
		
	Endif
		
Next    

//������������������������������������������������Ŀ
//� Definir nome do arquivo, cfme convencionado... �  
//��������������������������������������������������
For nCont := 1 to Len(aMatUti)
        
	cNomeArq := cDirExp+"EXT_ITAU"+Substr(aMatUti[nCont],6)
	cNomeArq += Iif(Substr(aMatUti[nCont],5,1)<>"C","L","C")+".TXT"
	nReg := 1
	
	If U_Cria_TXT(cNomeArq)

		//�������������������������������������������Ŀ
		//� Impressao das linhas do arquivo...   	  �  
		//���������������������������������������������
		cArray := aMatUti[nCont]
		For nCont1 := 1 to Len(&cArray)
		
			cElemImp := cArray+"[nCont1]"

			If !(U_GrLinha_TXT(&cElemImp+StrZero(nReg,5),cLin))
				MsgAlert("ATEN��O! N�O FOI POSS�VEL GRAVAR CORRETAMENTE O CABE�ALHO! OPERA��O ABORTADA!")
				Return
			Endif
			nReg++
			
		Next

		U_Fecha_TXT()	
		
	Endif
	
	//�������������������������������������������Ŀ
	//� Impressao do protocolo de exportacao.	  �  
	//���������������������������������������������
	If nLin > nQtdLin
		nLin := Cabec(cTitulo,cCabec1,cCabec2,cNomeProg,cTamanho,nTipo)
	Endif

	@ nLin,000 PSay "Exporta��o realizada com sucesso! Arquivo: "+cNomeArq
	nLin++
		
Next

TRB->(DbCloseArea())			

Return


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � ParSX1       �Autor  �Jean Schulz     � Data �  10/11/05   ���
�������������������������������������������������������������������������͹��
���Desc.     �Cria parametros para exportacao.                            ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function ParSX1()

PutSx1(cPerg,"01",OemToAnsi("Prefixo De") 				,"","","mv_ch1","C",03,0,0,"G","","","","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"02",OemToAnsi("Prefixo Ate") 				,"","","mv_ch2","C",03,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"03",OemToAnsi("Num. Tit. De") 			,"","","mv_ch3","C",06,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"04",OemToAnsi("Num. Tit. Ate") 			,"","","mv_ch4","C",06,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"05",OemToAnsi("Cod. Exp. Itau") 			,"","","mv_ch5","C",06,0,0,"G","","","","","mv_par05","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"06",OemToAnsi("M�s Demonstrativo")		,"","","mv_ch6","C",02,0,0,"G","","","","","mv_par06","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(cPerg,"07",OemToAnsi("Ano Demonstrativo")		,"","","mv_ch7","C",04,0,0,"G","","","","","mv_par07","","","","","","","","","","","","","","","","",{},{},{})

Return

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  � Atu_Var      �Autor  �Jean Schulz     � Data �  25/10/05   ���
�������������������������������������������������������������������������͹��
���Desc.     �Atualiza variaveis de parametros para uso no relatorio.     ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function Atu_Var()

cPrefDe	:= mv_par01
cPrefAte:= mv_par02
cTitDe	:= mv_par03
cTitAte	:= mv_par04
cCodFTM	:= mv_par05
cMesDem	:= mv_par06
cAnoDem	:= mv_par07

Return



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �BuscaRegs �Autor  �Jean Schulz         � Data �  22/01/07   ���
�������������������������������������������������������������������������͹��
���Desc.     �Busca registros cfme parametro informado.                   ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function BuscaRegs
Local cSQL		:= "" 
Local i			:= 0
Local cDatPro	:= CtoD("")

cSQL := " SELECT BD6_YMTEMI, BD6_OPEUSR, BD6_CODEMP, BD6_MATRIC, BD6_TIPREG, BD6_DIGITO, BD6_DATPRO, BD6_CODLDP, BD6_CODPEG, "
cSQL += " BD6_NUMERO, BD6_SEQUEN, BD6_DESPRO, BD6_YINFTM, BD6_NOMRDA, BA1_MATEMP, BD6_NOMSOL "
cSQL += " FROM "+RetSQLName("BD6")+", "+RetSQLName("BA1")
cSQL += " WHERE BD6_FILIAL = '"+xFilial("BD6")+"' "
cSQL += " AND BD6_YFTITA = '"+cCodFTM+"' "
cSQL += " AND BD6_YERITA = '00' " //Nao houve erro na importacao...
cSQL += " AND "+RetSQLName("BD6")+".D_E_L_E_T_ <> '*' "
cSQL += " AND BA1_FILIAL = '"+xFilial("BA1")+"' "
cSQL += " AND BA1_CODINT = BD6_OPEUSR "
cSQL += " AND BA1_CODEMP = BD6_CODEMP "
cSQL += " AND BA1_MATRIC = BD6_MATRIC "
cSQL += " AND BA1_TIPREG = BD6_TIPREG "   
cSQL += " AND "+RetSQLName("BA1")+".D_E_L_E_T_ <> '*' "

//Raios
//cSQL += " AND BD6_CODEMP = '0006' AND BD6_MATRIC <= '000274' "	
//cSQL += " AND BD6_CODEMP = '0006' AND (BD6_MATRIC = '000252' OR BD6_MATRIC = '010465') "

PLSQuery(cSQL,"TRB")
TRB->(DbGoTop())

While !TRB->(Eof())

	If Empty(TRB->BD6_DATPRO)
		If TRB->BD6_ORIMOV == "1"
			If BD5->(MsSeek(xFilial("BD5")+PLSINTPAD()+TRB->(BD6_CODLDP+BD6_CODPEG+BD6_NUMERO)))
				cDatPro := DtoS(BD5->BD5_DATPRO)
				cDatPro := Substr(cDatPro,7,2)+"/"+Substr(cDatPro,5,2)+"/"+Substr(cDatPro,1,4)
			Else
				cDatPro := "  /  /    "
			Endif					
		Else
			If BE4->(MsSeek(xFilial("BE4")+PLSINTPAD()+TRB->(BD6_CODLDP+BD6_CODPEG+BD6_NUMERO)))
				cDatPro := DtoS(BE4->BE4_DATPRO)
				cDatPro := Substr(cDatPro,7,2)+"/"+Substr(cDatPro,5,2)+"/"+Substr(cDatPro,1,4)
			Else
				cDatPro := "  /  /    "
			Endif
		Endif
	Else
		cDatPro := DtoS(TRB->BD6_DATPRO)
		cDatPro := Substr(cDatPro,7,2)+"/"+Substr(cDatPro,5,2)+"/"+Substr(cDatPro,1,4)
	Endif
	
	BC1->(MsSeek(xFilial("BCI")+PLSINTPAD()+TRB->(BD6_CODLDP+BD6_CODPEG)))
		
	aadd(aUtiliza,{Alltrim(TRB->BD6_YMTEMI)+Substr(TRB->BA1_MATEMP,Len(Alltrim(TRB->BA1_MATEMP))-1,2),"C",TRB->(BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_SEQUEN),TRB->(BD6_OPEUSR+BD6_CODEMP+BD6_MATRIC+BD6_TIPREG+BD6_DIGITO),cDatPro,"Rede Credenciada    ",;
		 Iif(TRB->BD6_CODLDP=='0012',Substr(TRB->BD6_NOMSOL,1,20),Substr(TRB->BD6_NOMRDA,1,20)),Substr(TRB->BD6_DESPRO,1,30),Iif(TRB->BD6_YINFTM=="S","*",Space(1))})
		 
	TRB->(DbSkip())
	
Enddo
	
TRB->(DbCloseArea())	

cSQL := " SELECT * FROM "+RetSQLName("BKE") 
cSQL += " WHERE BKE_FILIAL = '"+xFilial("BKE")+"' "
cSQL += " AND BKE_YFTITA = '"+cCodFTM+"' "
cSQL += " AND BKE_YERITA = '00' " //Nao houve erro na importacao...
cSQL += " AND "+RetSQLName("BKE")+".D_E_L_E_T_ <> '*' "

PLSQuery(cSQL,"TRB")
TRB->(DbGoTop())

While !TRB->(Eof())	

	If BKD->(MsSeek(xFilial("BKD")+cCodFTM))
		cDatPro := DtoS(BKD->BKD_DATA)
		cDatPro := Substr(cDatPro,7,2)+"/"+Substr(cDatPro,5,2)+"/"+Substr(cDatPro,1,4)
	Else
		cDatPro := "  /  /    "
	Endif

	BK6->(MsSeek(xFilial("BK6")+BKD->BKD_CODCRE))	
	
	aadd(aUtiliza,{Alltrim(TRB->BKE_YMTEMI),"R",TRB->(BKE_CODRBS+BKE_CODPRO),BKD->(BKD_OPEUSR+BKD_CODEMP+BKD_MATRIC+BKD_TIPREG+BKD_DIGITO),cDatPro,"Livre Escolha       ",;
		 Substr(BK6->BK6_NOME,1,20),Substr(Posicione("BR8",3,xFilial("BR8")+TRB->BKE_CODPRO,"BR8_DESCRI"),1,30),Iif(TRB->BKE_YINFTM=="S","*",Space(1))})

	TRB->(DBSkip())
Enddo

TRB->(DbCloseArea())	

//aSort(aUtiliza,,, { |x,y| x[1]+x[3]+x[2]+x[4] < y[1]+y[3]+y[2]+y[4] })
aSort(aUtiliza,,, { |x,y| x[1]+x[4]+x[5]+x[6] < y[1]+y[4]+y[5]+y[6] })
	
Return Nil


/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �BuscaTit  �Autor  �Microsiga           � Data �  22/01/07   ���
�������������������������������������������������������������������������͹��
���Desc.     �Busca titulos para exportar composicao.                     ���
���          �                                                            ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/
Static Function BuscaTit()
Local i := 0

For i := 1 to 2

	If i == 1
		cSQL := " SELECT COUNT("+RetSQLName("BM1")+".R_E_C_N_O_) AS TOTAL "
	Else
		cSQL := " SELECT "+RetSQLName("BM1")+".*, BA1_MATEMP, BA1_ENDERE, BA1_NR_END, BA1_COMEND, BA1_BAIRRO, BA1_MUNICI, BA1_CEPUSR, BA1_ESTADO, BA1_DATNAS, "
		cSQL += " BA1_CODPLA, BA1_VERSAO, BA1_TIPUSU, BA1_CODINT, BA1_CODEMP, BA1_MATRIC, BA1_TIPREG, BA1_YINDEN, BA1_YLOTAC, BA1_YNOMLO, BA1_MATANT "
	Endif
	
	cSQL += " FROM "+RetSQLName("BM1")+", "+RetSQLName("BA1")
	cSQL += " WHERE BM1_FILIAL = '"+xFilial("BM1")+"' AND BM1_PREFIX BETWEEN '"+cPrefDe+"' AND '"+cPrefAte+"' "
	cSQL += " AND BM1_NUMTIT BETWEEN '"+cTitDe+"' AND '"+cTitAte+"' "
	cSQL += " AND BA1_FILIAL = '"+xFilial("BA1")+"' "
	cSQL += " AND BA1_CODINT = BM1_CODINT "
	cSQL += " AND BA1_CODEMP = BM1_CODEMP "
	cSQL += " AND BA1_MATRIC = BM1_MATRIC "
	cSQL += " AND BA1_TIPREG = BM1_TIPREG "
	cSQL += " AND BA1_MATEMP <> ' ' "
	cSQL += " AND "+RetSQLName("BM1")+".D_E_L_E_T_ = ' ' "
	cSQL += " AND "+RetSQLName("BA1")+".D_E_L_E_T_ = ' ' "	
	
	//Raios
	//cSQL += " AND BM1_CODEMP = '0006' AND BM1_MATRIC <= '000274' "	
	//cSQL += " AND BM1_CODEMP = '0006' AND (BM1_MATRIC = '000252' OR BM1_MATRIC = '010465') "	
	

	If i == 1
		PLSQuery(cSQL,"TRB")	
		nTotReg := TRB->TOTAL
		TRB->(DbCloseArea())
		
		If nTotReg <= 0
			Help("",1,"RECNO")
			Return
		Endif
		
	Else
		cSQL += " ORDER BY BM1_PREFIX, BM1_NUMTIT, BM1_PARCEL, BM1_TIPTIT, BA1_MATEMP, BM1_CODINT, BM1_CODEMP, BM1_MATRIC, BM1_TIPREG, BM1_DIGITO, BM1_CODTIP, BM1_CODEVE "
		PLSQuery(cSQL,"TRB")	
	Endif
	
Next

Return Nil

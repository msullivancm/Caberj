//#INCLUDE "plsr420n.ch"
#include "PROTHEUS.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ PLSR420N ³ Autor ³ Luciano Aparecido     ³ Data ³ 13.08.07 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Guia de Internacao Hospitalar /Resumo Internação           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ PLSR420(nGuia)                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CABR420N(nGuia,cPathRelW)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define Variaveis                                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Local CbCont, Cabec1, Cabec2, Cabec3, nPos, wnRel
	Local cTamanho := "M"
	Local cTitulo  := ""
	Local cDesc1  := ""
	Local cDesc2  := "de acordo com a configuracao do usuario." //"de acordo com a configuracao do usuario."
	Local cDesc3  := " "
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Parametros do relatorio (SX1)...                                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Local nLayout

	Default cPathRelW:=""
	Private aReturn  := { "Zebrado", 1,"Administração", 2, 2, 1, "", 1 }
	Private aLinha   := { }
	Private nLastKey := 0
	Private cPerg    := ""
	Private lWeb     := IsInCallStack("u_PPRELPRG")

	If     nGuia ==1
		cTitulo  := "GUIA DE SOLICITAÇÂO INTERNAÇÃO" //"GUIA DE SOLICITAÇÂO INTERNAÇÃO"
		cDesc1  := "Ira imprimir a Guia de Solicitação Internação" //"Ira imprimir a Guia de Solicitação Internação"
	ElseIf nGuia ==2
		cTitulo  := "GUIA DE RESUMO INTERNAÇÃO" //"GUIA DE RESUMO INTERNAÇÃO"
		cDesc1  := "Irá imprimir a Guia de Resumo Internação" //"Ira imprimir a Guia de Resumo Internação"
	Else
		cTitulo  := "GUIA DE SOLICITAÇÃO DE PRORROGAÇÃO DE INTERNAÇÃO"
		cDesc1  := "Irá imprimir a Guia de Solicitação de Internação"
	Endif

	cPerg := "PL420N"

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Ajusta perguntas                                                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	CriaSX1() //nova pergunta...
	CriaSX1A('PL420G')
	CriaSX1A("PL420N")

	IF (cPathRelW <> "NR")
		If ! (BE4->BE4_STATUS $ "1,2,3,4")
			Help("",1,"PLSR420")
			Return
		EndIf
	endif

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Variaveis utilizadas para Impressao do Cabecalho e Rodape    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	CbCont  := 0

	if nGuia ==1
		Cabec1  := "GUIA DE INTERNAÇAO HOSPITALAR" //"GUIA DE INTERNAÇAO HOSPITALAR"
	elseIf nGuia ==2
		Cabec1  := "GUIA DE RESUMO INTERNAÇAO" //"GUIA DE RESUMO INTERNAÇAO"
	Else
		Cabec1  := "GUIA DE SOLICITAÇÃO DE PRORROGAÇÃO DE INTERNAÇÃO OU COMPLEMENTAÇÃO DO TRATAMENTO"
	Endif

	Cabec2  := " "
	Cabec3  := " "
	cString := "BE4"
	aOrd    := {}
	wnRel   := "PLSR420" // Nome Default do relatorio em Disco

	If nGuia == 1
		Pergunte(cPerg,.F.)
		cMail	:= mv_par03
	ElseIf nGuia == 2
		Pergunte(cPerg,.F.)
		If nLastKey = 27
			Set Filter To
			Return
		EndIf
		cMail	:= mv_par03
	Else
		cMail	:= ""
		IF (cPathRelW <> "NR")  //Para não exibir o pergunte aqui.
			cPerg:='PL420G'
			CriaSX1a(cPerg) //nova pergunta...
			IF !lWeb
				If !Pergunte(cPerg,.T.)
					Return
				EndIf
			Endif
			If nLastKey = 27
				Set Filter To
				Return
			EndIf
			cMail	:= ""
		ENDIF
	EndIf

	nLayout := 2
	nMail	:= 2

	IF !lWeb
		RptStatus({|lEnd| R420NImp(@lEnd,wnRel,cString,nGuia,nLayout,nMail,cMail)}, cTitulo)
	Else
		aRet:=R420NImp(@lEnd,wnRel,cString,nGuia,nLayout,nMail,cMail,cPathRelW)
		If Len(aRet)= 3
			Return(aRet)
		Endif
	Endif

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ R420NIMP ³ Autor ³ Sandro Hoffman Lopes  ³ Data ³ 19/10/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Chamada do Relatorio                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ PLSR420N                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function R420NImp(lEnd,wRel,cString,nGuia,nLayout,nMail,cMail,cPathRelW)

	LOCAL aDados  := {}
	LOCAL aRetPto := {}
	LOCAL aRet	  := {}
	DEFAULT nMail := 0
	DEFAULT cMail := ""
	DEFAULT cPathRelW:=""

	aAdd(aDados, MtaDados(nGuia))

	If ExistBlock("PLS420IM")
		aRetPto := ExecBlock("PLS420IM",.F.,.F.,{nGuia,aDados})
		aDados := aRetPto[1]
	Endif

	If nGuia == 1
		If PLSTISSVER() >= "3"
			aRet:=u_CabTISSE(aDados,,nLayout,,mv_par02==1)
		Else
			aRet:=u_CabTISS3(aDados,,nLayout,,mv_par02==1)
		EndIf
		If aRet[1]
			If Pergunte(cPerg,.T.)
				If mv_par02 == 1
					If PLSTrtMAIL(AllTrim(mv_par03),aRet[2])
						Aviso("Atenção","E-mail enviado com sucesso!",{"Ok"},1)
					EndIf
				EndIf
			Endif
		Endif
	ElseIf nGuia == 2
		If PLSTISSVER() >= "3"
			u_CABTISSF(aDados,,nLayout)
		Else
			u_CABTISS4(aDados,,nLayout)
		EndIf
	ElseIf nGuia == 3
		If lWeb
			aRet:=U_CABTISSP(aDados,,nLayout,,,lWeb,cPathRelW)
			Return(aRet)
		Else
			If PLSTISSVER() >= "3"
				U_CABTISSP(aDados,,nLayout)
			Else
				u_CABTISS4(aDados,,nLayout)
			EndIf
		Endif
	Endif


	MS_FLUSH()

Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ MtaDados ³ Autor ³ Luciano Aparecido       ³ Data ³ 22/03/07 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Grava STATUS das tabelas BE4/BEA e chama a funcao "PLSGINT"  ³±±
±±³          ³ que ira retornar o array com os dados a serem impressos.     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ PLSR420N                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function MtaDados(nGuia)

	Local aDados := {}

	DbSelectArea("BE4")
	BE4->(RecLock("BE4",.F.))
	BE4->BE4_GUIIMP := "1"
	If BE4->BE4_STATUS == "4"
		BE4->BE4_STATUS := "1"
	EndIf
	BE4->(MsUnLock())

	BEA->(DbSetOrder(6))
	If BEA->(DbSeek(xFilial("BEA")+BE4->(BE4_CODOPE+BE4_ANOINT+BE4_MESINT+BE4_NUMINT)))
		BEA->(RecLock("BEA",.F.))
		BEA->BEA_GUIIMP := "1"
		If BEA->BEA_STATUS == "4"
			BEA->BEA_STATUS := "1"
		EndIf
		BEA->(MsUnLock())
	EndIf

	aDados := u_CABGINT(nGuia) // Funcao que monta o array com os dados da guia

Return aDados

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³ CriaSX1   ³ Autor ³ Luciano Aparecido    ³ Data ³ 22.03.07 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Atualiza SX1                                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/

Static Function CriaSX1()
	LOCAL aRegs	 :=	{}

	dbSelectArea("SX1")

	If !SX1->(dbseek(PADR(cPerg,10)+'03'))
		SX1->(dbSeek(PADR(cPerg,10)))
		While !SX1->( Eof() ) .and. SX1->X1_GRUPO == PADR(cPerg,10)
			SX1->( RecLock("SX1", .F.) )
			SX1->( dbDelete() )
			SX1->( MsUnlock() )
			SX1->( dbSKip() )
		Enddo
	EndIf

	aadd(aRegs,{cPerg,"01","Selecionar Layout Papel:" 	,"","","mv_ch1","N", 1,0,0,"C","","mv_par01","Ofício 2"         	,"","","","","Papel A4"            	,"","","","","Papel Carta"             	,"","","","",""       ,"","","","","","","","",""   ,""})
	aadd(aRegs,{cPerg,"02","Envio por e-mail?" 			,"","","mv_ch2","N", 1,0,0,"C","","mv_par02","Sim" 	        	,"","","","","Não" 		           	,"","","","",""			                ,"","","","",""       ,"","","","","","","","",""   ,""})
	aadd(aRegs,{cPerg,"03","E-mail:" 					,"","","mv_ch3","C",50,0,0,"G","","mv_par03",""		         	,"","","","",""        		    	,"","","","",""            				,"","","","",""       ,"","","","","","","","",""   ,""})

	PlsVldPerg( aRegs )

Return



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa   ³ CriaSX1   ³ Autor ³ TOTVS                ³ Data ³ 13.11.14 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descricao  ³ Atualiza SX1                                               ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
/*/

Static Function CriaSX1A(cPerg)

	dbSelectArea("SX1")


	aHelpPor := {"Informe o Prestador"}
	aHelpEng := {""}
	aHelpSpa := {""}

	PutSX1(cPerg,"01","Prestador ?:","","","mv_ch1","C",15,0,0,"G","","BB0PLS","","S","mv_par01","","","","","","","","","","","","","","","","",aHelpPor,aHelpEng,aHelpSpa)



Return


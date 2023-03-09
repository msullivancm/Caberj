#INCLUDE "plsa262.ch"
#include "PLSMGER.CH"

#define K_DefExc  4
#define c_Ent CHR(13) + CHR(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABP999   ºAutor  ³Desconhecido        º Data ³  / /        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Rotina para reemissao de carteirinhas.                      º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³Caberj                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABP999
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta matriz com as opcoes do browse...                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private aRotina 	:=	{}
Private cDesCar   	:= Posicione("BA0",1,xFilial("BA0")+PLSINTPAD(),"AllTrim(If(Empty(BA0_NOMCAR), 'Cartão de Identificação', BA0_NOMCAR))") //'Carteira'
Private cCadastro 	:= STR0010+AllTrim(cDesCar) //"Exportacao/Emissao de "

Private	aCores := 	{ 	{ "BDE->BDE_STACAR='1'", 'BR_VERDE'    }	,;
						{ "BDE->BDE_STACAR='2'", 'BR_VERMELHO' } 	}

aAdd(aRotina,{ STR0001	,'AxPesqui'  , 0 , K_Pesquisar  			}) //"Pesquisar"
//aAdd(aRotina,{ STR0002	,'U_CABP999VIS', 0 , K_Visualizar 		}) //"Visualizar" //Leonardo Portella - 12/09/12 - Nao esta implementado, removi do menu.
aAdd(aRotina,{ STR0003	,'U_CABP999PRN'	, 0 , K_Incluir 			}) //"Exportar"
aAdd(aRotina,{ STR0004	,'PLSA262EXC'	, 0 , K_DefExc     			}) //"&Excluir"
											
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Retira campos de uso - campos obsoletos                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
SX3->(dbSetOrder(2))
If  SX3->(msSeek("BDE_STATUS"))
	cUsado := SX3->X3_USADO
	If  SX3->(msSeek("BDE_CODPLA"))
		If  SX3->(RecLock("SX3",.F.))
			SX3->X3_USADO := cUsado
			SX3->(msUnLock())
		Endif
	Endif
	If  SX3->(msSeek("BDE_DATALI"))
		If  SX3->(RecLock("SX3",.F.))
			SX3->X3_USADO := cUsado
			SX3->(msUnLock())
		Endif
	Endif
	If  SX3->(msSeek("BDE_DATALF"))
		If  SX3->(RecLock("SX3",.F.))
			SX3->X3_USADO := cUsado
			SX3->(msUnLock())
		Endif
	Endif
Endif
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Starta mBrowse...                                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BDE->(DBSetOrder(1))
BDE->(mBrowse(06,01,22,75,'BDE',,,,,,aCores,,,,, .T. ))
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da Rotina...                                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return

********************************************************************

User Function CABP999VIS()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da Rotina...                                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return

********************************************************************

User Function CABP999NUM(cCodInt)

Local cNum := ""
Local nTam := Len(BDE->BDE_CODIGO)

BDE->(DbSetOrder(1))
BDE->(MsSeek(xFilial("BDE")+cCodInt+Replicate("9",nTam),.T.))

BDE->(DbSkip(-1))

If BDE->(BDE_FILIAL+BDE_CODINT) == xFilial("BDE")+cCodInt
	cNum := StrZero(Val(BDE->BDE_CODIGO)+1,nTam)
Else
	cNum := StrZero(1,nTam)
Endif

Return(cNum)

********************************************************************
User Function CABP999Prn()

Processa({||E_CABP999Prn()},AllTrim(SM0->M0_NOMECOM))

Return

********************************************************************

Static Function E_CABP999Prn()

Local n_I := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local aRet
Local cExpRdm := ""
Local cCodInt := ""
Local cCodEmp := ""
Local cMatric := ""
Local cTipReg := ""
Local nI      := 0
Local aRecno  := {}
Local lNew 	  := .F.
Local cOperad := PlsIntPad()
Local nUltVia := 0
Local lImprim := .T.
Local lAgrupa := .T.
Local cQuebra := Chr(13)
Local nTipPes := 1   // 1=todas   2=fisica   3=juridica
Local lErro   := .F.
Local cCodLote := space(0)
Local lReemissao

AjustaSX1()

If !Pergunte("CAB999")  //PLS263
	Return
EndIf

ProcRegua(0)
	
For n_I := 1 to 5
	IncProc('Processando...')
Next
              
//Leonardo Portella - 14/09/12 - Inicio - Nao permitir parametrizar como nao gerar - Solicitado por Ana Paula

cMsg := '"Gera cartao agora" parametrizado para nao gerar agora!' + c_Ent + 'Deste modo o lote nao sera gerado!'
     
If  MV_PAR02 <> 1 
	MsgStop(cMsg,AllTrim(SM0->M0_NOMECOM))
	Return
EndIf     

//Leonardo Portella - 14/09/12 - Fim

lImprim  := ( MV_PAR02 == 1 ) //Gera cartao agora?

nTipPes  := MV_PAR04 //1=todas;2=fisica;3=juridica

If lImprim
	If Str(MV_PAR01,1) == "2"
		MsgStop(STR0014) //"Tipo de Geração não disponível nesta versão do Produto!"
		Return
	Endif
Endif

BEGIN TRANSACTION

cSQL := " SELECT * FROM " 																					+ c_Ent
cSQL += " ( SELECT BED.BED_CODINT, BED.BED_CODEMP, BED.BED_MATRIC, BED.R_E_C_N_O_ REG, "					+ c_Ent
cSQL += " Decode(Trim(BA1_CODPLA), NULL,BA3_CODPLA, BA1_CODPLA) AS BA1CODPLA, "								+ c_Ent
cSQL += " BA3.BA3_TIPOUS "																					+ c_Ent
cSQL += " FROM " + RetSQLName("BED")+" BED, "+RetSQLName("BA1")+" BA1, "+ RetSQLName("BA3")+" BA3 "		+ c_Ent
cSQL += " WHERE BED_FILIAL = '" + xFilial("BED") + "' AND "													+ c_Ent
cSQL += " BA1_FILIAL = '" + xFilial("BA1") + "' AND "														+ c_Ent
cSQL += " BA3_FILIAL = '" + xFilial("BA3") + "' AND "														+ c_Ent
cSQL += " BED_CDIDEN = 'AVULSA' AND "																		+ c_Ent
cSQL += " BED_CODINT = '"+PLSINTPAD()+"' AND "																+ c_Ent
cSQL += " BED_CODEMP BETWEEN '"+MV_PAR05+"' AND '"+MV_PAR06+"' AND "										+ c_Ent
cSQL += " BA1_CODINT = BED_CODINT AND "																		+ c_Ent
cSQL += " BA1_CODEMP = BED_CODEMP AND "																		+ c_Ent
cSQL += " BA1_MATRIC = BED_MATRIC AND "																		+ c_Ent
cSQL += " BA1_TIPREG = BED_TIPREG AND "																		+ c_Ent
cSQL += " BA3_CODINT = BED_CODINT AND "																		+ c_Ent
cSQL += " BA3_CODEMP = BED_CODEMP AND "																		+ c_Ent
cSQL += " BA3_MATRIC = BED_MATRIC AND "																		+ c_Ent
cSQL += " BED.D_E_L_E_T_ <> '*' AND "																		+ c_Ent
cSQL += " BA1.D_E_L_E_T_ <> '*' AND "																		+ c_Ent
cSQL += " BA3.D_E_L_E_T_ <> '*' ) "																			+ c_Ent
cSQL += " WHERE BA1CODPLA BETWEEN '"+MV_PAR07+"' AND '"+MV_PAR08+"'  "										+ c_Ent

PLSQuery(cSQL,"CABTRB")

lNew := .T.

DbGoTop("CABTRB")

While !CABTRB->(Eof())
//	BA3->(DbSetOrder(1))
//	BA3->(msSeek(xFilial("BA3")+CABP999->(BED_CODINT+BED_CODEMP+BED_MATRIC)))
	lErro := .F.
	If nTipPes > 1
		If nTipPes == 2 // somente pessoa fisica
			If CABTRB->BA3_TIPOUS == "2"  // SE CONTRATO FOR DE PESSOA JURIDICA PULA
				lErro := .T.
			EndIf
		ElseIf nTipPes == 3  // somente pessoa juridica
			If CABTRB->BA3_TIPOUS == "1"  // SE CONTRATO FOR DE PESSOA FISICA PULA
				lErro := .T.
			EndIf
		EndIf
	EndIf
	If !lErro
		aadd(aRecno,CABTRB->REG)
	EndIf
	CABTRB->(DbSkip())
EndDo

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fecha Temporario... 						                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
CABTRB->(DbCloseArea())

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Grava lote													³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cCodLote := U_CABP999NUM(cOperad)

DbSelectArea("BDE")
BDE->(DbSetOrder(1))
BDE->(RecLock("BDE",.T.))
BDE->BDE_FILIAL := xFilial("BDE")
BDE->BDE_CODINT := cOperad
BDE->BDE_CODIGO := cCodLote
BDE->BDE_UNILOC := "1"
BDE->BDE_TIPGRU := "3"
BDE->BDE_STACAR := "1"
BDE->BDE_TIPGER := Str(MV_PAR01,1)   
BDE->BDE_YUSUAR := UsrFullName( __cUserId ) // Marcela Coimbra - Chamado GLPI  2623
BDE->BDE_YEMISS := Date() // Marcela Coimbra - Chamado GLPI  2623
BDE->BDE_YORIGE := AllTrim(Upper(FunName()))//Leonardo Portella - 12/09/12
BDE->(MsUnlock())

DbSelectArea("BED")
BED->(DbSetOrder(1))
For nI := 1 to Len(aRecno)
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Posiciona BED...											³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BED->(DbGoto(aRecno[nI]))
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Alimenta variaveis...										³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cCodInt := BED->BED_CODINT
	cCodEmp := BED->BED_CODEMP
	cMatric := BED->BED_MATRIC
	cTipReg := BED->BED_TIPREG
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Compoe o Lote somente se for a Ultima Via do Usuario...		³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	nUltVia := PL261UVC(cCodInt, cCodEmp, cMatric, cTipReg, 1)[1]
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Validacao													³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If BED->BED_VIACAR = nUltVia
		lAgrupa := .T.
	Else
		lAgrupa := .F.
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica se a Via esta bloqueada...                                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If BED->( FieldPos("BED_CODBLO") ) = 0 .AND. BED->( FieldPos("BED_BLOIDE") ) = 0
		MsgStop(STR0030) //"Dicionario de dados desatualizado!!!"
		lAgrupa := .F.
	Else
		If BED->BED_BLOIDE == "1"
			MsgStop(STR0034 + cQuebra + STR0026 + BED->(BED_CODINT+BED_CODEMP+BED_MATRIC+BED_TIPREG)) //"Via do cartão não será emitida pois se encontra bloqueada!"###"Usuário: "
			lAgrupa := .F.
		Endif
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Checa e cria o registro									    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lAgrupa
		BED->(RecLock("BED",.F.))
		BED->BED_CDIDEN := cCodLote
		BED->BED_YORIGE := AllTrim(Upper(FunName()))//Leonardo Portella - 12/09/12
		BED->(MsUnlock())
	Endif
Next
aRet := {.F.,{0}}
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Posiciona na Operadora...                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BA0->(DbSetOrder(1))

If BA0->(MsSeek(xFilial("BA0")+BDE->BDE_CODINT))
	
	If Empty(BA0->BA0_EXPIDE)
		cExpRdm := AllTrim(GetNewPar("MV_PLSEXPI",""))
	Else
		cExpRdm := AllTrim(BA0->BA0_EXPIDE)
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Leonardo Portella - 13/09/12                                                                                 ³
	//³Rotina padrao Plsa264 utiliza o MV_PAR04 como caminho a ser gerado o arquivo quando "lImprim" eh verdadeiro. ³
	//³Antes o arquivo erra gerado no Rootpath pois o parametro estava errado. Parametro MV_PAR04 nao eh mais       ³
	//³utilizado no resto do fonte.                                                                                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ     
	If lImprim
		MV_PAR04 := AllTrim(MV_PAR03)
	EndIf
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Leonardo Portella - 12/09/12                                                                                               ³
	//³Na reemissao nao atualiza a via de carteirinha, todavia setar a variavel para reemissao verdadeiro ira gerar erros pois    ³
	//³diversas variaveis que sao utilizadas quando nao eh reemissao existem apenas nos Gets do fonte padrao. Alem disso se nao   ³
	//³for reemissao, podera gerar debitos para o beneficiario.                                                                   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	lReemissao := .T.
	
	If ExistBlock(cExpRdm)
		aRet := ExecBlock(cExpRdm,.F.,.F.,{BDE->BDE_CODIGO,BDE->BDE_MOTIVO,BDE->BDE_CODINT,NIL,5,lReemissao,lImprim,NIL,lNew})
	Else
		aRet := Plsa264({BDE->BDE_CODIGO,BDE->BDE_MOTIVO,BDE->BDE_CODINT,NIL,5,lReemissao,lImprim,NIL,lNew,AllTrim(MV_PAR03)/*Nil*/,.T.})
	EndIf
	
	If ValType(aRet) <> "A" .or. Len(aRet) == 0
		aRet := {.T.,{0}}
	Endif
	
Endif

If aRet[1] .And. aRet[2,1] > 0
	If lNew
		BDE->(RecLock("BDE",.F.))//Ja foi incluida uma linha na BDE anteriormente.
		
		BDE->BDE_QTD 	:= aRet[2,1]
  		BDE->BDE_CODPLA := MV_PAR07
  		BDE->BDE_CODPRO := MV_PAR08
  		BDE->BDE_EMPDE  := MV_PAR05
  		BDE->BDE_EMPATE := MV_PAR06
  		BDE->BDE_DIRGRV := MV_PAR03
  		BDE->BDE_DATENT := MV_PAR10
  		BDE->BDE_EMPRES := MV_PAR09
		BDE->(MsUnlock())
		MsgStop("Gerado Lote "+cCodLote +" com "+StrZero(aRet[2,1],5,0)+" Cartoes ")
	Endif
Else
	BDE->(RecLock("BDE",.F.))
	BDE->(DbDelete())//Deleta a linha incluida na BDE anteriormente se nao for gerar o lote.
	BDE->(MsUnlock())
	MsgStop("Nao foi gerado nenhum lote! ")
EndIf

END TRANSACTION

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da Rotina...                                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return

********************************************************************

Static Function AjustaSX1()

Local aRegs	:=	{}

aadd(aRegs,{"CAB999","01","Tipo Geracao ?     ","","","mv_ch1","N", 01,0,0,"C","","mv_par01","Arquivo","","","","","Impressao","","","","","","","","","","","","","","","","","","","",""}) //tipo de Geracao
aadd(aRegs,{"CAB999","02","Gera cartao agora ?","","","mv_ch2","N", 01,0,0,"C","","mv_par02","Sim","","","","","Nao","","","","","","","","","","","","","","","","","","","",""}) //Gera Cartao Agora
aadd(aRegs,{"CAB999","03","Local Grav. ?      ","","","mv_ch3","C", 60,0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","",IIf(PlsGetVersao() >= 8,"BB3PLS","BB3"),""}) //Local de Gravacao
aadd(aRegs,{"CAB999","04","Tipo de Usuario ?  ","","","mv_ch4","N", 01,0,0,"C","","mv_par04","Fisica/Juridica","","","","","Fisica","","","","","Juridica","","","","","","","","","","","","","","","",""}) // tipo de Usuario
aadd(aRegs,{"CAB999","05","Empresa De ?       ","","","mv_ch5","C", 04,0,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","","B7APLS",""}) //Empresa De
aadd(aRegs,{"CAB999","06","Empresa Ate ?      ","","","mv_ch6","C", 04,0,0,"G","","mv_par06","","","","","","","","","","","","","","","","","","","","","","","","","B7APLS",""}) //Empresa Ate
aadd(aRegs,{"CAB999","07","Produto De         ","","","mv_ch7","C", 04,0,0,"G","","mv_par07","","","","","","","","","","","","","","","","","","","","","","","","","B2DPLS",""}) //Produto De
aadd(aRegs,{"CAB999","08","Produto Ate ?      ","","","mv_ch8","C", 04,0,0,"G","","mv_par08","","","","","","","","","","","","","","","","","","","","","","","","","B2DPLS",""}) //Produto Ate
aadd(aRegs,{"CAB999","09","Resp. Impres ?     ","","","mv_ch7","C", 60,0,0,"G","","mv_par09","","","","","","","","","","","","","","","","","","","","","","","","","ZY",""}) //Responsavel Impressao
aadd(aRegs,{"CAB999","10","Dat. Entrega ?     ","","","mv_cha","D", 08,0,0,"G","","mv_par10","","","","","","","","","","","","","","","","","","","","","","","","","",""}) //Data Entrega

PlsVldPerg( aRegs )

Return

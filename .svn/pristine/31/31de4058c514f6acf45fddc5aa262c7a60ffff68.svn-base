#Include 'RWMAKE.CH'                               
#Include 'PLSMGER.CH'
#Include 'COLORS.CH'
#Include 'TOPCONN.CH'
#include "PROTHEUS.CH"
#include "PLSMCCR.CH" 

Static oBrwPro
Static oBrwCri
STATIC __cTipo     := "1"

STATIC oEncAut
STATIC __cDescri
STATIC __lAutoriz  := .F.
STATIC nHorIni     := 0
STATIC __cCodRdaP  := ""
STATIC cCodLocPar  := ""
STATIC aAutFor     := {}
STATIC aDadCri     := {}
STATIC aCabCri     := {}
STATIC aTrbCri     := {}
STATIC aValAcuAut  := {}
STATIC aDadB43    := {}
STATIC aCabB43    := {}
STATIC aTrbB43    := {}
STATIC aCdCores   := {}
STATIC cDesQtdSol := ""
STATIC cDesQtdAut := ""

#define __aCdCri102 {"702","Codigo EDI da critica nao encontrado"}                      //"Codigo EDI da critica nao encontrado"
#define __aCdCri107 {"703","Processo de autorizacao On-Line (Cancelado)"}               //"Processo de autorizacao On-Line (Cancelado)"  
#define __aCdCri065 {"534","Time out.Operadora fora do Ar."}                            //"Time out.Operadora fora do Ar."
#define __aCdCri158 {"087","Bloqueio de pagamento e cobran็a, evento nใo Autorizado."}  //"Bloqueio de pagamento e cobran็a, evento nใo Autorizado."

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณAJINTSIP  บAutor  ณ Jean Schulz        บ Data ณ  03/10/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Tela de log de geracao dos adicionais de pagamento a RDAs  บฑฑ
ฑฑบ          ณ confirme parametrizado por produtos opcionais.             บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function AJINTSIP()
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Monta matriz com as opcoes do browse...                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
PRIVATE aRotina   	:=	{	{ "Pesquisar"	    , 'AxPesqui'	  , 0 , K_Pesquisar  },;
{ "&Visualizar"	, 'AxVisual'	  , 0 , K_Visualizar },;
{ "M&odificar"	, 'U_MODINTER'    , 0 , K_Alterar    } } 

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Titulo e variavies para indicar o status do arquivo                 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
PRIVATE cCadastro 	:= "Modifica dados relativos ao SIP em internacoes"

PRIVATE cPath  := ""                        
PRIVATE cAlias := "BE4"
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Starta mBrowse...                                                   ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
BE4->(DBSetOrder(1))
BE4->(mBrowse(006,001,022,075,"BE4" , , , , , Nil,, , , ,nil, .T.))
BE4->(DbClearFilter())

Return
              
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณPrograma  ณ MODINTER   ณ Autor ณ Jean Schulz       ณ Data ณ 29.04.2008 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescrio ณ Gera adicionais de pagamento para RDA informada por param. ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function MODINTER(cAlias,nReg,nOpc)

Private _cPerg := "YMDSIP    "
Private cCodLoc
Private cCodEsp

Private cCodRDA
Private cNomRDA
Private cCodLoc
Private cDesLoc
Private cEndLoc
Private cDesEsp

RegToMemory("BE4",.F.,.F.)

CriaSX1()
If !Pergunte( _cPerg, .T. )
	Return
Endif

BA9->(DbSetOrder(1)) //BA9_FILIAL+BA9_CODDOE

/*M->BE4_CID    := mv_par01
M->BE4_INTSIP := mv_par02
M->BE4_TIPPAR := mv_par03
M->BE4_TIPNAS := mv_par04

//Inserido por Luzio em 10/09/2008 para permitir alterar alguns outros atributos da guia de internacao.
M->BE4_TIPINT := MV_PAR05
M->BE4_GRPINT := strzero(MV_PAR06,1)
M->BE4_OPESOL := MV_PAR07
M->BE4_REGSOL := MV_PAR08
M->BE4_MEDRES := MV_PAR09
M->BE4_REGEXE := MV_PAR10
*/
//BE4->(RecLock("BE4",.F.))

//Inserido por Luzio em 10/09/2008 para permitir alterar alguns outros atributos da guia de internacao.
If BE4->BE4_CID != mv_par01
	M->BE4_CID    := mv_par01
	M->BE4_DESCID := Posicione("BA9",1,xFilial("BA9")+M->BE4_CID,"BA9_DOENCA")
EndIf	
If BE4->BE4_INTSIP != mv_par02
	M->BE4_INTSIP := mv_par02
EndIf	
If BE4->BE4_TIPPAR != mv_par03
	M->BE4_TIPPAR := mv_par03
EndIf	
If BE4->BE4_TIPNAS != mv_par04
	M->BE4_TIPNAS := mv_par04
EndIf	
If BE4->BE4_TIPINT != mv_par05
	M->BE4_TIPINT := mv_par05
EndIf	
If BE4->BE4_GRPINT != StrZero(Mv_Par06,1)
	M->BE4_GRPINT := StrZero(Mv_Par06,1)
EndIf	
If BE4->BE4_OPESOL != Mv_Par07
	M->BE4_OPESOL := Mv_Par07
EndIf	
If BE4->BE4_REGSOL != Mv_Par08
	M->BE4_REGSOL := Mv_Par08
	M->BE4_NOMSOL := Posicione("BB0",4,xFilial("BB0")+M->BE4_ESTSOL+M->BE4_REGSOL+M->BE4_SIGLA,"BB0_NOME")
EndIf	
If BE4->BE4_MEDRES != Mv_Par09
	M->BE4_MEDRES := Mv_Par09
	M->BE4_DESMED := Posicione("BB0",1,xFilial("BB0")+M->BE4_MEDRES,"BB0_NOME")
EndIf	
If BE4->BE4_REGEXE != Mv_Par10
	M->BE4_REGEXE := Mv_Par10
EndIf	

PLUPTENC("BE4",K_Alterar)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCriaSX1   บAutor  ณJean Schulz         บ Data ณ  06/08/07   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCria parametros para analise de glosas CABERJ.              บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CriaSX1()
Local aArea		:= GetArea()
Local aRegs		:= {}
Local cOrdem	:= ""
Local nX		:= 0

//PutSx1(cGrupo,cOrdem,cPergunt                     ,cPerSpa,cPerEng,cVar    ,cTipo,nTamanho,nDecimal,nPresel,cGSC,cValid              ,cF3     , cGrpSxg,cPyme,cVar01    ,cDef01              ,cDefSpa1,cDefEng1,cCnt01,cDef02                ,cDefSpa2,cDefEng2,cDef03,cDefSpa3,cDefEng3,cDef04,cDefSpa4,cDefEng4,cDef05,cDefSpa5,cDefEng5,aHelpPor,aHelpEng,aHelpSpa,cHelp)
PutSx1(_cPerg,"01",OemToAnsi("Novo CID:")			 	 ,""     ,""     ,"mv_ch1","C"  ,08      ,0       ,0      ,"G" ,""                  ,"BA9PLS",""      ,""   ,"mv_par01",""                  ,""      ,""      ,""    ,""                    ,""      ,""      ,""    ,""      ,""      ,""    ,""      ,""      ,""    ,""      ,""      ,{}      ,{}      ,{})
PutSx1(_cPerg,"02",OemToAnsi("Intern SIP:")		    ,""     ,""     ,"mv_ch2","C"  ,04      ,0       ,0      ,"G" ,""                  ,"BT"    ,""      ,""   ,"mv_par02",""                  ,""      ,""      ,""    ,""                    ,""      ,""      ,""    ,""      ,""      ,""    ,""      ,""      ,""    ,""      ,""      ,{}      ,{}      ,{})
PutSx1(_cPerg,"03",OemToAnsi("Tipo de Parto:")		 ,""     ,""     ,"mv_ch3","C"  ,04      ,0       ,0      ,"G" ,""                  ,"BP"    ,""      ,""   ,"mv_par03",""                  ,""      ,""      ,""    ,""                    ,""      ,""      ,""    ,""      ,""      ,""    ,""      ,""      ,""    ,""      ,""      ,{}      ,{}      ,{})
PutSx1(_cPerg,"04",OemToAnsi("Tipo de Nascto:")		 ,""     ,""     ,"mv_ch4","C"  ,04      ,0       ,0      ,"G" ,""                  ,"BEWPLS",""      ,""   ,"mv_par04",""                  ,""      ,""      ,""    ,""                    ,""      ,""      ,""    ,""      ,""      ,""    ,""      ,""      ,""    ,""      ,""      ,{}      ,{}      ,{})

//Inserido por Luzio em 10/09/2008 para permitir alterar alguns outros atributos da guia de internacao.
PutSx1(_cPerg,"05",OemToAnsi("Tipo de Internacao")	 ,""     ,""     ,"mv_ch5","C"  ,02      ,0       ,0      ,"G" ,""                  ,"BQR999",""      ,""   ,"mv_par05",""                  ,""      ,""      ,""    ,""                    ,""      ,""      ,""    ,""      ,""      ,""    ,""      ,""      ,""    ,""      ,""      ,{}      ,{}      ,{})   //BE4_TIPINT
PutSx1(_cPerg,"06",OemToAnsi("Grupo de Internacao") ,""     ,""     ,"mv_ch6","C"  ,01      ,0       ,0      ,"C" ,""                  ,""      ,""      ,""   ,"mv_par06","Internacao Clinica",""      ,""      ,""    ,"Internacao Cirurgica",""      ,""      ,""    ,""      ,""      ,""    ,""      ,""      ,""    ,""      ,""      ,{}      ,{}      ,{})   //BE4_GRPINT
//PutSx1(_cPerg,"07",OemToAnsi("Codigo Prestador")    ,""     ,""     ,"mv_ch7","C"  ,06      ,0       ,0      ,"G" ,"IF(Empty(MV_PAR07),.T.,PLSA090RD4()) .AND. MV_PAR07 <> GETNEWPAR([MV_PLSRDAG],[999999]) .AND. PlAtuRda()","BQW999",""      ,""   ,"mv_par07",""                  ,""      ,""      ,""    ,""                    ,""     ,""      ,""    ,""      ,""      ,""    ,""      ,""      ,""    ,""      ,""      ,{}      ,{}      ,{})   //BE4_CODRDA
//PutSx1(_cPerg,"08",OemToAnsi("Cod. Esp. Prestador") ,""     ,""     ,"mv_ch8","C"  ,03      ,0       ,0      ,"G" ,"U_LUZIO2(MV_PAR08, MV_PAR07)","B91999",""      ,""   ,"mv_par08",""                  ,""      ,""      ,""    ,""                    ,""     ,""      ,""    ,""      ,""      ,""    ,""      ,""      ,""    ,""      ,""      ,{}      ,{}      ,{})       //BE4_CODESP
PutSx1(_cPerg,"07",OemToAnsi("Operad. Solicitante") ,""     ,""     ,"mv_ch7","C"  ,04      ,0       ,0      ,"G" ,"U_LUZIO3(MV_PAR07)","B89PLS",""      ,""   ,"mv_par07",""                  ,""      ,""      ,""    ,""                    ,""     ,""      ,""    ,""      ,""      ,""    ,""      ,""      ,""    ,""      ,""      ,{}      ,{}      ,{})     //BE4_OPESOL
PutSx1(_cPerg,"08",OemToAnsi("C.R.Solicitante")     ,""     ,""     ,"mv_ch8","C"  ,10      ,0       ,0      ,"G" ,"U_LUZIO4(MV_PAR08)","BTYPLS",""      ,""   ,"mv_par08",""                  ,""      ,""      ,""    ,""                    ,""     ,""      ,""    ,""      ,""      ,""    ,""      ,""      ,""    ,""      ,""      ,{}      ,{}      ,{})     //BE4_REGSOL
PutSx1(_cPerg,"09",OemToAnsi("Medico Responsavel")  ,""     ,""     ,"mv_ch9","C"  ,06      ,0       ,0      ,"G" ,"U_LUZIO2(MV_PAR09)","BB0PLS",""      ,""   ,"mv_par09",""                  ,""      ,""      ,""    ,""                    ,""     ,""      ,""    ,""      ,""      ,""    ,""      ,""      ,""    ,""      ,""      ,{}      ,{}      ,{})               //BE4_MEDRES
PutSx1(_cPerg,"10",OemToAnsi("C.R.Executante")      ,""     ,""     ,"mv_cha","C"  ,10      ,0       ,0      ,"G" ,"U_LUZIO1(MV_PAR10)","BTYPLS",""      ,""   ,"mv_par10",""                  ,""      ,""      ,""    ,""                    ,""     ,""      ,""    ,""      ,""      ,""    ,""      ,""      ,""    ,""      ,""      ,{}      ,{}      ,{})               //BE4_REGEXE

//If(Empty(MV_PAR08),.T.,PLSA090ESP([0001],MV_PAR07,M->BE4_CODLOC,MV_PAR08,BE4->BE4_DATPRO,[BE4]))
//Aadd(aSx1,{"GRUPO","ORDEM","PERGUNT"          	,"VARIAVL","TIPO","TAMANHO","DECIMAL","GSC","VALID","VAR01"   ,"F3" ,"DEF01"	,"DEF02" ,"DEF03"	,"DEF04","DEF05"})
//aadd(aRegs,{cPerg ,"11"   ,"Autorizacao        ?","","","mv_chb","N", 1,0,0,"C",""                     ,"mv_par11","Dispensa Autoriz.","","","","","Automatico","","","","","Guia Operadora","","","","","Auditoria","","","","","","","","",""})
//Aadd(aRegs,{cPerg ,"14"   ,"Parentesco Consider ","","","mv_che","C",20,0,0,"G","PL770F3GRP(@cA770ret)","mv_par14","","","","","","","","","","","","","","","","","","","","","","","","","XXX","HELPPOR","",""})

//Preencher os campo CONTEUDO do SX1 com os dados do campo do BE4

DbSelectArea("SX1")
DbSetOrder(1)

If (MsSeek(_cPerg))
	While SX1->( !Eof() ) .AND. SX1->X1_GRUPO == _cPerg
		RecLock("SX1",.F.)
		Do Case
		   Case SX1->X1_ORDEM == "01"
				Replace X1_CNT01	With BE4->BE4_CID
		   Case SX1->X1_ORDEM == "02"
				Replace X1_CNT01	With BE4->BE4_INTSIP
		   Case SX1->X1_ORDEM == "03"
				Replace X1_CNT01	With BE4->BE4_TIPPAR
		   Case SX1->X1_ORDEM == "04"
				Replace X1_CNT01	With BE4->BE4_TIPNAS
		   Case SX1->X1_ORDEM == "05"
				Replace X1_CNT01	With BE4->BE4_TIPINT
		   Case SX1->X1_ORDEM == "06"
				Replace X1_PRESEL	With val(BE4->BE4_GRPINT)
		   Case SX1->X1_ORDEM == "07"
				Replace X1_CNT01	With BE4->BE4_OPESOL
		   Case SX1->X1_ORDEM == "08"
				Replace X1_CNT01	With BE4->BE4_REGSOL
		   Case SX1->X1_ORDEM == "09"
				Replace X1_CNT01	With BE4->BE4_MEDRES
		   Case SX1->X1_ORDEM == "10"
				Replace X1_CNT01	With BE4->BE4_REGEXE
      End Case
			
		MsUnlock()
		SX1->(DbSkip())
	EndDo
Endif
RestArea( aArea )

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณLUZIO1    บAutor  ณLuzio Tavares       บ Data ณ  11/09/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para validar O C.R. Executante                       บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function LUZIO1()       //cCodRDA
Local nI
Local lRet := .F.
Local lPode := .T.
Local cRegExe := &(ReadVar())
Local nTam := Len(&(ReadVar()))

If M->BE4_REGEXE == Mv_Par10
	Return(.T.)
EndIf
If Empty(cRegExe)
	lRet := .T.
Else
	lRet := PLSA092EXE()
EndIf	                                                             

Return lRet 

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณLUZIO2    บAutor  ณLuzio Tavares       บ Data ณ  11/09/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para validar o Medico Responsavel.                   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function LUZIO2(cMedRes)
Local lRet    := .F.
Local cMedRes := &(ReadVar())

If BE4->BE4_MEDRES == Mv_Par09
   Return(.T.)
EndIf

ComZero(@cMedRes)

If Empty(cMedRes)
	lRet := .T.
Else
	lRet := BB0->(PLVLDPFS("BB0",cMedRes,1,dDataBase))
EndIf	

Return lRet 

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณLUZIO3    บAutor  ณLuzio Tavares       บ Data ณ  11/09/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para validar a Operadora do Solciitante              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function LUZIO3(cOpeSol)
Local lRet    := .F.
Local cOpeSol := &(ReadVar())

If Empty(cOpeSol)
	lRet := .T.
Else
	lRet := BA0->(ExistCpo("BA0",cOpeSol,1))
EndIf	

Return lRet 

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณLUZIO4    บAutor  ณLuzio Tavares       บ Data ณ  11/09/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณFuncao para validar o Solicitante.                          บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function LUZIO4(cRegSol)
Local lRet    := .F.
Local cRegSol := &(ReadVar())

If Empty(cRegSol) .or. MV_PAR08 <> PLSINTPAD()   //M->BE4_OPESOL <> PLSINTPAD()
	lRet := .T.
Else
	lRet := BB0->(PLVLDPFS("BB0",M->BE4_ESTSOL+cRegSol+M->BE4_SIGLA,4,dDataBase)) .and. U_BB0BE4(dDataBase)
EndIf	

Return lRet 

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณPrograma  ณ ComZero    ณ Autor ณ Luzio Tavares        ณ Data ณ 26/09/2008 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescrio ณ Preenche com zeros a esquerda o campo ou variavel             ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณParametrosณ cVar - nome do campo (DEVE SER PASSADO ENTRE ASPAS)           ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function ComZero(cVar)
Local nI
Local lPode := .T. 
Local nTam := Len(cVar)

If Empty(cVar)
    Return .T.
Endif

For nI := 1 to nTam
   If !(SubStr(cVar,nI,1) $ " 0123456789")
      lPode := .F.
      Exit
   EndIf
Next
If lPode
    cVar := StrZero(Val(Substr(cVar,1,nTam)),nTam)
EndIf   

Return

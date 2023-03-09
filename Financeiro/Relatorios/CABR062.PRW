#include "PROTHEUS.CH"
#include "TOPCONN.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³CABR062  ³ Autor ³ Renato Peixoto       ³ Data ³ 14/05/2012 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Relatorio de beneficiarios com pendencias financeiras em   |±±
±±³          ³ matriculas bloqueadas no sistema.                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ CABERJ                                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function CABR062           

Local   oReport 

Private cPerg	:= "CABR062" 
Private cCompet := ""  
Private aRel    := {}

oReport:= ReportDef()
oReport:PrintDialog()

Return

********************************************************************************************************************************

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Renato Peixoto                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatorio                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/                         

Static Function ReportDef()

Local oReport 
Local oUsr     

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Ajusta o Grupo de Perguntas                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
AjustaSX1()

Pergunte(cPerg,.F.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao do componente de impressao                                      ³
//³                                                                        ³
//³TReport():New                                                           ³
//³ExpC1 : Nome do relatorio                                               ³
//³ExpC2 : Titulo                                                          ³
//³ExpC3 : Pergunte                                                        ³
//³ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  ³
//³ExpC5 : Descricao                                                       ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

oReport	:= TReport():New("CABR062","Benefic. com pendencias financeiras em outra matricula bloq. ","CABR062", {|oReport| ReportPrint(oReport)},"Este relatorio emite uma relacao de beneficiários ativos com outra matricula bloqueada c/ pendência financeira.")

*'-----------------------------------------------------------------------------------'*
*'SoluÃ§Ã£o para impressÃ£o em que as colunas se truncam: "SetColSpace" e "SetLandScape"'* 
*'-----------------------------------------------------------------------------------'*

oReport:SetColSpace(2) //EspaÃ§amento entre colunas. 
oReport:SetLandscape() //ImpressÃ£o em paisagem.  
//oReport:SetPortrait() //ImpressÃ£o em retrato.  

*'-----------------------------------------------------------------------------------'*

oUsr := TRSection():New(oReport,"Beneficiarios com pendencia financeira em outra matric. bloqueada")
oUsr:SetTotalInLine(.F.)   
 
nTamMatric 	:= TamSx3('BA1_CODINT')[1] + TamSx3('BA1_CODEMP')[1] + TamSx3('BA1_MATRIC')[1] + TamSx3('BA1_TIPREG')[1] + TamSx3('BA1_DIGITO')[1] + 4
cPicture 	:= '@E 999,999,999,999.99'

TRCell():New(oUsr ,'DATA_INCLUSAO',  	,'Data Inclusão'                       	,/*Picture*/	,				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oUsr ,'MATRIC'		   ,	,'Matricula'		 					,/*Picture*/	,nTamMatric		,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oUsr ,'NOME'	       ,   	,'Nome Benefic.'    			        ,/*Picture*/	,50          	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oUsr ,'DATA_BLOQUEIO',		,'Data Bloqueio'                       	,/*Picture*/	,				,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)


aAdd ( aRel,    {"DATA INCLUSÃO","MATRICULA","NOME BENEFICIÁRIO","DATA BLOQUEIO" } )

//oUsr:SetTotalText("Total geral")

//TRFunction():New(oUsr:Cell("BA1_NOMUSR")  		,NIL,"COUNT"	,/*oBreak1*/,"@E 999,999,999",,/*uFormula*/,.T.,.F.)
//TRFunction():New(oUsr:Cell("VLR_ANTES")  		,NIL,"SUM"  	,/*oBreak1*/,"@E 999,999,999",,/*uFormula*/,.T.,.F.)
//TRFunction():New(oUsr:Cell("VLR_APOS")  		,NIL,"SUM" 		,/*oBreak1*/,"@E 999,999,999",,/*uFormula*/,.T.,.F.)

Return(oReport)

********************************************************************************************************************************

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint³ Autor ³ Renato Peixoto                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function ReportPrint(oReport)

Local oBreak01                             
Local i             := 0

Private oUsr   		:= oReport:Section(1)
Private cAlias1 	:= GetNextAlias()
Private cQuery		:= ''
Private nCont 		:= 0
Private SEMAFORO 	:= '' 
Private lContinua	:= .F.

Processa({||nCont := BscIncon()},"Grupo Caberj")

//Se nao tiver esta linha, nÃ£o imprime os dados
oUsr:init()
	
oReport:SetMeter(nCont) 
	
//cTot	:= allTrim(Transform(nCont,'@E 999,999,999,999'))
nCont 	:= 0       
nCritic	:= 0

While !( cAlias1->(Eof()) )
    
	If oReport:Cancel()  
		    
	    oReport:FatLine()     
	    oReport:PrintText('Cancelado pelo operador!!!',,,CLR_RED,,,.T.)
	    exit
    
	EndIf
                                                    
	oReport:SetMsgPrint("Analisando beneficiários com inconsistências financeiras...")
	oReport:IncMeter()

	//nome das celulas
	//DATA_INCLUSAO
	//'MATRIC'	
	//'NOME'
	//'DATA_BLOQUEIO'

	oUsr:Cell('DATA_INCLUSAO'):SetValue(STOD(cAlias1->DATINC))
	oUsr:Cell('MATRIC'		):SetValue(cAlias1->MATRIC)
	oUsr:Cell('NOME'	):SetValue(cAlias1->NOME)
	oUsr:Cell('DATA_BLOQUEIO'):SetValue(STOD(cAlias1->DATBLOQ))
				
	aAdd(aRel, {STOD(cAlias1->DATINC), cAlias1->MATRIC, cAlias1->NOME, STOD(cAlias1->DATBLOQ) })
				
	oUsr:PrintLine()
				

    cAlias1->(dbSkip())

EndDo

oUsr:Finish()

cAlias1->(dbCloseArea()) 

If Len(aRel) >0
	If APMSGYESNO("Deseja gerar uma listagem em excel com os resultados gerados?","Listar em Excel?")
		DlgToExcel({{"ARRAY","Listagem de inconsistências beneficiários ativos com matricula bloqueada com pendência financeira.","",aRel }} )
	EndIf
EndIf


Return   


********************************************************************************************************************************

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³BscIncon  ºAutor  ³Renato Peixoto      º Data ³  04/19/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Função que contém a query que vai buscar os registros que   º±±
±±º          ³possivelmente possuem inconsistencia no valor mensalidade.  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function BscIncon

Local cCodInt  := PLSINTPAD()

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

cVencRea := DTOS(MV_PAR01)

ProcRegua(0)

For i := 0 to 5
	IncProc('Selecionando registros...')
Next
// traz os registros de acordo com os parametros especificados
cQuery := "SELECT BA1_DATINC DATINC,  BA1_CODINT || BA1_CODEMP || BA1_MATRIC || BA1_TIPREG || BA1_DIGITO MATRIC, BA1_NOMUSR NOME , BA1_datblo DATBLOQ "
cQuery += "FROM "+RetSqlName("BA1")+" BA11, "+RetSqlName("BA3")+" BA3 "
cQuery += "WHERE BA1_FILIAL = '"+XFILIAL("BA1")+"' "
cQuery += "AND BA3_FILIAL = '"+XFILIAL("BA3")+"' " 
cQuery += "AND BA11.D_E_L_E_T_ = ' ' AND BA3.D_E_L_E_T_ = ' ' "
cQuery += "AND BA1_CODINT = '"+cCodInt+"'  "
cQuery += "AND BA1_CODEMP IN ( '0001', '0002', '0005') " //0001 - caberj auto-gestão associado; 0002 - caberj auto-gestão familiar; 0005 - caberj auto-gestão agregados
cQuery += "AND BA1_TIPUSU = 'T' "
cQuery += "AND BA1_datblo <> ' ' "
cQuery += "AND BA3_CODINT = BA1_CODINT "
cQuery += "AND BA3_CODEMP = BA1_CODEMP "
cQuery += "AND BA3_MATRIC = BA1_MATRIC "

cQuery += "AND EXISTS ( "
cQuery += "              SELECT BA1_DATINC,  BA1_CODINT || BA1_CODEMP || BA1_MATRIC || BA1_TIPREG || BA1_DIGITO , BA1_NOMUSR , to_date(BA1_datblo, 'yyyymmdd') "// --*
cQuery += "              FROM "+RetSqlName("BA1")+" BA12 "
cQuery += "              WHERE BA12.BA1_FILIAL = '"+XFILIAL("BA1")+"' "
cQuery += "              AND BA12.BA1_CODINT = BA11.BA1_CODINT "
cQuery += "              AND BA12.BA1_MATVID = BA11.BA1_MATVID "
cQuery += "              AND BA12.BA1_datblo = ' ' "
cQuery += "              AND D_E_L_E_T_ = ' ' "
cQuery += "            )

cQuery += "and EXISTS ( "
cQuery += "            SELECT *
cQuery += "            FROM "+RetSqlName("SE1")+" E1 "
cQuery += "            WHERE E1_FILIAL = '"+XFILIAL("SE1")+"' "  //'01'
cQuery += "                  AND (E1.E1_CODINT= BA11.BA1_CODINT "
cQuery += "                  AND E1.E1_CODEMP= BA11.BA1_CODEMP "
cQuery += "                  AND E1.E1_MATRIC= BA11.BA1_MATRIC) "
cQuery += "                  AND E1_SALDO <> 0 "
cQuery += "                  AND E1_VENCREA < '"+cVencRea+"' " // '20120103' 
cQuery += "                  and d_e_l_e_t_ = ' ' )


TcQuery cQuery New Alias cAlias1

cAlias1->(dbGoTop())

nCont := 0

cAlias1->(dbEval({||++nCont}))

cAlias1->(dbGoTop())

Return nCont

********************************************************************************************************************************
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ AjustaSX1³ Autor ³ Renato Peixoto                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Ajusta as perguntas do SX1                                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function AjustaSX1()

Local aHelp 	:= {}

aHelp := {}
aAdd(aHelp, "Informe a data de vencimento")
PutSX1(cPerg , "01" , "Vencimento?" 	,"","","mv_ch1","D",8,0,0,"G",""	,"","","","mv_par01","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

Return

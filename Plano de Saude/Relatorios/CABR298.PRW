#INCLUDE 'TOTVS.CH'
#INCLUDE "TOPCONN.CH" 
#Include "MSGRAPHI.CH"
#Include "FILEIO.CH"
#DEFINE CRLF Chr(13)+Chr(10)

/*/{Protheus.doc} CABR298
description
@type function
@version  1.0.0
@author Marcos Cantalice - 7 Consulting
@since 22/03/2022
@return variant, return_description
/*/
USER FUNCTION CABR298()

Local oReport
Local aArea := GetArea()
Private cPerg  := "CABR298"

AjustaSX1_2(cPerg)

IF !Pergunte(cPerg, .T.)
	Return
Endif

oReport:= ReportH()
oReport:PrintDialog()

RestArea(aArea)

RETURN

Static Function ReportH()
                                      
Local oSection2
Local oReport
Local aAreaSM0  := SM0->(GetArea())   
Local cTit := "Especialidade x SubEspecialidade"
Private contador := 1

cDesCRel := cTit

//??????????????????????????????????????
//?Criacao do componente de impressao                                     ?
//?oReport():New                                                          ?
//?ExpC1 : Nome do relatorio                                              ?
//?ExpC2 : Titulo                                                         ?
//?ExpC3 : Pergunte                                                       ?
//?ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao ?
//?ExpC5 : Descricao                                                      ?
//??????????????????????????????????????
cDesl:= "Este relatorio tem como objetivo imprimir a relação das especialidades x subespecialidades"
oReport:= TReport():New(cPerg,cTit,cPerg, {|oReport| ReportPrt(oReport)},cDescRel)
oReport:SetLandScape(.T.)
oReport:SetTotalInLine(.T.)


Pergunte(oReport:uParam,.F.)

		 
		oSection2 := TRSection():New(oReport,"Especialidades X Subespecialidades",{"BFN", "BAQ"}) 

		// Colunas do relatorio
		TRCell():New(oSection2,"BAQ_CODESP"    	,,"Cod Especialidade"  	, ""	,9	   ,.F.,{|| (cAliasBOL)->BAQ_CODESP}  		,"LEFT"  ,.T. ,"LEFT" )
		TRCell():New(oSection2,"BAQ_DESCRI"    	,,"Especialidade"  	    , ""	,75	   ,.F.,{|| (cAliasBOL)->BAQ_DESCRI}  		,"LEFT"  ,.T. ,"LEFT" )
		TRCell():New(oSection2,"BFN_CODSUB"	   	,,"Cod Subespecialidade", ""	,8	   ,.F.,{|| (cAliasBOL)->BFN_CODSUB } 		,"LEFT"  ,.T. ,"LEFT" )
		TRCell():New(oSection2,"BFN_DESCRI"	   	,,"Subespecialidade"	, ""	,85	   ,.F.,{|| (cAliasBOL)->BFN_DESCRI }  		,"LEFT"  ,.T. ,"LEFT" )

RestArea( aAreaSM0 )

Return(oReport)

Static Function ReportPrt(oReport)
//Local oSection1 
Local oSection2 
//Local aUser 

Private cAliasBOL  := GetnextAlias()
Private dDatabase    
Private dData
Private aArea1  := {} 


oSection2 := oReport:Section(1)

// Query para buscar os dados no banco


	cQry:=" SELECT DISTINCT BAQ_CODESP , BAQ_DESCRI , BFN_CODSUB , BFN_DESCRI "
	cQry+="	FROM "+RetSqlName("BAQ")+" BAQ "
	cQry+=" INNER JOIN "+RetSqlName("BFN")+" BFN"
	cQry+=" ON (BFN_CODINT = BAQ_CODINT AND BFN_CODESP = BAQ_CODESP)"
	cQry+=" WHERE BAQ.D_E_L_E_T_ = ' ' AND BFN.D_E_L_E_T_ = ' ' "
       
    IF !EMPTY(MV_PAR01)
        cQry+=" AND BAQ_CODESP IN ("+MV_PAR01+")"	
    ENDIF
     
    cQry+="ORDER BY BAQ_DESCRI, BFN_CODSUB"

cQry    := ChangeQuery(cQry)
dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQry),cAliasBOL,.T.,.T.)

dbSelectArea(cAliasBOL)
(cAliasBOL)->(dbgotop())	

oReport:SetMeter((cAliasBOL)->(LastRec()))	  

//Imprime os dados do relatorio
If (cAliasBOL)->(Eof())
	Alert("Nao foram encontrados dados!")
Else

	oSection2:Init()

	While  !(cAliasBOL)->(Eof())       
			
		oReport:IncMeter()
		oSection2:PrintLine()
			
		(cAliasBOL)->(DbSkip())
	Enddo   
		
	oReport:FatLine()
	oReport:Section(1):Finish()

	(cAliasBOL)->(DbCloseArea())

EndIf

Return

Static Function AjustaSX1_2(cPerg)

Local aHelpPor	:= {} 


aHelpPor := {}
AADD(aHelpPor,"Informe qual especialidade deseja exibir:			")

 u_CABASX1(cPerg,"01","Especialidade:"	        	,"","",	"MV_CH1" ,"C",99  	                    ,0,0,"G","","CBR298",	"","","MV_PAR01",""			,""			,""			,"","","","","","","","","","","","","",aHelpPor,{},{},"")		

Return()

USER FUNCTION CABR298A()

Local cTitulo	:= "Especialidade"
Local oOk		:= LoadBitmap( GetResources(), "LBOK" )
Local oNo		:= LoadBitmap( GetResources(), "LBNO" )

Private lChk	:= .F.
Private oLbx	:= Nil
Private aVetor	:= {}
Private oDlg

Public cSub

BAQ->(DbSetOrder(1))	// BAQ_FILIAL+BAQ_CODINT+BAQ_CODESP
if BAQ->(DbSeek( xFilial("BAQ") + PlsIntPad() ))

	while BAQ->(!EOF() ) 

		aAdd( aVetor, { .F., BAQ->BAQ_CODESP, AllTrim(BAQ->BAQ_DESCRI) })

		BAQ->(DbSkip())
	end

endif



	DEFINE MSDIALOG oDlg TITLE cTitulo FROM 0,0 TO 240,500 PIXEL

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿ 	
	//³ Se houver duplo clique, recebe ele mesmo negando, depois da um refresh³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	@ 10,10 LISTBOX oLbx VAR cVar FIELDS HEADER " ", "Codigo","Descriçao";
	SIZE 230,095 OF oDlg PIXEL ON dblClick(aVetor[oLbx:nAt,1] := !aVetor[oLbx:nAt,1], oLbx:Refresh())
	oLbx:SetArray( aVetor )
	oLbx:bLine := {|| {Iif(aVetor[oLbx:nAt,1],oOk,oNo),	aVetor[oLbx:nAt,2],	aVetor[oLbx:nAt,3] }}

	DEFINE SBUTTON FROM 107,213 TYPE 1 ACTION (cSub := CABR298B()) ENABLE OF oDlg

	ACTIVATE MSDIALOG oDlg CENTER


Return(.T.)



Static Function CABR298B()

Local _i		:= 0
Local cRet		:= ""

for _i := 1 to len(aVetor)
	if aVetor[_i, 1]
		cRet += "'"+aVetor[_i, 2] + "',"
	endif
next

cRet := iif(SubStr(cRet,len(cRet),1) == ",", SubStr(cRet,1,len(cRet)-1), cRet)
cRet := AllTrim(cRet)

oDlg:End()

return cRet
Return lRet

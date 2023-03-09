#include "PROTHEUS.CH"
#include "TOPCONN.CH"    
#include "UTILIDADES.CH"  

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    � CABR109  � Autor � Leonardo Portella     � Data �31/05/2011���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Relatorio de performance da atualizacao de dados cadastrais���
�������������������������������������������������������������������������Ĵ��
��� Uso      � CABERJ                                                     ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function CABR109

Local oReport 
Private cPerg	:= "CABR109"  
Private nTotVal	:= 0
Private nTotIns	:= 0

oReport:= ReportDef()
oReport:PrintDialog()

Return

********************************************************************************************************************************

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  �ReportDef � Autor � Leonardo Portella                       ���
�������������������������������������������������������������������������Ĵ��
���Descri��o �A funcao estatica ReportDef devera ser criada para todos os ���
���          �relatorios que poderao ser agendados pelo usuario.          ���
�������������������������������������������������������������������������Ĵ��
���Retorno   �ExpO1: Objeto do relatorio                                  ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/             

Static Function ReportDef()

Local oReport  
Local oRDA

//������������������������������������������������������������������������Ŀ
//� Ajusta o Grupo de Perguntas                                            �
//��������������������������������������������������������������������������
AjustaSX1()

Pergunte(cPerg,.F.)

//������������������������������������������������������������������������Ŀ
//�Criacao do componente de impressao                                      �
//�                                                                        �
//�TReport():New                                                           �
//�ExpC1 : Nome do relatorio                                               �
//�ExpC2 : Titulo                                                          �
//�ExpC3 : Pergunte                                                        �
//�ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  �
//�ExpC5 : Descricao                                                       �
//��������������������������������������������������������������������������

oReport	:= TReport():New("CABR109","Performance da atualiza��o de dados cadastrais","CABR109", {|oReport| ReportPrint(oReport)},"Este relatorio emite uma relacao de performance da atualizacao de dados cadastrais")

*'-----------------------------------------------------------------------------------'*
*'Solu��o para impress�o em que as colunas se truncam: "SetColSpace" e "SetLandScape"'* 
*'-----------------------------------------------------------------------------------'*

oReport:SetColSpace(2) //Espa�amento entre colunas. 
oReport:SetPortrait() //oReport:SetLandscape()  

*'-----------------------------------------------------------------------------------'*

oRDA := TRSection():New(oReport,"Performance da atualizacao de dados cadastrais")
                  
TRCell():New(oRDA ,'BTS_XUSVAL'	,'BTS'	,'Usu�rio validou'		,/*Picture*/		,len(UsrFullName(RetCodUsr()))	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRDA ,'BTS_XSTATU'	,'BTS'	,'Status Atualiza��o'	,/*Picture*/		,/*Tamanho*/					,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRDA ,'ATUALIZADO'	,		,'Qtd atualizada'		,'@E 999,999,999'	,/*Tamanho*/					,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)

oRDA:SetTotalText("Total geral")                                   

If mv_par06 != 1

	oBreak1 := TRBreak():New(oRDA,oRDA:Cell('BTS_XUSVAL'),"Total por usu�rio",.T.)
	TRFunction():New(oRDA:Cell('ATUALIZADO'),NIL,"SUM"		,oBreak1,'Qtd atualizada'	,"@E 999,999,999"	,/*uFormula*/																,.F.,.T.)
	TRFunction():New(oRDA:Cell('ATUALIZADO'),NIL,"AVERAGE"	,oBreak1,'M�dia'			,"@E 999,999,999.99",/*uFormula*/																,.F.,.T.)
	TRFunction():New(oRDA:Cell('ATUALIZADO'),NIL,"SUM"		,oBreak1,'Perc. Validado'	,"@E 999,999,999.99",{||100*If(cAlias->(BTS_XSTATU) == 'V',cAlias->(ATUALIZADO),0)/nTotVal}	,.F.,.F.)
	TRFunction():New(oRDA:Cell('ATUALIZADO'),NIL,"SUM"		,oBreak1,'Perc. Insucesso'	,"@E 999,999,999.99",{||100*If(cAlias->(BTS_XSTATU) == 'V',0,cAlias->(ATUALIZADO))/nTotIns}	,.F.,.F.)
	TRFunction():New(oRDA:Cell('ATUALIZADO'),NIL,"SUM"		,oBreak1,'Perc. Total'		,"@E 999,999,999.99",{||100*cAlias->(ATUALIZADO)/(nTotVal+nTotIns)}							,.F.,.F.)

EndIf

Return(oReport)

********************************************************************************************************************************

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Programa  �ReportPrint� Autor � Leonardo Portella                      ���
�������������������������������������������������������������������������Ĵ��
���Descri��o �A funcao estatica ReportDef devera ser criada para todos os ���
���          �relatorios que poderao ser agendados pelo usuario.          ���
�������������������������������������������������������������������������Ĵ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

Static Function ReportPrint(oReport)

Local oBreak01                             

Private oRDA   		:= oReport:Section(1)
Private cAlias  	:= GetNextAlias()
Private cQuery		:= ''
Private nCont		:= 0
              
MsgRun("Selecionando registros...","GRUPO CABERJ",{||nCont := FilTRep()})

oReport:SetMeter(nCont) 

cTot	:= allTrim(Transform(nCont,'@E 999,999,999,999'))
nCont 	:= 0

oRDA:init()

While !( cAlias->(Eof()) )
    
	If oReport:Cancel()  
	    
	    oReport:FatLine()     
	    oReport:PrintText('Cancelado pelo operador!!!',,,CLR_RED,,,.T.)
	    
	    exit
	    
	EndIf
                                                    
	oReport:SetMsgPrint("Imprimindo a linha " + allTrim(Transform(++nCont,'@E 999,999,999,999')) + " de " + cTot)
	oReport:IncMeter()
	
	oRDA:Cell('BTS_XUSVAL'	):SetValue(Upper(UsrFullName(cAlias->(BTS_XUSVAL)))				)
	oRDA:Cell('BTS_XSTATU'	):SetValue(If(cAlias->(BTS_XSTATU) == 'V','Validado','Insucesso')	)
	oRDA:Cell('ATUALIZADO'	):SetValue(cAlias->(ATUALIZADO)										)  
	
	oRDA:PrintLine()
 	
 	cAlias->(dbSkip())

EndDo 

oRDA:Finish()
	
cAlias->(dbCloseArea())

Return   

********************************************************************************************************************************

Static Function FilTRep

Local nI := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

//������������������������������������������������������������������������Ŀ
//�Filtragem do relatorio                                                  �
//��������������������������������������������������������������������������

cQuery += "SELECT BTS_XUSVAL,BTS_XSTATU,COUNT(*) ATUALIZADO" 										+ CRLF
cQuery += "FROM " + RetSqlName('BTS')																+ CRLF
cQuery += "WHERE D_E_L_E_T_ = ' '"																	+ CRLF 
cQuery += "  AND BTS_FILIAL = '" + xFilial('BTS') + "'"												+ CRLF
cQuery += "  AND BTS_XDTVAL BETWEEN '" + DtoS(mv_par01) + "' AND '" + DtoS(mv_par02) + "'"			+ CRLF

If empty(mv_par05)
	cQuery += "		AND BTS_XUSVAL BETWEEN '" + mv_par03 + "' AND '" + mv_par04 + "'"				+ CRLF                                                                                                       
Else 
	aLogins 	:= strTokArr(allTrim(mv_par08),';')
	cLogins 	:= ''
	cLoginsNEnc := ''
	
	For nI := 1 to len(aLogins)  
	
		PswOrder(2)//Ordem por Login

	    If PswSeek(aLogins[nI],.T.)
	    	aGrupos := Pswret(1)
			cLogins += allTrim(aGrupos[1][1]) + ','
	    Else
	    	cLoginsNEnc += ' - ' + allTrim(aLogins[nI]) + ';' + CRLF	
		EndIf
		
	Next  
	
	If !empty(cLoginsNEnc)                         
		cLoginsNEnc := 'Logins n�o encontrados' + CRLF + CRLF + cLoginsNEnc             
		logErros(cLoginsNEnc,'Logins n�o encontrados')
	EndIf
	
	cLogins := left(cLogins,len(cLogins) - 1)
	
	cQuery += "		AND BTS_XUSVAL IN " + FormatIn(cLogins,',') + CRLF                                                                                                       
EndIf

cQuery += "GROUP BY BTS_XUSVAL,BTS_XSTATU"								+ CRLF
cQuery += "ORDER BY BTS_XUSVAL,BTS_XSTATU"						 		+ CRLF

TcQuery cQuery New Alias cAlias

cAlias->(dbGoTop())

nCont := 0
cAlias->(dbEval({||++nCont,If(cAlias->(BTS_XSTATU) == 'V',nTotVal+=cAlias->(ATUALIZADO),nTotIns+=cAlias->(ATUALIZADO))}))

cAlias->(dbGoTop())

Return nCont

********************************************************************************************************************************

/*/
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun�ao    � AjustaSX1� Autor � Leonardo Portella                       ���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Ajusta as perguntas do SX1                                 ���
�������������������������������������������������������������������������Ĵ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
/*/

Static Function AjustaSX1()

Local aHelp 	:= {}
Local aArea2	:= GetArea()  

aHelp := {}
aAdd(aHelp, "Informe a data de validacao inicial")         
PutSX1(cPerg , "01" , "Data Valid. de" 			,"","","mv_ch1","D",08							,0,0,"G",""	,""			,"","","mv_par01","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe a data de validacao  final")         
PutSX1(cPerg , "02" , "Data Valid. ate" 		,"","","mv_ch2","D",08							,0,0,"G",""	,""			,"","","mv_par02","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o usuario validador inicial")      
PutSX1(cPerg , "03" , "Usr. Valid. de" 			,"","","mv_ch3","C",TamSx3('BTS_XUSVAL')[1]	,0,0,"G",""	,"USRPRO"	,"","","mv_par03","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe o usuario validador inicial")      
PutSX1(cPerg , "04" , "Usr. Valid. ate" 		,"","","mv_ch4","C",TamSx3('BTS_XUSVAL')[1]	,0,0,"G",""	,"USRPRO"	,"","","mv_par04","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe a lista de logins de usuarios que")
aAdd(aHelp, "se quer filtrar, exemplo: fulano, beltrano")
aAdd(aHelp, "Separe os logins por ','")
aAdd(aHelp, "Se este par�metro estiver preenchido, ignora")
aAdd(aHelp, "os par�metros 3 e 4")
PutSX1(cPerg , "05" , "Usuarios" 	 			,"","","mv_ch5","C",99							,0,0,"G",""	,""			,"","","mv_par05","","","","","","","","","","",""	,"","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe dever� ser exibido o subtotal por")
aAdd(aHelp, "usu�rio")
PutSX1(cPerg , "06" , "Subtotal por usu�rio" 	,"","","mv_ch6","N",1							,0,0,"C",""	,""			,"","","mv_par06","Sim","","","","N�o","","","","","",""	,"","","","","",aHelp,aHelp,aHelp)

RestArea(aArea2)

Return

******************************************************************************************************************************



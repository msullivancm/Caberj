#INCLUDE "PROTHEUS.CH"  
#INCLUDE "TOPCONN.CH"  
#INCLUDE "UTILIDADES.CH"  

/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������Ŀ��
���Fun��o    � CABR107  � Autor � Leonardo Portella     � Data �12/05/2011���
�������������������������������������������������������������������������Ĵ��
���Descri��o � Relatorio de atualizacao de cadastro detalhado.            ���
�������������������������������������������������������������������������Ĵ��
��� Uso      � CABERJ                                                     ���
��������������������������������������������������������������������������ٱ�
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

User Function CABR107

Local oReport 
Private cPerg	:= "CABR107"  

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
Local oRDA2
Local oCompet

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

oReport	:= TReport():New("CABR107","Atualiza��o de cadastros detalhado","CABR107", {|oReport| ReportPrint(oReport)},"Este relatorio emite uma relacao de atualiza��o de cadastros detalhado")

*'-----------------------------------------------------------------------------------'*
*'Solu��o para impress�o em que as colunas se truncam: "SetColSpace" e "SetLandScape"'* 
*'-----------------------------------------------------------------------------------'*

oReport:SetColSpace(2) //Espa�amento entre colunas. 
oReport:SetLandscape() //Impress�o em paisagem.  

*'-----------------------------------------------------------------------------------'*

oRDA := TRSection():New(oReport,"Tentativa de atualiza��o de cadastros sem sucesso")
oRDA:SetTotalInLine(.F.)   
                  
TRCell():New(oRDA ,'PAM_CODUSR'	,'PAM'	,'Usu�rio validou'		,/*Picture*/	,len(UsrFullName(RetCodUsr()))	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRDA ,'PAM_DTVAL'	,'PAM'	,'Data valid.'			,/*Picture*/	,/*Tamanho*/					,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRDA ,'PAM_HRVAL'	,'PAM'	,'Hora valid.'			,/*Picture*/	,/*Tamanho*/					,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRDA ,'BA1_NOMUSR'	,'BA1'	,'Benefici�rio'			,/*Picture*/	,/*tamanho*/					,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)
TRCell():New(oRDA ,'TIPOBENEF'	,		,'Tipo'					,/*Picture*/	,15								,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)

oRDA2 := TRSection():New(oRDA,"Campos alterados")
oRDA2:SetTotalInLine(.F.) 
                  
TRCell():New(oRDA2 ,'CPO'	,,'Campos alterados'			,/*Picture*/	,220	,/*lPixel*/,/*{|| code-block de impressao }*/,,,"LEFT"		)

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

Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
Local j := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

Local oBreak01                             

Private oRDA   		:= oReport:Section(1)
Private oRDA2  		:= oReport:Section(1):Section(1)
Private cAlias  	:= GetNextAlias()
Private cQuery		:= ''
Private nCont		:= 0
              
MsgRun("Selecionando registros...","GRUPO CABERJ",{||nCont := FilTRep()})

oReport:SetMeter(nCont) 

cTot	:= allTrim(Transform(nCont,'@E 999,999,999,999'))
nCont 	:= 0

While !( cAlias->(Eof()) )
    
	If oReport:Cancel()  
	    
	    oReport:FatLine()     
	    oReport:PrintText('Cancelado pelo operador!!!',,,CLR_RED,,,.T.)
	    
	    exit
	    
	EndIf
                                                    
	oReport:SetMsgPrint("Imprimindo a linha " + allTrim(Transform(++nCont,'@E 999,999,999,999')) + " de " + cTot)
	oReport:IncMeter()
	
	oRDA:init()
	
	oRDA:Cell('PAM_CODUSR'	):SetValue(UsrFullName(cAlias->(PAM_CODUSR))	)
	oRDA:Cell('PAM_DTVAL'	):SetValue(DtoC(StoD(cAlias->(PAM_DTVAL)))		)
	oRDA:Cell('PAM_HRVAL'	):SetValue(cAlias->(PAM_HRVAL)					)  
	oRDA:Cell('BA1_NOMUSR'	):SetValue(cAlias->(BA1_NOMUSR)					)
	oRDA:Cell('TIPOBENEF'	):SetValue(cAlias->(TIPOBENEF)					)
	
	oRDA:PrintLine()
 	
	oRDA:Finish()
	
	oRDA2:init()   
	
	PAM->(dbGoTo(cAlias->(RECPAM)))
	
	//���������������������������������������������������������������������������������������������������������������������������������������Ŀ
	//�cMemo => NOMECPO_1#ContOrigCpo_1#ContAlteradoCpo1|NOMECPO_2#ContOrigCpo_2#ContAlteradoCpo2|...|NOMECPO_N#ContOrigCpo_N#ContAlteradoCpoN�
	//�����������������������������������������������������������������������������������������������������������������������������������������
	cMemo 	:= MSMM(PAM->PAM_CPOAAL,,,,3,,,"PAM","PAM_CPOAAL")
	
	aTexto 	:= strTokArr(cMemo,"|")
	
	For i := 1 to len(aTexto)
        
        aLinhas := strTokArr(aTexto[i],"#")
		
		If len(aLinhas) == 3                   
		
			cBuffer := allTrim(RetTitle(aLinhas[1])) 
			
			If left(aLinhas[1],2) == 'A1'
			     
				cBuffer += ' Cobr.' 
				
			ElseIf Upper(cBuffer) $ 'ENDERECO|BAIRRO|CEP|NUMERO'
			   	
			   	cBuffer += ' Res.'
			   	 
			EndIf 
			                                                                                                                    
			cBuffer += ' = ORIGINAL (' + allTrim(aLinhas[2]) + ') - ALTERADO PARA (' + allTrim(aLinhas[3]) + ')'
			
			aLinhas := qbTexto(cBuffer,200," ")
		                                
			For j := 1 to len(aLinhas)
			
				oRDA2:Cell('CPO'):SetValue(aLinhas[j])
			
				oRDA2:PrintLine()
				
			Next
			
		EndIf
		
	Next
	
	oRDA2:Finish()

 	cAlias->(dbSkip())

EndDo        

cAlias->(dbCloseArea())

Return   

********************************************************************************************************************************

Static Function FilTRep

Local nI := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

//������������������������������������������������������������������������Ŀ
//�Filtragem do relatorio                                                  �
//��������������������������������������������������������������������������

cQuery += "SELECT DISTINCT PAM_CODUSR,PAM_DTVAL,PAM_HRVAL,BA1_NOMUSR,PAM.R_E_C_N_O_ RECPAM,PAM_RECBTS,PAM_RECSA1,"	+ CRLF
cQuery += "		CASE WHEN PAM_BTSTIT = 0 THEN 'TITULAR' ELSE 'DEPENDENTE' END TIPOBENEF"							+ CRLF
cQuery += "FROM " + RetSqlName('PAM') + " PAM" 							   				  	 						+ CRLF
cQuery += "INNER JOIN " + RetSqlName('BTS') + " BTS ON BTS.D_E_L_E_T_ = ' '" 		   	 							+ CRLF
cQuery += "		AND BTS_FILIAL = '" + xFilial('BTS') + "'" 					 		  	   							+ CRLF
cQuery += "		AND PAM_RECBTS = BTS.R_E_C_N_O_" 									  		  						+ CRLF
cQuery += "INNER JOIN " + RetSqlName('BA1') + " BA1 ON BA1.D_E_L_E_T_ = ' '" 					 					+ CRLF
cQuery += "		AND BA1_FILIAL = '" + xFilial('BA1') + "'"										 					+ CRLF
cQuery += "		AND BA1_MATVID = BTS_MATVID"						   							   					+ CRLF
cQuery += "WHERE PAM.D_E_L_E_T_ = ' '"	 								 						   					+ CRLF
cQuery += "		AND PAM_FILIAL = '" + xFilial('PAM') + "'" 				 				  			  				+ CRLF
cQuery += "		AND PAM_DTVAL BETWEEN '" + DtoS(mv_par01) + "' AND '" + DtoS(mv_par02) + "'"		  				+ CRLF
//cQuery += "		AND PAM_CODUSR BETWEEN '" + mv_par03 + "' AND '" + mv_par04 + "'"					  				+ CRLF
cQuery += "		AND BA1_CODEMP = '" + mv_par05 + "'" 	 												   			+ CRLF
cQuery += "		AND BA1_MATRIC BETWEEN '" + substr(mv_par06,9,6) + "' AND '" + substr(mv_par07,9,6) + "'" 			+ CRLF

If empty(mv_par08)
	cQuery += "		AND BTS_XUSVAL BETWEEN '" + mv_par03 + "' AND '" + mv_par04 + "'"						+ CRLF                                                                                                       
Else 
	aLogins 	:= strTokArr(allTrim(mv_par08),';')
	cLogins 	:= ''
	cLoginsNEnc := ''
	
	For nI := 1 to len(aLogins)  
	
		PswOrder(2)//Ordem por Login

	    If PswSeek(aLogins[nI],.T.)
	    	aGrupos := Pswret(1)
			cLogins += aGrupos[1][1] + ','
	    Else
	    	cLoginsNEnc += ' - ' + aLogins[nI] + ';' + CRLF	
		EndIf
		
	Next  
	
	If !empty(cLoginsNEnc)                         
		cLoginsNEnc := 'Logins n�o encontrados' + CRLF + CRLF + cLoginsNEnc             
		logErros(cLoginsNEnc,'Logins n�o encontrados')
	EndIf
	
	cLogins := left(cLogins,len(cLogins) - 1)
	
	cQuery += "		AND BTS_XUSVAL IN " + FormatIn(cLogins,',') + CRLF                                                                                                       
EndIf

cQuery += "ORDER BY PAM_CODUSR, TIPOBENEF DESC" 																	+ CRLF

TcQuery cQuery New Alias cAlias

cAlias->(dbGoTop())

nCont := 0
cAlias->(dbEval({||++nCont}))

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
aAdd(aHelp, "Informe a operadora do benefici�rio")      
aAdd(aHelp, "(4 primeiros digitos da matricula)")      
PutSX1(cPerg , "05" , "Operadora"  				,"","","mv_ch5","C",TamSx3('BD7_OPEUSR')[1]	,0,0,"G",""	,""			,"","","mv_par05","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

//MATUSR -> consulta especifica
aHelp := {}
aAdd(aHelp, "Informe a matricula inicial do benefici�rio.")
PutSX1(cPerg , "06" , "Matr. usu�rio de" 		,"","","mv_ch6","C",TamSx3('BE4_USUARI')[1]	,0,0,"G",""	,"MATUSR"	,"","","mv_par06","","","","","","","","","","",""	,"","","","","",aHelp,aHelp,aHelp)

//MATUSR -> consulta especifica
aHelp := {}
aAdd(aHelp, "Informe a matricula final do benefici�rio.")
PutSX1(cPerg , "07" , "Matr. usu�rio ate" 		,"","","mv_ch7","C",TamSx3('BE4_USUARI')[1]	,0,0,"G",""	,"MATUSR"	,"","","mv_par07","","","","","","","","","","",""	,"","","","","",aHelp,aHelp,aHelp)

aHelp := {}
aAdd(aHelp, "Informe a lista de logins de usuarios que")
aAdd(aHelp, "se quer filtrar, exemplo: fulano, beltrano")
aAdd(aHelp, "Separe os logins por ','")
PutSX1(cPerg , "08" , "Usuarios" 	 			,"","","mv_ch8","C",99							,0,0,"G",""	,""			,"","","mv_par08","","","","","","","","","","",""	,"","","","","",aHelp,aHelp,aHelp)

RestArea(aArea2)

Return

******************************************************************************************************************************



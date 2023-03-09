#INCLUDE "RWMAKE.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE 'PARMTYPE.CH'

Static cEOL := chr(13) + chr(10)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ CABA085    º Autor ³ Angelo Henrique    º Data ³  10/01/19 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Rotina utilizada para chamar a rotina de importação de     º±±
±±º        o ³ arquivos da EMS e imprimir em relatório a importação.      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function CABA085()
	
	Local _aArea 	:= GetArea()
	Local _nOpc	 	:= 0
		
	Private oFont1	:= Nil
	Private oDlg1	:= Nil
	Private oGrp1	:= Nil
	Private oSay1	:= Nil
	Private oBtn1	:= Nil
	Private oBtn2	:= Nil
	
	/*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
	±± Definicao do Dialog e todos os seus componentes.                        ±±
	Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/
	oFont1     := TFont():New( "MS Sans Serif",0,-16,,.F.,0,,400,.F.,.F.,,,,,, )
	oDlg1      := MSDialog():New( 092,232,258,724,"Integracao Estoque de Faturamento OPME",,,.F.,,,,,,.T.,,,.T. )
	oGrp1      := TGroup():New( 004,004,072,236,"   Processo de Integração Estoque de Faturamento OPME   ",oDlg1,CLR_HBLUE,CLR_WHITE,.T.,.F. )
	oSay1      := TSay():New( 024,016,{||"Favor selecionar uma das opções abaixo para prosseguir:"},oGrp1,,oFont1,.F.,.F.,.F.,.T.,CLR_HBLUE,CLR_WHITE,208,012)
	 				
	oBtn1      := TButton():New( 044,016,"Importar Arquivos",oGrp1,{||u_CABI018()	},052,012,,,,.T.,,"",,,,.F. )
	oBtn2      := TButton():New( 044,084,"Gerar Relatorio"	,oGrp1,{||u_CABA085A()	},060,012,,,,.T.,,"",,,,.F. )
	oBtn3      := TButton():New( 044,156,"Fechar"			,oGrp1,{||oDlg1:End()	},056,012,,,,.T.,,"",,,,.F. )
	
	oDlg1:Activate(,,,.T.)		
	
	RestArea(_aArea)
	
Return


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ CABA085A   º Autor ³ Angelo Henrique    º Data ³  10/01/19 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Rotina responsável por gerar o relatório.                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CABERJ                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function CABA085A
	
	Local _aArea	:= GetArea()
	Local cPerg		:= "RLFATPD" 
	Local cParIpr	:= "1;0;1;Estoque de Faturamento"
	Local _cParams	:= ""
	Local cQry		:= ""
	Local cAliQry	:= GetNextAlias()
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³INICIO Perguntas dos parametros				   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	PutSx1( cPerg,"01","Operadora?"       ,"","","mv_ch1","N",01,0,0,"C","",""   	,"","","mv_par01" ,"1 CABERJ"    ,"1 CABERJ"    ,"1 CABERJ"    ,"","2 INTEGRAL" ,"2 INTEGRAL" ,"2 INTEGRAL"," 3 AMBAS"," 3 AMBAS"," 3 AMBAS" )
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Fim    Perguntas dos parametros				   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	If Pergunte(cPerg,.T.)
		
		//-------------------------------------------------------
		//Pesquisar a data e hora da ultima importação
		//-------------------------------------------------------
		
		cQry := "SELECT                                               	" 	+ CRLF
		cQry += "    (                                                	" 	+ CRLF
		cQry += "        SELECT                                       	" 	+ CRLF
		cQry += "            MAX(DT_IMPOR) DT_IMPORTA                 	" 	+ CRLF
		cQry += "        FROM                                         	" 	+ CRLF
		cQry += "            EMS_IMPORTA                              	" 	+ CRLF
		cQry += "    ) DATA,		                                   	" 	+ CRLF
		cQry += "    (                                                	" 	+ CRLF
		cQry += "        SELECT                                       	" 	+ CRLF
		cQry += "            MAX(HR_IMPOR)                            	" 	+ CRLF
		cQry += "        FROM                                         	" 	+ CRLF
		cQry += "            EMS_IMPORTA                              	" 	+ CRLF
		cQry += "        WHERE                                        	" 	+ CRLF
		cQry += "            DT_IMPOR = (                             	" 	+ CRLF
		cQry += "                            SELECT                   	" 	+ CRLF
		cQry += "                                MAX(INTERNA.DT_IMPOR)	" 	+ CRLF
		cQry += "                            FROM 						" 	+ CRLF
		cQry += "                                EMS_IMPORTA  INTERNA  	" 	+ CRLF
		cQry += "                        )                             	" 	+ CRLF
		cQry += "    ) HORA		                                    	" 	+ CRLF
		cQry += "FROM                                               	" 	+ CRLF
		cQry += "   EMS_IMPORTA                                        	" 	+ CRLF
		cQry += "GROUP BY                                              	" 	+ CRLF
		cQry += "    1,2                                               	" 	+ CRLF
		
		If Select(cAliQry)>0
			(cAliQry)->(DbCloseArea())
		EndIf
		
		DbUseArea(.T.,"TopConn",TcGenQry(,,cQry),cAliQry,.T.,.T.)
		
		DbSelectArea(cAliQry)
		
		If !((cAliQry)->(EOF()))
		
			_cParams:= AllTrim(cValToChar(MV_PAR01)) + ";" + AllTrim((cAliQry)->DATA) + ";" + AllTrim((cAliQry)->HORA) 
		
			CallCrys("RLFATPD",_cParams,cParIpr)
		
		Else
		
			Aviso("Atenção","Nenhuma importação foi realizada.",{"OK"})
			
		EndIf
		
		
		
	EndIf
	
	RestArea(_aArea)
	
Return
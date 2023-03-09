#include "rwmake.ch"
#include "TOPCONN.CH"
/*/
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR018   ºAutor  ³Luzio Tavares       º Data ³02/12/2008   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Lista Familia/Usuarios por Empresa Conforme Selecao nos     º±±
±±º          ³Parametros                                                  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function CABR018()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializa variaveis                                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

PRIVATE cString   := "BA3"
PRIVATE cDesc1    := "Listagem de Familia/Usuario por Empresa"
PRIVATE cDesc2    := ""
PRIVATE cDesc3    := ""
PRIVATE limite    := 132
PRIVATE tamanho   := "G"
PRIVATE aReturn   := { "Zebrado", 1,"Administracao", 1, 2, 1, "",1 }
PRIVATE nomeprog  := "CABR018"
PRIVATE aLinha    := {}     
private adados    := {}
PRIVATE nLastKey  := 0
PRIVATE Titulo    := "Listagem de Familia/Usuario por Empresa"
PRIVATE Cabec1    := "Cod. Operadora      Grupo/Empresa                                               Cod. Contrato            Cod. Sub-Contrato"  
PRIVATE Cabec2    := "Cod. Familia        Nome Usuario                        Tp. Dep     Sexo       Est.Civil       CPD Usuario     Dt.Incl.   Dt. Nasc.  Idade  Dt. Bloq.  Dt. Limite  Operadora Dest.  Funcional"
PRIVATE aCabec2   := {"Cod. Familia","Nome Usuario","Tp. Dep","Sexo","Est.Civil","CPD Usuario","Dt.Incl.","Dt. Nasc.","Idade" , "Dt. Bloq.","Dt. Limite","Operadora Dest.","Funcional"}
PRIVATE cCancel   := "***** CANCELADO PELO OPERADOR *****"                                                                                                 
PRIVATE m_pag     := 1  // numero da pagina
PRIVATE cPerg     := "CABR18"
PRIVATE pag       := 1
PRIVATE li        := 80
PRIVATE wnRel     := "CABR018"
PRIVATE lAbortPrint := .F.
PRIVATE cMatAnD
PRIVATE cMatAnA

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Exibe janela padrao de relatorios                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
CriaSX1()
wnRel := SetPrint(cString,wnrel,cPerg,titulo,cDesc1,cDesc2,cDesc3,.F.,"",,tamanho)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Atualiza Parametros com Pergunte CABR018                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Pergunte("CABR18",.F.)

dDatBas    := mv_par11
cMatAnD	   := mv_par12
cMatAnA    := mv_par13

If  nLastKey == 27
	Set Filter To
	Return
Endif

SetDefault(aReturn,cString)

MsAguarde({|| CABR018IMP() }, "Listagem de Familia/Usuario", "", .T.)

If  nLastKey == 27
	Set Filter To
	Return
Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Libera spool de impressao                                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Roda(0,"","M")

Set Filter To

If  aReturn[5] == 1
	Set Printer To
	Commit
	ourspool(wnrel)    // Chamada do Spool de Impressao
Endif

MS_FLUSH()             // Libera fila de relatorios em spool

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³CABR018IMP ³ Autor ³                       ³ Data ³         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³Prepara Relatorio para Ser Impresso                         ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CABR018IMP()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializa Variaveis                                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

LOCAL aTotEmp := 0
LOCAL aTotUsr := 0
LOCAL aEmpr   := 0
LOCAL aQtdFam := 0
LOCAL aQtdUsr := 0
LOCAL dDatBas := mv_par11
Local lImpEmp := .T.

MsProcTxt("Processado Arquivos de Familia ...")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Executa Query no Arquivo BA3(CADASTRO DE FAMILIA)                                   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

aQuery := " SELECT BA3_CODINT, BA3_CODEMP, BA3_CONEMP, BA3_VERCON, BA3_SUBCON, BA3_VERSUB, BA3_MATRIC, BA3_TIPCON, BA3_MOTBLO, BA3_MATANT, BA3_MATEMP "
aQuery += " FROM " +RetSqlName("BA3")
aQuery += " WHERE "
aQuery += " BA3_CODINT =  '"+mv_par01+"' AND "
aQuery += " BA3_CODEMP BETWEEN '"+mv_par02+"' AND '"+mv_par03+"' AND "
aQuery += " BA3_CONEMP BETWEEN '"+mv_par04+"' AND '"+mv_par05+"' AND "
aQuery += " BA3_SUBCON BETWEEN '"+mv_par06+"' AND '"+mv_par07+"' AND "
aQuery += " BA3_MATRIC BETWEEN '"+mv_par08+"' AND '"+mv_par09+"' AND "
aQuery += "	BA3_DATBAS <='"+DTOS(dDatBas)+"' AND "

If !Empty(cMatAnA)
	aQuery += " BA3_MATANT BETWEEN '"+cMatAnD+"' AND '"+cMatAnA+"' AND "
Endif

aQuery += " D_E_L_E_T_ = '' "

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Seleciona Registros de Familia Bloqueados ou Nao Conforme Pergunte                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If mv_par10 = 2   // BLOQUEADOS
	
	aQuery += "AND (BA3_DATBLO <> '   ' AND BA3_DATBLO <='"+DTOS(dDatBas)+"') "
	
Elseif mv_par10 = 3 //ATIVOS
	
	aQuery += "AND (BA3_DATBLO = '   ' OR BA3_DATBLO >'"+DTOS(dDatBas)+"') "
	
Endif

If ! Empty(aReturn[7])
	aQuery += " AND " + ParSQL(Upper(aReturn[7]))
Endif

//BIANCHINI - Ordenar Funcionais do Estaleiro por funcional
If (cEmpAnt =='02') .and. (mv_par02 $ GetMv("MV_CARCOFU"))
	aQuery += " ORDER BY BA3_CONEMP, BA3_SUBCON, BA3_CODEMP, BA3_MATEMP"
Else
	aQuery += " ORDER BY BA3_CONEMP, BA3_SUBCON, BA3_CODEMP, BA3_MATRIC"
Endif

PLSQuery(aQuery,"QRA")

DbSelectArea("QRA")

While ! QRA->(EOF())
	
	aCdEmpr  := QRA->BA3_CODEMP
	
	While ! QRA->(EOF()) .and. aCdEmpr == QRA->BA3_CODEMP
		aCdCont := QRA->BA3_CONEMP
		
		While ! QRA->(EOF()) .and. aCdEmpr == QRA->BA3_CODEMP .and. aCdCont == QRA->BA3_CONEMP
			aCdSubCo := QRA->BA3_SUBCON
			
			lImpEmp := .T.
			
			While ! QRA->(EOF()) .and. aCdEmpr == QRA->BA3_CODEMP .and. aCdCont == QRA->BA3_CONEMP .and. aCdSubCo == QRA->BA3_SUBCON
				
				If Interrupcao(lAbortPrint)
					li++
					@ li,000 pSay "ABORTADO PELO USUARIO"
					Exit
				Endif
				
				MsProcTXT("Imprimindo Usuarios da Familia.: "+QRA->BA3_CODINT+"."+QRA->BA3_CODEMP+"."+QRA->BA3_MATRIC)
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Executa Query no Arquivo BA1(CADASTRO DE USUARIOS)                                  ³
				//³Pesquisa BA1(Usuarios) De Acordo Com os Registros Selecionados no BA3(Familia)      ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				
				cSQL := " SELECT BA1_CODINT, BA1_CODEMP, BA1_MATRIC, BA1_CONEMP, BA1_SUBCON,"
				cSQL += " BA1_TIPREG, BA1_DIGITO, BA1_NOMUSR, BA1_TIPUSU, BA1_SEXO, BA1_ESTCIV,"
				cSQL += " BA1_CPFUSR, BA1_DATBLO, BA1_MOTBLO,BA1_NUMCON, BA1_MOTBLO, "
				cSQL += " BA1_DATINC, BA1_DATNAS, BA1_MATANT, BA1_YDTLIM, BA1_OPEDES "
				cSQL += " FROM "+RetSqlName("BA1")
				cSQL += " WHERE"
				cSQL += " BA1_CODINT = '"+QRA->BA3_CODINT+"' AND "
				cSQL += " BA1_CONEMP = '"+QRA->BA3_CONEMP+"' AND "
				cSQL += " BA1_SUBCON = '"+QRA->BA3_SUBCON+"' AND "
				cSQL += " BA1_CODEMP = '"+QRA->BA3_CODEMP+"' AND "
				cSQL += " BA1_MATRIC = '"+QRA->BA3_MATRIC+"' AND "
				
				cSQL += " BA1_DATINC <= '"+DTOS(dDatBas)+"' AND "
				
				cSQL += " D_E_L_E_T_ = ''"
				
				If mv_par10 = 2  //BLOQUEADOS
					
					cSQL += "AND (BA1_DATBLO <> '        ' AND BA1_DATBLO <='"+DTOS(dDatBas)+"') "
					
				ElseIf mv_par10 = 3  //ATIVOS
					
					cSQL += "AND (BA1_DATBLO = '        ' OR BA1_DATBLO >'"+DTOS(dDatBas)+"') "
					
				ElseIf mv_par10 = 4  //COM DATA LIMITE
					
					cSQL += "AND (BA1_DATBLO = '        ' ) "
					cSQL += "AND (BA1_YDTLIM >= '"+DTOS(dDatBas)+"') "
					
				Endif
				
				cSQL += " ORDER BY BA1_CONEMP, BA1_SUBCON, BA1_CODEMP, BA1_MATRIC, BA1_TIPREG "
				
				PLSQuery(cSQL,"QRB")
				
				DbSelectArea("QRB")
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Verifica se a Query Esta Vazia ou Nao                                               ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				
				aQtdFam := aQtdFam + 1
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Imprimi os Usuarios Relacionados de Acordo Com a Familia                            ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				While ! QRB->(EOF())
					
					If li >= 58
						li := cabec(titulo,cabec1,cabec2,nomeprog,tamanho,GetMv("MV_COMP"))
						li++
					EndIf
					
					If lImpEmp
						aEmpr := Substr(Posicione("BG9",1,xFilial("BG9")+QRA->BA3_CODINT+QRA->BA3_CODEMP,"BG9_DESCRI"),1,28)//+QRA->BA3_TIPCON,"BG9_DESCRI"),1,28)
						          
						li++
						@ li,000 Psay "Operadora.:"
						@ li,012 Psay QRA->BA3_CODINT
						@ li,021 Psay "Grupo/Empresa.:"
						@ li,038 Psay QRA->BA3_CODEMP
						@ li,045 Psay aEmpr
						@ li,081 Psay "Contrato.:"
						@ li,092 Psay QRA->BA3_CONEMP
						@ li,106 Psay "Sub-Contrato.:"
						@ li,121 Psay QRA->BA3_SUBCON  
				    	//BIANCHINI
				    	dbselectarea("BQC")
					    BQC->(dbSetOrder(1))
		//			    dbseek(xFilial("BQC")+PLSINTPAD()     +QRA->(BA3_CODEMP+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB))  
		   	  //        BQC->(DbSeek(xFilial("BQC")+BA3->(BA3_CODINT+BA3_CODEMP      +BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB)))
                       // MBC BQC->(DbSeek(xFilial("BQC")+PLSINTPAD()     +QRA->(BA3_CODEMP+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB)))
                       BQC->(DbSeek(xFilial("BQC")+QRA->(BA3_CODINT+BA3_CODEMP+BA3_CONEMP+BA3_VERCON+BA3_SUBCON+BA3_VERSUB)))

					   cDESCRI := BQC->BQC_DESCRI
					    @ li,135 Psay "Descricao:"
						@ li,147 Psay cDESCRI
						BQC->(DbCloseArea()) 
					                                  
						li := li + 2
						lImpEmp := .f.  
						
						
						 Aadd(adados,{ "Operadora.:"+QRA->BA3_CODINT , ; 
			             "Grupo/Empresa.:"+ QRA->BA3_CODEMP + aEmpr , ;   
			             "Contrato.:"+ QRA->BA3_CONEMP, ;                
			             "Sub-Contrato.:"+ QRA->BA3_SUBCON  , ;  
						 "Descricao:" + cDESCRI,;
			             " ", ;       
			             " ", ;          
			             " ", ;      
			             " ", ; //QRB->BA1_DATINC, ; 
	   			         " ", ; //QRB->BA1_DATNAS,;	 
				         0,; // Transform(Calc_Idade(dDataBase, QRB->BA1_DATNAS),X3Picture("BA1_IDADE",Calc_Idade(dDataBase, QRB->BA1_DATNAS))),; 
				         " ", ; //QRB->BA1_DATBLO ,; 
				         " ", ; //QRB->BA1_YDTLIM  ,; 
				         " ", ; //QRB->BA1_OPEDES  ,;
				         " " }) //QRA->BA3_MATEMP }) 	
						
					EndIf
					
					@ li,000 Psay QRB->BA1_CODINT+"."+QRB->BA1_CODEMP+"."+QRB->BA1_MATRIC+"."
					@ li,017 Psay QRB->BA1_TIPREG+"-"+QRB->BA1_DIGITO
					@ li,022 Psay IIf(Alltrim(QRB->BA1_MOTBLO)<>"","*"," ")
					@ li,024 Psay Substr(QRB->BA1_NOMUSR,1,30)
					@ li,056 Psay Substr(Posicione("BIH",1,xFilial("BIH")+QRB->BA1_TIPUSU,"BIH_DESCRI"),1,10)
					@ li,068 Psay X3Combo("BA1_SEXO",QRB->BA1_SEXO)
					@ li,079 Psay Substr(Posicione("SX5",1,xFilial("SX5")+"33"+QRB->BA1_ESTCIV,"X5_DESCRI"),1,15)
					@ li,095 Psay QRB->BA1_CPFUSR Picture X3Picture("BA1_CPFUSR",QRB->BA1_CPFUSR)
					@ li,111 Psay QRB->BA1_DATINC
					@ li,122 Psay QRB->BA1_DATNAS
					@ li,132 Psay Calc_Idade(dDataBase, QRB->BA1_DATNAS) Picture X3Picture("BA1_IDADE",Calc_Idade(dDataBase, QRB->BA1_DATNAS))
					@ li,139 Psay QRB->BA1_DATBLO
					@ li,150 Psay QRB->BA1_YDTLIM
					@ li,170 Psay QRB->BA1_OPEDES
					//BIANCHINI - Ordenar Funcionais do Estaleiro por funcional
					If (cEmpAnt =='02') .and. (mv_par02 $ GetMv("MV_CARCOFU"))
						@ li,182 Psay QRA->BA3_MATEMP					
					Endif

					li++                            
					 //IIf(Alltrim(QRB->BA1_MOTBLO)<>"","*"," ")      , ; ///segunda dimensao removida de aDados
					 
					 Aadd(adados,{ QRB->BA1_CODINT+"."+QRB->BA1_CODEMP+"."+QRB->BA1_MATRIC+"."+QRB->BA1_TIPREG+"-"+QRB->BA1_DIGITO , ;   
	                 Substr(QRB->BA1_NOMUSR,1,30), ; 
		             Substr(Posicione("BIH",1,xFilial("BIH")+QRB->BA1_TIPUSU,"BIH_DESCRI"),1,10) , ;  
		             X3Combo("BA1_SEXO",QRB->BA1_SEXO), ;       
		             Substr(Posicione("SX5",1,xFilial("SX5")+"33"+QRB->BA1_ESTCIV,"X5_DESCRI"),1,15), ;          
		             Transform(QRB->BA1_CPFUSR, X3Picture("BA1_CPFUSR",QRB->BA1_CPFUSR)), ;      
		             QRB->BA1_DATINC, ; 
   			         QRB->BA1_DATNAS,;	 
			         Transform(Calc_Idade(dDataBase, QRB->BA1_DATNAS),X3Picture("BA1_IDADE",Calc_Idade(dDataBase, QRB->BA1_DATNAS))),; 
			         QRB->BA1_DATBLO ,; 
			        QRB->BA1_YDTLIM  ,; 
			        QRB->BA1_OPEDES  ,;
			        QRA->BA3_MATEMP })    
					
					QRB->(DbSkip())
					aTotUsr := aTotUsr + 1
					aQtdUsr := aQtdUsr + 1
				Enddo
				QRB->(DbCloseArea())
				QRA->(DbSkip())
			EndDo
		EndDo
	Enddo
	If aQtdUsr > 0
		@ li,000 Psay Replicate("-",132)
		++li
		@ li,003 Psay "Total da Empresa.:"
		@ li,022 Psay aCdEmpr
		@ li,028 Psay aEmpr
		@ li,082 Psay "Qtd. Familias.:"
		@ li,098 Psay aQtdFam
		@ li,108 Psay "Qtd. Usuarios.:"
		@ li,124 Psay aQtdUsr
		++li
		@ li,000 Psay Replicate("-",132)
		li := li+2
		aQtdFam := 0
		aQtdUsr := 0
		aTotEmp := aTotEmp + 1
	Endif
	                                       
Enddo

@ li,049 Psay "--------- TOTAIS DO RELATORIO -----------"
++li
@ li,052 Psay "Numero de Empresas Impressas.:"
@ li,083 Psay aTotEmp
++li
@ li,052 Psay "Numero de Usuarios Impressos.:"
@ li,083 Psay aTotUsr
++li
@ li,049 Psay "-----------------------------------------"

QRA->(DbCloseArea())                       

If mv_par12 == 1
   DlgToExcel({{"ARRAY","Gravações da Filial" ,aCabec2 ,adados}})      
EndIf
Return

Static Function ParSQL(cFilADV)

cFilADV := StrTran(cFilADV,".AND."," AND ")
cFilADV := StrTran(cFilADV,".OR."," OR ")
cFilADV := StrTran(cFilADV,"=="," = ")
cFilADV := StrTran(cFilADV,'"',"'")
cFilADV := StrTran(cFilADV,'$'," IN ")
cFilADV := StrTran(cFilADV,"ALLTRIM","  ")

Return(cFilADV)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CRIASX1   ºAutor  ³ Luzio Tavares      º Data ³ 02/12/2008  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Altera Pergunta caso o tamanho da pergunta de contrato sejaº±±
±±º          ³ menor que 12                                               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function CriaSX1()

Local aRegs	:=	{}
SX1->(DbSetOrder(1))
If SX1->(DbSeek(Padr(cPerg,Len(SX1->X1_GRUPO))+"06"))
	If SX1->X1_TAMANHO = 11
		SX1->(DbSeek(cPerg))
		While Alltrim(SX1->X1_GRUPO) == cPerg
			RecLock("SX1",.F.)
			SX1->(DbDelete())
			SX1->(MsUnlock())
			SX1->(DbSkip())
		End
	EndIf
EndIf

aadd(aRegs,{cPerg,"01","Operadora De ?                ","¿De operadora ?               ","From operator ?               ","mv_ch1","C",04,0,0,"G","","mv_par01",""     ,""     ,""   ,"","",""          ,""          ,""       ,"","",""              ,""            ,""           ,"","","","","","","","","","","",IIf(PlsGetVersa() >= 8, "B89PLS", "B89"),"N","","","",""})
aadd(aRegs,{cPerg,"02","Empresa De ?                  ","¿De empresa ?                 ","From company ?                ","mv_ch2","C",04,0,0,"G","","mv_par02",""     ,""     ,""   ,"","",""          ,""          ,""       ,"","",""              ,""            ,""           ,"","","","","","","","","","","",IIf(PlsGetVersa() >= 8, "B7APLS", "B7A"),"N","","","",""})
aadd(aRegs,{cPerg,"03","Empresa Ate ?                 ","¿A empresa ?                  ","To company ?                  ","mv_ch3","C",04,0,0,"G","","mv_par03",""     ,""     ,""   ,"","",""          ,""          ,""       ,"","",""              ,""            ,""           ,"","","","","","","","","","","",IIf(PlsGetVersa() >= 8, "B7APLS", "B7A"),"N","","","",""})
aadd(aRegs,{cPerg,"04","Contrato De ?                 ","¿De contrato ?                ","From contract ?               ","mv_ch4","C",12,0,0,"G","","mv_par04",""     ,""     ,""   ,"","",""          ,""          ,""       ,"","",""              ,""            ,""           ,"","","","","","","","","","","",IIf(PlsGetVersa() >= 8, "B7BPLS", "B7B"),"N","","","",""})
aadd(aRegs,{cPerg,"05","Contrato Ate ?                ","¿A contrato ?                 ","To contract ?                 ","mv_ch5","C",12,0,0,"G","","mv_par05",""     ,""     ,""   ,"","",""          ,""          ,""       ,"","",""              ,""            ,""           ,"","","","","","","","","","","",IIf(PlsGetVersa() >= 8, "B7BPLS", "B7B"),"N","","","",""})
aadd(aRegs,{cPerg,"06","Sub-Contrato De ?             ","¿De sub contrato ?            ","From sub-contract ?           ","mv_ch6","C",09,0,0,"G","","mv_par06",""     ,""     ,""   ,"","",""          ,""          ,""       ,"","",""              ,""            ,""           ,"","","","","","","","","","","",IIf(PlsGetVersa() >= 8, "B7CPLS", "B7C"),"N","","","",""})
aadd(aRegs,{cPerg,"07","Sub-Contrato Ate ?            ","¿A sub contrato ?             ","To sub-contract ?             ","mv_ch7","C",09,0,0,"G","","mv_par07",""     ,""     ,""   ,"","",""          ,""          ,""       ,"","",""              ,""            ,""           ,"","","","","","","","","","","",IIf(PlsGetVersa() >= 8, "B7CPLS", "B7C"),"N","","","",""})
aadd(aRegs,{cPerg,"08","Familia De ?                  ","¿De familia ?                 ","From family ?                 ","mv_ch8","C",06,0,0,"G","","mv_par08",""     ,""     ,""   ,"","",""          ,""          ,""       ,"","",""              ,""            ,""           ,"","","","","","","","","","","",""                                      ,"N","","","",""})
aadd(aRegs,{cPerg,"09","Familia Ate ?                 ","¿A familia ?                  ","To family ?                   ","mv_ch9","C",06,0,0,"G","","mv_par09",""     ,""     ,""   ,"","",""          ,""          ,""       ,"","",""              ,""            ,""           ,"","","","","","","","","","","",""                                      ,"N","","","",""})
aadd(aRegs,{cPerg,"10","Imprimi Somente Fam ?         ","¿Imprimir solo familia ?      ","Print family only ?           ","mv_ch0","C",01,0,1,"C","","mv_par10","Todos","Todos","All","","","Bloqueados","Bloqueados","Blocked","","","Nao bloqueados","Sin bloquear","Not blocked","","","Data Limite","","","","","","","","",""                                      ,"N","","","",""})
aadd(aRegs,{cPerg,"11","Data Referencia ?             ","¿Fecha de referencia ?        ","Reference date ?              ","mv_cha","D",08,0,0,"G","","mv_par11",""     ,""     ,""   ,"","",""          ,""          ,""       ,"","",""              ,""            ,""           ,"","","","","","","","","","","",""                                      ,"N","","","",""})    
aadd(aRegs,{cPerg,"12","Gerar Excel      ?            ",""                              ,""                              ,"mv_chb","N",01,0,1,"C","","mv_par12","Sim"  ,"Si"   ,"Yes","","","Nao"       ,"No"        ,"No"     ,"","",""              ,""            ,""           ,"","","","","","","","","","","",""                                       ,"N","","","",""})
//aadd(aRegs,{cPerg,"12","Matr. Antiga de ?             ","¿De matric.antigua ?          ","To registration ?             ","mv_chc","C",17,0,0,"G","","mv_par12",""     ,""     ,""   ,"","",""          ,""          ,""       ,"","",""              ,""            ,""           ,"","","","","","","","","","","",""                                       ,"N","","","",""})
//aadd(aRegs,{cPerg,"13","Matr. Antiga ate ?            ","¿A matric.antigua ?           ","From old registration ?       ","mv_chd","C",17,0,0,"G","","mv_par13",""     ,""     ,""   ,"","",""          ,""          ,""       ,"","",""              ,""            ,""           ,"","","","","","","","","","","",""                                       ,"N","","","",""})
//aadd(aRegs,{cPerg,"14","Imp. Matr. Antiga?            ",""                              ,""                              ,"mv_che","N",01,0,1,"C","","mv_par14","Sim"  ,"Si"   ,"Yes","","","Nao"       ,"No"        ,"No"     ,"","",""              ,""            ,""           ,"","","","","","","","","","","",""                                       ,"N","","","",""})

PlsVldPerg( aRegs )

Return

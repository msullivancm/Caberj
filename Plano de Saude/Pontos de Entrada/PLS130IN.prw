#INCLUDE "RWMAKE.CH"
#include "PLSMGER.CH"
#include "COLORS.CH"
#include "TOPCONN.CH"
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PLS130IN  ºAutor  ³Microsiga           º Data ³  24/11/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Ponto de entrada para manipular o calculo de totais de      º±±
±±º          ³acordo com regras Caberj.                                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ MP8                                                        º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function PLS130IN()

Local cOper		:= paramixb[1]
Local cEmpIni	:= paramixb[2]
Local cEmpFim	:= paramixb[3]
Local cMatIni	:= paramixb[4]
Local cMatFim	:= paramixb[5]
Local dDatIni	:= paramixb[6]
Local dDatFim	:= paramixb[7]
Local cGruBen	:= paramixb[8]

Local nHorIni   := Seconds()
Local nCir := 0
Local nCli := 0
Local nObs := 0
Local nPed := 0
Local nPsi := 0
Local lGerLog   := If(file("PLSSIP.LOG"),.T.,.F.)
Local aRecInt	:= {}
Local nPosInt	:= {}
Local nQtd		:= {}
Local nP130vlr	:= 1

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Totaliza valores por procedimento - Ambulatorial                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nHorIni := Seconds()
If lGerLog
	PlsLogFil(Space(03)+"-> Hora ["+Time()+"] processo inicio ["+AllTrim(Str(Seconds()-nHorIni,10,3))+"] Segundo(s)","LOGPE.SIP")
Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Totaliza quantidades                                                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	cFiltro := "SELECT BE4.R_E_C_N_O_ RECBE4, COUNT(BE4_CODOPE+BE4_CODLDP+BE4_CODPEG+BE4_NUMERO) QTD "
	cFiltro += "FROM " + RetSqlName("BD6") + " BD6  INNER JOIN  "+ RetSqlName("BD7") + " BD7 ON " 
	cFiltro += "BD7_FILIAL = '" + xFilial("BD7") + "' "
	cFiltro += "AND  BD7_CODOPE = BD6_CODOPE "
	cFiltro += "AND  BD7_CODLDP = BD6_CODLDP "
	cFiltro += "AND  BD7_CODPEG = BD6_CODPEG "
	cFiltro += "AND  BD7_NUMERO = BD6_NUMERO "
	cFiltro += "AND  BD7_SEQUEN = BD6_SEQUEN "
	cFiltro += "AND BD7.D_E_L_E_T_ = ' ' INNER JOIN "+ RetSQLName("BE4") + " BE4 ON 
	cFiltro += " BE4_FILIAL = '" + xFilial("BE4") + "' "
	cFiltro += "AND  BE4_CODOPE = BD6_CODOPE "
	cFiltro += "AND  BE4_CODLDP = BD6_CODLDP "
	cFiltro += "AND  BE4_CODPEG = BD6_CODPEG "
	cFiltro += "AND  BE4_NUMERO = BD6_NUMERO AND"
	//Filtro para tratar se as guias interassam ao SIP 1=Sim;0=Nao
	IF BE4->(FieldPos("BE4_GUIAIN")) > 0
		cFiltro += " BE4_GUIAIN <> '0' AND "	
	Endif
    cFiltro += " BE4.D_E_L_E_T_ = ' ' INNER JOIN " + RetSQLName("BA3") + " BA3 ON " 
    cFiltro += " BA3_FILIAL = '" + xFilial("BA3") + "' "
	cFiltro += "AND  BA3_CODINT = BD6_OPEUSR "
	cFiltro += "AND  BA3_CODEMP = BD6_CODEMP "
	cFiltro += "AND  BA3_MATRIC = BD6_MATRIC "
	cFiltro += "AND BA3.D_E_L_E_T_ = ' ' INNER JOIN "+ RetSQLName("BA1") + " BA1  ON "
	cFiltro += "BA1_FILIAL = '" + xFilial("BA1") + "' "
	cFiltro += "AND  BA1_CODINT = BD6_OPEUSR "
	cFiltro += "AND  BA1_CODEMP = BD6_CODEMP "
	cFiltro += "AND  BA1_MATRIC = BD6_MATRIC "
	cFiltro += "AND  BA1_TIPREG = BD6_TIPREG "
	cFiltro += "AND  BA1_DIGITO = BD6_DIGITO "		
	cFiltro += "AND  BA1.D_E_L_E_T_ = ' ' "
	cFiltro += " WHERE BD6_FILIAL = '" + xFilial("BD6") + "' "
	cFiltro += "AND  BD6_OPEUSR =  '" + cOper   + "' "
	If ! empty(cEmpIntS)
		cFiltro += "AND BD6_CODEMP NOT IN (" + cEmpIntS + ") "	
	Endif
	cFiltro += "AND  BD6_CODEMP >= '" + cEmpIni + "' "
	cFiltro += "AND  BD6_MATRIC >= '" + cMatIni + "' "
	cFiltro += "AND  BD6_CODEMP <= '" + cEmpFim + "' "
	cFiltro += "AND  BD6_MATRIC <= '" + cMatFim + "' "
	cFiltro += " AND BD6_FASE IN ("+cFase+") "
	cFiltro += " AND BD6_SITUAC IN ("+cSituac+") AND "
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Desconsidera guias estornadas										 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If FindFunction("PlReChvEst")
		aRetAux  := PlReChvEst("BD6",.T.,.F.,.T.,.F.,.F.,.F.)
		cFiltro  += aRetAux[1]
	Endif
	//Ponto de entrada para mudanca no filtro do programa de contabilizacao de guias
   	If  ExistBlock("PLS130CG")
       cFiltro += ExecBlock("PLS130CG",.F.,.F.)
   	Else
		cFiltro += " (BD6_ANOPAG > '" + cAnoIni + "' OR ( BD6_ANOPAG = '" + cAnoIni + "' AND BD6_MESPAG  >= '" + cMesIni + "' )) AND "
		cFiltro += " (BD6_ANOPAG < '" + cAnoFim + "' OR ( BD6_ANOPAG = '" + cAnoFim + "' AND BD6_MESPAG  <= '" + cMesFim + "' )) "
   	Endif
	cFiltro += "AND  BD6.D_E_L_E_T_ = ' ' AND"
	cFiltro1 :=" "
	cFiltro2 :=" "
	
	If ExistBlock("PL130BEN")
		cFiltro2 += ExecBlock("PL130BEN",.F.,.F.,{cGruBen,cOper,"V"})
	Else
		Do Case
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Beneficiarios expostos                                                   ³
			//³ Beneficiarios da operadora que esta enviando as informacoes e tem o      ³
			//³ servico fornecido majoriatariamente pela mesma                           ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			Case cGruBen == "1" // Beneficiarios expostos
				cFiltro2 += " (BA1_OPEORI = '" + cOper + "' AND BA1_OPEDES = '" + cOper + "') AND "
				cFiltro2 += "BA1_INFANS <> '0' "
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Expostos nao beneficiarios                                               ³
				//³ Beneficiarios de outra operadora mas que tem o servico fornecido         ³
				//³ majoritariamente pela operadora que esta enviando as informacoes         ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			Case cGruBen == "2" // Expostos nao beneficiarios
				cFiltro2 += " (BA1_OPEORI <> '" + cOper + "' AND BA1_OPEDES = '" + cOper + "') "
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Beneficiarios nao expostos                                               ³
				//³ Beneficiarios da operadora que esta enviando as informacoes que tem o    ³
				//³ servico fornecido majoriatariamente por outra operadora                  ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			Case cGruBen == "3" // Beneficiarios nao expostos
				cFiltro2 += " (BA1_OPEORI = '" + cOper + "' AND BA1_OPEDES <> '" + cOper + "') AND "
				cFiltro2 += "BA1_INFANS <> '0' "
		EndCase
	EndIf
	cFiltro3 := "GROUP BY BE4.R_E_C_N_O_"
		
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Executa query                                                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

	PLSQuery(cFiltro + cFiltro1 + cFiltro2 + cFiltro3,"BE4QRY")
	If lGerarLog
		PlsLogFil(Space(03)+"-> Hora ["+Time()+"] qry BE4 4505 " + cFiltro + cFiltro1 + cFiltro2 + cFiltro3,"LOGQRY.SIP")
	Endif
	
	While ! BE4QRY->(eof())
		
		BE4->(DbGoTo(BE4QRY->RECBE4))
		nPosInt := Ascan(aRecInt,{|x| x[1] = BE4->(BE4_CODOPE+BE4_CODLDP+BE4_CODPEG+BE4_NUMERO)})
		
		If ValType('aI130vlr') = 'A'
			nP130vlr := Ascan(aI130vlr,{|x| x[1] = BE4->(BE4_CODOPE+BE4_CODLDP+BE4_CODPEG+BE4_NUMERO)})
		EndIf
		
		If nPosInt = 0 .and. nP130vlr > 0
			aadd(aRecInt,{BE4->(BE4_CODOPE+BE4_CODLDP+BE4_CODPEG+BE4_NUMERO)})
			nQtd:= 1
		Else
			nQtd:= 0	
		EndIf
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Salva valores                                              ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	   	//ROTINA CABERJ
	   	Do Case
	   	  //CLINICA
	      Case BE4->BE4_GRPINT == "1" .and. BE4->BE4_TIPINT $ "01,04" // CLINICA (Caberj: ADULTO/UTI ADULTO)
	           nCli += nQtd   	
	      Case BE4->BE4_GRPINT == "1" .and. BE4->BE4_TIPINT == "03" // PSIQUIATRICA (Caberj: PSIQUIATRICA)
	           nPsi += nQtd         
	      Case BE4->BE4_GRPINT == "1" .and. BE4->BE4_TIPINT $ "02,05,06" // PEDIATRICA (Caberj: PEDIATRICA/UTI NEONATAL/UTI PEDIATRICA
	           nPed += nQtd	           
	      //CIRURGICA
	      Case BE4->BE4_GRPINT == "2" .and. BE4->BE4_TIPINT $ "07,09" // // CIRURGICA (Caberj: ADULTO/UTI ADULTO)
	           nCir += nQtd
	      Case BE4->BE4_GRPINT == "2" .and. BE4->BE4_TIPINT == "13" // // OBSTETRICA (Caberj: OBSTETRICA)
	           nObs += nQtd                                                        
	      Case BE4->BE4_GRPINT == "2" .and. BE4->BE4_TIPINT $ "08,10,11" // PEDIATRICA (Caberj: PEDIATRICA/UTI NEONATAL/UTI PEDIATRICA)
	           nPed += nQtd	           
	   	EndCase        	   		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Acessa proximo registro                                    ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		BE4QRY->(DbSkip())
	Enddo

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Fecha area de trabalho                                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BE4QRY->(DbCloseArea())

If lGerLog
	PlsLogFil(Space(03)+"-> Hora ["+Time()+"] processo fim ["+AllTrim(Str(Seconds()-nHorIni,10,3))+"] Segundo(s)","LOGPE.SIP")
Endif

Return({nCir,nCli,nObs,nPed,nPsi})
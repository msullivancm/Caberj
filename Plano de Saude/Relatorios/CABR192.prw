#INCLUDE "REPORT.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR192     บAutor  ณAngelo Henrique   บ Data ณ  17/08/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRelat๓rio responsแvel por exibir os beneficiแrios bloqueadosบฑฑ
ฑฑบ          ณpor empresas.                                               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function CABR192()

	Local _aArea 		:= GetArea()
	Local oReport		:= Nil

	Private _cPerg	:= "CABR192"

	//Cria grupo de perguntas
	CABR192C(_cPerg)

	If Pergunte(_cPerg,.T.)

		oReport := CABR192A()
		oReport:PrintDialog()

	EndIf

	RestArea(_aArea)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR192A  บAutor  ณAngelo Henrique     บ Data ณ  17/08/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina que irแ gerar as informa็๕es do relat๓rio            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CABR192A

	Local oReport		:= Nil
	Local oSection1 	:= Nil
	Local oSection2	:= Nil
	Local oSection3	:= Nil
	Local oSection4	:= Nil

	oReport := TReport():New("CABR192","Usuแrio p/ Empresas Bloqueados",_cPerg,{|oReport| CABR192B(oReport)},"Usuแrio p/ Empresas Bloqueados")

	oReport:SetLandScape()

	oReport:oPage:setPaperSize(12)

	//--------------------------------
	//Primeira linha do relat๓rio
	//--------------------------------
	oSection1 := TRSection():New(oReport,"Contrato/Sub-Contrato","BA3")

	TRCell():New(oSection1,"BA3_CODINT" 	,"BA3")
	TRCell():New(oSection1,"BA3_CODEMP" 	,"BA3")
	TRCell():New(oSection1,"BA3_CONEMP" 	,"BA3")
	TRCell():New(oSection1,"BA3_SUBCON" 	,"BA3")

	//--------------------------------
	//Segunda linha do relat๓rio
	//--------------------------------
	oSection2 := TRSection():New(oSection1,"","BA3,BA1,BCA")

	TRCell():New(oSection2,"MATRICULA" 	,"BA1",,,,,,,,,,,,,,,,,,,,)
	oSection2:Cell("MATRICULA"):SetAutoSize(.F.)
	oSection2:Cell("MATRICULA"):SetSize(20)

	TRCell():New(oSection2,"NOMUSR" 		,"BA1",,,,,,,,,,,,,,,,,,,,)
	oSection2:Cell("NOMUSR"):SetAutoSize(.F.)
	oSection2:Cell("NOMUSR"):SetSize(25)

	TRCell():New(oSection2,"DESCRI" 		,"BIH",,,,,,,,,,,,,,,,,,,,)
	oSection2:Cell("DESCRI"):SetAutoSize(.F.)
	oSection2:Cell("DESCRI"):SetSize(15)

	TRCell():New(oSection2,"PLANO" 			,"BA1",,,,,,,,,,,,,,,,,,,,)
	oSection2:Cell("PLANO"):SetAutoSize(.F.)
	oSection2:Cell("PLANO"):SetSize(7)

	TRCell():New(oSection2,"DESC_PLANO" 	,"BA1",,,,,,,,,,,,,,,,,,,,)
	oSection2:Cell("DESC_PLANO"):SetAutoSize(.F.)
	oSection2:Cell("DESC_PLANO"):SetSize(15)

	TRCell():New(oSection2,"CPF" 			,"BA1",,,,,,,,,,,,,,,,,,,,)
	oSection2:Cell("CPF"):SetAutoSize(.F.)
	oSection2:Cell("CPF"):SetSize(15)

	TRCell():New(oSection2,"DATINC" 		,"BA1",,,,,,,,,,,,,,,,,,,,)
	oSection2:Cell("DATINC"):SetAutoSize(.F.)
	oSection2:Cell("DATINC"):SetSize(10)

	TRCell():New(oSection2,"DATNAS" 		,"BA1",,,,,,,,,,,,,,,,,,,,)
	oSection2:Cell("DATNAS"):SetAutoSize(.F.)
	oSection2:Cell("DATNAS"):SetSize(10)

	TRCell():New(oSection2,"MOTBLO" 		,"BA1",,,,,,,,,,,,,,,,,,,,)
	oSection2:Cell("MOTBLO"):SetAutoSize(.F.)
	oSection2:Cell("MOTBLO"):SetSize(8)

	TRCell():New(oSection2,"TIPO" 			,"BA1",,,,,,,,,,,,,,,,,,,,)
	oSection2:Cell("TIPO"):SetAutoSize(.F.)
	oSection2:Cell("TIPO"):SetSize(15)

	TRCell():New(oSection2,"DESC_BLOQ" 	,"BA1",,,,,,,,,,,,,,,,,,,,)
	oSection2:Cell("DESC_BLOQ"):SetAutoSize(.F.)
	oSection2:Cell("DESC_BLOQ"):SetSize(30)

	TRCell():New(oSection2,"OBS_BLQ" 		,"BA1",,,,,,,,,,,,,,,,,,,,)
	oSection2:Cell("OBS_BLQ"):SetAutoSize(.F.)
	oSection2:Cell("OBS_BLQ"):SetSize(30)

	TRCell():New(oSection2,"DAT_BLO" 		,"BA1",,,,,,,,,,,,,,,,,,,,)
	oSection2:Cell("DAT_BLO"):SetAutoSize(.F.)
	oSection2:Cell("DAT_BLO"):SetSize(10)

	TRCell():New(oSection2,"DATLANC" 		,"BA1",,,,,,,,,,,,,,,,,,,,)
	oSection2:Cell("DATLANC"):SetAutoSize(.F.)
	oSection2:Cell("DATLANC"):SetSize(10)

	TRCell():New(oSection2,"LOGIN" 			,"BA1",,,,,,,,,,,,,,,,,,,,)
	oSection2:Cell("LOGIN"):SetAutoSize(.F.)
	oSection2:Cell("LOGIN"):SetSize(10)

	//--------------------------------
	//Terceira linha do relat๓rio
	//--------------------------------
	oSection3 := TRSection():New(oSection2,"","BA3,BA1,BCA")

	TRCell():New(oSection3,"TOTAL" 			,"BA1",,,,,,,,,,,,,,,,,,,,)

	//--------------------------------
	//Quarta linha do relat๓rio
	//--------------------------------
	oSection4 := TRSection():New(oSection3,"","BA3,BA1,BCA")

	TRCell():New(oSection4,"TOT_GERAL"		,"BA1",,,,,,,,,,,,,,,,,,,,)


Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR192B  บAutor  ณAngelo Henrique     บ Data ณ  17/08/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina para montar a query e trazer as informa็๕es no       บฑฑ
ฑฑบ          ณrelat๓rio.                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CABR192B(oReport,_cAlias1)

	Local _aArea 			:= GetArea()

	Private oSection1 	:= oReport:Section(1)
	Private oSection2 	:= oReport:Section(1):Section(1)
	Private oSection3 	:= oReport:Section(1):Section(1):Section(1)
	Private oSection4 	:= oReport:Section(1):Section(1):Section(1):Section(1)
	Private _cQuery		:= ""
	Private _cAlias1		:= GetNextAlias()
	Private _cAlias2		:= GetNextAlias()
	Private _cCodEmp 		:=ด""
	Private _cCont		:= ""
	Private _cSubCnt 		:= ""
	Private _cCodInt		:= ""
	Private _cEmpAt		:= ""
	Private _lImp			:= .T.
	Private _cDscBlq 		:= ""
	Private _nTot 		:= 0
	Private _cMat 		:= ""
	Private _cNm			:= ""
	Private _nTotGr 		:= 0

	_cQuery := " SELECT BA3_CODINT, BA3_CODEMP, BA3_CONEMP, BA3_SUBCON, BA3_MATRIC, BA3_TIPCON, BA3_MOTBLO "
	_cQuery += " FROM " + RetSqlName("BA3")
	_cQuery += " WHERE "
	_cQuery += " BA3_FILIAL =  '" + xFilial("BA3") 	+ "' AND "
	_cQuery += " BA3_CODINT =  '" + mv_par01			+ "' AND "
	_cQuery += " BA3_CODEMP >= '" + mv_par02			+ "' AND "
	_cQuery += " BA3_CODEMP <= '" + mv_par03			+ "' AND "
	_cQuery += " BA3_CONEMP >= '" + mv_par04			+ "' AND "
	_cQuery += " BA3_CONEMP <= '" + mv_par05			+ "' AND "
	_cQuery += " BA3_SUBCON >= '" + mv_par06			+ "' AND "
	_cQuery += " BA3_SUBCON <= '" + mv_par07			+ "' AND "
	_cQuery += " BA3_MATRIC >= '" + mv_par08			+ "' AND "
	_cQuery += " BA3_MATRIC <= '" + mv_par09			+ "' AND "
	_cQuery += " D_E_L_E_T_ = ' ' "
	_cQuery += " AND BA3_DATBLO <> ' ' "
	_cQuery += " ORDER BY BA3_CONEMP, BA3_SUBCON, BA3_CODEMP, BA3_MATRIC"

	If Select(_cAlias1) > 0
		(_cAlias1)->(DbCloseArea())
	EndIf

	PLSQuery(_cQuery,_cAlias1)

	_cCodEmp 	:= ""
	_cCont		:= ""
	_cSubCnt 	:= ""
	_cCodInt	:= ""
	_lImp		:= .T.


	While !(_cAlias1)->(eof())

		oReport:IncMeter()

		If oReport:Cancel()
			Exit
		EndIf

		If !(_cCodInt	== (_cAlias1)->BA3_CODINT .And. _cCodEmp == (_cAlias1)->BA3_CODEMP .And. _cCont == (_cAlias1)->BA3_CONEMP .And. _cSubCnt == (_cAlias1)->BA3_SUBCON)

			_cCodEmp 	:= (_cAlias1)->BA3_CODEMP
			_cCont		:= (_cAlias1)->BA3_CONEMP
			_cSubCnt 	:= (_cAlias1)->BA3_SUBCON
			_cCodInt	:= (_cAlias1)->BA3_CODINT

			_cEmpAt	:= IIF(cEmpAnt == "01", "C", "I")

			oSection1:Cell("BA3_CODINT"):SetValue((_cAlias1)->BA3_CODINT)
			oSection1:Cell("BA3_CODEMP"):SetValue((_cAlias1)->BA3_CODEMP)

			oSection1:Cell("BA3_CONEMP"):SetValue((_cAlias1)->BA3_CONEMP)
			oSection1:Cell("BA3_SUBCON"):SetValue((_cAlias1)->BA3_SUBCON)

			oSection1:Init()
			oSection1:SetHeaderSection(.T.)
			oSection1:PrintLine()
			oSection1:Finish()

			_lImp := .F. //Depois que passar a primeira vez

			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			//ณExecuta Query no Arquivo BA1(CADASTRO DE USUARIOS)                                  ณ
			//ณPesquisa BA1(Usuarios) De Acordo Com os Registros Selecionados no BA3(Familia)      ณ
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

			_cQuery := " SELECT "
			_cQuery += " BCA.BCA_DATA DAT_BLQ, "
			_cQuery += " BCA.BCA_MOTBLO MOT_BLO, "
			_cQuery += " DECODE(BCA.BCA_TIPO,'0','Bloqueio','1','Desbloqueio') TIPO, "
			_cQuery += " BCA.BCA_OBS OBS, "
			_cQuery += " BCA.BCA_DATLAN DATLAN, "
			_cQuery += " BCA.BCA_USUOPE USUOPE, "
			_cQuery += " BCA.BCA_NIVBLQ NIVBLQ, "
			_cQuery += " BA1.BA1_CODINT||BA1.BA1_CODEMP||BA1.BA1_MATRIC||BA1.BA1_TIPREG||BA1.BA1_DIGITO MATRICULA, "
			_cQuery += " BA1.BA1_NOMUSR NOMUSR, "
			_cQuery += " BA1.BA1_TIPUSU TIPUSU, "
			_cQuery += " BA1.BA1_CPFUSR CPF, "
			_cQuery += " BA1.BA1_DATINC DAT_INC, "
			_cQuery += " BA1.BA1_DATNAS DAT_NASC, "
			_cQuery += " BA1.BA1_CODPLA PLANO, "
			_cQuery += " ( "
			_cQuery += " SELECT BI3.BI3_DESCRI "
			_cQuery += " FROM  " + RetSqlName("BI3") + " BI3 "
			_cQuery += " WHERE BI3.BI3_FILIAL = '" + xFilial("BI3") + "' "
			_cQuery += " AND BI3.BI3_CODIGO = BA1.BA1_CODPLA "
			_cQuery += " AND BI3.D_E_L_E_T_ = ' ' "
			_cQuery += " ) DESC_PLANO "
			_cQuery += " FROM  " + RetSqlName("BCA") + " BCA, " + RetSqlName("BA1") + " BA1 "
			_cQuery += " WHERE "
			_cQuery += " BCA.BCA_FILIAL = '" + xFilial("BCA") + "' "
			_cQuery += " AND BCA.BCA_MATRIC =  BA1.BA1_CODINT||BA1.BA1_CODEMP||BA1.BA1_MATRIC "
			_cQuery += " AND BCA.D_E_L_E_T_ = ' ' "
			_cQuery += " AND BA1.BA1_FILIAL = '" + xFilial("BA1") + "' "
			_cQuery += " AND BA1.BA1_CODINT = SUBSTR(BCA.BCA_MATRIC,1,4) "
			_cQuery += " AND BA1.BA1_CODEMP = SUBSTR(BCA.BCA_MATRIC,5,4) "
			_cQuery += " AND BA1.BA1_MATRIC = SUBSTR(BCA.BCA_MATRIC,9,6) "
			_cQuery += " AND BA1.BA1_TIPREG = BCA.BCA_TIPREG "
			_cQuery += " AND BA1.BA1_DATBLO <> ' ' "
			_cQuery += " AND BA1.BA1_CODINT =  '" + (_cAlias1)->BA3_CODINT + "' "
			_cQuery += " AND BA1.BA1_CONEMP =  '" + (_cAlias1)->BA3_CONEMP + "' "
			_cQuery += " AND BA1.BA1_SUBCON =  '" + (_cAlias1)->BA3_SUBCON + "' "
			_cQuery += " AND BA1.BA1_CODEMP =  '" + (_cAlias1)->BA3_CODEMP + "' "
			_cQuery += " AND BA1.BA1_MATRIC >= '" + mv_par08			   + "' "
			_cQuery += " AND BA1.BA1_MATRIC <= '" + mv_par09			   + "' "			
			_cQuery += " AND BA1.D_E_L_E_T_ = ' ' "

			//-----------------------------
			//Data de Movimenta็ใo
			//-----------------------------
			If !Empty( DTOS(mv_par10)) .OR. !Empty( DTOS(mv_par11))

				_cQuery += " AND BCA.BCA_DATLAN BETWEEN '" + DTOS(mv_par10) + "' AND '"	+ DTOS(mv_par11) +  "' "

			EndIf

			//----------------------------
			//Data de Bloqueio
			//----------------------------
			If !Empty( DTOS(mv_par12)) .OR. !Empty( DTOS(mv_par13))

				_cQuery += " AND BCA.BCA_DATA BETWEEN '" + DTOS(mv_par12) + "' AND '" + DTOS(mv_par13) +  "' "

			EndIf

			If !Empty(mv_par15) .AND. !Empty(mv_par16)

				_cQuery += " AND BA1.BA1_MOTBLO BETWEEN '" + mv_par15 + "' AND '" +  mv_par16 + "' "				

			EndIf

			_cQuery += " ORDER BY MATRICULA, BCA_DATA "


			If Select(_cAlias2) > 0
				(_cAlias2)->(DbCloseArea())
			EndIf

			PLSQuery(_cQuery,_cAlias2)

			_cMat 	:= ""
			_cNm	:= ""

			While ! (_cAlias2)->(EOF())

				_cDescTp := Substr(Posicione("BIH",1,xFilial("BIH")+(_cAlias2)->TIPUSU,"BIH_DESCRI"),1,10)

				_nTotGr ++

				//-------------------------------------
				//Valida็ใo do Nivel de bloqueio
				//-------------------------------------
				//Nivel Usuแrio - Tabela BG3
				//Nivel Famํlia - Tabela BG1
				//-------------------------------------
				If (_cAlias2)->NIVBLQ = "U"

					_cDscBlq := Posicione("BG3",1,xFilial("BG3")+(_cAlias2)->MOT_BLO, "BG3_DESBLO")

				Else

					_cDscBlq := Posicione("BG1",1,xFilial("BG1")+(_cAlias2)->MOT_BLO, "BG1_DESBLO")

				EndIf

				oReport:IncMeter()

				//----------------------------------------------
				//Valida็ใo para imprimir totalizador por login
				//----------------------------------------------
				If Empty(_cMat) .And. Empty(_cNm)

					_cMat 	:= (_cAlias2)->MATRICULA
					_cNm	:= (_cAlias2)->NOMUSR

					_nTot ++

				ElseIf (_cAlias2)->MATRICULA == _cMat .And. (_cAlias2)->NOMUSR == _cNm

					_nTot ++

				Else

					_cMat 	:= (_cAlias2)->MATRICULA
					_cNm	:= (_cAlias2)->NOMUSR

					oSection3:Init()
					oSection3:SetHeaderSection(.T.)

					oSection3:Cell("TOTAL"):SetValue(_nTot)

					oSection3:PrintLine()

					_nTot := 1

					oSection3:Finish()

				EndIf

				oSection2:Init()
				oSection2:SetHeaderSection(.T.)

				oSection2:Cell("MATRICULA"	):SetValue((_cAlias2)->MATRICULA				)
				oSection2:Cell("NOMUSR"		):SetValue((_cAlias2)->NOMUSR					)
				oSection2:Cell("DESCRI"		):SetValue(_cDescTp								)
				oSection2:Cell("PLANO"		):SetValue((_cAlias2)->PLANO					)
				oSection2:Cell("DESC_PLANO"	):SetValue((_cAlias2)->DESC_PLANO				)
				oSection2:Cell("CPF"		):SetValue((_cAlias2)->CPF						)
				oSection2:Cell("DATINC"		):SetValue(DTOC(STOD((_cAlias2)->DAT_INC	))	)
				oSection2:Cell("DATNAS"		):SetValue(DTOC(STOD((_cAlias2)->DAT_NASC	))	)
				oSection2:Cell("MOTBLO"		):SetValue((_cAlias2)->MOT_BLO					)
				oSection2:Cell("TIPO"		):SetValue((_cAlias2)->TIPO						)
				oSection2:Cell("DESC_BLOQ"	):SetValue(_cDscBlq								)
				oSection2:Cell("OBS_BLQ"	):SetValue((_cAlias2)->OBS						)
				oSection2:Cell("DAT_BLO"	):SetValue(DTOC(STOD((_cAlias2)->DAT_BLQ	))	)
				oSection2:Cell("DATLANC"	):SetValue(DTOC(STOD((_cAlias2)->DATLAN		))	)
				oSection2:Cell("LOGIN"	 	):SetValue((_cAlias2)->USUOPE					)

				oSection2:PrintLine()

				(_cAlias2)->(DbSkip())

			EndDo

			If Select(_cAlias2) > 0
				(_cAlias2)->(DbCloseArea())
			EndIf

		EndIf

		oSection2:Finish()

		(_cAlias1)->(DbSkip())

	EndDo

	//------------------------------------------
	//Impressใo do total geral
	//------------------------------------------

	oSection4:Init()
	oSection4:SetHeaderSection(.T.)
	oSection4:Cell("TOT_GERAL"):SetValue(_nTotGr)
	oSection4:PrintLine()
	oSection4:Finish()

	If Select(_cAlias1) > 0
		(_cAlias1)->(DbCloseArea())
	EndIf

	RestArea(_aArea)

Return(.T.)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR192C  บAutor  ณAngelo Henrique     บ Data ณ  17/08/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina responsavel pela gera็ใo das perguntas no relat๓rio  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CABR192C(cGrpPerg)

	Local aHelpPor := {} //help da pergunta

	aHelpPor := {}
	AADD(aHelpPor,"Indique a operadora que serแ		")
	AADD(aHelpPor,"a base para o relat๓rio.    		")

	PutSx1(cGrpPerg,"01","Operadora De"			,"a","a","MV_CH1"	,"C",TamSX3("BA3_CODINT")[1]	,2,0,"G","","B89PLS"	,"","","MV_PAR01",""			,"","","",""			,"","",""		,"","","","","","","","",aHelpPor,{},{},"")

	aHelpPor := {}
	AADD(aHelpPor,"Indique o Grupo/Empresa     		")
	AADD(aHelpPor,"De/Ate a ser utilizado.     		")

	PutSx1(cGrpPerg,"02","Empresa De ? "		,"a","a","MV_CH2"	,"C",TamSX3("BA3_CODEMP")[1]	,0,0,"G","","B7APLS"	,"","","MV_PAR02",""			,"","","",""			,"","",""		,"","","","","","","","",aHelpPor,{},{},"")
	PutSx1(cGrpPerg,"03","Empresa Ate ?"		,"a","a","MV_CH3"	,"C",TamSX3("BA3_CODEMP")[1]	,0,0,"G","","B7APLS"	,"","","MV_PAR03",""			,"","","",""			,"","",""		,"","","","","","","","",aHelpPor,{},{},"")

	aHelpPor := {}
	AADD(aHelpPor,"Indique o contrato De/Ate   		")
	AADD(aHelpPor,"a ser utilizado.            		")

	PutSx1(cGrpPerg,"04","Contrato De ?"		,"a","a","MV_CH4"	,"C",TamSX3("BA3_CONEMP")[1]	,0,0,"G","","B7BPLS"	,"","","MV_PAR04",""			,"","","",""			,"","",""		,"","","","","","","","",aHelpPor,{},{},"")
	PutSx1(cGrpPerg,"05","Contrato Ate ?"		,"a","a","MV_CH5"	,"C",TamSX3("BA3_CONEMP")[1]	,0,0,"G","","B7BPLS"	,"","","MV_PAR05",""			,"","","",""			,"","",""		,"","","","","","","","",aHelpPor,{},{},"")

	aHelpPor := {}
	AADD(aHelpPor,"Indique o sub-contrato 	   	 	")
	AADD(aHelpPor,"De/Ate a ser utilizado.     		")

	PutSx1(cGrpPerg,"06","Sub-Contrato De ? "	,"a","a","MV_CH6"	,"C",TamSX3("BA3_SUBCON")[1]	,0,0,"G","","B7CPLS"	,"","","MV_PAR06",""			,"","","",""			,"","",""		,"","","","","","","","",aHelpPor,{},{},"")
	PutSx1(cGrpPerg,"07","Sub-Contrato Ate ?"	,"a","a","MV_CH7"	,"C",TamSX3("BA3_SUBCON")[1]	,0,0,"G","","B7CPLS"	,"","","MV_PAR07",""			,"","","",""			,"","",""		,"","","","","","","","",aHelpPor,{},{},"")

	aHelpPor := {}
	AADD(aHelpPor,"Indique a Familia 			 	")
	AADD(aHelpPor,"De/Atea ser utilizada.      		")

	PutSx1(cGrpPerg,"08","Familia De ?"			,"a","a","MV_CH8"	,"C",TamSX3("BA3_MATRIC")[1]	,0,0,"G","",""			,"","","MV_PAR08",""			,"","","",""			,"","",""		,"","","","","","","","",aHelpPor,{},{},"")
	PutSx1(cGrpPerg,"09","Familia Ate ?"		,"a","a","MV_CH9"	,"C",TamSX3("BA3_MATRIC")[1]	,0,0,"G","",""			,"","","MV_PAR09",""			,"","","",""			,"","",""		,"","","","","","","","",aHelpPor,{},{},"")

	aHelpPor := {}
	AADD(aHelpPor,"Indique a data de Movimenta็ใo	")
	AADD(aHelpPor,"De/Ate a ser utilizada.       	")

	PutSx1(cGrpPerg,"10","Data Moviment. De ?"	,"a","a","MV_CH10"	,"D",TamSX3("BA3_DATBAS")[1]	,0,0,"G","",""			,"","","MV_PAR10",""			,"","","",""			,"","",""		,"","","","","","","","",aHelpPor,{},{},"")
	PutSx1(cGrpPerg,"11","Data Moviment. Ate?"	,"a","a","MV_CH11"	,"D",TamSX3("BA3_DATBAS")[1]	,0,0,"G","",""			,"","","MV_PAR11",""			,"","","",""			,"","",""		,"","","","","","","","",aHelpPor,{},{},"")

	aHelpPor := {}
	AADD(aHelpPor,"Indique a data de Bloqueio		")
	AADD(aHelpPor,"De/Ate a ser utilizada.   		")

	PutSx1(cGrpPerg,"12","Data Bloqueio De ?"	,"a","a","MV_CH12"	,"D",TamSX3("BA3_DATBAS")[1]	,0,0,"G","",""			,"","","MV_PAR12",""			,"","","",""			,"","",""		,"","","","","","","","",aHelpPor,{},{},"")
	PutSx1(cGrpPerg,"13","Data Bloqueio Ate?"	,"a","a","MV_CH13"	,"D",TamSX3("BA3_DATBAS")[1]	,0,0,"G","",""			,"","","MV_PAR13",""			,"","","",""			,"","",""		,"","","","","","","","",aHelpPor,{},{},"")

	aHelpPor := {}
	AADD(aHelpPor,"Indique o tipo de Bloqueio:		")
	AADD(aHelpPor,"Sub-contrato, familia ou usuario.")

	PutSx1(cGrpPerg ,"14","Tipo Bloqueio ?"		,"a","a","MV_CH14","N",1							,0,0,"C","",""			,"","","MV_PAR14","SUB-CONTRATO","","","","FAMILIA"		,"","","USUARIO","","","","","","","","",aHelpPor,{},{},"")	
	aHelpPor := {}
	AADD(aHelpPor,"Indique o codigo do Bloqueio:	")
	AADD(aHelpPor,"Sub-contrato, familia ou usuario.")

	PutSx1(cGrpPerg,"15","Cod Bloqueio De?" 	,"a","a","MV_CH15"	,"C",TamSX3("BA3_MOTBLO")[1]	,0,0,"G","","BA1BLQ"	,"","","MV_PAR15",""			,"","","",""			,"","",""		,"","","","","","","","",aHelpPor,{},{},"")	
	PutSx1(cGrpPerg,"16","Cod Bloqueio Ate?"	,"a","a","MV_CH16"	,"C",TamSX3("BA3_MOTBLO")[1]	,0,0,"G","","BA1BLQ"	,"","","MV_PAR16",""			,"","","",""			,"","",""		,"","","","","","","","",aHelpPor,{},{},"")

Return

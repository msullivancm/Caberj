#INCLUDE "REPORT.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"

#DEFINE c_ent CHR(13) + CHR(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR225     บAutor  ณAngelo Henrique   บ Data ณ  10/05/16   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRelat๓rio de CARENCIA                       					บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function CABR225()
	
	Local _aArea 		:= GetArea()
	Local oReport		:= Nil
	Private _cPerg	:= "CABR225"
	
	//Cria grupo de perguntas
	CABR225C(_cPerg)
	
	If Pergunte(_cPerg,.T.)
		
		oReport := CABR225A()
		oReport:PrintDialog()
		
	EndIf
	
	RestArea(_aArea)
	
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR225A  บAutor  ณAngelo Henrique     บ Data ณ  17/08/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina que irแ gerar as informa็๕es do relat๓rio            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CABR225A
	
	Local oReport		:= Nil
	Local oSection1 	:= Nil
	
	oReport := TReport():New("CABR225","CARENCIA",_cPerg,{|oReport| CABR225B(oReport)},"CARENCIA")
	
	oReport:SetLandScape()
	
	oReport:oPage:setPaperSize(12)
	
	//--------------------------------
	//Primeira linha do relat๓rio
	//--------------------------------
	oSection1 := TRSection():New(oReport,"CARENCIA","BA1,BDE,BED")
	
	TRCell():New(oSection1,"LOTE" 			,"BDE") //01 -- LOTE
	oSection1:Cell("LOTE"):SetAutoSize(.F.)
	oSection1:Cell("LOTE"):SetSize(10)
	
	TRCell():New(oSection1,"MATRICULA"		,"BA1") //02 -- MATRICULA
	oSection1:Cell("MATRICULA"):SetAutoSize(.F.)
	oSection1:Cell("MATRICULA"):SetSize(20)
	
	TRCell():New(oSection1,"NOME" 			,"BA1") //03 -- NOME
	oSection1:Cell("NOME"):SetAutoSize(.F.)
	oSection1:Cell("NOME"):SetSize(15)
	
	TRCell():New(oSection1,"CARENCIA_1"	,"BA1") //04 -- CARENCIA 1
	oSection1:Cell("CARENCIA_1"):SetAutoSize(.F.)
	oSection1:Cell("CARENCIA_1"):SetSize(10)
	
	TRCell():New(oSection1,"CARENCIA_2"	,"BA1") //05 -- CARENCIA 2
	oSection1:Cell("CARENCIA_2"):SetAutoSize(.F.)
	oSection1:Cell("CARENCIA_2"):SetSize(10)
	
	TRCell():New(oSection1,"CARENCIA_3"	,"BA1") //06 -- CARENCIA 3
	oSection1:Cell("CARENCIA_3"):SetAutoSize(.F.)
	oSection1:Cell("CARENCIA_3"):SetSize(10)
	
Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR225B  บAutor  ณAngelo Henrique     บ Data ณ  17/08/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina para montar a query e trazer as informa็๕es no       บฑฑ
ฑฑบ          ณrelat๓rio.                                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CABR225B(oReport)
	
	Local _aArea 			:= GetArea()
	Local _aLine 			:= {}
	Local _cMatCmp 		:= "" //Matricula Completa para ser usada na query que busca as car๊ncias
	Local _cEmp			:= IIF(cEmpAnt == "01","CABERJ","INTEGRAL")
	
	Private oSection1 	:= oReport:Section(1)
	Private _cQuery		:= ""
	Private _cAlias1		:= GetNextAlias()
	
	If !Empty(MV_PAR01) .And. !Empty(MV_PAR02) .And. MV_PAR03  = 1
		
		DbSelectArea("BDE")
		DbSetOrder(1) //BDE_FILIAL+BDE_CODINT+BDE_CODIGO
		If DbSeek(xFilial("BDE")+MV_PAR01+MV_PAR02)
			
			DbSelectArea("BED")
			DbSetOrder(4) //BED_FILIAL+BED_CDIDEN
			If DbSeek(xFilial("BDE")+BDE->BDE_CODIGO)
				
				oSection1:Init()
				oSection1:SetHeaderSection(.T.)
						
				While BDE->(!EOF()) .And. BED->BED_CDIDEN == BDE->BDE_CODIGO
					
					DbSelectArea("BA1")
					DbSetOrder(2)
					If DbSeek(xFilial("BA1")+BED->(BED_CODINT+BED_CODEMP+BED_MATRIC+BED_TIPREG+BED_DIGITO))
						
						_cMatCmp := BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)
						
						//-------------------------------------------------------------------
						//Fun็ใo CARENCIA_BENEF
						//Responsแvel pela pelo retorno das car๊ncias dos beneficiแrios
						//o resultado vem em uma string separadas por pipe (||)
						//-------------------------------------------------------------------
						_cQuery := " SELECT " + CRLF
						_cQuery += "	CARENCIA_BENEF('" + _cEmp + "','" + _cMatCmp + "',3) CARENC" + CRLF
						_cQuery += " FROM DUAL " + CRLF
						
						If Select(_cAlias1) > 0
							(_cAlias1)->(DbCloseArea())
						EndIf
						
						DbUseArea(.T.,"TOPCONN",TcGenQry(,,_cQuery),_cAlias1,.T.,.T.)												
						
						oSection1:Cell("LOTE"		):SetValue( BDE->BDE_CODIGO					)//01 -- LOTE
						oSection1:Cell("MATRICULA"	):SetValue( _cMatCmp							)//02 -- MATRICULA
						oSection1:Cell("NOME" 		):SetValue( AllTrim(BA1->BA1_NOMUSR)		)//03 -- NOME
						
						If !(_cAlias1)->(EOF())
							
							oReport:IncMeter()
							
							If oReport:Cancel()
								Exit
							EndIf
							
							_aLine := Separa((_cAlias1)->CARENC,'|',.T.)
							
							If !Empty(_aLine[1])
								
								oSection1:Cell("CARENCIA_1"	):SetValue( AllTrim(_aLine[1])		)//04 -- CARENCIA_1
								
								If Len(_aLine) > 1
									
									oSection1:Cell("CARENCIA_2"	):SetValue( AllTrim(_aLine[2])	)//05 -- CARENCIA_2
									
								Else
									
									oSection1:Cell("CARENCIA_2"	):SetValue( " " 					)//05 -- CARENCIA_2
									
								EndIf
								
								If Len(_aLine) > 2
									
									oSection1:Cell("CARENCIA_3"	):SetValue( AllTrim(_aLine[3])	)//06 -- CARENCIA_3
									
								Else
									
									oSection1:Cell("CARENCIA_3"	):SetValue( " " 					)//06 -- CARENCIA_3
									
								EndIf
								
							Else
								
								oSection1:Cell("CARENCIA_1"	):SetValue( " " 						)//04 -- CARENCIA_1
								oSection1:Cell("CARENCIA_2"	):SetValue( " " 						)//05 -- CARENCIA_2
								oSection1:Cell("CARENCIA_3"	):SetValue( " " 						)//06 -- CARENCIA_3
								
							EndIf
							
						Else
							
							oSection1:Cell("CARENCIA_1"	):SetValue( " "							)//04 -- CARENCIA_1
							oSection1:Cell("CARENCIA_2"	):SetValue( " "							)//05 -- CARENCIA_2
							oSection1:Cell("CARENCIA_3"	):SetValue( " "							)//06 -- CARENCIA_3
							
						EndIf
						
						oSection1:PrintLine()												
						
						If Select(_cAlias1) > 0
							(_cAlias1)->(DbCloseArea())
						EndIf
						
					EndIf
					
					BED->(DbSkip())
					
				EndDo
				
				oSection1:Finish()
				
			Else
				
				Aviso("Aten็ใo","O lote selecionado nใo possui itens para serem validados. Favor verificar o lote.",{"OK"})
				
			EndIf
			
		Else
			
			Aviso("Aten็ใo","Lote nใo encontrado no sistema.",{"OK"})
			
		EndIf
		
	Else
		
		DbSelectArea("BA1")
		DbSetOrder(2)
		If DbSeek(xFilial("BA1") + MV_PAR04)
			
			_cMatCmp := BA1->(BA1_CODINT+BA1_CODEMP+BA1_MATRIC+BA1_TIPREG+BA1_DIGITO)
			
			//-------------------------------------------------------------------
			//Fun็ใo CARENCIA_BENEF
			//Responsแvel pela pelo retorno das car๊ncias dos beneficiแrios
			//o resultado vem em uma string separadas por pipe (||)
			//-------------------------------------------------------------------
			_cQuery := " SELECT " + CRLF
			_cQuery += "	CARENCIA_BENEF('" + _cEmp + "','" + _cMatCmp + "',3) CARENC" + CRLF
			_cQuery += " FROM DUAL " + CRLF
			
			If Select(_cAlias1) > 0
				(_cAlias1)->(DbCloseArea())
			EndIf
			
			DbUseArea(.T.,"TOPCONN",TcGenQry(,,_cQuery),_cAlias1,.T.,.T.)
			
			oSection1:Init()
			oSection1:SetHeaderSection(.T.)
			
			oSection1:Cell("LOTE"		):SetValue( BDE->BDE_CODIGO					)//01 -- LOTE
			oSection1:Cell("MATRICULA"	):SetValue( _cMatCmp							)//02 -- MATRICULA
			oSection1:Cell("NOME" 		):SetValue( AllTrim(BA1->BA1_NOMUSR)		)//03 -- NOME
			
			If !(_cAlias1)->(EOF())
				
				oReport:IncMeter()
				
				If oReport:Cancel()
					Return
				EndIf
				
				_aLine := Separa((_cAlias1)->CARENC,'|',.T.)
				
				If !Empty(_aLine[1])
					
					oSection1:Cell("CARENCIA_1"	):SetValue( AllTrim(_aLine[1])		)//04 -- CARENCIA_1
					
					If Len(_aLine) > 1
						
						oSection1:Cell("CARENCIA_2"	):SetValue( AllTrim(_aLine[2])	)//05 -- CARENCIA_2
						
					Else
						
						oSection1:Cell("CARENCIA_2"	):SetValue( " " 					)//05 -- CARENCIA_2
						
					EndIf
					
					If Len(_aLine) > 2
						
						oSection1:Cell("CARENCIA_3"	):SetValue( AllTrim(_aLine[3])	)//06 -- CARENCIA_3
						
					Else
						
						oSection1:Cell("CARENCIA_3"	):SetValue( " " 					)//06 -- CARENCIA_3
						
					EndIf
					
				Else
					
					oSection1:Cell("CARENCIA_1"	):SetValue( " " 						)//04 -- CARENCIA_1
					oSection1:Cell("CARENCIA_2"	):SetValue( " " 						)//05 -- CARENCIA_2
					oSection1:Cell("CARENCIA_3"	):SetValue( " " 						)//06 -- CARENCIA_3
					
				EndIf
				
			Else
				
				oSection1:Cell("CARENCIA_1"	):SetValue( " "							)//04 -- CARENCIA_1
				oSection1:Cell("CARENCIA_2"	):SetValue( " "							)//05 -- CARENCIA_2
				oSection1:Cell("CARENCIA_3"	):SetValue( " "							)//06 -- CARENCIA_3
				
			EndIf
			
			oSection1:PrintLine()
			
			oSection1:Finish()
			
			If Select(_cAlias1) > 0
				(_cAlias1)->(DbCloseArea())
			EndIf
		
		Else
		
			Aviso("Aten็ใo","Beneficiแrio nใo encontrado no sistema",{"OK"})
			
		EndIf
		
	EndIf
	
	RestArea(_aArea)
	
Return(.T.)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABR225C  บAutor  ณAngelo Henrique     บ Data ณ  17/08/15   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina responsavel pela gera็ใo das perguntas no relat๓rio  บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ CABERJ                                                     บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function CABR225C(cGrpPerg)
	
	Local aHelpPor := {} //help da pergunta
	Local _nTamMat := 0
	
	_nTamMat := TAMSX3("BA1_CODINT")[1]
	_nTamMat += TAMSX3("BA1_CODEMP")[1]
	_nTamMat += TAMSX3("BA1_MATRIC")[1]
	_nTamMat += TAMSX3("BA1_TIPREG")[1]
	_nTamMat += TAMSX3("BA1_DIGITO")[1]
		
	aHelpPor := {}
	AADD(aHelpPor,"Informe a operadora				")
	
	PutSx1(cGrpPerg,"01","Operadora: ?"	,"a","a","MV_CH1"	,"C",TamSX3("BDE_CODINT")[1]	,0,0,"G","","B89PLS"	,"","","MV_PAR01","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	
	aHelpPor := {}		
	AADD(aHelpPor,"Informe o numero do lote		")
	
	PutSx1(cGrpPerg,"02","Lote: ?"			,"a","a","MV_CH2"	,"C",TamSX3("BA1_CDIDEN")[1]	,0,0,"G","","BEDPLS"	,"","","MV_PAR02","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	
	aHelpPor := {}
	AADD(aHelpPor,"Tipo de Gera็ใo 					")
	
	PutSx1(cGrpPerg,"03","Tipo: ?"			,"a","a","MV_CH3"	,"C",TamSX3("BDE_CODIGO")[1]	,0,0,"C","",""		,"","","MV_PAR03","Lote","","","","Matricula","","","","","","","","","","","",aHelpPor,{},{},"")
	
	aHelpPor := {}
	AADD(aHelpPor,"Informe a matricula 			")
	
	PutSx1(cGrpPerg,"04","Matricula: ?"	,"a","a","MV_CH4"	,"C",_nTamMat						,0,0,"G","","ZZ7USU"	,"","","MV_PAR04","","","","","","","","","","","","","","","","",aHelpPor,{},{},"")
	
Return


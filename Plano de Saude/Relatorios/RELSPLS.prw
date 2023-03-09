#INCLUDE 'PROTHEUS.CH'

//*************************************Relat�rio de Compra OPME****************************************
User Function COMOPME()
	
	Local oDlg
	Local _nOpc   := 0
	Local oEmpre  := Nil
	Local cEmpre  := Substr(cNumEmp,1,2)
	
	Private cCRPar:="1;0;1;Relat�rio Compra OPME"
	Private cParam1     := ""
	Private cParam2     := ""
	Private cPerg       := "RLOPME"
	Private cPed        := SPACE(TamSX3("D1_PEDIDO")[1]  )
	Private cMatUsu     := SPACE(TamSX3("BA1_MATRIC")[1] )
	Private oNomUsr     := Nil
	Private cNomUsr     := ""
	Private aVetPed     := {}
	Private oMatUsu     := Nil
	Private oPed        := Nil
	
	
	//inicio alteracao Renato Peixoto
	Define FONT oFont1 	NAME "Arial" SIZE 0,15  Bold
	
	DEFINE MSDIALOG oDlg TITLE "Parametriza��o Relat�rio OPME" FROM 000,000 TO 170,350 PIXEL
	
	@ 012,009 Say   "Matricula:"        Size 121,012 FONT oFont1 COLOR CLR_HBLUE PIXEL OF oDlg
	@ 012,050 MSGET oMatUsu Var cMatUsu Size 080,012 When .T. F3 "BA1OPM"  Valid IIF(!Empty(cMatUsu),BscPedsOPM(),"") PIXEL OF oDlg
	
	@ 027,009 Say   "Nome Usr:"         Size 045,008 FONT oFont1 COLOR CLR_HBLUE PIXEL OF oDlg
	@ 027,050 MSGET oNomUsr Var cNomUsr Size 080,010 WHEN .F. PIXEL OF oDlg
	
	@ 042,009 Say   "Pedido:"           Size 045,008 FONT oFont1 COLOR CLR_HBLUE PIXEL OF oDlg
	@ 042,050 MSGET oPed Var cPed       Size 080,010 WHEN .T.  PIXEL OF oDlg
	
	@ 057,009 Say   "Empresa:"          Size 045,008 FONT oFont1 COLOR CLR_HBLUE PIXEL OF oDlg
	@ 057,050 MSGET oEmpre Var cEmpre   Size 080,010 WHEN .F.  PIXEL OF oDlg
	
	@ 072,009 Button "OK"       Size 037,012 PIXEL OF oDlg Action(_nOpc := 1,oDlg:End())
	@ 072,060 Button "Cancelar" Size 037,012 PIXEL OF oDlg Action oDlg:end()
	
	ACTIVATE MSDIALOG oDlg CENTERED
	
	
	
	
	/* If !Pergunte(cPerg,.T.)  comentado por Renato Peixoto
Return
Endif
*/
/*Conjunto de op��es para nao mostrar a tela da SetPrint, composta por x;y;z;w, onde
x = v�deo(1) ou impressora(3)
y = Atualiza(0) ou n�o(1) os dados
z = N�mero de c�pias
w = T�tulo do relatorio.
*/
If _nOpc = 1
	cParam2:=Substr(cNumEmp,1,2)
	cParam1:=cPed+";"+cParam2//mv_par01+";"+cParam2
	CallCrys("RLOPME",cParam1,cCRPar)
EndIf

Return

//************************************* FIM Relat�rio de Compra OPME***************************************

//*************************************Relat�rio de Compra MEDICAMENTOS"****************************************
User Function COMMEDI()
	
	Local oDlg
	Local _nOpc   := 0
	Local oEmpre  := Nil
	Local cEmpre  := Substr(cNumEmp,1,2)
	
	Private cCRPar:="1;0;1;Relat�rio Compra MEDICAMENTOS"
	Private cParam1     := ""
	Private cParam2     := ""
	Private cPerg       := "RLMEDI"
	Private cPed        := SPACE(TamSX3("D1_PEDIDO")[1]  )
	Private cMatUsu     := SPACE(TamSX3("BA1_MATRIC")[1] )
	Private oNomUsr     := Nil
	Private cNomUsr     := ""
	Private aVetPed     := {}
	Private oMatUsu     := Nil
	Private oPed        := Nil
	
	
	//inicio alteracao Renato Peixoto
	Define FONT oFont1 	NAME "Arial" SIZE 0,15  Bold
	
	DEFINE MSDIALOG oDlg TITLE "Parametriza��o Relat�rio MEDICAMENTOS" FROM 000,000 TO 170,350 PIXEL
	
	@ 012,009 Say   "Matricula:"        Size 121,012 FONT oFont1 COLOR CLR_HBLUE PIXEL OF oDlg
	@ 012,050 MSGET oMatUsu Var cMatUsu Size 080,012 When .T. F3 "BA1OPM"  Valid IIF(!Empty(cMatUsu),BscPedsOPM(),"") PIXEL OF oDlg
	
	@ 027,009 Say   "Nome Usr:"         Size 045,008 FONT oFont1 COLOR CLR_HBLUE PIXEL OF oDlg
	@ 027,050 MSGET oNomUsr Var cNomUsr Size 080,010 WHEN .F. PIXEL OF oDlg
	
	@ 042,009 Say   "Pedido:"           Size 045,008 FONT oFont1 COLOR CLR_HBLUE PIXEL OF oDlg
	@ 042,050 MSGET oPed Var cPed       Size 080,010 WHEN .T.  PIXEL OF oDlg
	
	@ 057,009 Say   "Empresa:"          Size 045,008 FONT oFont1 COLOR CLR_HBLUE PIXEL OF oDlg
	@ 057,050 MSGET oEmpre Var cEmpre   Size 080,010 WHEN .F.  PIXEL OF oDlg
	
	@ 072,009 Button "OK"       Size 037,012 PIXEL OF oDlg Action(_nOpc := 1,oDlg:End())
	@ 072,060 Button "Cancelar" Size 037,012 PIXEL OF oDlg Action oDlg:end()
	
	ACTIVATE MSDIALOG oDlg CENTERED
	
	
	
	
	/* If !Pergunte(cPerg,.T.)  comentado por Renato Peixoto
Return
Endif
*/
/*Conjunto de op��es para nao mostrar a tela da SetPrint, composta por x;y;z;w, onde
x = v�deo(1) ou impressora(3)
y = Atualiza(0) ou n�o(1) os dados
z = N�mero de c�pias
w = T�tulo do relatorio.
*/
If _nOpc = 1
	cParam2:=Substr(cNumEmp,1,2)
	cParam1:=cPed+";"+cParam2//mv_par01+";"+cParam2
	CallCrys("RLMEDI",cParam1,cCRPar)
EndIf

Return

//************************************* FIM Relat�rio de Compra MEDICAMENTOS"***************************************

//*************************************Relat�rio Autoriza��o Provisoria****************************************

User Function AUTPRO()
	
	Local i := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
	Local lOdonto	:= .f. // mateus medeiros - 30/11/18
	Private cCRPar:="1;0;1;Relat�rio Autoriza��o Provis�ria"
	Private cParam1     := ""
	Private cParam2     := ""
	Private cParam3     := ""
	Private cPerg       := "AUTPRO"
	
	If !Pergunte(cPerg,.T.)
		Return
	Endif
	
	/*Conjunto de op��es para nao mostrar a tela da SetPrint, composta por x;y;z;w, onde
	x = v�deo(1) ou impressora(3)
	y = Atualiza(0) ou n�o(1) os dados
	z = N�mero de c�pias
	w = T�tulo do relatorio.
	*/
	
	//Leonardo Portella - 15/06/11 - Inicio
	//Seleciona mais de uma matricula
	
	aMatrics := AUTPROMATR()
	
	cMatrics := "'"
	
	For i := 1 to len(aMatrics)
		cMatrics += aMatrics[i][1] + ","
	Next
	
	cMatrics := left(cMatrics,len(cMatrics)-1) + "'"
	
	cMatrics := replace(cMatrics,'.','')
	cMatrics := replace(cMatrics,'-','')
	
	//Leonardo Portella - 15/06/11 - Fim
	
	//cParam2:=Substr(cNumEmp,1,2)
	//Bianchini - V12 - Corre��o Autoriza��o Provis�ria
	cParam2:=Substr(cNumEmp,2,1)
	cParam3:=Alltrim(cUserName)
	
	//Leonardo Portella - 15/06/11
	//cParam1:=mv_par01+";"+dtoc(mv_par02)+";"+cParam2+";"+cParam3
	
	//Leonardo Portella - 28/11/11 - Incluir a data de validade ate
	//cParam1:=cMatrics+";"+dtoc(mv_par01)+";"+cParam2+";"+cParam3
	cParam1:=cMatrics+";"+dtoc(mv_par01)+";"+dtoc(mv_par02)+";"+cParam2+";"+cParam3
	
	cMatric := STRTRAN(cMatrics,"'","")
	// mateus medeiros - 30/11/18
	
	BA1->( DbSetOrder(2) )		// BA1_FILIAL + BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPREG + BA1_DIGITO
	If BA1->( MsSeek( xFilial("BA1")+cMatric ) )
		IF !empty(BA1->BA1_YMTODO)
			lOdonto := .T.
			MsgAlert('Matricula Odontol�gica!','AVISO')
		Endif
	Endif
	
	if !lOdonto 
		CallCrys("AUTPRO",cParam1,cCRPar)
	else
		//cParam1:= dtoc(mv_par01)+";"+dtoc(mv_par02)+";"+cParam2+";"+cMatrics+";"+cParam3
		CallCrys("AUTPRO2O",cParam1,cCRPar)
	endif
	
Return

//��������������������������������������������������
//�Funcao para selecionar as matriculas manualmente�
//��������������������������������������������������

Static Function AUTPROMATR
	
	Local aSaveArea := GetArea()
	Local oDlg
	Local oLbx
	Local aNumRec := {}
	Local oMatric
	Local cMatric := CriaVar("BA1_MATANT")
	
	Aadd( aNumRec, {"", "", 0} )
	
	DEFINE MSDIALOG oDlg TITLE "Usu�rios" FROM 0,0 TO 350,650 PIXEL
	
	@ 035,005 SAY "Matricula" OF oDlg PIXEL
	@ 032,030 MSGET oMatric VAR cMatric OF oDlg SIZE 100,09 PIXEL WHEN .T. PICTURE "@!" VALID VALMAT(oLbx, oMatric, cMatric) F3 "B92PLS"
	
	@ 045,005 LISTBOX oLbx FIELDS HEADER "Matricula", "Nome do Usu�rio", "Record" SIZE 317, 130 NOSCROLL OF oDlg PIXEL
	oLbx:SetArray(aNumRec)
	oLbx:bLine:={||{ aNumRec[oLbx:nAt,01], aNumRec[oLbx:nAt,02], aNumRec[oLbx:nAt,03] }}
	oLbx:nAt := 1
	oLbx:aColSizes := {70, 170, 30}
	oLbx:BLDBLCLICK := { || AUTPROExcl(oLbx) }


	
	ACTIVATE MSDIALOG oDlg CENTERED ON INIT (EnchoiceBar(oDlg,{||oDlg:End()},{||(aNumRec:={},oDlg:End())}))
	
	RestArea(aSaveArea)
	
Return aNumRec

*****************************

Static Function VALMAT(oLbx, oMatric, cMatric)
	
	BA1->( DbSetOrder(2) )		// BA1_FILIAL + BA1_CODINT + BA1_CODEMP + BA1_MATRIC + BA1_TIPREG + BA1_DIGITO
	
	If BA1->( !MsSeek( xFilial("BA1")+cMatric ) )
		BA1->( DbSetOrder(5) )		// BA1_FILIAL + BA1_MATANT + BA1_TIPANT
		If BA1->( !MsSeek( xFilial("BA1")+cMatric ) )
			MsgStop("Matricula informada n�o cadastrada...")
			oMatric:SetFocus()
		Endif
	Endif
	
	If BA1->(Found())
		
		If aScan(oLbx:AARRAY,{|x|x[3] == BA1->(RecNo())}) <= 0
			
			If !Empty( oLbx:AARRAY[1][1] )
				Aadd( oLbx:AARRAY, {"", "", 0} )
			Endif
			
			oLbx:AARRAY[Len(oLbx:AARRAY)][1] := BA1->BA1_CODINT + "." +;
				BA1->BA1_CODEMP + "." +;
				BA1->BA1_MATRIC + "." +;
				BA1->BA1_TIPREG + "-" +;
				BA1->BA1_DIGITO
			oLbx:AARRAY[Len(oLbx:AARRAY)][2] := BA1->BA1_NOMUSR
			oLbx:AARRAY[Len(oLbx:AARRAY)][3] := BA1->(RecNo())
			
		EndIf
		
		oLbx:nAt := 1
		oLbx:Refresh()
		oMatric:SetFocus()
	Endif
	
Return .T.

********************************

Static Function AUTPROExcl(oLbx)
	
	Local aArray := Aclone( oLbx:AARRAY )
	
	If MsgYesNo("Deseja excluir este usu�rio ?")
		If Len(aArray) > 0
			Adel(aArray, oLbx:nAt) // deleta o item
			Asize(aArray, Len(aArray) - 1) //redimensiona o array
		Endif
	Endif
	
	If Len(aArray) == 0
		Aadd( aArray, {"", "", 0} )
	Endif
	
	oLbx:AARRAY := Aclone( aArray )
	oLbx:Refresh()
	
Return .T.

//************************************* FIM Relat�rio Autoriza��o Provisoria***************************************

//*************************************Relat�rio Confer�ncia****************************************
User Function REGINC()
	
	Private cCRPar:="1;0;1;Confer�ncia Demais Despesas/Outros Atendimentos"
	Private cParam1     := ""
	Private cParam2     := ""
	Private cPerg       := "CONREG"
	
	If !Pergunte(cPerg,.T.)
		Return
	Endif
	
	/*Conjunto de op��es para nao mostrar a tela da SetPrint, composta por x;y;z;w, onde
	x = v�deo(1) ou impressora(3)
	y = Atualiza(0) ou n�o(1) os dados
	z = N�mero de c�pias
	w = T�tulo do relatorio.
	*/
	
	cParam2:=Substr(cNumEmp,1,2)
	cParam1:=mv_par01+";"+mv_par02+";"+cParam2
	CallCrys("CONREG",cParam1,cCRPar)
	
Return
//************************************* FIM Relat�rio Autoriza��o Provisoria***************************************

//*************************************Relat�rio de Protocolos das Ag�ncias****************************************
User Function RPROAG()
	
	Private cCRPar:="1;0;1;Relat�rio de Protocolos das Ag�ncias"
	Private cParam1     := ""
	Private cParam2     := ""
	Private cPerg       := "PROTAG"
	
	If !Pergunte(cPerg,.T.)
		Return
	Endif
	
	/*Conjunto de op��es para nao mostrar a tela da SetPrint, composta por x;y;z;w, onde
	x = v�deo(1) ou impressora(3)
	y = Atualiza(0) ou n�o(1) os dados
	z = N�mero de c�pias
	w = T�tulo do relatorio.
	*/
	
	cParam2:=Substr(cNumEmp,1,2)
	cParam1:=mv_par01+";"+mv_par02+";"+mv_par03+";"+cParam2
	CallCrys("PROTAG",cParam1,cCRPar)
	
Return
//************************************* FIM Relat�rio de Protocolos das Ag�ncias **********************************
//************************************* Relat�rio Sint�tico de Desligamento ***************************************
User Function STDESL()
	
	Private cCRPar:="1;0;1;Relat�rio Sint�tico de Desligamento"
	Private cParam1     := ""
	Private cParam2     := ""
	Private cPerg       := "SIDESL"
	Private cDataTemp1  := ""
	Private cDataTemp2  := ""
	Private cMotivo     := ""
	
	If !Pergunte(cPerg,.T.)
		Return
	Endif
	
	/* Este bloco todo ser� tratado com IFs dentro da Procedure. Foi necess�rio porque sen�o a procedure n�o executava caso houvesse par�metro vazio */
	if Empty(mv_par03)
		cDataTemp1 := "01/01/01"
	else
		cDataTemp1 := dtoc(mv_par03)
	Endif
	
	if Empty(mv_par04)
		cDataTemp2 := "01/01/01"
	else
		cDataTemp2 := dtoc(mv_par04)
	Endif
	
	if Empty(mv_par05)
		cMotivo := 'ZZZ'
	else
		cMotivo := mv_par05
	Endif
	/*Fim do bloco forcado.  Mal necess�rio*/
	
	/*Conjunto de op��es para nao mostrar a tela da SetPrint, composta por x;y;z;w, onde
	x = v�deo(1) ou impressora(3)
	y = Atualiza(0) ou n�o(1) os dados
	z = N�mero de c�pias
	w = T�tulo do relatorio.
	*/
	
	cParam2:=Substr(cNumEmp,1,2)
	//cParam1:=dtos(mv_par01)+";"+dtos(mv_par02)+";"+cDataTemp1+";"+cDataTemp2+";"+cMotivo+";"+cParam2
	cParam1:=dtoc(mv_par01)+";"+dtoc(mv_par02)+";"+cDataTemp1+";"+cDataTemp2+";"+cMotivo+";"+cParam2+";"+alltrim(str(mv_par06))
	CallCrys("SIDESL",cParam1,cCRPar)
	
Return
//************************************* FIM Relat�rio Sintetico de Desligamento **********************************
//************************************* Relat�rio Anal�tico de Desligamento ***************************************
User Function RLDESL()
	
	Private cCRPar:="1;0;1;Relat�rio Anal�tico de Desligamento"
	Private cParam1     := ""
	Private cParam2     := ""
	Private cPerg       := "ANDESL"
	Private cDataTemp1  := ""
	Private cDataTemp2  := ""
	Private cMotivo     := ""
	
	If !Pergunte(cPerg,.T.)
		Return
	Endif
	
	/* Este bloco todo ser� tratado com IFs dentro da Procedure. Foi necess�rio porque sen�o a procedure n�o executava caso houvesse par�metro vazio */
	if Empty(mv_par03)
		cDataTemp1 := "01/01/01"
	else
		cDataTemp1 := dtoc(mv_par03)
	Endif
	
	if Empty(mv_par04)
		cDataTemp2 := "01/01/01"
	else
		cDataTemp2 := dtoc(mv_par04)
	Endif
	
	if Empty(mv_par05)
		cMotivo := 'ZZZ'
	else
		cMotivo := mv_par05
	Endif
	/*Fim do bloco forcado.  Mal necess�rio*/
	
	/*Conjunto de op��es para nao mostrar a tela da SetPrint, composta por x;y;z;w, onde
	x = v�deo(1) ou impressora(3)
	y = Atualiza(0) ou n�o(1) os dados
	z = N�mero de c�pias
	w = T�tulo do relatorio.
	*/
	
	cParam2:=Substr(cNumEmp,1,2)
	//cParam1:=dtos(mv_par01)+";"+dtos(mv_par02)+";"+cDataTemp1+";"+cDataTemp2+";"+cMotivo+";"+cParam2
	cParam1:=dtoc(mv_par01)+";"+dtoc(mv_par02)+";"+cDataTemp1+";"+cDataTemp2+";"+cMotivo+";"+cParam2
	CallCrys("ANDESL",cParam1,cCRPar)
	
Return
//************************************* FIM Relat�rio Anal�tico de Desligamento **********************************
//************************************* Relat�rio Anal�tico de Inclus�es ***************************************
User Function RLINCL()
	
	Private cCRPar:="1;0;1;Relat�rio Anal�tico de Inclus�es"
	Private cParam1     := ""
	Private cParam2     := ""
	Private cPerg       := "ANINCL"
	Private cDataTemp1  := ""
	Private cDataTemp2  := ""
	
	If !Pergunte(cPerg,.T.)
		Return
	Endif
	
	/* Este bloco todo ser� tratado com IFs dentro da Procedure. Foi necess�rio porque sen�o a procedure n�o executava caso houvesse par�metro vazio */
	if Empty(mv_par03)
		cDataTemp1 := "01/01/01"
	else
		cDataTemp1 := dtoc(mv_par03)
	Endif
	
	if Empty(mv_par04)
		cDataTemp2 := "01/01/01"
	else
		cDataTemp2 := dtoc(mv_par04)
	Endif
	
	/*Fim do bloco forcado.  Mal necess�rio*/
	
	/*Conjunto de op��es para nao mostrar a tela da SetPrint, composta por x;y;z;w, onde
	x = v�deo(1) ou impressora(3)
	y = Atualiza(0) ou n�o(1) os dados
	z = N�mero de c�pias
	w = T�tulo do relatorio.
	*/
	
	cParam2:=Substr(cNumEmp,1,2)
	//cParam1:=dtos(mv_par01)+";"+dtos(mv_par02)+";"+cDataTemp1+";"+cDataTemp2+";"+cMotivo+";"+cParam2
	cParam1:=dtoc(mv_par01)+";"+dtoc(mv_par02)+";"+cDataTemp1+";"+cDataTemp2+";"+cParam2
	CallCrys("ANINCL",cParam1,cCRPar)
	
Return
//************************************* FIM Relat�rio Anal�tico de Inclus�o **********************************
//************************************* Relat�rio Anal�tico de Troca de Plano ***************************************
User Function RLTROP()
	
	Private cCRPar:="1;0;1;Relat�rio Anal�tico de Inclus�es"
	Private cParam1     := ""
	Private cParam2     := ""
	Private cPerg       := "TROPLA"
	Private cDataTemp1  := ""
	Private cDataTemp2  := ""
	
	If !Pergunte(cPerg,.T.)
		Return
	Endif
	
	/* Este bloco todo ser� tratado com IFs dentro da Procedure. Foi necess�rio porque sen�o a procedure n�o executava caso houvesse par�metro vazio */
	if Empty(mv_par03)
		cDataTemp1 := "01/01/01"
	else
		cDataTemp1 := dtoc(mv_par03)
	Endif
	
	if Empty(mv_par04)
		cDataTemp2 := "01/01/01"
	else
		cDataTemp2 := dtoc(mv_par04)
	Endif
	
	/*Fim do bloco forcado.  Mal necess�rio*/
	
	/*Conjunto de op��es para nao mostrar a tela da SetPrint, composta por x;y;z;w, onde
	x = v�deo(1) ou impressora(3)
	y = Atualiza(0) ou n�o(1) os dados
	z = N�mero de c�pias
	w = T�tulo do relatorio.
	*/
	
	cParam2:=Substr(cNumEmp,1,2)
	//cParam1:=dtos(mv_par01)+";"+dtos(mv_par02)+";"+cDataTemp1+";"+cDataTemp2+";"+cMotivo+";"+cParam2
	cParam1:=dtoc(mv_par01)+";"+dtoc(mv_par02)+";"+cDataTemp1+";"+cDataTemp2+";"+cParam2
	CallCrys("TROPLA",cParam1,cCRPar)
	
Return
//************************************* FIM Relat�rio Anal�tico de Troca de Plano **********************************

//************************************* FIM Relat�rio de Protocolos das Ag�ncias **********************************
//************************************* Relat�rio Sint�tico de Desligamento ***************************************
User Function RELSPA()
	
	Private cCRPar:="1;0;1;Relat�rio Sint�tico de SPA"
	Private cParam1     := ""
	Private cParam2     := ""
	Private cPerg       := "RELSPA"
	Private cDataTemp1  := ""
	Private cDataTemp2  := ""
	Private cMotivo     := ""
	
	PutSx1( cPerg ,"01","RDA                   ","","","mv_ch1","C",06,0,0,"G","                                     ","BAUPLS","S","","mv_par01","        ","","","    ","           ","","","         ","","","","","","","","",{},{},{},"")
	PutSx1( cPerg ,"02","RDA                   ","","","mv_ch2","C",06,0,0,"G","                                     ","BAUPLS","S","","mv_par02","        ","","","    ","           ","","","         ","","","","","","","","",{},{},{},"")
	PutSx1( cPerg ,"03","Inclus�o inicial:","","","mv_ch3","D",08,0,0,"G","NaoVazio()                           ","      ","S","","mv_par03","        ","","","    ","           ","","","         ","","","","","","","","",{},{},{},"")
	PutSx1( cPerg ,"04","Inclus�o Final:","","","mv_ch4","D",08,0,0,"G","NaoVazio()                           ","      ","S","","mv_par04","        ","","","    ","           ","","","         ","","","","","","","","",{},{},{},"")
	PutSx1( cPerg ,"05","Status:","","","mv_ch5","N",02,0,0,"C","","","S","","mv_par05","Aguardando Aprova��o","","","","Aprovado","","","Cancelado","","","Reprovado","","","Ambos","","",{},{},{},"")
	
	If !Pergunte(cPerg,.T.)
		Return
	Endif
	
	/* Este bloco todo ser� tratado com IFs dentro da Procedure. Foi necess�rio porque sen�o a procedure n�o executava caso houvesse par�metro vazio */
	
	
	if Empty(mv_par02)
		cMotivo := 'ZZZ'
	else
		cMotivo := mv_par02
	Endif
	
	if Empty(mv_par03)
		cDataTemp1 := "01/01/01"
	else
		cDataTemp1 := dtoc(mv_par03)
	Endif
	
	if Empty(mv_par04)
		cDataTemp2 := "01/01/01"
	else
		cDataTemp2 := dtoc(mv_par04)
	Endif
	
	/*Fim do bloco forcado.  Mal necess�rio*/
	
	/*Conjunto de op��es para nao mostrar a tela da SetPrint, composta por x;y;z;w, onde
	x = v�deo(1) ou impressora(3)
	y = Atualiza(0) ou n�o(1) os dados
	z = N�mero de c�pias
	w = T�tulo do relatorio.
	*/
	
	cParam2:=Substr(cNumEmp,1,2)
	//cParam1:=dtos(mv_par01)+";"+dtos(mv_par02)+";"+cDataTemp1+";"+cDataTemp2+";"+cMotivo+";"+cParam2
	cParam1:=dtoc(mv_par01)+";"+dtoc(mv_par02)+";"+cDataTemp1+";"+cDataTemp2+";"+cMotivo+";"+cParam2+";"+alltrim(str(mv_par06))
	CallCrys("SIDESL",cParam1,cCRPar)
	
Return




/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �BscPedsOPM�Autor  �Renato Peixoto      � Data �  05/06/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �Fun��o que vai ser respons�vel por retornar os pedidos      ���
���          �OPME de acordo com o usu�rio escolhido.                     ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function BscPedsOPM
	
	Local aCab      := {"Pedido","Matricula","Nome Associado","Data da Compra","Data Solicita��o"}
	Local aTam      := {20,20,50,100,50,50}
	Local lConfirm  := .F.
	
	Private oDlg 	:= nil
	Private oBrowse	:= nil
	Private oBrowse2:= nil
	Private nPos 	:= 0
	Private oOk    	:= LoadBitMap(GetResources(),"LBOK")
	Private oNo    	:= LoadBitMap(GetResources(),"LBNO")
	Private oPaga	:= LoadBitMap(GetResources(),"BR_VERDE")
	Private oNaoPag	:= LoadBitMap(GetResources(),"BR_VERMELHO")
	Private oPagDbr	:= LoadBitMap(GetResources(),"BR_LARANJA")
	
	
	SetPrvt("oDlg1","oCBox1")
	
	Processa({||aVetPed := RetArrPed()})
	
	If Len(aVetPed) = 0
		APMSGSTOP("Aten��o, n�o existe pedido ligado a esse benefici�rio. Por favor, escolha outro benefici�rio e tente novamente.","N�o h� pedidos para o usu�rio selecionado.")
		Return
	EndIf
	
	oDlg := MSDialog():New(0,0,510,850,"Sele��o de Pedidos por Usu�rio",,,.F.,,,,,,.T.,,,.T. )
	
	oGrp1      	:= TGroup():New( 005,010,025,420,"",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
	
	oBrowse := TCBrowse():New(030,010,410,190,,aCab,aTam,oDlg,,,,,{|| },,,,,,,.F.,,.T.,,.F.,,, )
	oBrowse:SetArray(aVetPed)
	
	
	oBrowse:bLine := {||{ aVetPed[oBrowse:nAt,1],aVetPed[oBrowse:nAt,2],aVetPed[oBrowse:nAt,3],aVetPed[oBrowse:nAt,4],aVetPed[oBrowse:nAt,5]  } }
	
	oSBtn1     := SButton():New(230,365,1,{||lConfirm := .T.,	cMatUsu := BA1->BA1_MATRIC, cNomUsr := BA1->BA1_NOMUSR, cPed := aVetPed[oBrowse:nAt,1],oDlg:End()}	,oDlg,,"", )
	oSBtn2     := SButton():New(230,395,2,{||oDlg:End()}					,oDlg,,"", )
	
	oDlg:Activate(,,,.T.)
	
Return .T.



/*
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
�������������������������������������������������������������������������ͻ��
���Programa  �RETARRPED �Autor  �Renato Peixoto      � Data �  05/06/12   ���
�������������������������������������������������������������������������͹��
���Desc.     �Funcao que vai alimentar o vetor com os pedidos de cada     ���
���          �usuario selecionado.                                        ���
�������������������������������������������������������������������������͹��
���Uso       � AP                                                         ���
�������������������������������������������������������������������������ͼ��
�����������������������������������������������������������������������������
�����������������������������������������������������������������������������
*/

Static Function RetArrPed
	
	Local cQuery   := ""
	Local cAlias   := GetNextAlias()
	Local aArray   := {}
	//Local cPedidos := ""
	//Local cMatric  := MV_PAR01
	
	//Public cPedsOPME := ""
	
	cQuery := "SELECT distinct D1_PEDIDO PEDIDO, "
	cQuery += "       BD6_OPEUSR||'.'||BD6_CODEMP||'.'||BD6_MATRIC||'.'||BD6_TIPREG||'-'||BD6_DIGITO  MATRICULA, "
	cQuery += "       Trim(BD6_NOMUSR)  NOME_ASSOCIADO, "
	cQuery += "       E2_EMISSAO DATA_COMPRA, "
	cQuery += "       BD6_DATPRO DATA_SOLICITACAO "
	
	cQuery += "  FROM "+RetSqlName("B19")+" B19, "+RetSqlName("SD1")+" SD1, "+RetSqlName("SF1")+" SF1, "+RetSqlName("BD6")+" BD6 , "
	cQuery += " "+RetSqlName("SA2")+" SA2, "+RetSqlName("BA1")+" BA1, "+RetSqlName("SE2")+" SE2 "
	
	cQuery += " WHERE A2_FILIAL=' ' "
	cQuery += "   AND A2_COD = B19_FORNEC "
	cQuery += "   AND E2_FORNECE= A2_COD  "
	cQuery += "   AND D1_FORNECE= A2_COD  "
	cQuery += "   AND f1_FORNECE= A2_COD  "
	cQuery += "   AND D1_DOC = F1_DOC     "
	cQuery += "   AND B19_DOC = D1_DOC    "
	cQuery += "   AND D1_ITEM = B19_ITEM  "
	cQuery += "   AND D1_FORNECE = F1_FORNECE "
	cQuery += "   AND D1_FORNECE = B19_FORNEC "
	cQuery += "   AND F1_FORNECE = B19_FORNEC "
	cQuery += "   AND BD6_FILIAL = '  '       "
	cQuery += "   AND E2_FILIAL IN ('01','02') "
	cQuery += "   AND F1_FILIAL='01' "
	cQuery += "   AND BD6_CODOPE = SubStr(B19_GUIA,01,04) "
	cQuery += "   AND BD6_CODLDP = SubStr(B19_GUIA,05,04) "
	cQuery += "   AND BD6_CODPEG = SubStr(B19_GUIA,09,08) "
	cQuery += "   AND BD6_NUMERO = SubStr(B19_GUIA,17,08) "
	cQuery += "   AND BD6_ORIMOV = SubStr(B19_GUIA,25,01) "
	cQuery += "   AND BD6_SEQUEN = SUBSTR(B19_GUIA,26,03) "
	
	cQuery += "   AND BD6_OPEUSR='"+BA1->BA1_CODINT+"'   "
	cQuery += "   AND BD6_CODEMP='"+BA1->BA1_CODEMP+"'   "
	cQuery += "   AND BD6_MATRIC='"+BA1->BA1_MATRIC+"'   "
	cQuery += "   AND BD6_TIPREG='"+BA1->BA1_TIPREG+"'  "
	cQuery += "   AND BD6_DIGITO='"+BA1->BA1_DIGITO+"'  "
	/*cQuery += "   AND BD6_OPEUSR='0001'   "
	cQuery += "   AND BD6_CODEMP='0005'   "
	cQuery += "   AND BD6_MATRIC='025404' "
	cQuery += "   AND BD6_TIPREG='00'     "
	cQuery += "   AND BD6_DIGITO='3'      "
	*/
	cQuery += "   AND BD6_FASE IN (3,4)  "
	cQuery += "   AND BD6_CODLDP='0013'  "
	cQuery += "   AND BD6_SITUAC = 1     "
	cQuery += "   AND E2_PREFIXO = F1_SERIE "
	cQuery += "   AND E2_NUM = F1_DOC        "
	cQuery += "   AND SE2.D_E_L_E_T_ = ' '   "
	cQuery += "   AND SA2.D_E_L_E_T_ = ' '   "
	cQuery += "   AND B19.D_E_L_E_T_ = ' '   "
	cQuery += "   AND SD1.D_E_L_E_T_ = ' '   "
	cQuery += "   AND SF1.D_E_L_E_T_ = ' '   "
	cQuery += "   AND BD6.D_E_L_E_T_ = ' '   "
	
	cQuery += "   order by TO_DATE(E2_EMISSAO,'YYYYMMDD') DESC "
	
	
	If Select(cAlias) > 0
		(cAlias)->(DbCloseArea())
	EndIf
	
	*--------------------------------------------*
	*** Cria o alias executando a query
	*--------------------------------------------*
	DbUseArea(.T.,"TopConn",TcGenQry(,,cQuery),cAlias,.F.,.T.)
	
	DbSelectArea(cAlias)
	(cAlias)->(DbGoTOp())
	
	If !((cAlias)->(Eof()))
		While !((cAlias)->(Eof()))
			//cPedsOPME += (cAlias)->PEDIDO+"|"
			aAdd ( aArray, { (cAlias)->PEDIDO, (cAlias)->MATRICULA, (cAlias)->NOME_ASSOCIADO, STOD((cAlias)->DATA_COMPRA), STOD((cAlias)->DATA_SOLICITACAO) } )
			(cAlias)->(DbSkip())
		EndDo
	Else
		APMSGSTOP("Aten��o, n�o existe nenhum pedido associado ao benefici�rio informado.","N�o h� pedido a ser exibido.")
	EndIf
	
	
Return aArray




**********************
User Function CTBOPE()
	**********************
	
	//RAQUEL - novo relat�rio de contabiliza��o do opme
	
	Private cCRPar    :="1;0;1;Opme"
	Private cParam1   := ""
	Private cParam2   := ""
	Private cPerg     := "CTBOPE"
	Private cDataMovDe  := ""
	Private cDataMovAte  := ""
	Private cDataPgtDe  := ""
	Private cDataPgtAte  := ""
	Private cDataVencDe  := ""
	Private cDataVencAte  := ""
	
	cParam2:=Substr(cNumEmp,1,2)
	
	If !Pergunte(cPerg,.T.)
		Return
	Endif
	
	if Empty(mv_par08)
		cDataMovDe:="01/01/1901"
	else
		cDataMovDe:=dtoc(mv_par08)
	Endif
	
	if Empty(mv_par09)
		cDataMovAte:="01/01/1901"
	else
		cDataMovAte:=dtoc(mv_par09)
	Endif
	
	if Empty(mv_par10)
		cDataPgtDe:="01/01/1901"
	else
		cDataPgtDe:=dtoc(mv_par10)
	Endif
	
	if Empty(mv_par11)
		cDataPgtAte:="01/01/1901"
	else
		cDataPgtAte:=dtoc(mv_par11)
	Endif
	
	if Empty(mv_par12)
		cDataVencDe:="01/01/1901"
	else
		cDataVencDe:=dtoc(mv_par12)
	Endif
	
	if Empty(mv_par13)
		cDataVencAte:="01/01/1901"
	else
		cDataVencAte:=dtoc(mv_par13)
	Endif
	
	
	
	cParam1   := Alltrim(str(mv_par01))+";"+Alltrim(str(mv_par02))+";"+mv_par03+";"+mv_par04+";"+mv_par05+";"+mv_par06+";"+mv_par07+";"+cDataMovDe+";"+cDataMovAte+";"+cDataPgtDe+";"+cDataPgtAte+";"+cDataVencDe+";"+cDataVencAte+";"+cParam2
	/*Conjunto de op��es para nao mostrar a tela da SetPrint, composta por x;y;z;w, onde
	x = v�deo(1) ou impressora(3)
	y = Atualiza(0) ou n�o(1) os dados
	z = N�mero de c�pias
	w = T�tulo do relatorio.
	*/
	
	CallCrys("CTBOPE",cParam1,cCRPar)
	
	
	

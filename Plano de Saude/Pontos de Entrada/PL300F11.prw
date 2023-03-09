#INCLUDE 'PROTHEUS.CH'
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PL300F11  ºAutor  ³Renato Peixoto      º Data ³  11/05/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Ponto de entrada para tratar a tela que e chamada ao clicarº±±
±±º          ³ no botao "Dados Beneficiario" na rotina de agenda medica.  º±±
±±º          ³                                                            º±±          
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function PL300F11()

Local cCodPac   := ParamIxb[1]     // Codigo do Paciente
Local cCodEspec := Paramixb[2]     // Codigo da Especialidade Médica

Private oDlg 
Private oFont1

If Empty(cCodPac)
	APMSGALERT("Atenção, você deve primeiro selecionar um beneficiário para clicar neste botão")
	Return
Else
	DbSelectArea("BA1")
	DbSetOrder(2)
	If DbSeek(XFILIAL("BA1")+cCodPac)
	
		Define FONT oFont1 	NAME "Arial" SIZE 0,15  Bold
		
		DEFINE MSDIALOG oDlg TITLE "Dados do beneficiario escolhido" FROM 000,000 TO 150,320 PIXEL
		@ 010,009 Say "Data de Nascimento:" Size 059,008 COLOR CLR_BLACK PIXEL OF oDlg   //007
		//@ 018,009 ComboBox cComboBx1 Items aComboBx1 Size 121,010 PIXEL OF oDlg  //015
		@ 018,009 Say BA1->BA1_DATNAS     Size 121,012 FONT oFont1 COLOR CLR_HBLUE PIXEL OF oDlg  //015
		//@ 033,009 Say   "Diretorio"       Size 045,008 PIXEL OF oDlg   //030   008
		//@ 041,009 MSGET c_dirimp          Size 120,010 WHEN .F. PIXEL OF oDlg  //038
		
		@ 60,009 Button "OK"       Size 037,012 PIXEL OF oDlg Action oDlg:end()//(_nOpc := 1,oDlg:End())
		//@ 60,060 Button "Cancelar" Size 037,012 PIXEL OF oDlg Action oDlg:end()
	
		ACTIVATE MSDIALOG oDlg CENTERED
    
    EndIf
    
EndIf
		

Return
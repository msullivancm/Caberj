#Include 'PROTHEUS.CH'                               
#Include 'COLORS.CH'


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCABA060   บAutor  ณRenato Peixoto      บ Data ณ  04/03/12   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Rotina que ira chamar uma telinha para que o usuแrio possa บฑฑ
ฑฑบ          ณ alterar conteudo dos parametros para geracao rateio AUDIMEDบฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/


User Function CABA060() 

Local oDlg
Local c_dirimp  := space(100)
Local _nOpc	    := 0
Local cRDA      := GETMV("MV_YRDAAUD")//RDA a ser utilizado no rateio AUDIMED
local nVlrAud   := GETMV("MV_YVLRAUD")//valor a ser rateado, identificado por esse parametro
Local cNomRDA   := AllTrim(POSICIONE("BAU",1,XFILIAL("BAU")+cRDA,"BAU_NOME"))
Local lAlterRDA := .F.
Local lAlterVlr := .F.

If APMSGYESNO("Aten็ใo, atualmente o RDA "+cRDA+" - "+cNomRDA+" estแ parametrizado com valor igual a "+AllTrim(Transform(nVlrAud,"@E 999,999.99"))+". Deseja alterar essa parametriza็ใo?","Parametriza็ใo rateio AUDIMED.")
    
	Define FONT oFont1 	NAME "Arial" SIZE 0,15  Bold
	
	DEFINE MSDIALOG oDlg TITLE "Parametriza็ใo Rateio AUDIMED" FROM 000,000 TO 150,320 PIXEL
	//@ 010,009 Say "Tabela" Size 059,008 COLOR CLR_BLACK PIXEL OF oDlg   //007
	//@ 018,009 ComboBox cComboBx1 Items aComboBx1 Size 121,010 PIXEL OF oDlg  //015
	@ 018,009 Say   "RDA:"           Size 121,012 FONT oFont1 COLOR CLR_HBLUE PIXEL OF oDlg  //015
	@ 018,050 MSGET cRDA             Size 080,012 When .T. F3 "BAUPLS" PIXEL OF oDlg  //121 015
	@ 033,009 Say   "Valor Rateio:"  Size 045,008 FONT oFont1 COLOR CLR_HBLUE PIXEL OF oDlg   //030   008
	@ 033,050 MSGET nVlrAud          Size 080,010 WHEN .T. Picture "@E 999,999.99" PIXEL OF oDlg  //121 038
	
	@ 60,009 Button "OK"       Size 037,012 PIXEL OF oDlg Action(_nOpc := 1,oDlg:End())
	@ 60,060 Button "Cancelar" Size 037,012 PIXEL OF oDlg Action oDlg:end()

	ACTIVATE MSDIALOG oDlg CENTERED
    
	If _nOpc == 1
		
		If AllTrim(cRDA) <> AllTrim(GETMV("MV_YRDAAUD"))
			PutMvPar( "MV_YRDAAUD" , cRDA )
			lAlterRDA := .T.
		EndIf
		
		If nVlrAud <> GETMV("MV_YVLRAUD")
			PutMvPar( "MV_YVLRAUD", nVlrAud )
			lAlterVlr := .T.
		EndIf
		
	Endif
	
EndIf

If lAlterRDA
	APMSGINFO("Aten็ใo, o RDA parametrizado para rateio AUDIMED foi alterado. O novo RDA a ser utilizado ้ "+AllTrim(cRDA)+" - "+AllTrim(POSICIONE("BAU",1,XFILIAL("BAU")+cRDA,"BAU_NOME"))+".","RDA para rateio AUDIMED alterado e gravado na base de dados.")
EndIf

If lAlterVlr
	APMSGINFO("Aten็ใo, o valor parametrizado para o pagamento do rateio AUDIMED foi alterado. O novo valor a ser rateado ้ "+AllTrim(Transform(nVlrAud,"@E 999,999.99"))+".","Valor do rateio AUDIMED alterado e gravado na base de dados.")
EndIf

Return
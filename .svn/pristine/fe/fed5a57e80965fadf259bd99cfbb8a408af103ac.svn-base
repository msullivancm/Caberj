#INCLUDE "RWMAKE.CH"
#include "PLSMGER.CH"
#include "COLORS.CH"
#include "TOPCONN.CH"
/* 
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PLS001CLI ºAutor  ³Jean Schulz         º Data ³  27/05/09   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Ponto de entrada para alterar o prefixo do titulo, caso     º±±
±±º          ³trate-se de um reembolso de auxilio funeral.                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function PLS001CLI()

Local a_AreaRee	:= GetArea() 		//Leonardo Portella - 10/03/16
Local a_AreaB44	:= B44->(GetArea()) //Leonardo Portella - 10/03/16

LOCAL cCodCli	:= paramixb[1]  //Codigo do cliente padrao
LOCAL cLoja		:= paramixb[2]  //Loja Cliente padrao
LOCAL cNat		:= paramixb[3]  //Natureza Cliente
LOCAL cPrefixo	:= paramixb[4]  //Prefixo titulo
LOCAL cNumTit	:= paramixb[5]  //Numero do titulo
LOCAL cTipTit	:= paramixb[6]  //Tipo do titulo
LOCAL dVencto	:= paramixb[7]  //Dia do vencimento        
LOCAL bRetorno := { || {cCodCli,cLoja,cNat,cPrefixo,cNumTit,cTipTit,dVencto} }
Local aAreaSE1	:= SE1->(GetArea())
Local cSQL		:= ""
Local cPlano   := ""

ZZQ->(DbSetOrder(1))	// ZZQ_FILIAL+ZZQ_SEQUEN
if ZZQ->(DbSeek( xFilial("ZZQ") + B44->B44_YCDPTC ))

	if ZZQ->ZZQ_TPSOL == '1' .and. ZZQ->ZZQ_TIPPRO == '4'	// remmbolso de auxilio funeral
	//If alltrim(B44->B44_ZZZCOD) $ GETNEWPAR("MV_YTPAFUN","13")

		cPrefixo := GetNewPar("MV_YPREAUX","AXF")

		cSQL := " SELECT Max(E1_NUM) AS MAXNUM "
		cSQL += " FROM "+RetSQLName("SE1")+" SE1 "
		cSQL += " WHERE E1_FILIAL = '"+xFilial("SE1")+"' "
		cSQL += " AND E1_PREFIXO = '"+cPrefixo+"' "
		cSQL += " AND Length(Trim(E1_NUM)) = 9 " 
		cSQL += " AND SE1.D_E_L_E_T_ = ' ' "
			
		PLSQuery(cSQL,"TRBAXF")
		
		If Val(TRBAXF->MAXNUM) > 0
			cNumTit := Soma1(TRBAXF->MAXNUM)
		Else
			cNumTit := "000001"
		Endif
		
		TRBAXF->(DbCloseArea())

	endif

endif

RestArea(aAreaSE1)

cPlano := U_Codprod(B44->(B44_OPEUSR+B44_CODEMP+B44_MATRIC+B44_TIPREG+B44_DIGITO)) 
            
//Conforme Altamiro, modificar a natureza 
//conforme o plano do beneficiario
Do Case
	Case cPlano $ "0001001,0042001"
     cNat := "44201"     
   Case cPlano $ "0002001,0043001"
     cNat := "44204"          
   Case cPlano $ "0004001,0044001"
     cNat := "44206"
     	Case cPlano $ "0006001"
     cNat := "44202"
     	Case cPlano $ "0007001"
     cNat := "44205"           
   Case cPlano $ "0008001"
     cNat := "44207"
EndCase	

B44->(RestArea(a_AreaB44))	//Leonardo Portella - 10/03/16
RestArea(a_AreaRee) 		//Leonardo Portella - 10/03/16

Return(Eval(bRetorno)) 

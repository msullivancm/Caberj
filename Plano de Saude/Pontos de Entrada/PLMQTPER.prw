/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PLMQTPER  ºAutor  ³Leonardo Portella   º Data ³  21/12/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³PE para excluir a parametrização Qtd x Percentual em repas- º±±
±±º          ³ses.                                                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³Caberj                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function PLMQTPER

Local aArea			:= GetArea()
Local aArBD6		:= BD6->(GetArea())
Local aArBAU		:= BAU->(GetArea())
Local cCodSeq      	:= paramixb[1]
Local cCodPad      	:= paramixb[2]
Local cCodPro      	:= paramixb[3]
Local nQtdPro      	:= paramixb[4]
Local lMemory      	:= paramixb[5]
Local cChaveGui    	:= paramixb[6]
Local dDatPro      	:= paramixb[7]
Local lValid       	:= paramixb[8]
Local nPosBD6      	:= paramixb[9]
Local aBL0         	:= paramixb[10]
Local aRet    		:= paramixb[11]

If !empty(aRet)

	BD6->(DbSetOrder(1))//BD6_FILIAL+BD6_CODOPE+BD6_CODLDP+BD6_CODPEG+BD6_NUMERO+BD6_ORIMOV+BD6_SEQUEN+BD6_CODPAD+BD6_CODPRO
	
	If BD6->(DbSeek(cChaveGui))
	
		BAU->(DbSetOrder(1))//BAU_FILIAL+BAU_CODIGO
		
		If BAU->(DbSeek(xFilial('BAU') + BD6->BD6_CODRDA))
		 
			If 	( ( AllTrim(BD6->BD6_DESBPF) == "RATEIO INTERNISTAS" ) .or. ( BD6->BD6_CODLDP == '0017' ) );
					.or. ;
				( BAU->BAU_CODOPE $ GetNewPar("MV_YOPAVLC","") );
					.or. ;
				( ( cEmpAnt == '02' ) .and. ( BAU->BAU_CODIGO == '999997'/*RDA repasse Caberj/Integral*/ ) );
					.or. ;
				( ( cEmpAnt == '01' ) .and. ( BAU->BAU_CODIGO == '140880'/*RDA repasse Estaleiro*/ ) )
				
				aRet := {} //Não aplica Qtd x Percentuais
				
			EndIf
			
		EndIf
	
	EndIf
	
EndIf

BD6->(RestArea(aArBD6))
BAU->(RestArea(aArBAU))
RestArea(aArea)

Return aRet
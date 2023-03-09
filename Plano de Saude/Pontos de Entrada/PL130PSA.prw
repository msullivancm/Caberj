/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ PL130PSA ³ Autor ³ Wagner Mobile Costa   ³ Data ³ 03/06/03 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Alterao do Cod. Procedimento para Classificação SIP        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ PL130PSA                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function PL130PSA
Local cCodOpe		:= paramixb[1]
Local cCodLdp		:= paramixb[2]
Local cCodPeg		:= paramixb[3]
Local cNumero		:= paramixb[4]
Local cCodPad		:= paramixb[5]
Local cCodPro		:= paramixb[6] 
Local cNameBD6		:= RetSqlName("BD6")
Local cNameZZT		:= RetSqlName("ZZT")
Local cCodProRet	:= cCodPro
Local nIndexBFA		:= BFA->(Indexord())
Local cSql
Local nNat			:= 0
Local nPosaSip		:= 0
Local nPos15		:= 0
Local nPos141		:= 0
Local cCdSIP		:= ""

cSql := "SELECT ZZT_CODEV " 
cSql += "FROM "+cNameBd6+" BD6, "+cNameZZT+" ZZT  "
cSql += "WHERE BD6_FILIAL= '"+xFilial("BD6")+"' "
cSql += "AND BD6_CODOPE= '"+cCodOpe+"' "
cSql += "AND BD6_CODLDP= '"+cCodLdp+"' "
cSql += "AND BD6_CODPEG= '"+cCodPeg+"' "
cSql += "AND BD6_NUMERO= '"+cNumero+"' "
cSql += "AND BD6_CODPAD= '"+cCodpad+"' "
cSql += "AND BD6_CODPRO= '"+cCodPro+"' " 
cSql += "AND BD6.D_E_L_E_T_= ' ' "
cSql += "AND ZZT_FILIAL= '"+xFilial("ZZT")+"' " 
cSql += "AND ZZT_CODEV = RETORNA_EVENTO_BD5(BD6_OPEUSR,BD6_CODLDP, BD6_CODPEG,BD6_NUMERO,BD6_ORIMOV,BD6_CODPAD,BD6_CODPRO,BD6_MATVID,'C' ) "
cSql += "AND ZZT.D_E_L_E_T_= ' ' "

PLSQuery(cSql,"PEQRY")
PEQRY->(DbGoTop())

nPosaSip := aScan(aSip,{|x| x[iCodPsa]	 == cCodPro })
nPos15	 := aScan(aSip,{|x| AllTrim(x[iCodigo])	 == "1.5"  .and. !Empty(Alltrim(x[iCodPsa])) }) 
nPos141	 := aScan(aSip,{|x| AllTrim(x[iCodigo])	 == "1.4.1"  }) 
If nPosaSip > 0
	cCdSIP	 := AllTrim(aSip[nPosaSip,iCodigo])
Else
	cCdSIP	 := ""
EndIf
 
Do Case
	Case nPosaSip > 0 .and. !Empty(cCdSIP) .and. PEQRY->ZZT_CODEV == 1  .and. cCdSIP = '1.1'
		cCodProRet	:= cCodPro
	Case nPosaSip > 0 .and. !Empty(cCdSIP) .and. PEQRY->ZZT_CODEV == 6  .and. cCdSIP = '1.5'
		cCodProRet	:= cCodPro
	Case nPosaSip > 0 .and. !Empty(cCdSIP) .and. PEQRY->ZZT_CODEV == 7  .and. cCdSIP = '1.6'
		cCodProRet	:= cCodPro
	Case nPosaSip > 0 .and. !Empty(cCdSIP) .and. PEQRY->ZZT_CODEV == 30 .and. SubStr(cCdSIP,1,5) = '1.2.1' 
		cCodProRet	:= cCodPro
	Case nPosaSip > 0 .and. !Empty(cCdSIP) .and. PEQRY->ZZT_CODEV == 31 .and. SubStr(cCdSIP,1,5) = '1.2.2' 
		cCodProRet	:= cCodPro
	Case nPosaSip > 0 .and. !Empty(cCdSIP) .and. PEQRY->ZZT_CODEV == 32 .and. SubStr(cCdSIP,1,5) = '1.3.1'
		cCodProRet	:= cCodPro		
	Case nPosaSip > 0 .and. !Empty(cCdSIP) .and. PEQRY->ZZT_CODEV == 33 .and. SubStr(cCdSIP,1,5) = '1.3.2'
		cCodProRet	:= cCodPro
	Case PEQRY->ZZT_CODEV >= 34
		aSIP[nPos141,iEventos]  ++
		aSIP[nPos141,iCusto]   += nCusto
		aSIP[nPos141,iRecupe]  += nRecupe	
		cCodProRet := ""
	OtherWise
		cCodProRet	:= aSIP[nPos15,iCodPsa]
Endcase

PEQRY->(DbCloseArea())
Return(cCodProRet)
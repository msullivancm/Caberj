#include "PROTHEUS.CH"


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³MSREACB   ºAutor  ³Caberj              º Data ³  16/08/07   º±±  
±±º          ³          ºMotta  ³                    º      ³             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Monta a mensagem de reajuste (2006/2007) do contrato       º±±
±±º          ³ conforme os parametros do contrato                         º±±
±±º          ³ Usada pela Function bol_itau                               º±± 
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function MSREACB() 

Local cMsg   := ""
Local cMsg1  := "" 
Local cMsg2  := "" 
Local cMsg3  := ""  
Local cFix1  := "PLANO COLETIVO POR ADESAO SEM PATROCINADOR-"
Local cFix2  := " CONTRATO Nº "
Local cFix3  := " REGISTRADO SOB Nº " 
Local cFix4a := " REAJUSTADO EM 3,19% = 1,883%(ANS 5,76% PARCELA "
Local cFix4b := " REAJUSTADO EM 1,883%(ANS 5,76% PARCELA "
Local cFix5  := ") CONFORME OFICIO Nº 1783 DE 27/06/2007 "
Local cFix6  := ", PROXIMO REAJUSTE "
Local cQuin  := " + 1,285%(PLANO QUINQUENAL) " 
Local cParc  := ""    
Local aAreaBI3 := BI3->(GetArea()) 

//Motta reajuste 2009
If SE1->E1_anobase == "2009" .AND. SE1->E1_MESBASE == "07"
  If BA3->BA3_INDREA == "000005" .AND. BA3->BA3_MESREA $ "05,06,07"
    cMsg1  := "PLANO REAJUSTADO EM 6,76% CONFORME AUTORIZACAO DA ANS PUBLICADO NO D.O.U. DE 27/04/2009."
  End if
  If BA3->BA3_INDREA == "000005" .AND. BA3->BA3_MESREA = "05"
    cMsg2  := "LANCAMENTOS RETROATIVOS RELATIVOS A MAIO E JUNHO/2009."
  End if 
  If BA3->BA3_INDREA == "000005" .AND. BA3->BA3_MESREA = "06" 
    cMsg2  := "LANCAMENTO RETROATIVO RELATIVO A JUNHO/2009."
  End if
End if 
If SE1->E1_anobase+SE1->E1_MESBASE > "200907" .AND. SE1->E1_anobase+SE1->E1_MESBASE < "200909"                                                                                                                        
  If BA3->BA3_INDREA == "000005" .AND. BA3->BA3_MESREA == SE1->E1_MESBASE
    cMsg1  := "PLANO REAJUSTADO EM 6,76% CONFORME AUTORIZACAO DA ANS PUBLICADO NO D.O.U. DE 27/04/2009."
  End if
End if   


//Motta
If SE1->E1_anobase == "2009" .AND. SE1->E1_MESBASE == "05"
  cMsg1  := "DE 27/04 A 08/05/09, A CABERJ VACINA CONTRA GRIPE PESSOAS COM MAIS DE 60 ANOS. O HORARIO NA SEDE"                                                                                                                            
  cMsg2  := "E DAS 9H30 AS 17H E NOS NUPRES NITEROI, TIJUCA E BANGU, DAS 10H AS 17H."                                                                                               
  cMsg3  := "" 
Endif 

// Motta 
If SE1->E1_ANOBASE+SE1->E1_MESBASE >= "200808" .AND. SE1->E1_ANOBASE+SE1->E1_MESBASE <= "200906"
  If SE1->E1_ANOBASE+SE1->E1_MESBASE = "200809"
    If BA3->BA3_CODEMP = "0007"
      cMsg1 := "Plano coletivo por adesão sem patrocinador. Reajustado em 5,48 conf. RN 171 da ANS"
    Endif
  Endif 
  If BA3->BA3_YREAPC == "1"
    If BA3->BA3_MESREA == SE1->E1_MESBASE
      nPar := GetNewPar("MV_YNRPARE",3)
      If Val(BA3->BA3_MESREA) <= 6
        nDe := Val(BA3->BA3_MESREA) - 12
      Else
        nDe := Val(BA3->BA3_MESREA) 
      Endif
      If Val(BA3->BA3_YMESRE) <= 6
        nAte := Val(BA3->BA3_YMESRE) - 12
      Else
        nAte := Val(BA3->BA3_YMESRE) 
      Endif
      cParc = AllTrim(Str((nAte - nDe + 1))) + '/' + AllTrim(Str(nPar))
      cMsg1 := "PLANO COLETIVO POR ADESAO SEM PATROCINADOR-" + ALLTRIM(BI3->BI3_DESCRI) + " REG. SOB NUM. " + FRMNSUS(BI3->BI3_SUSEP) 
      cMsg2 := "REAJUSTADO EM 5,48% (DIVIDIDO EM 3 PARCELAS) CONFORNE RN/0171 DA ANS. "
      If BI3->(dbSeek(xFilial("BI3")+BA3->BA3_CODINT+BA3->BA3_CODPLA+BA3->BA3_VERSAO))
        If BI3->BI3_YGRPLA = "2" //afinidade
          If BA3->BA3_CODPLA == "0006" //afin (antigo) nao opt
            cMsg1 := "PLANO COLETIVO POR ADESAO SEM PATROCINADOR-" + ALLTRIM(BI3->BI3_DESCRI) + " CONT.NUM. " + ALLTRIM(BI3->BI3_CODANT) 
            cMsg2 := "REAJUSTADO EM 5,48% (DIVIDIDO EM 3 PARCELAS) CONFORNE RN/0171 DA ANS. "          
          Endif
        Endif  
      Endif
    Endif
  Endif
Endif
cMsg1 := Alltrim(cMsg1) + Space(100 - Len(Alltrim(cMsg1))) //Quebrar a linha na saida
cMsg2 := Alltrim(cMsg2) + Space(100 - Len(Alltrim(cMsg2)))
cMsg  := cMsg1 + cMsg2

If SE1->E1_ANOBASE+SE1->E1_MESBASE = "200808" 
  cSqlBSQ := "SELECT COUNT(*) QTD "
  cSqlBSQ += "FROM   BSQ010 "
  cSqlBSQ += "WHERE  BSQ_FILIAL = '" + BA3->BA3_FILIAL + "' " 
  cSqlBSQ += "AND    BSQ_CODINT = '" + BA3->BA3_CODINT + "' "   
  cSqlBSQ += "AND    BSQ_CODEMP = '" + BA3->BA3_CODEMP + "' "  
  cSqlBSQ += "AND    BSQ_MATRIC = '" + BA3->BA3_MATRIC + "' " 
  cSqlBSQ += "AND    BSQ_OBS LIKE '%DIFER%1,883%' " 
  cSqlBSQ += "AND    D_E_L_E_T_ = ' ' " 	
  PLSQuery(cSqlBSQ,"TBSQ")   

	If TBSQ->(QTD) > 0 
	  cMsg3 := "LANCAMENTO DE DIFERENCA DE MENSALIDADE DE JULHO/08 , COBRADO A MENOR ,NESTA REFERENCIA." 
	  cMsg3 := Alltrim(cMsg3) + Space(100 - Len(Alltrim(cMsg3)))
	  cMsg  += cMsg3
   Endif  	  
  TBSQ->(DbCloseArea())
Endif

If SE1->E1_anobase == "2008" .AND. SE1->E1_MESBASE == "07" .AND. BA3->BA3_MESREA == "07" .AND. BA3->BA3_INDREA == "000001"
  cMsg := "PLANO COLETIVO POR ADESÃO SEM PATROCINADOR-" + ALLTRIM(BI3->BI3_NREDUZ) + " CONT.Nº" + ALLTRIM(BI3->BI3_CODANT) + " REG. SOB Nº " + FRMNSUS(BI3->BI3_SUSEP) + "REAJUSTADO EM 5,48% CONFORNE RN Nº 171 ANS"
Endif

//If SE1->E1_anobase == "2008" .AND. (SE1->E1_MESBASE == "04" .OR. SE1->E1_MESBASE == "05")  
If SE1->E1_anobase == "2009" .AND. (SE1->E1_MESBASE == "03" .OR. SE1->E1_MESBASE == "04") //que mes?
  cMsg := U_IR2007()
Endif

If SE1->E1_anobase == "2008" .AND. SE1->E1_MESBASE == "03"
  cMsg := "AS DESPESAS MEDICAS, ANO-BASE 2007, PARA FINS DE DECLARACAO DE IMPOSTO DE RENDA (IR),     SERAO INFORMADAS NO PROXIMO EXTRATO DE ATENDIMENTO"
Endif      

//ERRO AED MENSAGEM ESPECIAL
If SE1->E1_anobase == "2008" .AND. SE1->E1_MESBASE == "12"  .AND. SE1->E1_PLNUCOB = "000100007234"
  cMsg := "FAVOR DESCONSIDERAR O BOLETO ENVIADO ANTERIORMENTE"
Endif  

If SE1->E1_anobase == "2007" 
  If SE1->E1_MESBASE == "09"
    cParc := "2/3"
  Endif
  If SE1->E1_MESBASE == "10"
    cParc := "3/3"
  Endif
Endif  
 
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Obter dados do plano  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
BI3->(dbSetOrder(1)) 
If BI3->(dbSeek(xFilial("BI3")+BA3->BA3_CODINT+BA3->BA3_CODPLA+BA3->BA3_VERSAO))
  If BI3->BI3_YGRPLA = "2" //afinidade
    If BA3->BA3_CODPLA == "0006" //afin (antigo) nao opt
      If (SE1->E1_ANOBASE == "2007" .AND. (SE1->E1_MESBASE == "09" .OR. SE1->E1_MESBASE == "10"))    
        If BA3->BA3_SUBCON = "000000007"
          cMsg := cFix1 + ALLTRIM(BI3->BI3_NREDUZ) + cFix2 + ALLTRIM(BI3->BI3_CODANT) + cFix3 + "999.999"      + cFix4b + cParc + cFix5 + cFix6 + "07/08"
        Elseif BA3->BA3_SUBCON = "000000002"//afin (antigo) opt
          cMsg := cFix1 + ALLTRIM(BI3->BI3_NREDUZ) + cFix2 + ALLTRIM(BI3->BI3_CODANT) + cFix3 + "999.999"      + cFix4a + cParc + cFix5 + cQuin + cFix6 + "07/08"  
        Endif
      Endif
    Else
      cParc := "" 
      If SE1->E1_ANOBASE == "2007" 
        If SE1->E1_MESBASE == "09" .AND. BA3->BA3_MESREA == "09"
          cParc := "1/3"
        Endif
        If SE1->E1_MESBASE == "10" .AND. BA3->BA3_MESREA == "09" //180907
          cParc := "2/3"
        Endif
        If SE1->E1_MESBASE == "11" .AND. BA3->BA3_MESREA == "09" //180907
          cParc := "3/3"
        Endif
        If SE1->E1_MESBASE == "10" .AND. BA3->BA3_MESREA == "10"
          cParc := "1/3"
        Endif
        If SE1->E1_MESBASE == "11" .AND. BA3->BA3_MESREA == "10" 
          cParc := "2/3"
        Endif
        If SE1->E1_MESBASE == "11" .AND. BA3->BA3_MESREA == "11"
          cParc := "1/3"
        Endif 
        If SE1->E1_MESBASE == "12" .AND. BA3->BA3_MESREA == "10" 
          cParc := "3/3"
        Endif
        If SE1->E1_MESBASE == "12" .AND. BA3->BA3_MESREA == "11"
          cParc := "2/3"
        Endif
         If SE1->E1_MESBASE == "12" .AND. BA3->BA3_MESREA == "12"
          cParc := "1/3"
        Endif
      Endif 
      If Substr(DToS(BA3->BA3_DATBAS),1,4) <> "2007" .AND. BA3->BA3_INDREA <> "000003" .AND. cParc <> ""
        If BA3->BA3_MESREA == "08" .OR. BA3->BA3_MESREA == "09" .OR. BA3->BA3_MESREA == "10" .OR. BA3->BA3_MESREA == "11"  
          cMsg := cFix1 + ALLTRIM(BI3->BI3_NREDUZ) + cFix2 + ALLTRIM(BI3->BI3_CODANT) + cFix3 + FRMNSUS(BI3->BI3_SUSEP) + cFix4b + cParc + cFix5 + cFix6 + BA3->BA3_MESREA + '/08'  
        Endif
      Endif
    Endif  
  Elseif BI3->BI3_YGRPLA = "4" //mater
    If BA3->BA3_CODPLA == "0001" .AND.; 
       (SE1->E1_ANOBASE == "2007" .AND. (SE1->E1_MESBASE == "09" .OR. SE1->E1_MESBASE == "10")) .AND.;  
       (U_QTDFXE() = 7)  
          cMsg := cFix1 + ALLTRIM(BI3->BI3_NREDUZ) + cFix2 + ALLTRIM(BI3->BI3_CODANT) + cFix3 + FRMNSUS(BI3->BI3_SUSEP) + cFix4b + cParc + cFix5 + cFix6 + "07/08"
    Else
      cParc := ""
      If SE1->E1_ANOBASE == "2007" 
        If SE1->E1_MESBASE == "09" .AND. BA3->BA3_MESREA == "09"
          cParc := "1/3"
        Endif
        If SE1->E1_MESBASE == "10" .AND. BA3->BA3_MESREA == "09" //180907
          cParc := "2/3"
        Endif
        If SE1->E1_MESBASE == "11" .AND. BA3->BA3_MESREA == "09" //180907
          cParc := "3/3"
        Endif
        If SE1->E1_MESBASE == "10" .AND. BA3->BA3_MESREA == "10"
          cParc := "1/3"
        Endif
        If SE1->E1_MESBASE == "11" .AND. BA3->BA3_MESREA == "10" 
          cParc := "2/3"
        Endif
        If SE1->E1_MESBASE == "11" .AND. BA3->BA3_MESREA == "11"
          cParc := "1/3"
        Endif  
         If SE1->E1_MESBASE == "12" .AND. BA3->BA3_MESREA == "10" 
          cParc := "3/3"
        Endif
        If SE1->E1_MESBASE == "12" .AND. BA3->BA3_MESREA == "11"
          cParc := "2/3"
        Endif
         If SE1->E1_MESBASE == "12" .AND. BA3->BA3_MESREA == "12"
          cParc := "1/3"
        Endif
      Endif
      If Substr(DToS(BA3->BA3_DATBAS),1,4) <> "2007" .AND. BA3->BA3_INDREA <> "000003" .AND. cParc <> ""
        If BA3->BA3_MESREA == "08" .OR. BA3->BA3_MESREA == "09" .OR. BA3->BA3_MESREA == "10" .OR. BA3->BA3_MESREA == "11"  
          cMsg := cFix1 + ALLTRIM(BI3->BI3_NREDUZ) + cFix2 + ALLTRIM(BI3->BI3_CODANT) + cFix3 + FRMNSUS(BI3->BI3_SUSEP) + cFix4b + cParc + cFix5 + cFix6 + BA3->BA3_MESREA + '/08'  
        Endif
      Endif
    Endif
  Endif //BI3->BI3_YGRPLA = "2" 
  
  If !(SE1->E1_anobase == "2008" .AND. (SE1->E1_MESBASE == "04" .OR. SE1->E1_MESBASE == "05"))
    If BA3->BA3_INDREA == "000003"
      cMsg := ""
    Endif
  Endif
  
  If SE1->E1_ANOBASE == "2007" .AND. SE1->E1_MESBASE == "09"
    If BA3->BA3_INDREA == "000003" .AND. BA3->BA3_MESREA == "09"
      cMsg := "PLANO COLETIVO POR ADESÃO SEM PATROCINADOR-" + ALLTRIM(BI3->BI3_NREDUZ) + " CONT.Nº" + ALLTRIM(BI3->BI3_CODANT) + " REG. SOB Nº " + FRMNSUS(BI3->BI3_SUSEP) + "REAJUSTADO EM 8,89% CONFORME OFÍCIO ANS Nº418 DE 28.06.2006."
    Endif
  Endif
  If SE1->E1_ANOBASE == "2007" .AND. SE1->E1_MESBASE == "10"
    If BA3->BA3_INDREA == "000003" .AND. BA3->BA3_MESREA == "10"
      cMsg := "PLANO COLETIVO POR ADESÃO SEM PATROCINADOR-" + ALLTRIM(BI3->BI3_NREDUZ) + " CONT.Nº" + ALLTRIM(BI3->BI3_CODANT) + " REG. SOB Nº " + FRMNSUS(BI3->BI3_SUSEP) + "REAJUSTADO EM 8,89% CONFORME OFÍCIO ANS Nº418 DE 28.06.2006."
    Endif
  Endif
  If SE1->E1_ANOBASE == "2007" .AND. SE1->E1_MESBASE == "11"
    If BA3->BA3_INDREA == "000003" .AND. BA3->BA3_MESREA == "11"
      cMsg := "PLANO COLETIVO POR ADESÃO SEM PATROCINADOR-" + ALLTRIM(BI3->BI3_NREDUZ) + " CONT.Nº" + ALLTRIM(BI3->BI3_CODANT) + " REG. SOB Nº " + FRMNSUS(BI3->BI3_SUSEP) + "REAJUSTADO EM 8,89% CONFORME OFÍCIO ANS Nº418 DE 28.06.2006."
    Endif
  Endif
Endif //BI3->(dbSeek

//RestArea(aAreaBI3)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Fim da rotina                                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Return cMsg    


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³QTDFXE    ºMotta  ³Caberj              º Data ³  08/18/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Retorna quantidade de faixa etarias do titular de uma      º±±
±±º          ³ familia                                                    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/  
User Function QTDFXE()

Local nQtd  := 0
Local cSqlFX := "" 



//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ0¿
//³Supõe que a BA3 já esteja ponteirada³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ0Ù


cSqlFX := "SELECT COUNT(R_E_C_N_O_) QTD   "
cSqlFX += "FROM   "+RetSQLName("BDK")+" BDK "
cSqlFX += "WHERE  BDK.BDK_FILIAL = '  '  "  
cSqlFX += "AND    BDK.BDK_CODINT = '" + BA3->BA3_CODINT + "' "  
cSqlFX += "AND    BDK.BDK_CODEMP = '" + BA3->BA3_CODEMP + "' "  
cSqlFX += "AND    BDK.BDK_MATRIC = '" + BA3->BA3_MATRIC + "' "  
cSqlFX += "AND    BDK.BDK_TIPREG = '00' "
cSqlFX += "AND    BDK.D_E_L_E_T_ = ' ' "  
	
PLSQuery(cSqlFX,"TFX")

While ! TFX->(EOF()) 
    nQtd := TFX->QTD
    TFX->(DbSkip())						
Enddo	

TFX->(DbCloseArea())

Return nQtd     


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FRMNSUS   ºMotta  ³Caberj              º Data ³  08/18/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Formata nº SUS (ANS)                                       º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

Static Function FRMNSUS(cNumANS)

cNumANS := Substr(cNumANS,1,3) + "." + Substr(cNumANS,4,3) + "/" + Substr(cNumANS,7,2) + "-"  + Substr(cNumANS,9,1)

Return cNumANS

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³IR2007    ºMotta  ³Caberj              º Data ³  11/01/08   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ rETORNA A LINHA COM TOTAL DE IR 2007                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/  
User Function IR2007()

Local cLinIR := " "
Local cSqlIR := " " 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ0¿
//³Supõe que a BA3 já esteja ponteirada³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ0Ù

cSqlIR := "SELECT SUM(VALOR) VALOR "
cSqlIR += "FROM   IR_BENEF "
cSqlIR += "WHERE  CODINT = '" + BA3->BA3_CODINT + "' "  
cSqlIR += "AND    CODEMP = '" + BA3->BA3_CODEMP + "' "  
cSqlIR += "AND    MATRIC = '" + BA3->BA3_MATRIC + "' " 
cSqlIR += "AND    ANOBASEIR = 2008 "
	
	
PLSQuery(cSqlIR,"TIR")   

If TIR->(VALOR) > 0 
//	cLinIR := "IR - VALOR PAGO A CABERJ NO ANO 2007 " + BA3->BA3_CODINT + "." + BA3->BA3_CODEMP + "." + BA3->BA3_MATRIC + " R$ " + Transform(TIR->VALOR,"@E 999,999.99")  
	cLinIR := "IR - VALOR PAGO A CABERJ NO ANO 2008 " + BA3->BA3_CODINT + "." + BA3->BA3_CODEMP + "." + BA3->BA3_MATRIC + " R$ " + Transform(TIR->VALOR,"@E 999,999.99") 
endif  						

//Alert(cLinIR) 

TIR->(DbCloseArea())

Return cLinIR     
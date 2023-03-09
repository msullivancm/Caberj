#Include "protheus.ch"
#Include "rwmake.ch"
#Include "topconn.ch"
#INCLUDE "plsmcon.ch"                            
**'-----------------------------------------------------------------------'**                                                                            
**'--Rotina para geração de SE2-------------------------------------------'**                                                                            
**'-----------------------------------------------------------------------'**
User Function GrAcrSe2(cCusto , cParte, cVenc)  
	Local l_Ret     := .f.   
	Local xFornece  := " "
	//Local a_DadosSE2:= {}
	Local _cErro    := ""

	//default d_DataEmis  := ""
	private  a_Banco    := &(GetMv("MV_XBCOPA"))

	Private cAliastmp   := GetNextAlias()   
	Private cAliastmp1  := GetNextAlias()  
	Private cAliastmp2  := GetNextAlias()       
	Private cAliastmp3  := GetNextAlias()  
	Private cAliastmp4  := GetNextAlias()
	Private cAliastmp5  := GetNextAlias()  
	Private cAliastmp6  := GetNextAlias()

	private a_DadosSE2  := {}
	private cParcIrrf   := ' '  
	private cParcIns    := ' '
    
    private X           := 1  
    private X2          := 0 
 
    Private cRdaAtu     := ' '  
    
	PRIVATE aDadostit1  := {} // falta titulos de impostos inss ou irrf
	PRIVATE aDadostit2  := {} // titulos de impostos deletados do sistema inss ou irrf 
	PRIVATE aDadostit3  := {} // estrato da ação

	PRIVATE aLog        := {} // vetor de erro do sistemas

    PRIVATE nVidx0      := 0
	PRIVATE nVidx1      := 0  
    PRIVATE nVidx2      := 0
    PRIVATE nVidx3      := 0

	PRIVATE cCusto      := '202105'   
    PRIVATE cCompte     := cCusto

   Private  cParte      := '3'
   Private  cSecao      := cParte 
   
   Private  cVenc       := '20210530'
   Private  cVencto     := cVenc

   If  cParte == '0' 	
       fparte0()	//- acerta o titulo de pagamento e as referencias ao impostos
    ElseIf cParte == '1'
     fparte1()   //- criaos titulos de impostos que nao foram criados IRRF
//	fparte2()   //- vincula a paracela ir e inss no titulo principal -- NUNCA RODAR ----
    ElseIf cParte == '3'
  	   fparte3()   //- acerta o demonstrativo
	EndIf

//return() 

STATIC FUNCTION fparte0()

    local cQuery0 := ' '
	local cScript0:= ' ' 
	
cQuery0 := " Select Calc.Baixa   CBaixa  , "
cQuery0 += CRLF + " Calc.Numbor Numbor   , "
cQuery0 += CRLF + " Calc.VencRea CVencRea, "
cQuery0 += CRLF + " Calc.Emissao  CEmissao, " 
cQuery0 += CRLF + " Calc.CodRda   CCodRda , " 
cQuery0 += CRLF + " Calc.Tit      CTit    , "  
cQuery0 += CRLF + " Calc.Plote    CPlote  , "
cQuery0 += CRLF + " Calc.fornece  CFornece , " 
cQuery0 += CRLF + " Calc.CodRet   CCodRet , "
cQuery0 += CRLF + " Calc.Valor    CValor  , "
cQuery0 += CRLF + " Calc.irrf     CIrrf   , "
cQuery0 += CRLF + " trunc(Calc.Irpfcal,2)  CIrpfcal, "
cQuery0 += CRLF + " Calc.inss     CInss   , "
cQuery0 += CRLF + " trunc(Calc.Insscalc,2) CInsscalc, "
cQuery0 += CRLF + " Calc.Vlrbrut  CVlrbrut, "
cQuery0 += CRLF + " Calc.Decl     CDecl, "
cQuery0 += CRLF + " Calc.Declar   CDeclar, "
cQuery0 += CRLF + " Calc.vlrpag   CVlrpag, "

cQuery0 += CRLF + " Decode(Calc.Insscalc, 0,' ' ,'1') parc, "

cQuery0 += CRLF + " 'UPDATE " +RetSQLName("SE2")+ " SET E2_PARCINS = ''' ||Decode(Calc.Insscalc, 0,' ' ,'1')||''', E2_PARCIR = '''||DECODE(Calc.Irpfcal, 0,' ' ,'1')||''', E2_IRRF = '||Trunc(Calc.Irpfcal,2) ||' , E2_baseirf = '||Trunc((Vlrbrut  - Calc.Insscalc),2)||' ,E2_vlcruz = '||Trunc((Vlrbrut - Calc.Irpfcal - Calc.Insscalc),2)||' , E2_INSS = '||Trunc( Calc.Insscalc,2) ||', E2_VALOR ='||Trunc((Vlrbrut  - Calc.Irpfcal - Calc.Insscalc),2)||' ,E2_SALDO ='||Trunc((Vlrbrut  - Calc.Irpfcal - Calc.Insscalc),2)|| ' WHERE e2_filial = '''||'01'||''' and d_E_L_E_T_ = '''||' '|| ''' and  e2_fornece = '''||calc.Fornece||''' and E2_PREFIXO || E2_NUM || E2_TIPO = '''||  Calc.Tit ||''';'  Fazse2 , "
cQuery0 += CRLF + " (Case When (Trunc( Calc.Insscalc,2)) <> Calc.Inss  "
cQuery0 += CRLF + "       Then ('UPDATE  " +RetSQLName("SE2")+ " SET  e2_parcela = '''||Decode(Calc.Insscalc, 0,' ' ,'1')||''', E2_VALOR ='||Trunc(( Calc.Insscalc),2)||' ,E2_SALDO ='||Trunc((Calc.Insscalc),2)||' WHERE e2_filial = '''||'01'||''' and d_E_L_E_T_ = '''||' '|| ''' and  E2_PREFIXO || E2_NUM || E2_TIPO = '''||  Substr(Calc.Tit,1,12) ||'INS'';') Else ' ' End) Fazins , "
cQuery0 += CRLF + " (Case When Trunc(Calc.Irpfcal,2) <> Calc.Irrf "
cQuery0 += CRLF + "       Then ('UPDATE " +RetSQLName("SE2")+ " SET  e2_parcela = '''||DECODE(Calc.Irpfcal, 0,' ' ,'1')||''',  E2_VALOR ='||Trunc((Calc.Irpfcal),2)||' ,E2_SALDO ='||Trunc((Calc.Irpfcal),2)||' WHERE e2_filial = '''||'01'||''' and d_E_L_E_T_ = '''||' '|| ''' and  E2_PREFIXO || E2_NUM || E2_TIPO = '''||  Substr(Calc.Tit,1,12) ||'TX'';' ) Else ' ' End) Faztxs "

cQuery0 += CRLF + " From (Select E2_Baixa Baixa , " 
cQuery0 += CRLF + "              E2_numbor Numbor   , "
cQuery0 += CRLF + "              E2_Vencrea VencRea , "
cQuery0 += CRLF + "              E2_Emissao Emissao , " 
cQuery0 += CRLF + "              E2_Codrda CodRda   , " 
cQuery0 += CRLF + "              E2_Prefixo||E2_Num||E2_Tipo Tit , " 
cQuery0 += CRLF + "              E2_Pllote  Plote  , "
cQuery0 += CRLF + "              E2_fornece Fornece , "  
cQuery0 += CRLF + "              E2_Codret  CodRet , "
cQuery0 += CRLF + "              E2_Valor   Valor  , "
cQuery0 += CRLF + "              E2_Irrf    irrf   , " 
cQuery0 += CRLF + "              Trunc ( "            
cQuery0 += CRLF + "              Case  When ((E2_Valor+E2_Irrf + E2_Inss) - (Case When  ((E2_Valor+E2_Irrf + E2_Inss) *  (Decode(Nvl(Bbc.Bbc_Codigo,'Sem decl'),'Sem decl',0.11,0))  ) > 707.69 Then 707.69 Else ((E2_Valor+E2_Irrf + E2_Inss) *  (Decode(Nvl(Bbc.Bbc_Codigo,'Sem decl'),'Sem decl',0.11,0)) ) End) ) >= 4664.68 "
cQuery0 += CRLF + "                    Then ((((E2_Valor+E2_Irrf + E2_Inss) - (Case When ((E2_Valor+E2_Irrf + E2_Inss) * (Decode(Nvl(Bbc.Bbc_Codigo,'Sem decl'),'Sem decl',0.11,0)) ) > 707.69 Then 707.69 Else ((E2_Valor+E2_Irrf + E2_Inss) *  (Decode(Nvl(Bbc.Bbc_Codigo,'Sem decl'),'Sem decl',0.11,0)) ) End) )  * 0.275) - 869.36) "
cQuery0 += CRLF + "                    When (((E2_Valor+E2_Irrf + E2_Inss)- (Case When  ((E2_Valor+E2_Irrf + E2_Inss) *  (Decode(Nvl(Bbc.Bbc_Codigo,'Sem decl'),'Sem decl',0.11,0))  ) > 707.69 Then 707.69 Else ((E2_Valor+E2_Irrf + E2_Inss) *  (Decode(Nvl(Bbc.Bbc_Codigo,'Sem decl'),'Sem decl',0.11,0)) ) End) ) >= 3751.06 And  (E2_Valor+E2_Irrf + E2_Inss) - (Case When  ((E2_Valor+E2_Irrf + E2_Inss) *  (Decode(Nvl(Bbc.Bbc_Codigo,'Sem decl'),'Sem decl',0.11,0))  ) > 707.69 Then 707.69 Else ((E2_Valor+E2_Irrf + E2_Inss) *  (Decode(Nvl(Bbc.Bbc_Codigo,'Sem decl'),'Sem decl',0.11,0))  ) End) < 4664.68) "       
cQuery0 += CRLF + "                    Then ((((E2_Valor+E2_Irrf + E2_Inss)- (Case When  ((E2_Valor+E2_Irrf + E2_Inss) * (Decode(Nvl(Bbc.Bbc_Codigo,'Sem decl'),'Sem decl',0.11,0)) ) > 707.69 Then 707.69 Else ((E2_Valor+E2_Irrf + E2_Inss) *  (Decode(Nvl(Bbc.Bbc_Codigo,'Sem decl'),'Sem decl',0.11,0)) ) End) )  * 0.225) - 636.13) "
cQuery0 += CRLF + "                    When (((E2_Valor+E2_Irrf + E2_Inss)- (Case When  ((E2_Valor+E2_Irrf + E2_Inss) *  (Decode(Nvl(Bbc.Bbc_Codigo,'Sem decl'),'Sem decl',0.11,0))  ) > 707.69 Then 707.69 Else ((E2_Valor+E2_Irrf + E2_Inss) *  (Decode(Nvl(Bbc.Bbc_Codigo,'Sem decl'),'Sem decl',0.11,0)) ) End) ) >= 2826.66 And (E2_Valor+E2_Irrf + E2_Inss)- (Case When  ((E2_Valor+E2_Irrf + E2_Inss) *  (Decode(Nvl(Bbc.Bbc_Codigo,'Sem decl'),'Sem decl',0.11,0))  ) > 707.69 Then 707.69 Else ((E2_Valor+E2_Irrf + E2_Inss) *  (Decode(Nvl(Bbc.Bbc_Codigo,'Sem decl'),'Sem decl',0.11,0))  ) End) < 3751.06 )  "     
cQuery0 += CRLF + "                    Then ((((E2_Valor+E2_Irrf + E2_Inss)- (Case When  ((E2_Valor+E2_Irrf + E2_Inss) * (Decode(Nvl(Bbc.Bbc_Codigo,'Sem decl'),'Sem decl',0.11,0)) ) > 707.69 Then 707.69 Else ((E2_Valor+E2_Irrf + E2_Inss) *  (Decode(Nvl(Bbc.Bbc_Codigo,'Sem decl'),'Sem decl',0.11,0)) ) End) )  * 0.15) - 354.80 ) "                   
cQuery0 += CRLF + "                    When (((E2_Valor+E2_Irrf + E2_Inss)- (Case When  ((E2_Valor+E2_Irrf + E2_Inss) *  (Decode(Nvl(Bbc.Bbc_Codigo,'Sem decl'),'Sem decl',0.11,0))  ) > 707.69 Then 707.69 Else ((E2_Valor+E2_Irrf + E2_Inss) *  (Decode(Nvl(Bbc.Bbc_Codigo,'Sem decl'),'Sem decl',0.11,0)) ) End) ) >= 1903.99 And (E2_Valor+E2_Irrf + E2_Inss) - (Case When  ((E2_Valor+E2_Irrf + E2_Inss) *  (Decode(Nvl(Bbc.Bbc_Codigo,'Sem decl'),'Sem decl',0.11,0))  ) > 707.69 Then 707.69 Else ((E2_Valor+E2_Irrf + E2_Inss) *  (Decode(Nvl(Bbc.Bbc_Codigo,'Sem decl'),'Sem decl',0.11,0))  ) End) < 2826.66 ) "      
cQuery0 += CRLF + "                    Then ((((E2_Valor+E2_Irrf + E2_Inss)- (Case When  ((E2_Valor+E2_Irrf + E2_Inss) * (Decode(Nvl(Bbc.Bbc_Codigo,'Sem decl'),'Sem decl',0.11,0)))  > 707.69 Then 707.69 Else ((E2_Valor+E2_Irrf + E2_Inss) * (Decode(Nvl(Bbc.Bbc_Codigo,'Sem decl'),'Sem decl',0.11,0))  ) End) )  * 0.075) - 142.80 ) "                   
cQuery0 += CRLF + "             Else 0 End,2)  Irpfcal , "
cQuery0 += CRLF + "             E2_Inss inss, "
cQuery0 += CRLF + "              Trunc ( "
cQuery0 += CRLF + "             Case When  ((E2_Valor+E2_Irrf + E2_Inss) *  (Decode(Nvl(Bbc.Bbc_Codigo,'Sem decl'),'Sem decl',0.11,0))  ) > 707.69 Then 707.69 Else ((E2_Valor+E2_Irrf + E2_Inss) *  (Decode(Nvl(Bbc.Bbc_Codigo,'Sem decl'),'Sem decl',0.11,0))) End,2)  Insscalc ,"
cQuery0 += CRLF + "             (E2_Valor+E2_Irrf + E2_Inss) Vlrbrut , "
cQuery0 += CRLF + "             Nvl(Bbc.Bbc_Codigo , 'Sem decl') Decl , "
cQuery0 += CRLF + "             Decode(trim(Bbc.Bbc_Codigo) ,'', 'Nao', 'Sim') Declar , "
cQuery0 += CRLF + "             SUM(Bd7.Bd7_Vlrpag) vlrpag "
cQuery0 += CRLF + "        From " +RetSQLName("SE2")+ " Se2 , " +RetSQLName("BD7")+ " Bd7 , "

cQuery0 += CRLF + "(  Select Bau_Codigo Bbc_Codigo "
cQuery0 += CRLF + "   From siga."+RetSQLName("FLX")+ " FLX ," +RetSQLName("BAU")+ " BAU " 
cQuery0 += CRLF + "  Where FLX_Filial =  '"+xFilial("FLX")+ "'  And FLX.D_E_L_E_T_ = ' ' "  
cQuery0 += CRLF + "    AND BAU_Filial =  '"+xFilial("BAU")+ "'  And BAU.D_E_L_E_T_ = ' ' "
cQuery0 += CRLF + "    And (Substr(FLX_dtini,1,6) <= '"+cCompte+"' " 
cQuery0 += CRLF + "    And  Substr(FLX_dtfim,1,6) >= '"+cCompte+"' )"
cQuery0 += CRLF + "    and  flx_fornec = bau_codsa2    )BBC "

/*
cQuery0 += CRLF + "(Select Bbc_Codigo "
cQuery0 += CRLF + "   From " +RetSQLName("BBC")+ " BBC "
cQuery0 += CRLF + "  Where Bbc_Filial =  '"+xFilial("BBC")+ "'  And D_E_L_E_T_ = ' ' And Bbc_Codser = '050' "
cQuery0 += CRLF + "    And (Substr(Bbc_Vldini,1,6) <= '"+cCompte+"' "
cQuery0 += CRLF + "    And  Substr(Bbc_Vldfim,1,6) >= '"+cCompte+"') )Bbc "
*/

cQuery0 += CRLF + "  Where E2_Filial  = '"+xFilial("SE2")+ "' And Se2.D_E_L_E_T_ = ' ' "
cQuery0 += CRLF + "    And Bd7_Filial = '"+xFilial("BD7")+ "' And Bd7.D_E_L_E_T_ = ' ' "
cQuery0 += CRLF + "    And E2_Pllote >= '"+cCompte+"0001' "
cQuery0 += CRLF + "    And E2_Origem  = 'PLSMPAG' "
cQuery0 += CRLF + "    And E2_Tipo    = 'FT' "
cQuery0 += CRLF + "    And E2_Codret  = '0588' "
cQuery0 += CRLF + "    And Bd7_Codrda = E2_Codrda And Bd7_Numlot = E2_Pllote "
cQuery0 += CRLF + "    And E2_Codrda  = Bbc.Bbc_Codigo(+) "
cQuery0 += CRLF + "  Group By E2_Baixa  , E2_Vencrea , E2_Emissao , e2_Numbor , "  
cQuery0 += CRLF + "           E2_Codrda , E2_Prefixo||E2_Num||E2_Tipo , "
cQuery0 += CRLF + "           E2_Pllote , E2_Codret , E2_Valor , E2_Irrf , E2_fornece, "            
cQuery0 += CRLF + "           Case When ((E2_Valor+E2_Irrf + E2_Inss) - (Case When  ((E2_Valor+E2_Irrf + E2_Inss) *  (Decode(Nvl(Bbc.Bbc_Codigo,'Sem decl'),'Sem decl',0.11,0))  ) > 707.69 Then 707.69 Else ((E2_Valor+E2_Irrf + E2_Inss) *  (Decode(Nvl(Bbc.Bbc_Codigo,'Sem decl'),'Sem decl',0.11,0)) ) End) ) >= 4664.68 "
cQuery0 += CRLF + "                Then ((((E2_Valor+E2_Irrf + E2_Inss) - (Case When ((E2_Valor+E2_Irrf + E2_Inss) * (Decode(Nvl(Bbc.Bbc_Codigo,'Sem decl'),'Sem decl',0.11,0)) ) > 707.69 Then 707.69 Else ((E2_Valor+E2_Irrf + E2_Inss) *  (Decode(Nvl(Bbc.Bbc_Codigo,'Sem decl'),'Sem decl',0.11,0)) ) End) )  * 0.275) - 869.36) "
cQuery0 += CRLF + "                When (((E2_Valor+E2_Irrf + E2_Inss)- (Case When  ((E2_Valor+E2_Irrf + E2_Inss) *  (Decode(Nvl(Bbc.Bbc_Codigo,'Sem decl'),'Sem decl',0.11,0))  ) > 707.69 Then 707.69 Else ((E2_Valor+E2_Irrf + E2_Inss) *  (Decode(Nvl(Bbc.Bbc_Codigo,'Sem decl'),'Sem decl',0.11,0)) ) End) ) >= 3751.06 And  (E2_Valor+E2_Irrf + E2_Inss) - (Case When  ((E2_Valor+E2_Irrf + E2_Inss) *  (Decode(Nvl(Bbc.Bbc_Codigo,'Sem decl'),'Sem decl',0.11,0))  ) > 707.69 Then 707.69 Else ((E2_Valor+E2_Irrf + E2_Inss) *  (Decode(Nvl(Bbc.Bbc_Codigo,'Sem decl'),'Sem decl',0.11,0))  ) End) < 4664.68) "       
cQuery0 += CRLF + "                Then ((((E2_Valor+E2_Irrf + E2_Inss)- (Case When  ((E2_Valor+E2_Irrf + E2_Inss) * (Decode(Nvl(Bbc.Bbc_Codigo,'Sem decl'),'Sem decl',0.11,0)) ) > 707.69 Then 707.69 Else ((E2_Valor+E2_Irrf + E2_Inss) *  (Decode(Nvl(Bbc.Bbc_Codigo,'Sem decl'),'Sem decl',0.11,0)) ) End) )  * 0.225) - 636.13) "                  
cQuery0 += CRLF + "                When (((E2_Valor+E2_Irrf + E2_Inss)- (Case When  ((E2_Valor+E2_Irrf + E2_Inss) *  (Decode(Nvl(Bbc.Bbc_Codigo,'Sem decl'),'Sem decl',0.11,0))  ) > 707.69 Then 707.69 Else ((E2_Valor+E2_Irrf + E2_Inss) *  (Decode(Nvl(Bbc.Bbc_Codigo,'Sem decl'),'Sem decl',0.11,0)) ) End) ) >= 2826.66 And (E2_Valor+E2_Irrf + E2_Inss)- (Case When  ((E2_Valor+E2_Irrf + E2_Inss) *  (Decode(Nvl(Bbc.Bbc_Codigo,'Sem decl'),'Sem decl',0.11,0))  ) > 707.69 Then 707.69 Else ((E2_Valor+E2_Irrf + E2_Inss) *  (Decode(Nvl(Bbc.Bbc_Codigo,'Sem decl'),'Sem decl',0.11,0))  ) End) < 3751.06 )  "     
cQuery0 += CRLF + "                Then ((((E2_Valor+E2_Irrf + E2_Inss)- (Case When  ((E2_Valor+E2_Irrf + E2_Inss) * (Decode(Nvl(Bbc.Bbc_Codigo,'Sem decl'),'Sem decl',0.11,0)) ) > 707.69 Then 707.69 Else ((E2_Valor+E2_Irrf + E2_Inss) *  (Decode(Nvl(Bbc.Bbc_Codigo,'Sem decl'),'Sem decl',0.11,0)) ) End) )  * 0.15) - 354.80 ) "                  
cQuery0 += CRLF + "                When (((E2_Valor+E2_Irrf + E2_Inss)- (Case When  ((E2_Valor+E2_Irrf + E2_Inss) *  (Decode(Nvl(Bbc.Bbc_Codigo,'Sem decl'),'Sem decl',0.11,0))  ) > 707.69 Then 707.69 Else ((E2_Valor+E2_Irrf + E2_Inss) *  (Decode(Nvl(Bbc.Bbc_Codigo,'Sem decl'),'Sem decl',0.11,0)) ) End) ) >= 1903.99 And (E2_Valor+E2_Irrf + E2_Inss) - (Case When  ((E2_Valor+E2_Irrf + E2_Inss) *  (Decode(Nvl(Bbc.Bbc_Codigo,'Sem decl'),'Sem decl',0.11,0))  ) > 707.69 Then 707.69 Else ((E2_Valor+E2_Irrf + E2_Inss) *  (Decode(Nvl(Bbc.Bbc_Codigo,'Sem decl'),'Sem decl',0.11,0))  ) End) < 2826.66 ) "      
cQuery0 += CRLF + "                Then ((((E2_Valor+E2_Irrf + E2_Inss)- (Case When  ((E2_Valor+E2_Irrf + E2_Inss) * (Decode(Nvl(Bbc.Bbc_Codigo,'Sem decl'),'Sem decl',0.11,0)))  > 707.69 Then 707.69 Else ((E2_Valor+E2_Irrf + E2_Inss) * (Decode(Nvl(Bbc.Bbc_Codigo,'Sem decl'),'Sem decl',0.11,0))  ) End) )  * 0.075) - 142.80 ) "                  
cQuery0 += CRLF + "           Else 0 End , "
cQuery0 += CRLF + "           E2_Inss , "
cQuery0 += CRLF + "           Case When  ((E2_Valor+E2_Irrf + E2_Inss) *  (Decode(Nvl(Bbc.Bbc_Codigo,'Sem decl'),'Sem decl',0.11,0))  ) > 707.69 Then 707.69 Else ((E2_Valor+E2_Irrf + E2_Inss) *  (Decode(Nvl(Bbc.Bbc_Codigo,'Sem decl'),'Sem decl',0.11,0))) End , "
cQuery0 += CRLF + "           (E2_Valor+E2_Irrf + E2_Inss)  , Nvl(Bbc.Bbc_Codigo , 'Sem decl') , "
cQuery0 += CRLF + "           Decode(trim(Bbc.Bbc_Codigo) ,'', 'Nao', 'Sim') "
cQuery0 += CRLF + "           Order By 3 ) Calc "
cQuery0 += CRLF + "  Where calc.baixa = ' ' and calc.Numbor = ' ' " 
cQuery0 += CRLF + "    and (Trunc(Irpfcal,2) <> Trunc(Calc.Irrf,2) Or Trunc(Insscalc,2) <> Trunc(Calc.Inss,2)) " 
cQuery0 += CRLF + "  Order By Calc.Tit "

    If Select((cAliastmp5)) <> 0    
	   (cAliastmp5)->(DbCloseArea())  
	EndIf   

	TCQuery cQuery0  New Alias (cAliastmp5)   

	(cAliastmp5)->(dbGoTop())                         

	    While (cAliastmp5)->(!EOF())   

            If  trim((cAliastmp5)->CBaixa) != ''
                Fazlog('1')
	        Else 
               
				If  trim((cAliastmp5)->Fazse2) != '' .and. fValAcao()
					cScript0:= (cAliastmp5)->Fazse2
				 //   If TcSqlExec(cScript0) < 0
				 //	   LogErros('Erro ao rodar o script [ ' + cScript0 + ' ]. ' + CRLF + 'Descr. Erro: ' + CRLF + TcSqlError())
				 //   EndIf
				EndIf

				If  trim((cAliastmp5)->FazIns) != '' .and. fValAcao()
					cScript0:= (cAliastmp5)->FazIns
				//	If TcSqlExec(cScript0) < 0
				//	   LogErros('Erro ao rodar o script [ ' + cScript0 + ' ]. ' + CRLF + 'Descr. Erro: ' + CRLF + TcSqlError())
				//	EndIf
				EndIf

				If  trim((cAliastmp5)->FazTxs) != '' .and. fValAcao()
					cScript0:= (cAliastmp5)->FazTxs
				//	If TcSqlExec(cScript0) < 0
				//	   LogErros('Erro ao rodar o script [ ' + cScript0 + ' ]. ' + CRLF + 'Descr. Erro: ' + CRLF + TcSqlError())
				//	EndIf
				EndIf
            EndIf  
		    
			(cAliastmp5)->(dbSkip()) 	  			                              

		EndDo  

return() 

///////////////////////////////////////////////// - irrf ////////////////////////////

STATIC FUNCTION fparte1()

	local cQuery1:= ' '
	local cQuery2:= ' '
	local cQuery3:= ' '      
	local cScript:= ' ' 
	LOCAL Y      := 1 
	/// titulos que faltam o irrf 
	cQuery1 := " SELECT e2_prefixo Prefixo,"         + CRLF
	cQuery1 += "        e2_num Num ,"             + CRLF
	cQuery1 += "        e2_parcins parcins,"         + CRLF 
	cQuery1 += "        E2_PARCIR parcir  ,"          + CRLF 
	cQuery1 += "        e2_tipo tipo,"         + CRLF 
	cQuery1 += "        (e2_valor +e2_irrf + e2_inss) vlrtit ,"         + CRLF 
	cQuery1 += "        Se2.E2_Inss Inss , "         + CRLF
	cQuery1 += "        E2_IRRF irrf ,"         + CRLF
	cQuery1 += "        E2_FORNECE fornece , "         + CRLF
	cQuery1 += "        E2_PLLOTE pllote , "         + CRLF
	cQuery1 += "        E2_CODRDA codrda , "         + CRLF
	cQuery1 += "        e2_emissao emissao"         + CRLF
	cQuery1 += "   FROM " + RetSqlName("SE2")  +" SE2 "         + CRLF
	cQuery1 += "  WHERE  E2_FILIAL = '" + xFilial('SE2')+ "'" 	+ CRLF        
	cQuery1 += "    and d_E_L_E_T_ = ' '  "         + CRLF 
	cQuery1 += "    And E2_Pllote Like '"+cCompte+"%'  "         + CRLF 
	cQuery1 += "    And E2_Origem = 'PLSMPAG' "         + CRLF 
	cQuery1 += "    And E2_Tipo = 'FT' "         + CRLF 
	cQuery1 += "    And E2_Codret = '0588' "         + CRLF 
	cQuery1 += "    and e2_IRRF > 0.00  "         + CRLF 

	//cQuery1 += "    and E2_PREFIXO = 'CON' AND E2_NUM in('000139347')  "

	cQuery1 += "  and (SELECT Count(*) "         + CRLF  
	cQuery1 += "         FROM " + RetSqlName("SE2")  +" SE21 "         + CRLF
	cQuery1 += "        WHERE E2_FILIAL = '" + xFilial('SE2')+ "'" 	+ CRLF        
	cQuery1 += "          And E2_Pllote Like '"+cCompte+"%'"         + CRLF 
	//cQuery1 += "          And E2_Origem = 'PLSMPAG' "         + CRLF 
	cQuery1 += "          and e2_prefixo = se2.e2_prefixo  "         + CRLF 
	cQuery1 += "          and e2_num = se2.e2_num "         + CRLF 
	cQuery1 += "          and d_E_L_E_T_ = ' '  "         + CRLF 
	cQuery1 += "          and E2_Tipo = 'TX' "         + CRLF 
	cQuery1 += "   ) = 0 "         + CRLF 

	///////////////////////////

	If Select((cAliastmp1)) <> 0 
       (cAliastmp1)->(DbCloseArea())  
	Endif 

	TCQuery cQuery1  New Alias (cAliastmp1)   

	(cAliastmp1)->(dbGoTop())                          

	//////

	While (cAliastmp1)->(!EOF())   

		aaDD(aDadostit1,{(cAliastmp1)->Prefixo    ,;
		(cAliastmp1)->Num        ,;                                                          
		(cAliastmp1)->parcins    ,;     
		(cAliastmp1)->parcir     ,;                                                                            
		(cAliastmp1)->tipo       ,;                                                                            
		(cAliastmp1)->vlrtit     ,;
		(cAliastmp1)->irrf      ,;
		(cAliastmp1)->FORNECE    ,;
		(cAliastmp1)->pllote     ,;
		(cAliastmp1)->codrda     ,;
		(cAliastmp1)->emissao   })      

		(cAliastmp1)->(dbSkip()) 				                              

	enddo                   

	cQuery2 := " SELECT E2_FILIAL , "                           + CRLF
	cQuery2 += "        E2_PREFIXO prefixo , "                  + CRLF
	cQuery2 += "        E2_NUM num , "                          + CRLF
	cQuery2 += "        E2_TIPO tipo , "                        + CRLF
	cQuery2 += "        D_e_l_e_t_ , "                          + CRLF
	cQuery2 += "        E2_EMISSAO emissao , "                  + CRLF
	cQuery2 += "        E2_PARCELA parcela , E2_NATUREZ NATUREZ"  + CRLF
	cQuery2 += "   FROM " + RetSqlName("SE2")  +" SE2 "         + CRLF
	cQuery2 += "  WHERE  E2_FILIAL = '" + xFilial('SE2')+ "'" 	+ CRLF        
	cQuery2 += "    and (d_E_L_E_T_ = '*'  OR E2_VALOR = 0 )"   + CRLF 
	cQuery2 += "    and e2_tipo = 'TX' "                        + CRLF
//	cQuery2 += "    AND E2_CODRET = '0588' "                    + CRLF
	cQuery2 += "    and e2_emissao >= '20010101' "              + CRLF 
	cQuery2 += "    and e2_origem = 'PLSMPAG' "                 + CRLF
	cQuery2 += "    AND E2_BAIXA   = ' ' "                      + CRLF


	///////////////////////////
	If Select((cAliastmp2)) <> 0 
		(cAliastmp2)->(DbCloseArea())  
	Endif 

	TCQuery cQuery2  New Alias (cAliastmp2)   

	(cAliastmp2)->(dbGoTop())                          

	//////

	While (cAliastmp2)->(!EOF())   

		aaDD(aDadostit2,{(cAliastmp2)->Prefixo    ,;
		(cAliastmp2)->Num        ,;                                                         
		(cAliastmp2)->tipo       ,;                                                                            
		(cAliastmp2)->parcela    ,;
		(cAliastmp2)->emissao    ,;
		(cAliastmp2)->NATUREZ    })                         

		(cAliastmp2)->(dbSkip()) 				                              				           

	enddo                   

	for i := 1 to len(aDadostit1) 

	z := i
		cScript := " UPDATE "+ RetSqlName("SE2")+" SE2 "  + CRLF
		cScript += "    SET E2_PREFIXO = '"+aDadostit1[i,1]+"'," + CRLF
		cScript += "        E2_NUM     = '"+aDadostit1[i,2]+"'," + CRLF
        cScript += "        E2_TIPO    = 'TX'        ," + CRLF
		cScript += "        E2_CODRET  = '0588'      , " + CRLF

		cScript += "        E2_parcela = '1'         ," + CRLF
		cScript += "        E2_EMISSAO = '"+aDadostit1[i,11]+"'," + CRLF

        cScript += "        E2_VENCTO  = '20210720' ," //'"+cVencto+"'  ," + CRLF
	    cScript += "        E2_VENCREA = '20210720' ," //'"+cVencto+"' ," + CRLF
     
		cScript += "        E2_VALOR   = "+Str(aDadostit1[i,7])+"," + CRLF 
		cScript += "        E2_SALDO   = "+Str(aDadostit1[i,7])+"," + CRLF
		cScript += "        E2_VENCORI = '20210720' ," //+cVencto+"'  , " + CRLF
		cScript += "        E2_VLCRUZ  = "+Str(aDadostit1[i,7])+"," + CRLF
		cScript += "        E2_ANOBASE = '"+substr(cCompte,1,4)+"'      ," + CRLF
		cScript += "        E2_MESBASE = '"+substr(cCompte,5,2)+"'        , " + CRLF
		cScript += "        E2_CODRDA  = '"+aDadostit1[i,10]+"' ," + CRLF
		cScript += "        E2_FORORI  = '"+aDadostit1[i,8]+"' ," + CRLF
		cScript += "        E2_PLLOTE  = '"+aDadostit1[i,9]+"' ,"+ CRLF

        cScript += "        E2_NATUREZ  = 'IRF' ,"+ CRLF

		cScript += "        E2_TITPAI  = '"+aDadostit1[i,1]+aDadostit1[i,2]+' '+aDadostit1[i,5]+aDadostit1[i,8]+'01'+"'," + CRLF
		cScript += "        SE2.D_e_l_e_t_ = ' '  " + CRLF
		cScript += "  WHERE E2_FILIAL  = '" + xFilial('SE2')+ "'  " + CRLF
		cScript += "    AND (d_E_L_E_T_ = '*' OR E2_VALOR = 0 )  " + CRLF
		cScript += "    AND E2_PREFIXO = '"+aDadostit2[z,1]+"' " + CRLF
		cScript += "    AND E2_NUM     = '"+aDadostit2[z,2]+"' "+ CRLF
		cScript += "    and e2_tipo    = 'TX' " + CRLF
		 cScript += "   AND E2_NATUREZ = '"+aDadostit2[z,6]+"'  "+ CRLF
		//cScript += "    AND E2_CODRET  = '0588' "+ CRLF
		cScript += "    and e2_emissao = '"+aDadostit2[z,5]+"' " + CRLF
		cScript += "    And e2_origem  = 'PLSMPAG' " + CRLF
		cScript += "    AND E2_BAIXA   = ' ' " +CRLF                                              

		If TcSqlExec(cScript) < 0
			LogErros('Erro ao rodar o script [ ' + cScript + ' ]. ' + CRLF + 'Descr. Erro: ' + CRLF + TcSqlError())
		EndIf
	next
	fparte11()  // - criaos titulos de impostos que nao foram criados INSS
return()

///////////////////////////////////////////////// - inss ////////////////////////////

STATIC FUNCTION fparte11()

	local cQuery1:= ' '
	local cQuery2:= ' '  
	local cQuery3:= ' '  
	local cScript:= ' '	 
	LOCAL Y      := 1 

	aDadostit1 := {}
	aDadostit2 := {}

	/// titulos que faltam o inss
	cQuery1 := " SELECT e2_prefixo Prefixo,"         + CRLF
	cQuery1 += "        e2_num Num ,"             + CRLF
	cQuery1 += "        e2_parcins parcins,"         + CRLF 
	cQuery1 += "        E2_PARCIR parcir  ,"          + CRLF 
	cQuery1 += "        e2_tipo tipo,"         + CRLF 
	cQuery1 += "        (e2_valor +e2_irrf + e2_inss) vlrtit ,"         + CRLF 
	cQuery1 += "        Se2.E2_Inss Inss , "         + CRLF
	cQuery1 += "        E2_IRRF irrf ,"         + CRLF
	cQuery1 += "        E2_FORNECE fornece , "         + CRLF
	cQuery1 += "        E2_PLLOTE pllote , "         + CRLF
	cQuery1 += "        E2_CODRDA codrda , "         + CRLF
	cQuery1 += "        e2_emissao emissao"         + CRLF
	cQuery1 += "   FROM " + RetSqlName("SE2")  +" SE2 "         + CRLF
	cQuery1 += "  WHERE  E2_FILIAL = '" + xFilial('SE2')+ "'" 	+ CRLF        
	cQuery1 += "    and d_E_L_E_T_ = ' '  "         + CRLF 
	cQuery1 += "    And E2_Pllote Like '"+cCompte+"%'  "         + CRLF 
	cQuery1 += "    And E2_Origem = 'PLSMPAG' "         + CRLF 
	cQuery1 += "    And E2_Tipo = 'FT' "         + CRLF 
	cQuery1 += "    And E2_Codret = '0588' "         + CRLF 
    cQuery1 += "    and e2_inss > 0.00 "          + CRLF  
	
	//cQuery1 += "    and E2_PREFIXO = 'CON' AND E2_NUM in('000139347')  "

	cQuery1 += "  and (SELECT Count(*) "         + CRLF  
	cQuery1 += "         FROM " + RetSqlName("SE2")  +" SE21 "         + CRLF
	cQuery1 += "        WHERE E2_FILIAL = '" + xFilial('SE2')+ "'" 	+ CRLF        
	cQuery1 += "          And E2_Pllote Like '"+cCompte+"%' "         + CRLF 
	//cQuery1 += "          And E2_Origem = 'PLSMPAG' "         + CRLF 
	cQuery1 += "          and e2_prefixo = se2.e2_prefixo  "         + CRLF 
	cQuery1 += "          and e2_num = se2.e2_num "         + CRLF 
	cQuery1 += "          and d_E_L_E_T_ = ' '  "         + CRLF 
	cQuery1 += "          And E2_Tipo = 'INS' "         + CRLF 
	cQuery1 += "   ) = 0 "         + CRLF 

	///////////////////////////

	If Select((cAliastmp1)) <> 0 
       (cAliastmp1)->(DbCloseArea())  
	Endif 

	TCQuery cQuery1  New Alias (cAliastmp1)   

	(cAliastmp1)->(dbGoTop())                          

	//////

	While (cAliastmp1)->(!EOF())   

		aaDD(aDadostit1,{(cAliastmp1)->Prefixo    ,;
		(cAliastmp1)->Num        ,;                                                          
		(cAliastmp1)->parcins    ,;     
		(cAliastmp1)->parcir     ,;                                                                            
		(cAliastmp1)->tipo       ,;                                                                            
		(cAliastmp1)->vlrtit     ,;
		(cAliastmp1)->inss       ,;
		(cAliastmp1)->FORNECE    ,;
		(cAliastmp1)->pllote     ,;
		(cAliastmp1)->codrda     ,;
		(cAliastmp1)->emissao   })      

		(cAliastmp1)->(dbSkip()) 				                              

	enddo                   

	//  titulo de inss que seram usados para criar os inss acima 


	cQuery2 := " SELECT E2_FILIAL , "                           + CRLF
	cQuery2 += "        E2_PREFIXO prefixo , "                  + CRLF
	cQuery2 += "        E2_NUM num , "                          + CRLF
	cQuery2 += "        E2_TIPO tipo , "                        + CRLF
	cQuery2 += "        D_e_l_e_t_ , "                          + CRLF
	cQuery2 += "        E2_EMISSAO emissao , "                  + CRLF
	cQuery2 += "        E2_PARCELA parcela ,"                   + CRLF
	cQuery2 += "        E2_NATUREZ naturez "                    + CRLF
	cQuery2 += "   FROM " + RetSqlName("SE2")  +" SE2 "         + CRLF
	cQuery2 += "  WHERE  E2_FILIAL = '" + xFilial('SE2')+ "'" 	+ CRLF        
	cQuery2 += "    and (d_E_L_E_T_ = '*'  OR E2_VALOR = 0 )"   + CRLF 
    cQuery2 += "    and e2_tipo in ( 'INS' , 'TX')"             + CRLF 
	//cQuery2 += "    AND E2_CODRET = '0588' "                    + CRLF
	cQuery2 += "    and e2_emissao >= '20010101' "              + CRLF 
	cQuery2 += "    and e2_origem = 'PLSMPAG' "                 + CRLF
	cQuery2 += "    AND E2_BAIXA   = ' ' "                      + CRLF


	///////////////////////////
	//cAliastmp2
	If Select((cAliastmp2)) <> 0 
		(cAliastmp2)->(DbCloseArea())  
	Endif 

	TCQuery cQuery2  New Alias (cAliastmp2)   

	(cAliastmp2)->(dbGoTop())                          

	//////

	While (cAliastmp2)->(!EOF())   

		aaDD(aDadostit2,{(cAliastmp2)->Prefixo    ,;
		(cAliastmp2)->Num        ,;                                                          
		(cAliastmp2)->tipo       ,;
		(cAliastmp2)->parcela    ,;
		(cAliastmp2)->emissao    ,;                         
        (cAliastmp2)->naturez   })                         
		(cAliastmp2)->(dbSkip()) 				                              				           

	enddo                   


	for i := 1 to len(aDadostit1) 

	z := i
 
		cScript := " UPDATE "+ RetSqlName("SE2")+" SE2 "  + CRLF
		cScript += "    SET E2_PREFIXO = '"+aDadostit1[i,1]+"'," + CRLF
		cScript += "        E2_NUM     = '"+aDadostit1[i,2]+"'," + CRLF
        cScript += "        E2_TIPO    = 'INS'       ," + CRLF
   
		cScript += "        E2_parcela = '1'         ," + CRLF
		cScript += "        E2_EMISSAO = '"+aDadostit1[i,11]+"'," + CRLF

        cScript += "        E2_VENCTO  = '20210618' , " //'"+cVencto+"'  ," + CRLF
	    cScript += "        E2_VENCREA = '20210618' , " //'"+cVencto+"'  ," + CRLF
        cScript += "        E2_CODRET  = '0588'         , "+ CRLF
		cScript += "        E2_VALOR   = "+Str(aDadostit1[i,7])+"," + CRLF 
		cScript += "        E2_SALDO   = "+Str(aDadostit1[i,7])+"," + CRLF
		cScript += "        E2_VENCORI = '20210618' , " //'"+cVencto+"'  , " + CRLF
		cScript += "        E2_VLCRUZ  = "+Str(aDadostit1[i,7])+"," + CRLF
		cScript += "        E2_ANOBASE = '"+substr(cCompte,1,4)+"' ," + CRLF
		cScript += "        E2_MESBASE = '"+substr(cCompte,5,2)+"'        , " + CRLF
		cScript += "        E2_CODRDA  = '"+aDadostit1[i,10]+"' ," + CRLF
		cScript += "        E2_FORORI  = '"+aDadostit1[i,8]+"' ," + CRLF
		cScript += "        E2_PLLOTE  = '"+aDadostit1[i,9]+"' ,"+ CRLF
		cScript += "        E2_NATUREZ  = 'INSS' ,"+ CRLF

 		cScript += "        E2_FORNECE = 'INPS' , E2_NOMFOR = 'INPS' , E2_HIST = 'INSS RETIDO DO PRESTADOR' ,"+ CRLF

		cScript += "        E2_TITPAI  = '"+aDadostit1[i,1]+aDadostit1[i,2]+' '+aDadostit1[i,5]+aDadostit1[i,8]+'01'+"'," + CRLF
		cScript += "        SE2.D_e_l_e_t_ = ' '  " + CRLF

		cScript += "  WHERE E2_FILIAL  = '" + xFilial('SE2')+ "'  " + CRLF
		cScript += "    AND (d_E_L_E_T_ = '*'  OR E2_VALOR = 0 )" + CRLF
		cScript += "    AND E2_PREFIXO = '"+aDadostit2[z,1]+"' " + CRLF
		cScript += "    AND E2_NUM     = '"+aDadostit2[z,2]+"' "+ CRLF
		cScript += "    and e2_tipo    = '"+aDadostit2[z,3]+"' "+ CRLF
		cScript += "    and e2_naturez = '"+aDadostit2[z,6]+"' "+ CRLF
		//cScript += "    AND E2_CODRET  = '0588' "+ CRLF
		cScript += "    and e2_emissao = '"+aDadostit2[z,5]+"' " + CRLF
		cScript += "    And e2_origem  = 'PLSMPAG' " + CRLF
		cScript += "    AND E2_BAIXA   = ' ' " + CRLF                                                

		If TcSqlExec(cScript) < 0
			a:='b'
			//LogErros('Erro ao rodar o script [ ' + cScript + ' ]. ' + CRLF + 'Descr. Erro: ' + CRLF + TcSqlError())
		EndIf
        a:='b'
	next
return()


///////////////////////////////////////

STATIC FUNCTION fparte2()

	local cQuery1:= ' '
	local cQuery2:= ' '
	local cQuery3:= ' '  
	local cScript:= ' '   
	LOCAL Y      := 1 

	cScript := " UPDATE "+ RetSqlName("SE2")+" SE2 "  + CRLF
	cScript += "    SET E2_parcINS  = '1'         " + CRLF
	cScript += "  WHERE E2_FILIAL  = '" + xFilial('SE2')+ "'  " + CRLF
	cScript += "    AND D_e_l_e_t_ = ' '   " + CRLF

	cScript += "    AND E2_TIPO    = 'FT'  " + CRLF
	cScript += "    AND E2_CODRET  = '0588'  " + CRLF
	cScript += "    AND E2_PARCINS = ' '  " + CRLF
	cScript += "    AND E2_INSS > 0   " + CRLF
	cScript += "    AND E2_ORIGEM  = 'PLSMPAG'  " + CRLF

	If TcSqlExec(cScript) < 0
		LogErros('Erro ao rodar o script [ ' + cScript + ' ]. ' + CRLF + 'Descr. Erro: ' + CRLF + TcSqlError())
	EndIf


	cScript := " UPDATE "+ RetSqlName("SE2")+" SE2 "  + CRLF
	cScript += "    SET E2_parcIR  = '1'         " + CRLF
	cScript += "  WHERE E2_FILIAL  = '" + xFilial('SE2')+ "'  " + CRLF
	cScript += "    AND D_e_l_e_t_ = ' '   " + CRLF

	cScript += "    AND E2_TIPO    = 'FT'  " + CRLF
	cScript += "    AND E2_CODRET  = '0588'  " + CRLF
	cScript += "    AND E2_PARCINS = ' '  " + CRLF
	cScript += "    AND E2_irrf > 0   " + CRLF
	cScript += "    AND E2_ORIGEM  = 'PLSMPAG'  " + CRLF

	If TcSqlExec(cScript) < 0
		LogErros('Erro ao rodar o script [ ' + cScript + ' ]. ' + CRLF + 'Descr. Erro: ' + CRLF + TcSqlError())
	EndIf

RETURN()

STATIC FUNCTION fparte3()

	local cQuery1:= ' '
	local cQuery2:= ' '
	local cQuery3:= ' '
	LOCAL cQuery4:= ' '    

	local cScript:= ' ' 
	LOCAL Y      := 1 

	cQuery1 += " SELECT e2_prefixo prefixo  , " + CRLF
	cQuery1 += "        e2_num     num      , " + CRLF
	cQuery1 += "        e2_parcins parcins  , " + CRLF
	cQuery1 += "        E2_PARCIR  PARCIR   , " + CRLF
	cQuery1 += "        e2_tipo    tipo     , " + CRLF
	cQuery1 += "        (e2_valor +e2_irrf + e2_inss) vlrtit , " + CRLF 
	cQuery1 += "        E2_Inss    Inss     , " + CRLF
	cQuery1 += "        E2_IRRF    IRRF     , " + CRLF
	cQuery1 += "        E2_FORNECE FORNECE  , " + CRLF
	cQuery1 += "        E2_PLLOTE  PLLOTE   , " + CRLF
	cQuery1 += "        E2_CODRDA  CODRDASE2, " + CRLF
	cQuery1 += "        e2_emissao emissao  , " + CRLF
	cQuery1 += "        BMR_OPERDA OPERDABMR, " + CRLF
	cQuery1 += "        BMR_CODRDA CODRDABMR, " + CRLF
	cQuery1 += "        BMR_OPELOT OPELOTBMR, " + CRLF
	cQuery1 += "        BMR_ANOLOT ANOLOTBMR, " + CRLF
	cQuery1 += "        BMR_MESLOT MESLOTBMR, " + CRLF
	cQuery1 += "        BMR_NUMLOT NUMLOTBMR, " + CRLF
	cQuery1 += "        BMR_CODLAN CODLANBMR, " + CRLF
	cQuery1 += "        BMR_VLRPAG VLRPAGBMR  " + CRLF      
	cQuery1 += "   FROM " + RetSqlName("SE2")  +" SE2 ," + RetSqlName("BMR")  +" BMR " + CRLF
	cQuery1 += "  WHERE  E2_FILIAL = '" + xFilial('SE2')+ "'" 	+ CRLF        
	cQuery1 += "    and SE2.d_E_L_E_T_ = ' '  "         + CRLF         
	cQuery1 += "    AND BMR_FILIAL(+) = '" + xFilial('BMR')+ "'" 	+ CRLF        
	cQuery1 += "    and BMR.d_E_L_E_T_(+) = ' '  "         + CRLF         
	
//  cQuery1 += "    And e2_codrda in ('141739')  " + CRLF //AKI

//	cQuery1 += "    And E2_Pllote Like '"+cCompte+"%' " + CRLF

    cQuery1 += "    And E2_Pllote = '2021050072' " + CRLF

	cQuery1 += "        And ( Select Count(*)  From " + RetSqlName("SE2")  +" Se21 " + CRLF
	cQuery1 += "               Where  Se21.E2_Filial = '01'" + CRLF
	cQuery1 += "                 And Se21.D_E_L_E_T_ = ' '  " + CRLF
	cQuery1 += "                 And Se21.E2_Codrda =  Se2.E2_Codrda " + CRLF
	//cQuery1 += "                 And Se21.E2_Pllote Like '"+cCompte+"%' " + CRLF
	cQuery1 += "                 And Se21.E2_Pllote = '2021050072'" + CRLF
	cQuery1 += "                 And Se21.E2_Origem = 'PLSMPAG' " + CRLF
	cQuery1 += "                 And Se21.E2_Tipo = 'FT' and se21.e2_valor > 5 " + CRLF  
	cQuery1 += "                 And Se21.E2_Codret = '0588' )= 1 " + CRLF

	cQuery1 += "    And E2_Origem = 'PLSMPAG' " + CRLF
	cQuery1 += "    And E2_Tipo = 'FT' " + CRLF
	cQuery1 += "    And E2_Codret = '0588' " + CRLF

//// codigo rda 
cQuery1 += "    And E2_Codrda = '043982' " + CRLF
//////

	cQuery1 += "    And BMR_ANOLOT(+) = Substr(E2_Pllote,1,4) " + CRLF
	cQuery1 += "    And BMR_MESLOT(+) = Substr(E2_Pllote,5,2) " + CRLF
	cQuery1 += "    And BMR_NUMLOT(+) = Substr(E2_Pllote,7,4) " + CRLF
	cQuery1 += "    AND BMR_CODRDA(+) = E2_CODRDA " + CRLF

	cQuery1 += "    AND (BMR_CODLAN(+) = '182'  " + CRLF
	cQuery1 += "     or  BMR_CODLAN(+) = '183'  " + CRLF
	cQuery1 += "     or  BMR_CODLAN(+) = '198'  " + CRLF
	cQuery1 += "     or  BMR_CODLAN(+) = '199' )" + CRLF

 	cQuery1 += "     and BMR_OPERDA is not  null  " + CRLF

	cQuery1 += "     ORDER BY E2_CODRDA  , BMR.BMR_CODLAN  " + CRLF      

	///////////////////////////


	If Select((cAliastmp3)) <> 0 
		(cAliastmp3)->(DbCloseArea())  
	Endif 

	TCQuery cQuery1  New Alias (cAliastmp3)   

	(cAliastmp3)->(dbGoTop())                              

	//////

	While (cAliastmp3)->(!EOF())   

		//				   (cAliastmp1)->irrf       ,; 

		aaDD(aDadostit1,{ (cAliastmp3)->prefixo  ,; //1
		(cAliastmp3)->num      ,; //2
		(cAliastmp3)->parcins  ,; //3
		(cAliastmp3)->PARCIR   ,; //4
		(cAliastmp3)->tipo     ,; //5
		(cAliastmp3)->vlrtit   ,; //6
		(cAliastmp3)->Inss     ,; //7
		(cAliastmp3)->IRRF     ,; //8
		(cAliastmp3)->FORNECE  ,; //9
		(cAliastmp3)->PLLOTE   ,; //10
		(cAliastmp3)->CODRDASE2,; //11
		(cAliastmp3)->emissao  ,; //12
		(cAliastmp3)->OPERDABMR,; //13
		(cAliastmp3)->CODRDABMR,; //14
		(cAliastmp3)->OPELOTBMR,; //15
		(cAliastmp3)->ANOLOTBMR,; //16
		(cAliastmp3)->MESLOTBMR,; //17
		(cAliastmp3)->NUMLOTBMR,; //18
		(cAliastmp3)->CODLANBMR,; //19
		(cAliastmp3)->VLRPAGBMR}) //20     

		(cAliastmp3)->(dbSkip()) 				                              

	enddo  
/*
	cQuery2 += " SELECT BMR_OPERDA OPERDAD, " + CRLF
	cQuery2 += "        BMR_CODRDA CODRDAD, " + CRLF
	cQuery2 += "        BMR_OPELOT OPELOTD, " + CRLF
	cQuery2 += "        BMR_ANOLOT ANOLOTD, " + CRLF
	cQuery2 += "        BMR_MESLOT MESLOTD, " + CRLF
	cQuery2 += "        BMR_NUMLOT NUMLOTD, " + CRLF
	cQuery2 += "        BMR_CODLAN CODLAND, " + CRLF
	cQuery2 += "        BMR_VLRPAG VLRPAGD, " + CRLF      
	cQuery2 += "        d_e_l_e_t_ DELETADO " + CRLF      
	cQuery2 += "   FROM " + RetSqlName("BMR")  +" BMR "         + CRLF
	cQuery2 += "  WHERE BMR_FILIAL = '" + xFilial('BMR')+ "'" 	+ CRLF        
//	cQuery2 += "    and BMR.d_E_L_E_T_(+) = '*'"                + CRLF 
    cQuery2 += "    and ( BMR.d_E_L_E_T_(+) = '*' or BMR_VLRPAG(+) = 0 ) "              + CRLF 	        
//	cQuery2 += "    And BMR_ANOLOT >=  '2017' " + CRLF      
/*	cQuery2 += "    AND (BMR_CODLAN(+) = '182'  " + CRLF
	cQuery2 += "     or  BMR_CODLAN(+) = '183'  " + CRLF
	cQuery2 += "     or  BMR_CODLAN(+) = '198'  " + CRLF
	cQuery2 += "     or  BMR_CODLAN(+) = '199' )" + CRLF


	///////////////////////////

	If Select((cAliastmp4)) <> 0 
		(cAliastmp4)->(DbCloseArea())  
	Endif 

	TCQuery cQuery2  New Alias (cAliastmp4)   

	(cAliastmp4)->(dbGoTop())                          

	//////

	While (cAliastmp4)->(!EOF())   


		aaDD(aDadostit2,{ (cAliastmp4)->OPERDAD,; //1
		(cAliastmp4)->CODRDAD,; //2
		(cAliastmp4)->OPELOTD,; //3
		(cAliastmp4)->ANOLOTD,; //4
		(cAliastmp4)->MESLOTD,; //5
		(cAliastmp4)->NUMLOTD,; //6
		(cAliastmp4)->CODLAND,; //7
		(cAliastmp4)->VLRPAGD,; //8     
		(cAliastmp4)->DELETADO}) //8     

		(cAliastmp4)->(dbSkip()) 				                              

	enddo  

for xi=1 to 99999
    a:='b'
next
*/
 I := 1 
	
While I <= len(aDadostit1)    

    cRdaAtu    := aDadostit1[i,11]

 	If  aDadostit1[i,19] ==  '182' 
			
        if  aDadostit1[i,6] != aDadostit1[i,20]   // base do inss

			cScript := " UPDATE "+ RetSqlName("BMR")+" BMR "  + CRLF
			cScript += "    SET BMR_CODRDA   = '"+aDadostit1[I,11]+"' ," + CRLF
			cScript += "        BMR_ANOLOT   = '"+SUBSTR(aDadostit1[I,10],1,4)+"' ," + CRLF
			cScript += "        BMR_MESLOT   = '"+SUBSTR(aDadostit1[I,10],5,2)+"' ," + CRLF
			cScript += "        BMR_NUMLOT   = '"+SUBSTR(aDadostit1[I,10],7,4)+"' ," + CRLF
			cScript += "        BMR_VLRPAG   = "+Str(aDadostit1[i,6])+" " + CRLF 
		
			cScript += "  WHERE BMR_FILIAL  = '" + xFilial('BMR')+ "'  " + CRLF
			cScript += "    AND D_e_l_e_t_ = ' '   " + CRLF
		
			cScript += "    AND BMR_OPERDA = '"+aDadostit1[I,13]+"' " + CRLF
			cScript += "    AND BMR_CODRDA = '"+aDadostit1[I,14]+"' " + CRLF
			cScript += "    AND BMR_OPELOT = '"+aDadostit1[I,15]+"' " + CRLF
			cScript += "    AND BMR_ANOLOT = '"+aDadostit1[I,16]+"' " + CRLF
			cScript += "    AND BMR_MESLOT = '"+aDadostit1[I,17]+"' " + CRLF
			cScript += "    AND BMR_NUMLOT = '"+aDadostit1[I,18]+"' " + CRLF
			cScript += "    AND BMR_CODLAN = '"+aDadostit1[I,19]+"' " + CRLF
			
			If TcSqlExec(cScript) < 0
		  	   LogErros('Erro ao rodar o script [ ' + cScript + ' ]. ' + CRLF + 'Descr. Erro: ' + CRLF + TcSqlError())
		    EndIf
			    		        
		    I++
						
		Else
					
	       I++
	       	
		EndIF     
		                       
	Else 
		   
	   fCInss('182')  
			    
    EndIf 
	
	If aDadostit1[i,19]==  '183' // valor do inss
	
       if  aDadostit1[i,7] != aDadostit1[i,20]   
	    
	       cScript := " UPDATE "+ RetSqlName("BMR")+" BMR "  + CRLF
		   cScript += "    SET BMR_CODRDA   = '"+aDadostit1[I,11]+"' ," + CRLF
		   cScript += "        BMR_ANOLOT   = '"+SUBSTR(aDadostit1[I,10],1,4)+"', " + CRLF
		   cScript += "        BMR_MESLOT   = '"+SUBSTR(aDadostit1[I,10],5,2)+"'," + CRLF
		   cScript += "        BMR_NUMLOT   = '"+SUBSTR(aDadostit1[I,10],7,4)+"', " + CRLF
		   cScript += "        BMR_VLRPAG   = "+Str(aDadostit1[i,7])+" " + CRLF 
		   cScript += "  WHERE BMR_FILIAL  = '" + xFilial('BMR')+ "'  " + CRLF
		   cScript += "    AND D_e_l_e_t_ = ' '   " + CRLF
		   cScript += "    AND BMR_OPERDA = '"+aDadostit1[I,13]+"' " + CRLF
		   cScript += "    AND BMR_CODRDA = '"+aDadostit1[I,14]+"' " + CRLF
		   cScript += "    AND BMR_OPELOT = '"+aDadostit1[I,15]+"' " + CRLF
		   cScript += "    AND BMR_ANOLOT = '"+aDadostit1[I,16]+"' " + CRLF
		   cScript += "    AND BMR_MESLOT = '"+aDadostit1[I,17]+"' " + CRLF
		   cScript += "    AND BMR_NUMLOT = '"+aDadostit1[I,18]+"' " + CRLF
		   cScript += "    AND BMR_CODLAN = '"+aDadostit1[I,19]+"' " + CRLF
			
           If TcSqlExec(cScript) < 0
			  LogErros('Erro ao rodar o script [ ' + cScript + ' ]. ' + CRLF + 'Descr. Erro: ' + CRLF + TcSqlError())
		   EndIf
		   
		   I++
		        
	   Else
		
		   I++
		   
		EndIf    
		
	Else  
	
	   If aDadostit1[i,7] != 0		   
	      fCInss('183')  
	   EndIF    
			    
    EndIf
            
   	If  aDadostit1[i,19]==  '198' // base do irrf

	   if (aDadostit1[i,6] - aDadostit1[i,7]) != aDadostit1[i,20]

		   cScript := " UPDATE "+ RetSqlName("BMR")+" BMR "  + CRLF
		   cScript += "    SET BMR_CODRDA   = '"+aDadostit1[I,11]+"' ," + CRLF
		   cScript += "        BMR_ANOLOT   = '"+SUBSTR(aDadostit1[I,10],1,4)+"' ," + CRLF
		   cScript += "        BMR_MESLOT   = '"+SUBSTR(aDadostit1[I,10],5,2)+"' ," + CRLF
		   cScript += "        BMR_NUMLOT   = '"+SUBSTR(aDadostit1[I,10],7,4)+"' ," + CRLF
		   cScript += "        BMR_VLRPAG   = "+Str(aDadostit1[i,6] - aDadostit1[i,7])+" " + CRLF 
		   cScript += "  WHERE BMR_FILIAL  = '" + xFilial('BMR')+ "'  " + CRLF
	 	   cScript += "    AND D_e_l_e_t_ = ' '   " + CRLF

		   cScript += "    AND BMR_OPERDA = '"+aDadostit1[I,13]+"' " + CRLF
		   cScript += "    AND BMR_CODRDA = '"+aDadostit1[I,14]+"' " + CRLF
		   cScript += "    AND BMR_OPELOT = '"+aDadostit1[I,15]+"' " + CRLF
		   cScript += "    AND BMR_ANOLOT = '"+aDadostit1[I,16]+"' " + CRLF
		   cScript += "    AND BMR_MESLOT = '"+aDadostit1[I,17]+"' " + CRLF
		   cScript += "    AND BMR_NUMLOT = '"+aDadostit1[I,18]+"' " + CRLF
		   cScript += "    AND BMR_CODLAN = '"+aDadostit1[I,19]+"' " + CRLF
				
           If TcSqlExec(cScript) < 0
		      LogErros('Erro ao rodar o script [ ' + cScript + ' ]. ' + CRLF + 'Descr. Erro: ' + CRLF + TcSqlError())
	       EndIf
		
		   I++
		
	   Else 
		
		  I++	
		     
	   EndIf 	
	   
   Else	   
			
       fCInss('198')  
			    
   EndIf 


   If  aDadostit1[i,19]==  '199' // valor IRRF
   
   	   if  aDadostit1[i,8] != aDadostit1[i,20]

	       cScript := " UPDATE "+ RetSqlName("BMR")+" BMR "  + CRLF
	       cScript += "    SET BMR_CODRDA   = '"+aDadostit1[I,11]+"' ," + CRLF
	       cScript += "        BMR_ANOLOT   = '"+SUBSTR(aDadostit1[I,10],1,4)+"' ," + CRLF
	       cScript += "        BMR_MESLOT   = '"+SUBSTR(aDadostit1[I,10],5,2)+"' ," + CRLF
	       cScript += "        BMR_NUMLOT   = '"+SUBSTR(aDadostit1[I,10],7,4)+"' ," + CRLF
	       cScript += "        BMR_VLRPAG   = "+Str(aDadostit1[i,8])+" " + CRLF 

	       cScript += "  WHERE BMR_FILIAL  = '" + xFilial('BMR')+ "'  " + CRLF
	       cScript += "    AND D_e_l_e_t_ = ' '   " + CRLF

	       cScript += "    AND BMR_OPERDA = '"+aDadostit1[I,13]+"' " + CRLF
	       cScript += "    AND BMR_CODRDA = '"+aDadostit1[I,14]+"' " + CRLF
	       cScript += "    AND BMR_OPELOT = '"+aDadostit1[I,15]+"' " + CRLF
	       cScript += "    AND BMR_ANOLOT = '"+aDadostit1[I,16]+"' " + CRLF
	       cScript += "    AND BMR_MESLOT = '"+aDadostit1[I,17]+"' " + CRLF
	       cScript += "    AND BMR_NUMLOT = '"+aDadostit1[I,18]+"' " + CRLF
	       cScript += "    AND BMR_CODLAN = '"+aDadostit1[I,19]+"' " + CRLF
				
		   If TcSqlExec(cScript) < 0
			  LogErros('Erro ao rodar o script [ ' + cScript + ' ]. ' + CRLF + 'Descr. Erro: ' + CRLF + TcSqlError())
	       EndIf
		
		   I++
		
	   Else 
	
	       I++
	     
	   EndIf     
	
	Else 
	
	   If aDadostit1[i,8] != 0		   
	      fCInss('199')  	  
	   EndIF    
	   
			    
    EndIf 
		
 EndDo 
 
RETURN()

static function fCInss(cCodLan) 

local cScript := " "
local lfazi   := .F. 
Local cCebCre := ' '  
local nVlrpag := 0
 
/*  If I > len(aDadostit1)
     I:= len(aDadostit1)
  EndIf    
*/

If cCodLan == '182'
   cCebCre := '3' 
   nVlrpag := aDadostit1[i,6]
ElseIf cCodLan == '183'
   cCebCre := '1'
   nVlrpag := aDadostit1[i,7]
ElseIf cCodLan == '198' 
	cCebCre := '3'
	nVlrpag := aDadostit1[i,6]- aDadostit1[i,7]
ElseIf cCodLan == '199'
    cCebCre := '1'
	nVlrpag := aDadostit1[i,8]
EndIf 	   
/*
If   cRdaAtu != aDadostit1[i,11]
     I := I--      
     lfazi   := .T.   
EndIf 
*/

    BMR->(Reclock("BMR",.T.))	
		
        BMR->BMR_FILIAL := xFilial("BMR") 
        BMR->BMR_OPERDA :='0001'  
        BMR->BMR_CODRDA :=  aDadostit1[I,11]  
		BMR->BMR_OPELOT := '0001' 
		BMR->BMR_ANOLOT := SUBSTR(aDadostit1[I,10],1,4)  
		BMR->BMR_MESLOT := SUBSTR(aDadostit1[I,10],5,2)  
		BMR->BMR_NUMLOT := SUBSTR(aDadostit1[I,10],7,4)  
		BMR->BMR_CODLAN := cCodLan 
		BMR->BMR_DEBCRE := cCebCre  
		BMR->BMR_VLRPAG := nVlrpag 
		BMR->BMR_ANOVCT := SUBSTR(aDadostit1[I,10],1,4)   
		BMR->BMR_MESVCT := SUBSTR(aDadostit1[I,10],5,2)   
		BMR->BMR_LOTB5E := ' '  	  
		   
    (MsUnlock())
/*
        cScript := " UPDATE "+ RetSqlName("BMR")+" BMR "  + CRLF
		cScript += "    SET BMR_CODRDA   = '"+aDadostit1[I,11]+"' ," + CRLF
		cScript += "        BMR_ANOLOT   = '"+SUBSTR(aDadostit1[I,10],1,4)+"' , " + CRLF
		cScript += "        BMR_MESLOT   = '"+SUBSTR(aDadostit1[I,10],5,2)+"' ," + CRLF
		cScript += "        BMR_NUMLOT   = '"+SUBSTR(aDadostit1[I,10],7,4)+"' ," + CRLF
		
        If cCodLan == '182'
		   cScript += "     BMR_VLRPAG   = "+Str(aDadostit1[i,6])+"," + CRLF 
        ElseIf cCodLan == '183'
		   cScript += "     BMR_VLRPAG   = "+Str(aDadostit1[i,7])+"," + CRLF 	
		ElseIf cCodLan == '198'
		   cScript += "     BMR_VLRPAG   = "+Str(aDadostit1[i,6]- aDadostit1[i,7])+"," + CRLF 	   
		ElseIf cCodLan == '199'
		   cScript += "     BMR_VLRPAG   = "+Str(aDadostit1[i,8])+"," + CRLF 	   
        EndIf 	   
		   
		cScript += "        BMR_CODLAN    = '"+ cCodLan +"'," + CRLF 
		cScript += "        BMR.D_E_L_E_T_ = ' ' ," + CRLF

        If cCodLan == '182' .or. cCodLan == '198'
		   cScript += "        BMR_DEBCRE    = '3' , " + CRLF 
        Else 	
     	   cScript += "        BMR_DEBCRE    = '1' , " + CRLF 
        EndIf 
		
		cScript += "        BMR_ANOVCT    = '"+SUBSTR(aDadostit1[I,10],1,4)+"' ," + CRLF
		cScript += "        BMR_MESVCT    = '"+SUBSTR(aDadostit1[I,10],5,2)+"' " + CRLF 		

		cScript += "  WHERE BMR_FILIAL  = '" + xFilial('BMR') + "'  " + CRLF
		cScript += "    AND D_e_l_e_t_ = '*'   " + CRLF

		cScript += "    AND BMR_OPERDA = '"+aDadostit2[X,1]+"'" + CRLF
		cScript += "    AND BMR_CODRDA = '"+aDadostit2[X,2]+"'" + CRLF
		cScript += "    AND BMR_OPELOT = '"+aDadostit2[X,3]+"'" + CRLF
		cScript += "    AND BMR_ANOLOT = '"+aDadostit2[X,4]+"'" + CRLF
		cScript += "    AND BMR_MESLOT = '"+aDadostit2[X,5]+"'" + CRLF
		cScript += "    AND BMR_NUMLOT = '"+aDadostit2[X,6]+"'" + CRLF
		cScript += "    AND BMR_CODLAN = '"+aDadostit2[X,7]+"'" + CRLF
		cScript += "    AND BMR.D_E_L_E_T_ = '*'" + CRLF
           
        If TcSqlExec(cScript) < 0
  		   LogErros('Erro ao rodar o script [ ' + cScript + ' ]. ' + CRLF + 'Descr. Erro: ' + CRLF + TcSqlError())
	    EndIf

      X++
*/
   If  lfazi
        
        I := I++       
   
   EndIf 
       
       
return()

Static Function Fazlog(cIdent)
       
	   If cIdent=='1'
          a:= 'b'
	   EndIf 

return()	   

Static Function fValAcao()

local lRet:= .F.

	
	if  (( (cAliastmp5)->CIrpfcal - (cAliastmp5)->CIrrf > 0.05)  .or. ;
		 ( (cAliastmp5)->CIrrf - (cAliastmp5)->CIrpfcal > 0.05)  .or. ; 
	     ( (cAliastmp5)->CInsscalc - (cAliastmp5)->CInss > 0.05) .or. ;
         ( (cAliastmp5)->CInss - (cAliastmp5)->CInsscalc > 0.05))

		lRet:= .T.

    EndIf 

return(lRet)
/*
SELECT * FROM BMR010 BMR
WHERE BMR_FILIAL = ' '  
--  AND (BMR_CODLAN = '182' OR BMR_CODLAN = '183') -- INSS
AND (BMR_CODLAN = '198' OR BMR_CODLAN = '199') -- IRRF
AND BMR.D_e_l_e_t_ = '*'

*/
/*
static Function fAcertaE2() 

'UPDATE " +RetSQLName("SE2")+ " SET
  E2_PARCINS = ''' ||Decode(Calc.Insscalc, 0,' ' ,'1')||''', 
  E2_PARCIR  = '''||DECODE(Calc.Irpfcal, 0,' ' ,'1')||''', 
  E2_IRRF    = '||Trunc(Calc.Irpfcal,2) ||' ,
  E2_baseirf = '||Trunc((Vlrbrut  - Calc.Insscalc),2)||' ,
  E2_vlcruz  = '||Trunc((Vlrbrut - Calc.Irpfcal - Calc.Insscalc),2)||' ,
  E2_INSS    = '||Trunc( Calc.Insscalc,2) ||',
  E2_VALOR   ='||Trunc((Vlrbrut  - Calc.Irpfcal - Calc.Insscalc),2)||' ,
  E2_SALDO ='||Trunc((Vlrbrut  - Calc.Irpfcal - Calc.Insscalc),2)|| '
WHERE  
  e2_fornece = '''||calc.Fornece||''' and
  E2_PREFIXO || E2_NUM || E2_TIPO = '''||  Calc.Tit ||''';'
  "
cQuery0 += CRLF + " (Case When (Trunc( Calc.Insscalc,2)) <> Calc.Inss  "
cQuery0 += CRLF + "       Then ('UPDATE  " +RetSQLName("SE2")+ " SET  e2_parcela = '''||Decode(Calc.Insscalc, 0,' ' ,'1')||''', E2_VALOR ='||Trunc(( Calc.Insscalc),2)||' ,E2_SALDO ='||Trunc((Calc.Insscalc),2)||' WHERE  E2_PREFIXO || E2_NUM || E2_TIPO = '''||  Substr(Calc.Tit,1,12) ||'INS'';') Else ' ' End) Fazins , "
cQuery0 += CRLF + " (Case When Trunc(Calc.Irpfcal,2) <> Calc.Irrf "
cQuery0 += CRLF + "       Then ('UPDATE " +RetSQLName("SE2")+ " SET  e2_parcela = '''||DECODE(Calc.Irpfcal, 0,' ' ,'1')||''',  E2_VALOR ='||Trunc((Calc.Irpfcal),2)||' ,E2_SALDO ='||Trunc((Calc.Irpfcal),2)||' WHERE  E2_PREFIXO || E2_NUM || E2_TIPO = '''||  Substr(Calc.Tit,1,12) ||'TX'';' ) Else ' ' End) Faztxs "

        cScript := " UPDATE "+ RetSqlName("SE2")+" SE2 "  + CRLF
		cScript += "    SET E2_PREFIXO = '"+aDadostit1[i,1]+"'," + CRLF
		cScript += "        E2_NUM     = '"+aDadostit1[i,2]+"'," + CRLF
        cScript += "        E2_TIPO    = 'TX'        ," + CRLF

		cScript += "        E2_parcela = '1'         ," + CRLF
		cScript += "        E2_EMISSAO = '"+aDadostit1[i,11]+"'," + CRLF

        cScript += "        E2_VENCTO  = '20200620'  ," + CRLF
	    cScript += "        E2_VENCREA = '20200620'  ," + CRLF
     
		cScript += "        E2_VALOR   = "+Str(aDadostit1[i,7])+"," + CRLF 
		cScript += "        E2_SALDO   = "+Str(aDadostit1[i,7])+"," + CRLF
		cScript += "        E2_VENCORI = '20200620'  , " + CRLF
		cScript += "        E2_VLCRUZ  = "+Str(aDadostit1[i,7])+"," + CRLF
		cScript += "        E2_ANOBASE = '2020'      ," + CRLF
		cScript += "        E2_MESBASE = '04'        , " + CRLF
		cScript += "        E2_CODRDA  = '"+aDadostit1[i,10]+"' ," + CRLF
		cScript += "        E2_FORORI  = '"+aDadostit1[i,8]+"' ," + CRLF
		cScript += "        E2_PLLOTE  = '"+aDadostit1[i,9]+"' ,"+ CRLF
		cScript += "        E2_TITPAI  = '"+aDadostit1[i,1]+aDadostit1[i,2]+' '+aDadostit1[i,5]+aDadostit1[i,8]+'01'+"'," + CRLF
		cScript += "        SE2.D_e_l_e_t_ = ' '  " + CRLF
		cScript += "  WHERE E2_FILIAL  = '" + xFilial('SE2')+ "'  " + CRLF
		cScript += "    AND (d_E_L_E_T_ = '*' OR E2_VALOR = 0 )  " + CRLF
		cScript += "    AND E2_PREFIXO = '"+aDadostit2[z,1]+"' " + CRLF
		cScript += "    AND E2_NUM     = '"+aDadostit2[z,2]+"' "+ CRLF
		cScript += "    and e2_tipo    = 'TX' " + CRLF
		cScript += "    AND E2_CODRET  = '0588' "+ CRLF
		cScript += "    and e2_emissao = '"+aDadostit2[z,5]+"' " + CRLF
		cScript += "    And e2_origem  = 'PLSMPAG' " + CRLF
		cScript += "    AND E2_BAIXA   = ' ' " + CRLF                                              
*/
#Define CRLF Chr(13)+Chr(10)
#INCLUDE "rwmake.ch"
#include "PROTHEUS.CH"                                                                                                                         
#include "TOPCONN.CH"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ CABR185  º Autor ³ Altamiro Affonso   º Data ³  10/06/15   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Relatorio de extrato de comissão - conferencia             º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP6 IDE                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CABR276()  

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
 //   @ nLin,001 PSAY ctraco80
Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := "de processos juridicos por origem , tipo  "
Local cDesc3         := "fazendo tratando alguns filtro a serem definidos "
Local cPict          := ""
Local titulo         := "Relatorio de processos  Sintetico "

Local Cabec1         := "  " //Codigo     Descrição                                            Saldo"
//                       12345678901234567890123456789012345678901234567890123456789001234567890
//                       0        1         2         3         4         5         6          7
//                          XXX       XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX   999.999.999,99 
//                      BK2_PROPRI||BK2_CODLAN,                                    Sum(BK2_SALDO) 
Local Cabec2         := " "
Local imprime        := .T.
Local aOrd           := {}
Private nLin         := 220  
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite       := 100
Private tamanho      := "P"
Private nomeprog     := "CABR276"
Private nTipo        := 15
Private aReturn      := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
Private nLastKey     := 0
Private cbtxt        := Space(10)
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01
Private wnrel        := "CABR276"
Private cString      := "SE2"
Private cPerg        := "CABR276   "
private ctraco80     := replicate("_",080)  
Private cAliastmp    := GetNextAlias()
Private cAliastmp1 	 := GetNextAlias()
Private cAliastmp2 	 := GetNextAlias()      
Private cAliastmp3 	 := GetNextAlias()

private cEscAdv      := ' ' 

Private cQuery        := " "   
Private cQuery1       := " "  
Private cQuery2       := " "  
Private cQuery3       := " "  

/*
ValidPerg(cPerg)

If Pergunte(cPerg,.T.) = .F.
	Return
Endif                                     

*/

//Pergunte(cPerg,.T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Monta a interface padrao com o usuario...                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

wnrel := SetPrint(cString,NomeProg,"",@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,Tamanho,,.T.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

nTipo := If(aReturn[4]==1,15,18)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Processamento. RPTSTATUS monta janela com a regua de processamento. ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³RUNREPORT º Autor ³ AP6 IDE            º Data ³  31/08/07   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS º±±
±±º          ³ monta a janela com a regua de processamento.               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)

Local nOrdem
Local cQuery := ' '
dbSelectArea(cString)
dbSetOrder(1)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ SETREGUA -> Indica quantos registros serao processados para a regua ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SetRegua(RecCount())                    
/****************************************************/
/* CQUERY  - QUERY DE CARGA DE CALCULO DA COMISSAO  */
/* CQYERY1 - Dados do(s) Titulo(S) a receber        */
/* CQYERY2 - compossição da cobrança                */
/****************************************************/   
///--- TOTAL DE PROCESSOS ---    

cQuery :=        " select pbw_escadv escadv , '1-Total Processo' IDENT , count(*) qtda "
cQuery += CRLF + "   from " + RetSqlName("PBW") +" PBW" 
cQuery += CRLF + "  where pbw_filial =' ' and d_E_L_E_T_ = ' ' and trim(Pbw_dtarq) is null "
cQuery += CRLF + " and substr(pbw_tpacao,1,4) In ('ALER','DECO','MINI','PROC','RECE','ACAO','EXEC') 
cQuery += CRLF + " group by pbw_escadv  order by 1 "

//--- TOTAL POR TIPO DE PROCESSO  ---     

cQuery1 := " select nvl(pbw_escadv,' ') escadv , '2-Total Tipo Processo' IDENT,  substr(pbw_tpauto,1,13) tpauto , count(*) qtda " 
cQuery1 += CRLF + "   from " + RetSqlName("PBW") +" PBW" 
cQuery1 += CRLF + "  where pbw_filial =' ' and d_E_L_E_T_ = ' ' and trim(Pbw_dtarq) is null  "
cQuery1 += CRLF + "    and substr(pbw_tpacao,1,4) In ('ALER','DECO','MINI','PROC','RECE','ACAO','EXEC')"
cQuery1 += CRLF + "  group by pbw_escadv , substr(pbw_tpauto,1,13) "
cQuery1 += CRLF + "  order by 1,2,3 "

//--- TOTAL POR TIPO DE ACAO ---     

cQuery2 := " select nvl(pbw_escadv,' ') escadv  , '3-Total tpacao ' IDENT , substr(pbw_tpauto,1,13) tpauto , substr(Pbw_Tpacao,1,13) Tpacao , count(*) qtda " 
cQuery2 += CRLF + "   from " + RetSqlName("PBW") +" PBW" 
cQuery2 += CRLF + "  where pbw_filial =' ' and d_E_L_E_T_ = ' ' and trim(Pbw_dtarq) is null  "
cQuery2 += CRLF + "    and substr(pbw_tpacao,1,4) In ('ALER','DECO','MINI','PROC','RECE','ACAO','EXEC')"
cQuery2 += CRLF + "  group by pbw_escadv , substr(pbw_tpauto,1,13) , substr(Pbw_Tpacao,1,13)"  
cQuery2 += CRLF + "  order by 1,2,3,4 "
//--- TOTAL POR TIPO DE ASSUNTO ---     

cQuery3 := " select nvl(pbw_escadv,' ') escadv  ,'4-Total Assunto processo' IDENT ,substr(pbw_tpauto,1,13) tpauto , substr(Pbw_Tpacao,1,13) Tpacao , substr(pbw_asspro,1,35) asspro , count(*) qtda " 
cQuery3 += CRLF + "   from " + RetSqlName("PBW") +" PBW" 
cQuery3 += CRLF + "  where pbw_filial =' ' and d_E_L_E_T_ = ' ' and trim(Pbw_dtarq) is null  "
cQuery3 += CRLF + "    and substr(pbw_tpacao,1,4) In ('ALER','DECO','MINI','PROC','RECE','ACAO','EXEC')"
cQuery3 += CRLF + "  group by pbw_escadv , substr(pbw_tpauto,1,13) , substr(Pbw_Tpacao,1,13) , substr(pbw_asspro,1,35) " 
cQuery3 += CRLF + "  order by 1,2,3,4,5 "

//-----------------------------------------
If Select((cAliastmp)) <> 0 
   (cAliastmp)->(DbCloseArea())  
Endif 
If Select((cAliastmp1)) <> 0 
   (cAliastmp1)->(DbCloseArea())  
Endif
If Select((cAliastmp2)) <> 0 
   (cAliastmp2)->(DbCloseArea())  
Endif
If Select((cAliastmp3)) <> 0 
   (cAliastmp3)->(DbCloseArea())  
Endif                
        
TCQuery cQuery  New Alias (cAliastmp)   
TCQuery cQuery1 New Alias (cAliastmp1)   
TCQuery cQuery2 New Alias (cAliastmp2)   
TCQuery cQuery3 New Alias (cAliastmp3)   


(cAliastmp)->(dbGoTop()) 
(cAliastmp1)->(dbGoTop())
(cAliastmp2)->(dbGoTop())
(cAliastmp3)->(dbGoTop())

//While (cAliastmp)->(!EOF()) .and. (cAliastmp1)->(!EOF()) .and. (cAliastmp2)->(!EOF()) .and. (cAliastmp3)->(!EOF()) .and. (cAliastmp4)->(!EOF())
	If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
       titulo := "Processos Sintetico - Ativos - " + (cAliastmp)->escadv
       cEscAdv:= (cAliastmp)->escadv
	   nLin   :=	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
	   nLin ++
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica o cancelamento pelo usuario...                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	
	If lAbortPrint
		@nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
	 //	Exit
	Endif
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Impressao do cabecalho do relatorio. . .                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ  
	//identificacao da empresa (contratante)

    While (cAliastmp)->(!EOF())  .and. (cAliastmp)->escadv == cescadv  	
             If nLin > 55 .or. (cAliastmp)->escadv <> cescadv  
                titulo := "Processos Sintetico - Ativos - " + (cAliastmp)->escadv
                cEscAdv:= (cAliastmp)->escadv
	            nLin :=	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
	            nLin ++
	         Endif
    
           @ nLin,001 PSAY (cAliastmp)->IDENT
           @ nLin,058 PSAY (cAliastmp)->qtda  Picture "@E 99,999" 
           @ nLin,075 PSAY '100%'    
             nlin++
              
             
             If nLin > 55 .or. (cAliastmp)->escadv <> cescadv  
                titulo := "Processos Sintetico - Ativos - " + (cAliastmp)->escadv
                cEscAdv:= (cAliastmp)->escadv
	            nLin :=	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
	            nLin ++
	         Endif
	         
      While (cAliastmp1)->(!EOF())   .and. (cAliastmp1)->escadv == cescadv  
          
          // @ nLin,005 PSAY (cAliastmp1)->IDENT
           @ nLin,005 PSAY (cAliastmp1)->tpauto 
           @ nLin,058 PSAY (cAliastmp1)->qtda  Picture "@E 99,999" 
           @ nLin,073 PSAY (((cAliastmp1)->qtda / (cAliastmp)->qtda )*100) Picture "@E 999.99%"     
             nlin++
             If nLin > 55  
	            nLin :=	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
	            nLin ++
	         Endif             
           While (cAliastmp2)->(!EOF()) .and. (cAliastmp1)->tpauto == (cAliastmp2)->tpauto .and. (cAliastmp2)->escadv == cescadv   
          
            //   @ nLin,008 PSAY (cAliastmp2)->IDENT
               @ nLin,008 PSAY (cAliastmp2)->Tpacao 
               @ nLin,058 PSAY (cAliastmp2)->qtda  Picture "@E 99,999" 
               @ nLin,073 PSAY (((cAliastmp2)->qtda / (cAliastmp)->qtda )*100) Picture "@E 999.99%"    
                 nlin++  
          
                If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
	               nLin :=	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
	               nLin ++
	            Endif
          
               While (cAliastmp3)->(!EOF()) .and. (cAliastmp2)->Tpacao == (cAliastmp3)->Tpacao  .and. (cAliastmp3)->escadv == cescadv  
          
             //      @ nLin,008 PSAY (cAliastmp3)->IDENT
                   @ nLin,010 PSAY (cAliastmp3)->asspro
                   @ nLin,058 PSAY (cAliastmp3)->qtda  Picture "@E 99,999" 
                   @ nLin,073 PSAY (((cAliastmp3)->qtda / (cAliastmp)->qtda )*100) Picture "@E 999.99%"    
                     nlin++
                     
                     If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
	                    nLin :=	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
	                    nLin ++
	                 Endif

                     (cAliastmp3)->(dbSkip())                  
                EndDo                  
                       
               (cAliastmp2)->(dbSkip())                  
           EndDo                  
          
          (cAliastmp1)->(dbSkip())                  
      EndDo                  
          
      (cAliastmp)->(dbSkip())                  
  EndDo                      
          
              
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Finaliza a execucao do relatorio...                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SET DEVICE TO SCREEN

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se impressao em disco, chama o gerenciador de impressao...          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If aReturn[5]==1
	dbCommitAll()
	SET PRINTER TO
	OurSpool(wnrel)
Endif    

MS_FLUSH()       



Return      



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ValidPerg º Autor ³ Jose Carlos Noronhaº Data ³ 01/08/07    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Parametros para selecao dos titulos do PLS                 º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ValidPerg()

Local aAreaAtu := GetArea()
Local aRegs    := {}
Local i,j

DbSelectArea("SX1")
dbSetOrder(1)
cPerg := PADR(cPerg,10)

aAdd(aRegs,{cPerg,"01","Mes/Ano Comissao       ?","","","mv_ch1","C",07,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "99/9999", "" })
aAdd(aRegs,{cPerg,"02","Cod Empresa De         ?","","","mv_ch2","C",04,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"03","Cod Empresa Ate        ?","","","mv_ch3","C",04,0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"04","Vendedor De            ?","","","mv_ch4","C",06,0,0,"G","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" })
aAdd(aRegs,{cPerg,"05","Vendedor Ate           ?","","","mv_ch5","C",06,0,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "", "" })
aadd(aRegs,{cPerg,"06","Matric. Incl. Anterior ?","","","mv_ch6","N", 1,0,0,"C","","mv_par06","Sim","","","","","Nao","","","","","","","","","","","","","","","","","" , "" ,""  , "", "", "" })
aadd(aRegs,{cPerg,"07","Regras de Comissoa     ?","","","mv_ch7","N", 1,0,0,"C","","mv_par07","Sintetica","","","","","Analitica","","","","","","","","","","","","","","","","","" , "" ,""  , "", "", "" })

For i:=1 to Len(aRegs)
	If !dbSeek(cPerg+aRegs[i,2])
		RecLock("SX1",.T.)
		For j:=1 to FCount()
			If j <= Len(aRegs[i])
				FieldPut(j,aRegs[i,j])
			Endif
		Next
		MsUnlock()
	Endif
Next

RestArea( aAreaAtu )

Return(.T.)






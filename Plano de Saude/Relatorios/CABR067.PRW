#INCLUDE "rwmake.ch"
#INCLUDE "topconn.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ CABR095  º Autor ³ Altamiro Affonso   º Data ³  01/08/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Relatorio Acompanhamento de Reembolso                      º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP6 IDE                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CABR067

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := "e emitir planolhas de acompanhamento do processo   "
Local cDesc3         := "processo de rembolso  - Protocolados X Calculados  "
Local cPict          := ""
Local titulo         := "Acompanhamento de reembolsos protocolados X Calculados "
Local nLin           := 80 															
Local Cabec1         := "Tipo                Data                                Vlr.Aprecentado  QTDA     Tipo               Data       Vlr.Apresentado      Vlr.Calculado       QTDA             Colaborador"
Local Cabec2         := ""
//                       123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789001234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789001234567890
//                       0        1         2         3         4         5         6         7         8         9         10        11        12        13         14        15        16        17        18        19        20        21        22        23        24
//                        Protocolados       XX/XX/XXXX                      XXX.XXX.XXX,XX     XX.XXX  -  Calculados         XX/XX/XXXX  XXX.XXX.XXX,XX      XXX.XXX.XXX,XX       XX.XXX
//                        
//                      BK2_PROPRI||BK2_CODLAN,                                    Sum(BK2_SALDO) 
Local Cabec2         := ""
Local imprime        := .T.
Local aOrd           := {}
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite       := 220
Private tamanho      := "G"
Private nomeprog     := "CABR67"
Private nTipo        := 15
Private aReturn      := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
Private nLastKey     := 0
Private cbtxt        := Space(10)
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01
Private wnrel        := "CABR067"
Private cString      := "b44"
Private cPerg        := "CAB067    "
Private vlr_tot      := 0.00  
Private vlr_Sald     := 0.00   
private nQtdac       := 0
private nVlSolc      := 0.00      
private nVlLibc      := 0.00      
private nQtdap       := 0
private nVlSolp      := 0.00      
Private cquebra      := " " 
Private lflagtot     :=.F.
private cNovGrpPag   := " "      
private acabec1      := {"Tipo"," Data"," Vlr.Apresentado", "QTDA", " ","Tipo","Data","Vlr.Apresentado", "Vlr.Calculado","QTDA","Colaborador"}
private acabec2      := {"Colaborador","QTDA","Vlr.Apresentado", "Vlr.Calculado"}
private aDados       := {}  
private aDados1      := {}
dbSelectArea("B44")
dbSetOrder(1)              
ValidPerg(cPerg)
If Pergunte(cPerg,.T.) = .F.
	Return
Endif
    
Private dDtinic    := dtos(mv_par01) 
Private dDtFim     := dtos(mv_par02) 
Private nGeraExc   := Iif(mv_par03==1,.T.,.F.)   
 
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
cQuery := " SELECT zzq_datdig , substr(zzq_datdig,7,2)||'/'||substr(zzq_datdig,5,2)||'/'||substr(zzq_datdig,1,4) Dt_digita, sum(zzq_vlrtot) Vlr_solic, count(*) Qtda "
cQuery += " FROM "+ RetSqlName('ZZQ ') +" ZZQ  WHERE D_E_L_E_T_ = ' ' AND ZZQ_FILIAL = '"+xFilial("ZZQ")+"' "     
cQuery += " AND ZZQ_DATDIG BETWEEN '"+dDtinic+"' AND '"+dDtFim +"' and zzq_status not in ('2') "
cQuery += " group by zzq_datdig " 
cQuery += " order by zzq_datdig "

cQuery1 := " SELECT  b44_dtdigi , b44_yussis, substr(b44_dtdigi,7,2)||'/'||substr(b44_dtdigi,5,2)||'/'||substr(b44_dtdigi,1,4) Dt_Calc, sum (zzq_vlrtot) vlr_solic, sum (b44_vlrpag) pagto, count(*) Qtda " 
cQuery1 += " FROM "+ RetSqlName('ZZQ ') +" ZZQ , "+ RetSqlName('b44 ') +" b44 "
cQuery1 += " WHERE ZZQ.D_E_L_E_T_ = ' ' AND ZZQ_FILIAL = '"+xFilial("ZZQ")+"' and b44_filial = '"+xFilial("B44")+"' and  b44.d_e_l_e_t_ =  ' ' "   
cQuery1 += " AND b44_DTDIGI BETWEEN '"+dDtinic+"' AND '"+dDtFim +"' and zzq_status not in ( '2') and b44_ycdptc = zzq_sequen and b44_prefix = 'RLE' "
cQuery1 += " group by b44_dtdigi, b44_yussis "
cQuery1 += " order by b44_dtdigi, b44_yussis "


 If Select(("TMP")) <> 0 
    ("TMP")->(DbCloseArea())  
 Endif
 TCQuery cQuery Alias "TMP" New 
 dbSelectArea("TMP")
 tmp->(dbGoTop())      
 
 If Select(("TMP1")) <> 0 
    ("TMP1")->(DbCloseArea())  
 Endif
 TCQuery cQuery1 Alias "TMP1" New 
 dbSelectArea("TMP1")
 tmp1->(dbGoTop())   

 lvaz := (TMP->(!Eof()) .or. TMP1->(!EOF()))       
nQtdac       := 0
nVlSolc      := 0.00      
nVlLibc      := 0.00      
nQtdap       := 0
nVlSolp      := 0.00                
 
   While lvaz //(TMP->(!Eof()) .or. TMP1->(!EOF())                                                                
	  If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
	   nLin :=	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
	   nLin ++
	Endif
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica o cancelamento pelo usuario...                             ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If lAbortPrint
		@nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"
		Exit
	Endif                                                     

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Impressao do cabecalho do relatorio. . .                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ                                                            
//                       123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789001234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789001234567890
//                       0        1         2         3         4         5         6         7         8         9         10        11        12        13         14        15        16        17        18        19        20        21        22        23        24
//                        Protocolados       XX/XX/XXXX                      XXX.XXX.XXX,XX     XX.XXX  -  Calculados         XX/XX/XXXX  XXX.XXX.XXX,XX      XXX.XXX.XXX,XX       XX.XXX
  if ((tmp->zzq_datdig <= tmp1->b44_dtdigi) .and. !empty(tmp->zzq_datdig) .or. empty(tmp1->b44_dtdigi))
	 @ nLin,002 PSay  'Protocolados' 
	 @ nLin,021 PSay tmp->Dt_digita
	 @ nLin,053 PSay Transform(tmp->Vlr_solic,"@E 99,999,999.99") 
	 @ nLin,072 PSay Transform(tmp->Qtda,"@E 99,999") 
	 Campo1:= 'Protocolados'	
     Campo2:= tmp->Dt_digita 
     Campo3:= Transform(tmp->Vlr_solic,"@E 99,999,999.99") 
     Campo4:= Transform(tmp->Qtda,"@E 99,999")           
     nQtdap += tmp->Qtda
     nVlSolp+= tmp->Vlr_solic
  Else 
     Campo1:= ' '	
     Campo2:= ' ' 
     Campo3:= ' ' 
     Campo4:= ' '
  EndIf	 
	 @ nLin,079 PSay ' - '
	 Campo5:= ' - '
  If ((tmp1->b44_dtdigi<= tmp->zzq_datdig) .and. !empty(tmp1->b44_dtdigi) .or. empty(tmp->zzq_datdig))
     @ nLin,083 PSay  'Calculado ' 
	 @ nLin,102 PSay tmp1->Dt_Calc
	 @ nLin,114 PSay Transform(tmp1->Vlr_solic,"@E 99,999,999.99")  
 	 @ nLin,133 PSay Transform(tmp1->pagto,"@E 99,999,999.99") 
	 @ nLin,154 PSay Transform(tmp1->Qtda,"@E 99,999")
     @ nLin,170 PSay tmp1->b44_yussis     
     Campo6 := 'Calculado ' 	
     Campo7 := tmp1->Dt_Calc 
     Campo8 := Transform(tmp1->Vlr_solic,"@E 99,999,999.99") 
     Campo9 := Transform(tmp1->pagto,"@E 99,999,999.99")   
     Campo10:= Transform(tmp1->Qtda,"@E 99,999")	
     Campo11:= tmp1->b44_yussis
     nQtdac += tmp1->Qtda
     nVlSolc+= tmp1->Vlr_solic      
     nVlLibc+= tmp1->pagto     
  Else
     Campo6 := ' '	
     Campo7 := ' ' 
     Campo8 := ' ' 
     Campo9 := ' '   
     Campo10:= ' '	
     Campo11:= ' ' 
  EndIf    
  	If (nAscan:=Ascan(adados1 , {|e| e[1] == tmp1->b44_yussis  }))== 0 
	    Aadd(adados1 , {tmp1->b44_yussis,;
	                    tmp1->Qtda      ,;
	                    tmp1->Vlr_solic ,; 
                        tmp1->pagto})
	Else                     
	    adados1[nAscan,02]+=tmp1->Qtda 
	    adados1[nAscan,03]+=tmp1->Vlr_solic
	    adados1[nAscan,04]+=tmp1->pagto                                       
	EndIf 
	
                                      
	nLin ++     // Avanca a linha de impressao 
	// Avanca o ponteiro do registro no arquivo
 if (tmp->Dt_digita <= tmp1->Dt_Calc) .or. TMP1->(Eof())
    tmp->(dbSkip()) 
 EndIf                              
 If (tmp1->Dt_Calc <= tmp->Dt_digita).or. TMP->(Eof())
    tmp1->(dbSkip())
 EndIf               
	lvaz := (TMP->(!Eof()) .or. TMP1->(!EOF()))   

  If nGeraExc	
	aaDD(aDados,{ Campo1 ,;	
                  Campo2 ,;  
                  Campo3 ,; 
                  Campo4 ,; 
                  Campo5 ,;	
                  Campo6 ,;  
                  Campo7 ,; 
                  Campo8 ,;
                  Campo9 ,;	
                  Campo10,;  
                  Campo11})
  EndIf                
EndDo    
    @ nLin,000 PSay replicate("_",220)
    nlin++                         
     @ nLin,008 PSay  'Totais ---> ' 
     @ nLin,053 PSay Transform(nVlSolp,"@E 99,999,999.99") 
	 @ nLin,072 PSay Transform(nQtdap ,"@E 99,999") 
	 @ nLin,114 PSay Transform(nVlSolc,"@E 99,999,999.99")  
 	 @ nLin,133 PSay Transform(nVlLibc,"@E 99,999,999.99") 
	 @ nLin,154 PSay Transform(nQtdac,"@E 99,999")        
    nlin++                         	 
    @ nLin,000 PSay replicate("_",220)            
    nlin++                         	 
    nlin++                         	 
    nlin++                         	                                       
    nlin++                         	                      
     @ nLin,010 PSay '+----------------------+-------+Resumo-----------+-----------------+          
     nlin++                         	 
     @ nLin,010 PSay '| Colaborador          |  Qtda | Tot. Apresentado| Tot. Calculado  |          
     nlin++                         	 
     @ nLin,010 PSay '+----------------------+-------+-----------------+-----------------+          
     i:=1
     While i <= len(adados1)                                                                                        
         nlin++                         	                                                            
         @ nLin,010 PSay '|'
         @ nLin,011 PSay  Substr(adados1[i,1],1,20) 
         @ nLin,033 PSay '|'         
         @ nLin,034 PSay  Transform(adados1[i,2],"@E 99,999")
         @ nLin,041 PSay '|'
     	 @ nLin,043 PSay Transform(adados1[i,3],"@E 99,999,999.99")  
         @ nLin,059 PSay '|'
 	     @ nLin,062 PSay Transform(adados1[i,4],"@E 99,999,999.99")                                     
         @ nLin,077 PSay '|'
          nlin++                         	 
        @ nLin,010 PSay '+----------------------+-------+-----------------+-----------------+                
      i++
     Enddo
                                          
 If nGeraExc	
	DlgToExcel({{"ARRAY"," Relação de Reembolso no periodo" ,aCabec1,aDados}}) 
    DlgToExcel({{"ARRAY"," Resumo de Produção por colaborador " ,aCabec2,aDados1}})
 EndIf	
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

cPerg := PADR(cPerg,6)    

                                                                                                                                                                                           
PutSx1(cPerg,"01","Data inicial  " ,"","","mv_ch01","D",08,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "99/99/9999", "" ) 
PutSx1(cPerg,"02","Data Final    " ,"","","mv_ch02","D",08,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "99/99/9999", "" ) 
PutSx1(cPerg,"03","Geral Excel   " ,"","","mv_ch08","N",01,0,0,"C","","","","","mv_par08","Sim","","","","Não","","","","","","","","","","","",{},{},{})


Return(.T.)



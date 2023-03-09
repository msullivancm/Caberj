#INCLUDE "rwmake.ch"                                                                                                                               
#INCLUDE "topconn.ch"       
#Define CRLF Chr(13)+Chr(10)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ CABR240  º Autor ³ Altamiro Affonso   º Data ³  11/09/12   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Conferencia do custo                                       º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP6 IDE                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function CABR240(  cMesBase1     , cAnoBase1     ,cNumTitI1    ,cNumTitF1     ,cOpeInc1      ,cOpeFim1 )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := "com Inconsitencia dos titulos financeiro para o custo"
Local cDesc3         := " "
Local cPict          := ""
Local titulo         := "Relatório de Despesas de Convênios Reciprocidade"
Local nLin           := 88 	
LOCAL cCabec1        := "Associado                                               Mat. Convenio      Data Proc.   Prestador                    Nr.Impresso           Procedimento                              Valor     Taxa Conv.         INSS   " 
LOCAL cCabec2        := " "
Local imprime        := .T.
Local aOrd           := {}
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private CbTxt        := ""
Private limite       := 220
Private tamanho      := "G"
Private nomeprog     := "CABR240"
Private nTipo        := 15
Private aReturn      := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
Private nLastKey     := 0
Private cbtxt        := Space(10)
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01
Private wnrel        := "CABR240"
Private cString      := "SE2"
Private cPerg        := "CABR240"
Private vlr_tot      := 0.00  
Private vlr_Sald     := 0.00                                                                      
Private cquebra      := " " 
Private lflagtot     :=.F.
private cNovGrpPag   := " "    
private cAliasCT     := GetNextAlias()       

private cdat         :=" "  

    Private cMesBase     := ' '  
    Private cAnoBase     := ' ' 
    Private cNumTitI     := ' '  
    Private cNumTitF     := ' '     
    Private cOpeInc      := ' ' 
    Private cOpeFim      := ' '                 

private _nTotUsrValor := 0
Private _nTotUsrTaxa  := 0
Private _nTotUsrINSS  := 0
												
Private _nTotValor := 0
Private _nTotTaxa  := 0
Private _nTotINSS  := 0   

private cOpe       := ' ' 
private cTit       := ' ' 

private cOpeori    := '' 
				
dbSelectArea("SE2")
dbSetOrder(1)                   

 If empty(cMesBase1)

    ValidPerg(cPerg)
    If Pergunte(cPerg,.T.) = .F.
	   Return
    Endif
                                
    cMesBase     := mv_par01 
    cAnoBase     := mv_par02
    cNumTitI     := mv_par03 
    cNumTitF     := mv_par04    
    cOpeInc      := mv_par05
    cOpeFim      := mv_par06    
                                        
Else
     
    cMesBase     := cMesBase1 
    cAnoBase     := cAnoBase1
    cNumTitI     := cNumTitI1 
    cNumTitF     := cNumTitF1
    cOpeInc      := cOpeInc1
    cOpeFim      := cOpeFim1    
    
EndIf 
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

RptStatus({|| RunReport(cCabec1,cCabec2, nomeprog,Titulo,nLin) },Titulo)
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

Static Function RunReport(cCabec1,cCabec2, nomeprog ,Titulo,nLin)

Local nOrdem
Local cQuery := ' ' 
local cMatImpAnt := "" 
dbSelectArea(cString)
dbSetOrder(1)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ SETREGUA -> Indica quantos registros serao processados para a regua ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Busca a movimentacao da operadora por usuarios... somente analitico³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	  

cQuery := "SELECT PCS.PCS_OPEORI OPEORI , " + CRLF
cQuery += "       OPE.NOMOPE NOMOPE ,     " + CRLF
cQuery += "       BA1_NOMUSR NOMUSR , " + CRLF
cQuery += "       BA1_CODINT ||'.'|| BA1_CODEMP ||'.'|| BA1_MATRIC ||'-'|| BA1_TIPREG ||'-'||BA1_DIGITO MATRIC , " + CRLF
cQuery += "       BA1_YMTREP YMTREP , " + CRLF
cQuery += "       TO_DATE(TRIM(BD6_DATPRO),'YYMMDD') DATPRO , " + CRLF
cQuery += "       BD6_CODRDA ||'-'||SUBSTR(BAU_NOME,1,20) RDA  , " + CRLF
cQuery += "       BD6_NUMIMP NUMIMP , " + CRLF
cQuery += "       BD6_CODPRO CODPRO , " + CRLF
cQuery += "       SUBSTR(BD6_DESPRO,1,20) DESPRO , " + CRLF 
cQuery += "       PCS_VLRBPF VLRBPF , " + CRLF
cQuery += "       PCS_VLRTAD VLRTAD , " + CRLF
cQuery += "       PCS_VLRINS VLRINS , " + CRLF
cQuery += "       E1_PREFIXO E1PREF , E1_NUM E1NUM , E1_PARCELA E1PARC , E1_TIPO E1TIPO , E1_VALOR E1VALOR " + CRLF       
                                              
cQuery += "       , DECODE(NVL(trim(XML.IDLOTE),' ' ),' ',' ' , XML.IDLOTE) IDLOT " + CRLF

cQuery += "  FROM "+RetSqlName('PCS')+ " PCS,"+RetSqlName('BD6')+ " BD6, "+RetSqlName('BA1')+ " BA1, "+RetSqlName('BAU')+ " BAU , "+RetSqlName('SE1')+ " SE1 ,"  + CRLF

cQuery += "       (select DISTINCT trim(RCP.RECBD6) RECBD6 , trim(RCP.IDLOTE) IDLOTE " + CRLF
cQuery += "          from siga.RECIPR_PROCEDIMENTO RCP , siga.RECIPR_LOTE RCG , siga.RECIPR_LOTE RCL " + CRLF
cQuery += "         where RCP.IDLOTE = RCG.IDLOTE " + CRLF 
cQuery += "           AND RCP.IDLOTE = RCL.IDLOTE " + CRLF
cQuery += "           AND RCL.XML_GERADO ='S' " + CRLF
cQuery += "           AND TRIM(RCP.EMPRESA) ='CABERJ'" + CRLF
cQuery += "           AND LTRIM(RCP.OPERADORA) = 'CABESP') XML , " + CRLF

cQuery += "       (SELECT '10'||BGH_GRUOPE OPEORI , BA2_DESCRI NOMOPE ,  BGH_VLRTRC VLRCOB " + CRLF                                         

cQuery += "          FROM "+RetSqlName('BGH')+ " BGH,"+RetSqlName('BA2')+ " BA2 " + CRLF
cQuery += "         WHERE BA2_FILIAL = '"+xFilial("BA2")+"'  AND BA2.D_E_L_E_T_ = ' ' " + CRLF
cQuery += "           AND BGH_FILIAL = '"+xFilial("BGH")+"'  AND BGH.D_E_L_E_T_ = ' ' " + CRLF
cQuery += "           AND BGH_DATFIN = ' ' AND BA2_GRUOPE = BGH_GRUOPE ) OPE " + CRLF  
cQuery += " WHERE PCS_FILIAL = '"+xFilial("PCS")+"' AND PCS.D_E_L_E_T_  = ' ' " + CRLF
//cQuery += "   AND BD6_FILIAL = '"+xFilial("BD6")+"' AND BD6.D_E_L_E_T_  = ' ' " + CRLF  
cQuery += "   AND BD6_FILIAL = '"+xFilial("BD6")+"'  " + CRLF
cQuery += "   AND  E1_FILIAL = '"+xFilial("SE1")+"' AND SE1.D_E_L_E_T_  = ' ' " + CRLF
cQuery += "   AND BA1_FILIAL = '"+xFilial("BA1")+"'  AND BA1.D_E_L_E_T_  = ' ' " + CRLF
cQuery += "   AND BAU_FILIAL = '"+xFilial("BAU")+"'  AND BAU.D_E_L_E_T_  = ' ' AND  BAU.R_E_C_D_E_L_ = 0 " + CRLF
cQuery += "   AND PCS_RECBD6 = BD6.R_E_C_N_O_ " + CRLF
    
cQuery += "   AND PCS_RECBD6 = XML.RECBD6(+)  " + CRLF  
  
cQuery += "   AND PCS_PREFIX = E1_PREFIXO  " + CRLF
cQuery += "   AND PCS_NUMTIT = E1_NUM " + CRLF
 cQuery += "   AND BA1_CODINT = '0001' " + CRLF 
cQuery += "   AND PCS_CODEMP = BA1_CODEMP " + CRLF
cQuery += "   AND PCS_MATRIC = BA1_MATRIC " + CRLF
cQuery += "   AND PCS_TIPREG = BA1_TIPREG " + CRLF
cQuery += "   AND BAU_CODIGO = BD6_CODRDA " + CRLF 
cQuery += "   AND PCS_OPEORI = OPE.OPEORI " + CRLF
  
cQuery += "   AND trim(PCS_ANOPAG) = '"+cAnoBase+"'" + CRLF
cQuery += "   AND trim(PCS_MESPAG) = '"+cMesBase+"'" + CRLF
  
cQuery += "   AND PCS_PREFIX = 'COV' " + CRLF
If !empty(cNumTitI)
   cQuery += "   AND trim(PCS_NUMTIT) >= '"+cNumTitI+"'" + CRLF 
   cQuery += "   AND trim(PCS_NUMTIT) <= '"+cNumTitF+"'" + CRLF
EndIf 
  
cQuery += "   AND trim(PCS_OPEORI) >= '"+cOpeInc+"' AND  trim(PCS_OPEORI) <= '"+cOpeFim+"'  " + CRLF

//cQuery += "   AND E1_VALOR = E1_SALDO " + CRLF
  
cQuery += "   ORDER BY 1,4 " + CRLF   

MemoWrite("C:\TEMP\CABR240.SQL",cQuery)     
            		                              
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime a movimentacao...                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ			        	            		
//Modificada logica para Caberj.
   If Select((cAliasCT)) <> 0 

      (cAliasCT)->(DbCloseArea()) 

   Endif           
                        
   TcQuery cQuery New Alias (cAliasCT)

            		
            //		@ nLin, 000 PSAY Replicate('-',215)
            //		nLin++
								
  If empty(copeOri) 
      copeOri :=  (cAliasCT)->opeori            		              
      
      cOpe:= (cAliasCT)->OPEORI +'-  '+(cAliasCT)->NOMOPE 
      cTit:= (cAliasCT)->E1PREF+'   ' +(cAliasCT)->E1NUM +(cAliasCT)->E1PARC +(cAliasCT)->E1TIPO 
      
      If nLin > 60 // Salto de Página. Neste caso o formulario tem 55 linhas...
	     nLin :=	Cabec(Titulo,cCabec1,cCabec2,NomeProg,Tamanho,nTipo)
	     nLin ++            		
      EndIf         		
  EndIf  
  
   (cAliasCT)->( dbGotop() )
   
   FGrvPlan((cAliasCT)->OPEORI ,(cAnoBase+cMesBase) ) 
   
   (cAliasCT)->( dbGotop() )   
  
  
  While !(cAliasCT)->( Eof() )
            		 
     If (cAliasCT)->MATRIC <> cMatImpAnt

        If !Empty(cMatImpAnt)  
			      				//Imprime totalizador somatorio / batimento de valores...
            @ nLin, 076 PSAY Replicate('-',139)
              nLin++
            @ nLin, 176 PSAY Transform(_nTotUsrValor,"@E 9999,999.99")
            @ nLin, 191 PSAY Transform(_nTotUsrTaxa,"@E 9999,999.99")
            @ nLin, 204 PSAY Transform(_nTotUsrINSS,"@E 9999,999.99") 
              nLin+=2                   
              
        EndIf 
        
        If !empty(copeOri) .and. copeOri <> (cAliasCT)->opeori
           @ nLin, 076 PSAY Replicate('-',139)
             nLin+=2
           @ nLin, 176 PSAY Transform(_nTotUsrValor,"@E 9999,999.99")
           @ nLin, 191 PSAY Transform(_nTotUsrTaxa,"@E 9999,999.99")
           @ nLin, 204 PSAY Transform(_nTotUsrINSS,"@E 9999,999.99") 
             nLin++ 
             nLin++ 	
					      				
//Imprime totalizador somatorio / batimento de valores...
           @ nLin, 000 PSAY Replicate('-',215)
             nLin++
           @ nLin, 176 PSAY Transform(_nTotValor,"@E 9999,999.99")
           @ nLin, 191 PSAY Transform(_nTotTaxa,"@E 9999,999.99")
           @ nLin, 204 PSAY Transform(_nTotINSS,"@E 9999,999.99") 
             nLin ++                                             
      	    			
           @ nLin, 000 PSAY cOpe
           @ nLin, 056 PSAY cTit 
	            			          
           @ nLin, 076 PSAY Transform(_nTotValor,"@E 9999,999.99")
           @ nLin, 091 PSAY Transform(_nTotTaxa,"@E 9999,999.99")  
           @ nLin, 111 PSAY Transform((_nTotTaxa+_nTotValor),"@E 9999,999.99") 
           @ nLin, 140 PSAY Transform(_nTotINSS,"@E 9999,999.99") 
	            			       
	            			       
           _nTotValor := (cAliasCT)->VLRBPF
           _nTotTaxa  := (cAliasCT)->VLRTAD
           _nTotINSS  := (cAliasCT)->VLRINS                                                      
           
           cOpe:= (cAliasCT)->OPEORI +'-  '+(cAliasCT)->NOMOPE 
           cTit:= (cAliasCT)->E1PREF +'   '+(cAliasCT)->E1NUM +(cAliasCT)->E1PARC +(cAliasCT)->E1TIPO 

           copeOri:= (cAliasCT)->opeori
           nLin   := Cabec(Titulo,cCabec1,cCabec2,NomeProg,Tamanho,nTipo)
           nLin ++            		      
           
        EndIf 
        
        @ nLin, 000 PSAY substr((cAliasCT)->NOMUSR,1,30)+ '-' + (cAliasCT)->MATRIC
	    @ nLin, 056 PSAY (cAliasCT)->YMTREP+' '
          cMatImpAnt := (cAliasCT)->MATRIC
        
           If !Empty(cMatImpAnt)     		   
              _nTotUsrValor := 0
              _nTotUsrTaxa  := 0
              _nTotUsrINSS  := 0
          EndIf  
          
          nLin ++
     
 //       @ nLin, 000 PSAY (cAliasCT)->NOMUSR +'-'+ (cAliasCT)->MATRIC
 //	    @ nLin, 056 PSAY (cAliasCT)->YMTREP
 //       cMatImpAnt := (cAliasCT)->MATRIC
		
	EndIf 					

     If (cAliasCT)->IDLOT != ' ' 	  
    	 @ nLin, 005 PSAY 'Lote XML--> '+(cAliasCT)->IDLOT
	 EndIf     
     @ nLin, 076 PSAY (cAliasCT)->DatPro
     @ nLin, 088 PSAY (cAliasCT)->RDA
     @ nLin, 117 PSAY (cAliasCT)->NumImp
     @ nLin, 139 PSAY (cAliasCT)->CODPRO + (cAliasCT)->DESPRO
     @ nLin, 176 PSAY Transform((cAliasCT)->VLRBPF,"@E 9999,999.99")
     @ nLin, 191 PSAY Transform((cAliasCT)->VLRTAD,"@E 9999,999.99")
     @ nLin, 204 PSAY Transform((cAliasCT)->VLRINS,"@E 9999,999.99") //INSS (cfme regra Caberj - Marcela - somente cobra de PF.)
         						
						//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
						//³ 12/2/08: Conforme solicitado pelo finenceiro, somar³
						//³ o valor por usuario para totalizacao individual... ³
						//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ			        	            							
       _nTotUsrValor += (cAliasCT)->VLRBPF
       _nTotUsrTaxa  += (cAliasCT)->VLRTAD
       _nTotUsrINSS  += (cAliasCT)->VLRINS
												
       _nTotValor += (cAliasCT)->VLRBPF
       _nTotTaxa  += (cAliasCT)->VLRTAD
       _nTotINSS  += (cAliasCT)->VLRINS
						
       nLin ++
       If nLin > 60 // Salto de Página. Neste caso o formulario tem 55 linhas...
	      nLin :=	Cabec(Titulo,cCabec1,cCabec2,NomeProg,Tamanho,nTipo)
	      nLin ++            		
       EndIf         		
       (cAliasCT)->( dbSkip() )
            			
  Enddo


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ 12/2/08: Imprime o ultimo totalizador por usuario. ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ			        	            												
//Imprime totalizador somatorio / batimento de valores...
@ nLin, 076 PSAY Replicate('-',139)
  nLin+=2
@ nLin, 176 PSAY Transform(_nTotUsrValor,"@E 9999,999.99")
@ nLin, 191 PSAY Transform(_nTotUsrTaxa,"@E 9999,999.99")
@ nLin, 204 PSAY Transform(_nTotUsrINSS,"@E 9999,999.99") 
nLin++ 
					      				
//Imprime totalizador somatorio / batimento de valores...
@ nLin, 000 PSAY Replicate('-',215)
  nLin++
@ nLin, 176 PSAY Transform(_nTotValor,"@E 9999,999.99")
@ nLin, 191 PSAY Transform(_nTotTaxa,"@E 9999,999.99")
@ nLin, 204 PSAY Transform(_nTotINSS,"@E 9999,999.99")     
  nLin ++                     
@ nLin, 000 PSAY Replicate('-',215)   
  nLin ++                             
@ nLin, 111 PSAY  "T O T A L "
  nLin ++                             
@ nLin, 000 PSAY  "Convênio "         
@ nLin, 056 PSAY  "Titulo"                            
@ nLin, 076 PSAY  "Valor Desp" 
@ nLin, 091 PSAY  "Valor Taxa" 
@ nLin, 111 PSAY  "Desp + Taxa"
@ nLin, 140 PSAY  "Valor Inss"   
  nLin ++                     
@ nLin, 000 PSAY Replicate('-',215) 

  nLin ++                                                   
      				
@ nLin, 000 PSAY cOpe
@ nLin, 056 PSAY cTit 
	            			          
@ nLin, 076 PSAY Transform(_nTotValor,"@E 9999,999.99")
@ nLin, 091 PSAY Transform(_nTotTaxa,"@E 9999,999.99")  
@ nLin, 111 PSAY Transform((_nTotTaxa+_nTotValor),"@E 9999,999.99") 
@ nLin, 140 PSAY Transform(_nTotINSS,"@E 9999,999.99") 
	            			       
					
    
/*                                                                    
	  If nLin > 65 // Salto de Página. Neste caso o formulario tem 55 linhas...
	   nLin :=	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
	   nLin ++
	Endif

*/    

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

cPerg := PADR(cPerg,7)    

PutSx1(cPerg,"01","Mes Compencia     "  ,"","","mv_ch01","C",02,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "99", "" )  
PutSx1(cPerg,"02","Ano Compencia     "  ,"","","mv_ch02","C",04,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "99", "" ) 
PutSx1(cPerg,"03","Num Titulo Inc    "  ,"","","mv_ch03","C",09,0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "99/99/9999", "" ) 
PutSx1(cPerg,"04","Num Titulo Fim    "  ,"","","mv_ch04","C",09,0,0,"G","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "99/99/9999", "" ) 
PutSx1(cPerg,"05","Ope Origem Inc    "  ,"","","mv_ch05","C",04,0,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "99/99/9999", "" )
PutSx1(cPerg,"06","Ope Origem Final  "  ,"","","mv_ch06","C",04,0,0,"G","","mv_par06","","","","","","","","","","","","","","","","","","","","","","","","","" , "" , "" , "", "99", "" )


Return(.T.)
                

Static Function FGrvPlan(cOperadora,cComp )                  
 
          cNomeArq := "C:\TEMP\Conv-Antec - "+trim(cOperadora)+'_'+cComp+DtoS(date())+"_"+STRTRAN(TIME(),":","")+".csv"
       // cNomeArq := "\LOGCOBCONV\"+trim(cOperadora)+'_'+cComp+DtoS(date())+"_"+STRTRAN(TIME(),":","")+".csv"
		nHandle := FCREATE(cNomeArq)
        
        cMontaTxt := 'Empresa  : '+ trim(cOperadora) 
        cMontaTxt += CRLF
        FWrite(nHandle,cMontaTxt)		
        
        cMontaTxt := 'Ação  : Log de Cobrança Parcial '
        cMontaTxt += CRLF
        FWrite(nHandle,cMontaTxt)		  
        
        cMontaTxt := 'Usuario : '+SubStr(cUSUARIO,1,15)
        cMontaTxt += CRLF
        FWrite(nHandle,cMontaTxt) 

  					   cMontaTxt := "Cod. Operador  ;" 
                       cMontaTxt += "Nome operadora  ;" 
                       cMontaTxt += "Nome usuario ;" 
                       cMontaTxt += "Matricula Cab   ;" 
                       cMontaTxt += "Matricula Conv ;" 
                       cMontaTxt += "Data Proc  ;"
                       cMontaTxt += "Prestador ;" 
                       cMontaTxt += "Numero Impr  ;" 
                       cMontaTxt += "Cod Proced.;" 
                       cMontaTxt += "Desc Proced. ;"
                       cMontaTxt += "Vlr Proced ;" 
                       cMontaTxt += "Vlr Taxa   ;" 
                       cMontaTxt += "Vlr Inss ;" 
                       
                       cMontaTxt += "Titulo Cobrança ;" 
                       cMontaTxt += "Vlr Titulo ;"  
                       cMontaTxt += "Lote Xml ;"
                       
                       
                       cMontaTxt += CRLF // Salto de linha para .csv (excel)   
             
		FWrite(nHandle,cMontaTxt)
		                           

	    (cAliasCT)->( dbGotop() )
            		
        While !(cAliasCT)->( Eof() ) 
        
        cdat:=substr(dtos((cAliasCT)->DATPRO),7,2)+'/'+substr(dtos((cAliasCT)->DATPRO),5,2)+'/'+substr(dtos((cAliasCT)->DATPRO),1,4)
   
                       cMontaTxt := (cAliasCT)->OPEORI + ";" 
                       cMontaTxt += (cAliasCT)->NOMOPE + ";" 
                       cMontaTxt += (cAliasCT)->NOMUSR + ";" 
                       cMontaTxt += (cAliasCT)->MATRIC + ";" 
                       cMontaTxt += (cAliasCT)->YMTREP + ";" 
                       cMontaTxt += cdat               + ";"
                       cMontaTxt += (cAliasCT)->RDA    + ";" 
                       cMontaTxt += (cAliasCT)->NUMIMP + ";" 
                       cMontaTxt += (cAliasCT)->CODPRO + ";" 
                       cMontaTxt += (cAliasCT)->DESPRO + ";"
                       cMontaTxt += Transform(((cAliasCT)->VLRBPF),"@E 99,999,999.99")+ ";" 
                       cMontaTxt += Transform(((cAliasCT)->VLRTAD),"@E 99,999,999.99")+ ";"  
                       cMontaTxt += Transform(((cAliasCT)->VLRINS),"@E 99,999,999.99")+ ";"  
                       cMontaTxt += (cAliasCT)->E1PREF + (cAliasCT)->E1NUM + (cAliasCT)->E1PARC + (cAliasCT)->E1TIPO + ";"
                       cMontaTxt += Transform(((cAliasCT)->E1VALOR),"@E 99,999,999.99")+ ";"          
                       cMontaTxt += (cAliasCT)->IDLOT+ ";"                    
                       cMontaTxt += CRLF // Salto de linha para .csv (excel)   
		      
		  FWrite(nHandle,cMontaTxt)    
		  
		 (cAliasCT)->( dbSkip() ) 
	
      EndDo  

	If nHandle > 0
		
		// encerra gravação no arquivo
		FClose(nHandle)
	//	cNomeArq1+= cNomeArq + CRLF
		MsgAlert("Relatorio salvo em: "+cNomeArq)

	//	fEnvEmail(cNomeArq , cEmpresa , trim(aDados[1,1]) )
	EndIf       

Return()	



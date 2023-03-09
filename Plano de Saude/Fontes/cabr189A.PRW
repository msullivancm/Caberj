#INCLUDE "PROTHEUS.CH"
#Include "TOPCONN.CH"    

                                                                                                                           
/*/                                                                                      
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออออหออออออัอออออออออออปฑฑ
ฑฑบPrograma  ณCABR189   บ Autor ณAltamiro              บ Data ณ 01/10/12  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออออสออออออฯอออออออออออนฑฑ
ฑฑบDescricao ณ Rotina para CONFERENCIA da METLIFE  contra a CABERJ       บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/                  

User Function CABR189A

Local cMsg			:= ""
Private cDpj        := 'Nใo'   
private cImp        := 'Nใo'
Private oLeTxt
Private lAbortPrint :=.F.
Private cPerg       := "CABR189a"
Private cTitulo     := "Conferencia e criticas MetLife	"
Private lpvez       :=.T.   
Private cTpCrit     :=" "  
Private lImporta    := .F.  
Private f_ok        := .F.
Private nLocaliz    := 0 // 1 - zzq -- 2 se2  -- 0 nao localizado         

private cpgto       := ' '    

private cTitCSald   := ' '   
PRIVATE nVlrTitPri  := 0.00
PRIVATE nVlrTitcmp  := 0.00   
private cNomeArq1   := ' '   

Private  aDadosOk    := {}
Private  aDadosSCabj := {}
Private  aDadosSlife := {}          

 

Private  aDadoslife := {}     
Private  aDadosCabj := {}        
                              
Private  aDadosCMF  := {}      
Private  aDadosECMF := {}      
Private  aDadosECCB := {}     

PRIVATE I := 1
PRIVATE X := 1
                                                                     
SetPrvt("oDlg1","oGrp1","oSay1","oSBtn1","oSBtn2","oSBtn3")

cMsg += " Este programa ira fazer a leitura do arquivo CSV  relativo as  " + CRLF
cMsg += " MATRICULAS odontologicas cobradas pela MET LIFE e cruza-las    " + CRLF
cMsg += " com o cadastro da CABERJ/INTEGRAL                              " + CRLF
oDlg1      := MSDialog():New( 095,232,368,705,"Leitura de Arquivo CVS",,,.F.,,,,,,.T.,,,.T. )
oGrp1      := TGroup():New( 008,012,100,224,"Arquivo CVS",oDlg1,CLR_BLACK,CLR_WHITE,.T.,.F. )
oSay1      := TSay():New( 020,020,{||cMsg},oGrp1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,196,076)
oSBtn1     := SButton():New( 112,140,05,{||AjustaSX1(cPerg)}		,oDlg1,,"", )
oSBtn2     := SButton():New( 112,168,01,{||OkLeTxt(),oDlg1:End()}	,oDlg1,,"", )
oSBtn3     := SButton():New( 112,196,02,{||oDlg1:End()}			,oDlg1,,"", )
oDlg1:Activate(,,,.T.)
Return
*****************************************************************************
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณ OKLETXT  บ Autor ณ                    บ Data ณ  09/04/03   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Funcao chamada pelo botao OK na tela inicial de processamenบฑฑ
ฑฑบ          ณ to. Executa a leitura do arquivo texto.                    บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Programa principal                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/                                                                                                                                      
Static Function OkLeTxt

Local nCont			:= 0     
Private  cNomeArq	:= ""
Private  cMesAdi	:= ""
Private  cAnoAdi	:= "" 
Private  cCritica   := " " 
Private  cCritImp   := " "  

private nPos      := 0    
private lfaz      :=.F.

Private  cUsua    := SubStr(cUSUARIO,7,15)     

cNomeArq	:= mv_par01
dDtInic		:= dtos(mv_par02)   
dDtBloq     := dtos(mv_par03) 
cCompMes    := SUBSTR(mv_par04,1,2) 
cCompAno    := SUBSTR(mv_par04,4,4)    
nEfetConv   := mv_par05   


If !File(cNomeArq)  .and. nReproc != 1
	MsgStop("Arquivo Invแlido! Programa encerrado.")
	Close(oLeTxt)
	Return
End       
  
Processa({||Processa1()}, cTitulo, "", .T.)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Libera impressao                                                         ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู


MsgInfo("Processo finalizado")

Return                 

**************************************************************************

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณ PROCESSA1บ Autor ณ Jean Schulz        บ Data ณ  11/11/06   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Funcao auxiliar chamada pela PROCESSA.  A funcao PROCESSA  บฑฑ
ฑฑบ          ณ monta a janela com a regua de processamento.               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Programa principal                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function Processa1()   

   cQuery := " SELECT count(*) qtd
   cQuery += CRLF +"  FROM " + RetSqlName("BM1") + " BM1" 
   cQuery += CRLF +"  WHERE BM1_FILIAL = '" + xFilial("BM1") +"' AND BM1.D_E_L_E_T_ = ' '  "
   cQuery += CRLF +"    AND BM1_MES    = '"+cCompMes+"' "
   cQuery += CRLF +"    AND BM1_ANO    = '"+cCompAno+"'"          
                                                                  
   cQuery += CRLF +"    and bm1_codtip = '101'
  
   cQuery += CRLF +"    AND BM1_XISODO = '1' "
/*
If cEmpAnt == '01'
   cQuery += CRLF +"    and bM1_CODEVE IN ('131' ,'133','134') " 
Else    
   cQuery += CRLF +"    and bm1_CODEVE IN ('0088' ,'0090','0091','0092') "
EndIf     
*/
   cQuery += CRLF +"    AND BM1_YVLPRI  <> 0 "           
   
  If Select(("TMP1")) <> 0 
       ("TMP1")->(DbCloseArea()) 
    Endif
    
    TCQuery cQuery Alias "TMP1" New 
                                                                                           
    dbSelectArea("TMP1")

    tmp1->(dbGoTop())  

 
   If tmp1->qtd > 0 
                      
          MsgAlert("   Arquivo Ja Processado . . . . " +CRLF +"Nใo serใo Refeito os Calculos , " + CRLF + "Nใo serใo feito os lancamentos no Custo ","Atencao!!!")     

      f_ok  := .F.
   Else                     
      f_ok  := .T.
      
   EndIf     
    

    If !File(cNomeArq)
        MsgAlert("Arquivo texto: CLIENTE.TXT nใo localizado","Atencao!")
        Return
    Endif

FT_FUSE(cNomeArq)
FT_FGOTOP()

ProcRegua(FT_FLASTREC()) 

nCont := 0

While !FT_FEOF() 

   	IncProc('Processando...')
   
   	cBuffer := FT_FREADLN()		//joga o conteudo da linha na variavel
 	FT_FSKIP() 
             
     aDados := separa(cBuffer,';',.T.)   
                                                              
//1	                                    2	                3	                                4	                                5	        6	            7	        8	    9	            10	        11	                12	        13	            14	            15	        16	                        17	             18	        19
//COLIGADA	                            CODIGO_ASSOCIADO	NOME_ASSOCIADO	                    NOME_TITULAR	                    CATEGORIA	PLANO	        VALOR	    PARCELA	CPF_ASSOCIADO	DTNASC	    REGISTRO	        ADESAO_CONT	INICIO_VIGENCIA	CENTRO_CUSTO	SUB_EMPRESA	INI_VIGENCIA_SUB_EMPRESA	CNPJ	         PARENTESCO	IDADE
//CAIXA DE ASSISTENCIA A SAUDE- CABERJ	02097900000300	    SERGIO VINICIUS DE PAULA E SILVA	SERGIO VINICIUS DE PAULA E SILVA	TITULAR   	DENTAL ESPECIAL	R$ 12,21	4	    07282141568	    01/01/1953	00015007000003009	01/11/2017	01/10/2017		                CABERJ	    01/10/2017	                42182200000000		        65
 
 If  substr(adados[02],1,7) <> 'CODIGO_'
  
     aAdd(aDadoslife,  { adados[02],  adados[06],adados[07] , adados[08], adados[11],adados[12],adados[03]})              
     
    ///  substr(adados[11],5,4)
    
   		If (nAscan:=Ascan(aDadosCMF , {|e| e[1]+e[2] == adados[05]+adados[06]})) == 0    
   
   			Aadd(aDadosCMF , { adados[05] ,; 
			                   adados[06] ,;  
   		                       VAL(Replace(SUBSTR(adados[07],3,LEN(adados[07])),',','.')) , ;  
			                   1 })
	 	Else 
	 	    aDadosCMF[nAscan,3]+= VAL(Replace(SUBSTR(adados[07],3,LEN(adados[07])),',','.')) 
	 	    aDadosCMF[nAscan,4]+= 1	 	    
	 	EndIf     
		 	                  

   		If (nAscan:=Ascan(aDadosECMF , {|e| e[1]+e[2]+e[3] == substr(adados[11],5,4)+adados[06]+adados[05]})) == 0    
   
   			Aadd(aDadosECMF , { substr(adados[11],5,4),;    
   			                   adados[06] ,;
   			                   adados[05] ,; 
   		                       VAL(Replace(SUBSTR(adados[07],3,LEN(adados[07])),',','.')) , ;  
			                   1 })
	 	Else 
	 	    aDadosECMF[nAscan,4]+= VAL(Replace(SUBSTR(adados[07],3,LEN(adados[07])),',','.')) 
	 	    aDadosECMF[nAscan,5]+= 1	 	    
	 	EndIf     
		 	    
    
    ///
     
 EndIf      
   
EndDo  

aSort(aDadoslife ,,,{|x,y| x[1] < y[1]} )

                                        
////////////////////////////////////////////////                                        
                                        
 cQuery := CRLF +"select bm1_codemp  , bm1_matric , bm1_tipreg , BM1.BM1_NOMUSR, bm1_valor , bm1_Yvlpri , bm1_dtcpr ,bm1_Yvlpr1 , bm1_dtcpr1 ,"
 cQuery += CRLF +"       bm1_mes , bm1_ano , bm1_codtip ,bm1_codeve,bm1_deseve , ba1_datinc , ba1_codpla , ba1_ymtodo  , BM1.r_e_c_n_o_ recbm1"  
    
cQuery += CRLF +"   FROM " + RetSqlName("BM1") + " BM1 , " + RetSqlName("BA1") + " BA1 " 
cQuery += CRLF +"  where bm1_filial = ' ' and BM1.d_E_L_E_T_ = ' ' 
cQuery += CRLF +"    and ba1_filial = ' ' and Ba1.d_E_L_E_T_ = ' ' 
cQuery += CRLF +"    and bm1_codemp = ba1_codemp  and bm1_matric = ba1_matric  and bm1_tipreg= ba1_TIPREG
cQuery += CRLF +"    and bm1_codtip = '101'
cQuery += CRLF +"    and ba1_ymtodo <> ' ' "        

cQuery += CRLF +"    AND BM1_XISODO = '1' "
/*
If cEmpAnt == '01'
   cQuery += CRLF +"    and bm1_CODEVE IN ('0131' ,'0133','0134') " 
Else    
   cQuery += CRLF +"    and bm1_CODEVE IN ('0088' ,'0090','0091','0092') "
EndIf     
*/
cQuery += CRLF +"    AND BM1_MES    = '"+cCompMes +"' "
cQuery += CRLF +"    AND BM1_ANO    = '"+cCompAno+"'"     

cQuery += CRLF +"    and (ba1_datblo >= '"+dDtBloq+" ' or ba1_datblo = ' '  ) 
cQuery += CRLF +"    and ba1_datinc  <= '"+dDtInic+"' "

cQuery += CRLF +" order by ba1_ymtodo

 If Select(("TMP")) <> 0 
       ("TMP")->(DbCloseArea()) 
 Endif
    
    TCQuery cQuery Alias "TMP" New 
                                                                                           
    dbSelectArea("TMP")
   
    tmp->(dbGoTop())                                                  

    While !(TMP->(Eof()))                                                                                                                                                                                                   
    
  //      aAdd(aDadosCmp, {tmp->matrbm1 , tmp->BM1_ANO , tmp->BM1_MES , tmp->BM1_NUMPAR , tmp->BM1_VALOR ,tmp->E1_PREFIXO , tmp->E1_NUM , tmp->E1_TIPO , tmp->E1_VENCREA , tmp->E1_BAIXA , tmp->E1_VALOR , tmp->E1_SALDO, TMP->TIPUSU , TMP->BM1REC , tmp->vlpri , tmp->nome ,tmp->codpla,tmp->despla ,tmp->VLRCALC , tmp->VLRRCALC}) 
/*                              1            2              3                  4               5                 6              7               8               8                 10             11             12            13           14               15            16       17           18       19              20 */          
                                                                                                     

        aAdd(aDadosCabj, {tmp->bm1_codemp , ;
                          tmp->bm1_matric , ;
                          tmp->bm1_tipreg , ;
                          tmp->BM1_NOMUSR , ;
                          tmp->bm1_valor  , ;
                          tmp->bm1_Yvlpri , ;
                          tmp->bm1_dtcpr  , ; 
                          tmp->bm1_Yvlpr1 , ;
                          tmp->bm1_dtcpr1 , ; 
                          tmp->bm1_mes    , ;
                          tmp->bm1_ano    , ;
                          tmp->bm1_codtip , ;
                          tmp->bm1_codeve , ;
                          tmp->bm1_deseve , ;
                          tmp->ba1_datinc , ;
                          tmp->ba1_codpla , ;
                          tmp->ba1_ymtodo , ;
                          tmp->recbm1})   
        tmp->(DbSkip())

    EndDo 
    
    dbSelectArea("BM1") 
    
   Fconfcob()        
   
   If nEfetConv == 1 .and. f_ok                                                 

      For I:=1 to len(aDadosECMF)   
      
/*
CABERJ	0131	DENTAL BASICO       	  /  /    	477743173   	48
CABERJ	0133	DENTAL EXECUTIVO    	  /  /    	477741177   	86
CABERJ	0134	DENTAL ESPECIAL     	  /  /    	477742175   	80
*/      

          If cEmpAnt == '01'
             If trim(aDadosECMF[I,2])=='DENTAL BASICO'
                cPlano := '0131' 
                cCodlan:= '162' 
             ElseIf trim(aDadosECMF[I,2])=='DENTAL ESPECIAL'
                cPlano := '0134' 
                cCodlan:= '163' 
             ElseIf trim(aDadosECMF[I,2])=='DENTAL EXECUTIVO' 
                cPlano := '0133' 
                cCodlan:= '161' 
             EndIf    
          Else     
          
/*                                                                       
INTEGRAL	0088	DENTAL BASICO EMPRES	  /  /    	477798171   	139
INTEGRAL	0090	DENTAL ESPECIAL EMPR	  /  /    	477797172   	91
INTEGRAL	0091	DENTAL INTEGRAL ESPE	  /  /    	477796174   	0
INTEGRAL	0092	DENTAL INTEGRAL BASI	  /  /    	477795176   	0
*/             
          
             If trim(aDadosECMF[I,2])=='DENTAL BASICO EMPRESARIAL'
                cPlano := '0088'
                cCodlan:= '164'  
             ElseIf trim(aDadosECMF[I,2])=='DENTAL ESPECIAL EMPRESARIAL'
                cPlano := '0090' 
                cCodlan:= '165' 
             ElseIf trim(aDadosECMF[I,2])=='DENTAL INTEGRAL ESPECIAL' 
                cPlano := '0091'
                cCodlan:= '166'  
             ElseIf trim(aDadosECMF[I,2])=='DENTAL INTEGRAL BASICO' 
                cPlano := '0092'
                cCodlan:= '167'                 
             EndIf   
          EndIf
          FGrvBGQ(aDadosECMF[I,1] , cPlano , aDadosECMF[I,4], cCompAno , cCompMes, '145246', cCodlan )    
      Next       
   EndIf     
                    
 u_cabr224a( cCompAno , cCompMes , aDadosCMF  ,aDadosECMF ,nEfetConv , f_ok)   
   
 If nEfetConv == 2 .and. f_ok 
 
    fLimpBm1()
    
 EndIf  
     
Return()    


Static Function Fconfcob()  

I := 1

X := 1

    
 While len(adadoslife) >= I .or. len(adadoscabj) >= X      

                              
      If len(adadoslife) >= I .and. len(adadoscabj) >= X 
      
         If trim(adadoslife[I,01]) ==  trim(adadoscabj[ X,17]) 

             fgravPla(1)          
             
             If len(adadoslife) >= I 
             
                I++
             
             EndIf 
                              
             If len(adadoscabj) >= X 
             
                X++
             
             EndIf                     
                                                  
         
         ElseIf trim(adadoslife[I,01]) >  trim(adadoscabj[ X,17])  

             fgravPla(3)    
   
             If len(adadoscabj) >= X              
             
                X++ 
             
             ElseIf len(adadoslife) >= I                  
                   
               fgravPla(2)
              
                I++
                
             EndIf  
                     
         ElseIf trim(adadoslife[I,01]) <  trim(adadoscabj[ X,17]) 
 
             fgravPla(2)                         
             
             If len(adadoslife) >= I              

                 I++               
                 
             ElseIf len(adadoscabj) >= X
                     
                 fgravPla(3)
             
                 X++
                 
             EndIf          
             
         EndIf
         
      ElseIf len(adadoslife) >= I     
      
          fgravPla(2)    
          I++  
          
      ElseIf len(adadoscabj) >= X     
      
          fgravPla(3)    
          X++
 
      EndIF 
                 
           
      
 EndDo             

   FGrvPlan1() 
   
RETURN()    


Static Function AjustaSX1(cPerg)

Local aHelpPor := {}

PutSx1(cPerg,"01",OemToAnsi("Arquivo Primavida  ")	    ,"","","mv_ch1","C",060,0,0,"G","U_fGetFile('csv     (*.csv)            | *.csv | ')","","","","mv_par01","","","","","","","","","","","","","","","","",aHelpPor,{},{})
PutSx1(cPerg,"02",OemToAnsi("Data Iniclussใo ate") 		,"","","mv_ch2","D",10,0,0,"G","","","","","mv_par02","","","","","","","","","","","","","","","","",aHelpPor,{},{})
PutSx1(cPerg,"03",OemToAnsi("Data bloqueio Maior") 		,"","","mv_ch3","D",10,0,0,"G","","","","","mv_par03","","","","","","","","","","","","","","","","",aHelpPor,{},{})
PutSx1(cPerg,"04",OemToAnsi("Mes/Ano Competencia?") 	,"","","mv_ch4","C",07,0,0,"G","","","","","mv_par04","","","","","","","","","","","","","","","","99/9999",aHelpPor,{},{})

PutSx1(cPerg,"05",OemToAnsi("Efetivar Conferencia")     ,"","","mv_ch5","N",01,0,0,"C","","","","","mv_par05","Sim ","","","","Nใo ","",""," ","","","","","","","","",{},{},{})   

Pergunte(cPerg,.T.)

Return 


Static Function fgravPla(_status)   


If _status == 1                          

    aAdd(aDadosOk,{"Dados Validados - " , aDadosCabj[X,01], ;
                                          aDadosCabj[X,02], ;
                                          aDadosCabj[X,03], ;
                                          aDadosCabj[X,04], ;  
                                          aDadosCabj[X,13], ;
                                          aDadosCabj[X,14], ; 
                                          aDadosCabj[X,05], ;                                          
                                          VAL(Replace(SUBSTR(aDadoslife[I,03],3,LEN(aDadoslife[I,03])),',','.')) , ;                                          
                                          aDadosCabj[x,05] - VAL(Replace(SUBSTR(aDadoslife[I,03],3,LEN(aDadoslife[I,03])),',','.')) })         
     
//   dbSelectArea("BM1")  

       If  f_ok    
                                      
         dbGoTo(adadosCabj[X,18])  
                           
         RecLock("BM1",.F.)     

         BM1->BM1_YVLPRI := VAL(Replace(SUBSTR(aDadoslife[I,03],3,LEN(aDadoslife[I,03])),',','.')) 
         BM1->BM1_YVLPR1 := aDadosCabj[x,05] - VAL(Replace(SUBSTR(aDadoslife[I,03],3,LEN(aDadoslife[I,03])),',','.')) 
         BM1->BM1_DTCPR  := DATE()  
       
         Msunlock("BM1")

      EndIf                                        
                                       
ElseIf _status == 2                          

   aAdd(aDadosSCabj,{"Dados nao Loc. na Caberj - " , ;  //status     
                                 aDadoslife[I,01], ;    // matt oddonto
                                 aDadoslife[I,02], ;    // matt plano 
			                     VAL(Replace(SUBSTR(aDadoslife[I,03],3,LEN(aDadoslife[I,03])),',','.')), ;  //valor met life 
                                 aDadoslife[I,05], ;  // mat tit
                                 aDadoslife[I,07], ;  // nome usuario 
                                 aDadoslife[I,06]} )  // dat iniciu
                                  

ElseIf _status == 3                          
   
   aAdd(aDadosSlife,{"Dados nao Loc. na Met Life - " , ;     //status
                                   aDadosCabj[X,01], ;
                                   aDadosCabj[X,02], ;
                                   aDadosCabj[X,03], ;
                                   aDadosCabj[X,04], ;                                          
                                   aDadosCabj[X,05], ; 
                                   aDadosCabj[X,15], ;
                                   aDadosCabj[X,17]} )                                          
endIf   

return()                                        

Static Function FGrvPlan1()     


   cNomDadCab:=  '1 - Dados Validados '
   cComp     :=  cCompMes+'/'+cCompAno
   cNomPla   := 'Base de Compara็ใo , OK'                   
 
     	cNomeArq := "C:\TEMP\"+cCompAno+cCompMes+" - "+cNomDadCab+"_"+SubStr(DtoS(date()),7,2)+"_"+SubStr(DtoS(date()),5,2)+"_"+SubStr(DtoS(date()),1,4)+"_"+STRTRAN(TIME(),":","_")+".csv"
		nHandle := FCREATE(cNomeArq)
        cMontaTxt := cNomDadCab
        cMontaTxt += CRLF
        FWrite(nHandle,cMontaTxt)        		 
        cMontaTxt := 'Competencia : '+cComp
        cMontaTxt += CRLF
        FWrite(nHandle,cMontaTxt)		 
        cMontaTxt := 'Planilha : '+cNomPla  
        cMontaTxt += CRLF
        FWrite(nHandle,cMontaTxt)		
        
        cMontaTxt := "Status       ;"
        cMontaTxt += "Matric.Compl ;"
		cMontaTxt += "Nome         ;" 
		cMontaTxt += "Plano        ;" 
		cMontaTxt += "Vlr Caberj   ;"   
		cMontaTxt += "Vlr Met Life ;"  
		cMontaTxt += "Resultado    ;"      
		
		cMontaTxt += CRLF // Salto de linha para .csv (excel)
             
		FWrite(nHandle,cMontaTxt)
		
      For nCount:=1 to len(aDadosOk)
          cMontaTxt := trim(aDadosOk[nCount][1]) + ";"		
   		  cMontaTxt += trim(aDadosOk[nCount][2]) + '-' + trim(aDadosOk[nCount][3]) + '-' + trim(aDadosOk[nCount][4]) + ";"  
   		  cMontaTxt += trim(aDadosOk[nCount][5]) + ";"    
   		  cMontaTxt += trim(aDadosOk[nCount][6])+' - '+trim(aDadosOk[nCount][7]) + ";"
   		  cMontaTxt += Transform(aDadosOk[nCount][08],'@E  999,999,999.99')+ ";" 
          cMontaTxt += Transform(aDadosOk[nCount][09],'@E  999,999,999.99')+ ";"     
          cMontaTxt += Transform(aDadosOk[nCount][10],'@E  999,999,999.99')+ ";"    
    
    	  cMontaTxt += CRLF // Salto de linha para .csv (excel)      
		      
		  FWrite(nHandle,cMontaTxt)
	
      Next 

	If nHandle > 0
		
		// encerra grava็ใo no arquivo
		FClose(nHandle)
		cNomeArq1+= cNomeArq + CRLF
	  //	MsgAlert("Relatorio salvo em: "+cNomeArq)
		
   
	    MsgAlert("Relatorio(s) salvo(s) em: "+ CRLF +cNomeArq1)

	EndIf                                 
	

   cNomDadCab:= ' 2 - DADOS NรO LOC. NA CABERJ '
   cComp     :=  cCompMes+'/'+cCompAno
   cNomPla   := ' BASE DE DADOS MET LIFE '                   
 
     	cNomeArq := "C:\TEMP\"+cCompAno+cCompMes+" - "+cNomDadCab+"_"+SubStr(DtoS(date()),7,2)+"_"+SubStr(DtoS(date()),5,2)+"_"+SubStr(DtoS(date()),1,4)+"_"+STRTRAN(TIME(),":","_")+".csv"

		nHandle := FCREATE(cNomeArq)
        cMontaTxt := cNomDadCab
        cMontaTxt += CRLF
        FWrite(nHandle,cMontaTxt)       		 
        cMontaTxt := 'Competencia : '+cComp
        cMontaTxt += CRLF
        FWrite(nHandle,cMontaTxt)		 
        cMontaTxt := 'Planilha : '+cNomPla  
        cMontaTxt += CRLF
        FWrite(nHandle,cMontaTxt)	 
        
        cMontaTxt := "Status       ;"
        cMontaTxt += "Matric.Odonto;"   
        cMontaTxt += "Plano        ;"  
		cMontaTxt += "Vlr. Cobrado ;"   
		cMontaTxt += "Mat Titular  ;"   
		cMontaTxt += "Nome Usuario ;"
		cMontaTxt += "Data Inclu.  ;"  		  		
                                                  
		
		cMontaTxt += CRLF // Salto de linha para .csv (excel)
             
		FWrite(nHandle,cMontaTxt)
		
      For nCount:=1 to len(aDadosSCabj)
		                                    
   		  cMontaTxt := aDadosSCabj[nCount][1] + ";"  
          cMontaTxt += aDadosSCabj[nCount][2] + ";"   		   
          cMontaTxt += aDadosSCabj[nCount][3] + ";"   		            
          cMontaTxt += Transform(aDadosSCabj[nCount][4],'@E  999,999,999.99')+ ";"   
		  cMontaTxt += aDadosSCabj[nCount][5] + ";"
		  cMontaTxt += aDadosSCabj[nCount][6] + ";" 
		  cMontaTxt += aDadosSCabj[nCount][7] + ";"		  
		
		  cMontaTxt += CRLF // Salto de linha para .csv (excel)      
		      
		  FWrite(nHandle,cMontaTxt)
	
      Next 

	If nHandle > 0
		
		// encerra grava็ใo no arquivo
		FClose(nHandle)
		cNomeArq1+= cNomeArq + CRLF
		MsgAlert("Relatorio salvo em: "+cNomeArq)
		
	EndIf           
	    

   cNomDadCab:=  ' 3 - DADOS NรO LOC. NA MET LIFE ' 
   cComp     :=  cCompMes+'/'+cCompAno
   cNomPla   := 'BASE DE DADOS MET LIFE'                   
 
     	cNomeArq := "C:\TEMP\"+cCompAno+cCompMes+" - "+cNomDadCab+"_"+SubStr(DtoS(date()),7,2)+"_"+SubStr(DtoS(date()),5,2)+"_"+SubStr(DtoS(date()),1,4)+"_"+STRTRAN(TIME(),":","_")+".csv"

		nHandle := FCREATE(cNomeArq)
        cMontaTxt := cNomDadCab
        cMontaTxt += CRLF
        FWrite(nHandle,cMontaTxt)       		 
        cMontaTxt := 'Competencia : '+cComp
        cMontaTxt += CRLF
        FWrite(nHandle,cMontaTxt)		 
        cMontaTxt := 'Planilha : '+cNomPla  
        cMontaTxt += CRLF
        FWrite(nHandle,cMontaTxt)		
                                   
        cMontaTxt := "Status ;"
        cMontaTxt += "Matric.Compl ;"
		cMontaTxt += "Nome usuario ;"  
		cMontaTxt += "Data Incl  ;" 
		cMontaTxt += "Mat Odonto ;"  
		cMontaTxt += "Valor ;" 
		
		cMontaTxt += CRLF // Salto de linha para .csv (excel)
             
		FWrite(nHandle,cMontaTxt)
		
      For nCount:=1 to len(aDadosSlife)
		
   		  cMontaTxt := trim(aDadosSlife[nCount][1]) + ";"  
   		  
          cMontaTxt += trim(aDadosSlife[nCount][2]) + '.' +trim(aDadosSlife[nCount][3])+'-'+trim(aDadosSlife[nCount][4]) + ";"
          cMontaTxt += trim(aDadosSlife[nCount][5]) + ";"  
          cMontaTxt += trim(aDadosSlife[nCount][7]) + ";"
          cMontaTxt += trim(aDadosSlife[nCount][8]) + ";"
		  cMontaTxt += Transform(aDadosSlife[nCount][6],'@E  999,999,999.99')+ ";"   
		
		  cMontaTxt += CRLF // Salto de linha para .csv (excel)      
		      
		  FWrite(nHandle,cMontaTxt)
	
      Next 

	If nHandle > 0
		
		// encerra grava็ใo no arquivo
		FClose(nHandle)
		cNomeArq1+= cNomeArq + CRLF
		MsgAlert("Relatorio salvo em: "+cNomeArq)
		
	EndIf           

Return () 

Static Function FGrvBGQ(cEmpresa , cPlano , nValor, cAnoComp , cMesComp, cRDA , cDebCred )     
                                  
LOCAL cRDAAud := cRDA 

	
		BBB->(MsSeek(xFilial("BBB")+ cDebCred ))

		//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
		//ณ Necessario truncar casas decimais, lancando centavo no ultimo adic. ณ
		//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู					
		BGQ->(Reclock("BGQ",.T.))	
		BGQ->BGQ_FILIAL	:= xFilial("BGQ") 
		BGQ->BGQ_CODSEQ	:= GETSX8NUM("BGQ","BGQ_CODSEQ")
		BGQ->BGQ_CODIGO	:= cRDAAud
		BGQ->BGQ_NOME	:= Posicione("BAU",1,xFilial("BAU")+cRDAAud,"BAU_NOME")
		BGQ->BGQ_ANO	:= cAnoComp
		BGQ->BGQ_MES	:= cMesComp
		BGQ->BGQ_CODLAN	:= cDebCred
		BGQ->BGQ_VALOR	:= nValor
		BGQ->BGQ_QTDCH	:= 0
		BGQ->BGQ_TIPO	:= "2" //Credito
		BGQ->BGQ_TIPOCT	:= "2" //PJ
		BGQ->BGQ_INCIR	:= BBB->BBB_INCIR
		BGQ->BGQ_INCINS	:= BBB->BBB_INCINS
		BGQ->BGQ_INCPIS	:= BBB->BBB_INCPIS
		BGQ->BGQ_INCCOF	:= BBB->BBB_INCCOF
		BGQ->BGQ_INCCSL	:= BBB->BBB_INCCSL
		BGQ->BGQ_VERBA	:= BBB->BBB_VERBA
		BGQ->BGQ_CODOPE	:= '0001'
		BGQ->BGQ_CONMFT	:= "0" //Nao
		BGQ->BGQ_OBS	:= "LANCTO PGTO ODONT Metlife - Ref: "+cAnoComp+cMesComp
		BGQ->BGQ_USMES	:= 0
		BGQ->BGQ_LANAUT	:= "0" //Nao   
		
		BGQ->BGQ_ITECTA := cPlano   
        BGQ->BGQ_CLVL   := cEmpresa
        BGQ->BGQ_CODEMP := cEmpresa  

		BGQ->BGQ_YLTAUD	:=' '   		
		BGQ->(MsUnlock()) 
		ConfirmSx8()
		
		
return()

Static Function fLimpBm1()                      

LOCAL nSucesso := 0

   cQuery := " UPDATE "+RetSqlName("BM1")         
   cQuery += CRLF +" SET BM1_YVLPRI = 0.00 , BM1_YVLPR1 = 0.00 , BM1_DTCPR = ' '  , BM1_DTCPR1 = ' ' "
   cQuery += CRLF +"  WHERE BM1_FILIAL = '" + xFilial("BM1") +"' AND D_E_L_E_T_ = ' '  "
   cQuery += CRLF +"    AND BM1_MES    = '"+cCompMes+"' "
   cQuery += CRLF +"    AND BM1_ANO    = '"+cCompAno+"'"          
                                                                  
   cQuery += CRLF +"    and bm1_codtip = '101'
  
   cQuery += CRLF +"    AND BM1_XISODO = '1' "
   cQuery += CRLF +"    AND BM1_YVLPRI  <> 0 "           
   
    nSucesso += TcSqlExec(cQuery)	
	    	       
  
return()
#Include "protheus.ch"
#Include "rwmake.ch"
#Include "topconn.ch"
#INCLUDE "plsmcon.ch"                            
**'-----------------------------------------------------------------------'**                                                                            
**'-- Rotina para Conciliação de titulos de Convenio de recipeocidade ----'**                                                                            
**'-----------------------------------------------------------------------'**
User Function CABA130( cPrefPLS , cNumPLS , cParcPLS , cTipoPLS ,  cPrefCOV , cNumCOV , cParcCOV , cTipoCOV , cvlrbpf , cvlrtad , cvlrins, coperadora)        

private l_Ret     := .f.   
private a_DadosSE1:= {}   

private _cErro    := ""     

private cAliasCR1 := GetNextAlias()   
private cAliasCR2 := GetNextAlias()        

private cVlrbaix  := 0.00
         
  
cQuery1 := "  SELECT E1_PREFIXO , E1_NUM , E1_PARCELA , E1_TIPO , E1_VALOR , E1_SALDO  "
cQuery1 += "    FROM SE1010 SE1 	"
cQuery1 += "   WHERE E1_FILIAL  = '01'  "  
cQuery1 += "     AND E1_PREFIXO = '"+ cPrefPLS +"' "
cQuery1 += "     AND E1_NUM     = '"+ cNumPLS +"' "
cQuery1 += "     AND E1_PARCELA = '"+ cParcPLS +"' "      
cQuery1 += "     AND E1_TIPO   = '"+ cTIPOPLS +"' "
cQuery1 += "     AND SE1.D_E_L_E_T_ = ' ' "  
//////       


If Select(cAliasCR1) > 0
	dbSelectArea(cAliasCR1)
	dbclosearea()
Endif

TcQuery cQuery1 New Alias (cAliasCR1)

(cAliasCR1)->(dbGoTop())

/////////
cQuery2 := "  SELECT NVL(E1_PREFIXO,' ') E1_PREFIXO  , NVL(E1_NUM,' ' )E1_NUM  , NVL(E1_PARCELA,' ')E1_PARCELA , NVL(E1_TIPO,' ')E1_TIPO , NVL(E1_VALOR,0.00)E1_VALOR , NVL(E1_SALDO,0.00)  "
cQuery2 += "    FROM   SE1010 SE1 	"
cQuery2 += "   WHERE E1_FILIAL  = '01'  "  
cQuery2 += "     AND E1_PREFIXO ='"+ cPrefCOV +"'"
cQuery2 += "     AND E1_NUM     ='"+ cNumCOV  +"'"
cQuery2 += "     AND E1_PARCELA ='"+ cParcCOV +"'"
cQuery2 += "     AND E1_TIPO    ='"+ cTipoCOV +"'"
cQuery2 += "     AND SE1.D_E_L_E_T_ = ' ' "                                       
 
//////       


If Select(cAliasCR2) > 0
	dbSelectArea(cAliasCR2)
	dbclosearea()
Endif

TcQuery cQuery2 New Alias (cAliasCR2)

(cAliasCR2)->(dbGoTop())

//If MsgYesNo("Confirma Execução Da Conciliação do Titulos PLS da Cobrança de Convenio ?")

if((((cAliasCR1)->E1_SALDO - (cvlrbpf + cvlrtad )) >= (cAliasCR1)->E1_SALDO) .or. (cvlrbpf + cvlrtad ) == 0)   
   cVlrbaix:= (cAliasCR1)->E1_SALDO     
   cvlrins := 0.00
Else                                 
   cVlrbaix:= ((cAliasCR1)->E1_SALDO - (cvlrbpf + cvlrtad )) 
EndIf 

 Begin Transaction
////////////  baixa PLS 
     dbselectArea("SE1")
     dbSetOrder(1)
 If ( dbSeek(xFilial("SE1") + (cAliasCR1)->E1_PREFIXO + alltrim( (cAliasCR1)->E1_NUM ) + (cAliasCR1)->E1_PARCELA + (cAliasCR1)->E1_TIPO) )
                                                                     
 
   a_DadosSE1 := {{"E1_PREFIXO"	  ,(cAliasCR1)->E1_PREFIXO         ,Nil},;
                  {"E1_NUM"		  ,alltrim( (cAliasCR1)->E1_NUM )  ,Nil},;
                  {"E1_PARCELA"	  ,(cAliasCR1)->E1_PARCELA         ,Nil},;
			      {"E1_TIPO"      ,(cAliasCR1)->E1_TIPO            ,Nil},;
 			      {"AUTMOTBX"	  ,"NEG"                           ,Nil},;  
			      {"AUTDTBAIXA"	  ,dDataBase                       ,Nil},;
			      {"AUTDTCREDITO" ,dDataBase                       ,Nil},;
			      {"AUTHIST"	  ,'Bx Convenio - Conciliação'     ,Nil},;
			      {"AUTVALREC"	  ,cVlrbaix                        ,Nil }}               
			      
//((cAliasCR1)->E1_SALDO - (Iif((cvlrbpf + cvlrtad ) > (cAliasCR1)->E1_SALDO , (cAliasCR1)->E1_SALDO , (cvlrbpf + cvlrtad )))) 			      

   _lRet  := .T.
   lMsErroAuto := .F.
  
   MSExecAuto({|x,y| fina070(x,y)}, a_DadosSE1,3) //Inclusao
 
 If lMsErroAuto
    conout( "E R R O    N O    E X E C A U T O" )
    lMsHelpAuto := .T.
    DisarmTransaction()
    _cErro := MostraErro(NIL, "C:\erro_exec.GER") // Para gravar o erro
    memowrite("C:\erro_exec.GER", _cErro)

    conout( _cErro )

   _lRet := .F.                                
                    
 
 EndIf 
 
EndIf 

End Transaction             
 
/// demonstrativo da operação 

         cTitse1  := (cAliasCR1)->E1_PREFIXO +' '+ alltrim( (cAliasCR1)->E1_NUM ) +' '+  (cAliasCR1)->E1_PARCELA +' '+ (cAliasCR1)->E1_TIPO
          
           vlrTitse1:= Transform ((cAliasCR1)->E1_SALDO , "@R  999,999,999.99")
           vlrbse1  := Transform (cVlrbaix   , "@R  999,999,999.99")
        //   vlrTot1  := Transform (((cAliasCR1)->E1_SALDO - (cvlrbpf + cvlrtad ))  , "@R  999,999,999.99") 
        
            vlrTot1  := Transform((cAliasCR1)->E1_SALDO - cVlrbaix , "@R 999,999,999.99")

           MsgAlert("       Resumo da Conciliação  " + CRLF + CRLF + CRLF +;
                    " Operadora        : " + cOperadora + CRLF +;  
                    " Titulo Receber   : " + cTitse1    + CRLF +; 
                    " Valor Titulo Rec : " + vlrTitse1  + CRLF +;
              	    " Valor à Compensar: " + vlrbse1    +'(-)'+ CRLF +;    
              	    "__________________________________________"+ CRLF +;  
                    " Saldo Apos Comp  : " + vlrTot1    + CRLF + CRLF + CRLF +    ;
                    " Valor Do Inss    : " +   Transform (cvlrins, "@R  999,999,999.99")  + '  (Tit a Parte)'+ CRLF + ;
                    " Resumo da Conciliação")  
                                                                                                                                    
     
     
    
                    
// fim do demonstrativo   + cvlrins  

If cvlrins > 0
   
   u_fGrInss1(se1->e1_Num , se1->e1_parcela , se1->e1_tipo , cvlrins ,se1->e1_mesbase , se1->e1_anobase , cOperadora  , se1->e1_Cliente , se1->e1_loja , se1->e1_Vencto , se1->e1_porcjur  )   
   //fGrInss(cvlrins ,(cAliasCR1)->E1_mesbase , (cAliasCR1)->E1_anobase , cOperadora  )

EndIf

  
   DbCommitAll()

//EndIf 

Return _cErro  


///////////// 
//Static Function fGrInss(cvlrins ,(cAliasCR1)->E1_mesbase , (cAliasCR1)->E1_anobase , cOperadora   ) 
user  Function fGrInss1(cNum , cparcel , ctipo , cvlrins ,cmesbase , canobase , cOperadora  , cCliente , cloja , cVenc , cporcjur  )    

private aGerINSS  := {} 

If cvlrins > 0

	SE1->(RecLock("SE1",.T.))

	SE1->E1_FILIAL   := xFilial("SE1")
	SE1->E1_TIPO     := cTipo
	SE1->E1_CLIENTE  := cCliente
	SE1->E1_LOJA     := cloja          
	SE1->E1_NATUREZ  := '30'//GetNewPar("MV_YNTINS",SE1->E1_NATUREZ)
	SE1->E1_EMISSAO  := dDataBase
	SE1->E1_EMIS1    := dDataBase
	SE1->E1_SITUACA  := "0"
	SE1->E1_MOEDA    := 1
	SE1->E1_OCORREN  := "01"
	SE1->E1_FLUXO    := "S"
	SE1->E1_STATUS   := "A"
	SE1->E1_PROJPMS  := " "
	SE1->E1_VENCORI  := Iif(cVENC < dDataBase,dDataBase,cVENC)
	SE1->E1_VENCTO   := Iif(cVENC < dDataBase,dDataBase,cVENC)
	SE1->E1_PREFIXO  := "INS"
	SE1->E1_NUM      := cNum
	SE1->E1_PARCELA  := cParcel
	SE1->E1_VENCREA  := DataValida(Iif(cVENC < dDataBase,dDataBase,cVENC)) 
	SE1->E1_VLCRUZ   := cvlrins
	SE1->E1_IRRF	 := 0
	SE1->E1_VALOR    := cvlrins
	SE1->E1_NOMCLI   := SA1->A1_NOME
	SE1->E1_SALDO    := cvlrins                    
	SE1->E1_HIST     := cOperadora  
	SE1->E1_DECRESC  := 0
	SE1->E1_SDDECRE  := 0
	SE1->E1_ACRESC   := 0
	SE1->E1_SDACRES  := 0
	SE1->E1_VALLIQ   := 0
	 
	SE1->E1_BCOCLI   := " "
	SE1->E1_AGECLI   := " "
	SE1->E1_CTACLI   := " "
	
	SE1->E1_NUMBCO   := " "
	SE1->E1_PLNUCOB  := " "
	SE1->E1_VALJUR   := 0
	SE1->E1_PORCJUR  := 0
	SE1->E1_CODINT   := " "
	SE1->E1_CODEMP   := '0004'	
	SE1->E1_MATRIC 	 := " "
	SE1->E1_CONEMP   := " "
	SE1->E1_VERCON   := " "
	SE1->E1_SUBCON   := " "
	SE1->E1_VERSUB   := " "
	SE1->E1_MESBASE  := cMesBase
	SE1->E1_ANOBASE  := cAnoBase
	SE1->E1_MULTNAT  := "2"
	SE1->E1_NUMCON   := " "
	SE1->E1_TIPREG   := " "
	SE1->E1_ORIGEM   := 'FINA040'
	
	SE1->(MsUnLock())

/*					
					aadd(aGerINSS,{{"E1_PREFIXO" ,"INS",Nil},;
					               {"E1_NUM"     ,cNUM,Nil},;
			                       {"E1_PARCELA" ,cPARCEL,Nil},;
			                       {"E1_TIPO"    ,cTIPO,Nil},;
			                       {"E1_VALOR"   ,cvlrins ,Nil},;
			                       {"E1_NATUREZ" ,GetNewPar("MV_YNTINS",SE1->E1_NATUREZ),Nil},;
			                       {"E1_CLIENTE" ,cCLIENTE,Nil},;
   		                    	   {"E1_LOJA"    ,SE1->E1_LOJA ,Nil},;
			                       {"E1_EMISSAO" ,dDataBase,Nil},;
			                       {"E1_EMIS1"   ,dDataBase,Nil},;
			                       {"E1_HIST"    ,cOperadora,Nil},;
			                       {"E1_VENCTO"  ,Iif(cVENC < dDataBase,dDataBase,cVENC),Nil},; 
			                       {"E1_VENCREA" ,DataValida(Iif(cVENC < dDataBase,dDataBase,cVENC)),Nil},;
			                       {"E1_MESBASE" ,cMESBASE,Nil},;
			                       {"E1_ANOBASE" ,cANOBASE,Nil},;
			                       {"E1_PORCJUR" ,cPORCJUR,Nil},;
			                       {"E1_ORIGEM" ,"CABA130",Nil} })
			                    					                    	
//			Processa( {|| IncTitINSS( aGerINSS ) }, "Aguarde","Criando Titulos INSS...",.T.)
*/
EndIF 
 		
Return()
/*
Static Function IncTitINSS(aGerINSS)
Local nCont := 0
                 


Begin Transaction

For nCont := 1 to Len(aGerINSS)

	lMsErroAuto := .F.
	MsExecAuto({|x,y| Fina040(x,y)},aGerINSS[nCont],3)
	If lMsErroAuto
		DisarmTransaction()
		MostraErro()
	Endif   
		

Next
			
End Transaction 

Return Nil
*/
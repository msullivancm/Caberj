#Include "protheus.ch"
#Include "rwmake.ch"
#Include "topconn.ch"
#INCLUDE "plsmcon.ch"                            
**'-----------------------------------------------------------------------'**                                                                            
**'--Rotina para geração de SE2-------------------------------------------'**                                                                            
**'-----------------------------------------------------------------------'**     

  
User Function ACERTPCC1()

    Local cFilSe2	:= xFilial("SE2")
	Private lMsHelpAuto	:= .T.
	Private lMsErroAuto	:= .F.
	//Private aRotina		:= {{"","",0,1},{"","",0,2},{"","",0,3},{"","",0,4},{"","Fa050Delet",0,5}}
	Private cCadastro	:= ""
	Private lAltera		:= .F.
	Private lF050Auto	:= .T.
	Private nRecno		:= 0    
	private vlrtot      := 0.00
          

/////
cQuery := "select  e2_filial , e2_prefixo , e2_num , e2_parcela , e2_tipo ,E2_FORNECE ,E2_NOMFOR ,  e2_loja  , "
cQuery += CRLF +"(e2_valor + e2_iss + e2_irrf + e2_vretpis + e2_vretcof + e2_vretcsl ) vlrtot , e2_iss  ISS ,  e2_irrf IR ,  "
cQuery += CRLF +" ROUND (DECODE (A2_RECPIS, '2' ,(e2_valor + e2_iss + e2_irrf + e2_vretpis + e2_vretcof + e2_vretcsl )* 0.0065 , 0.00),2) PIS , "
cQuery += CRLF +" ROUND (DECODE (sa2.A2_RECCOFI , '2' ,(e2_valor + e2_iss + e2_irrf + e2_vretpis + e2_vretcof + e2_vretcsl )* 0.03 , 0.00),2) COFINS , "
cQuery += CRLF +" ROUND (DECODE (A2_RECCSLL, '2' ,(e2_valor + e2_iss + e2_irrf + e2_vretpis + e2_vretcof + e2_vretcsl )* 0.01 , 0.00),2) CSLL , "
cQuery += CRLF +" ROUND (((e2_valor + e2_iss + e2_irrf + e2_vretpis + e2_vretcof + e2_vretcsl )- "
cQuery += CRLF +"         (DECODE (A2_RECPIS, '2' ,(e2_valor + e2_iss + e2_irrf + e2_vretpis + e2_vretcof + e2_vretcsl )* 0.0065 , 0.00) + "
cQuery += CRLF +"          DECODE (sa2.A2_RECCOFI , '2' ,(e2_valor + e2_iss + e2_irrf + e2_vretpis + e2_vretcof + e2_vretcsl )* 0.03 , 0.00) +  "
cQuery += CRLF +"          DECODE (A2_RECCSLL, '2' ,(e2_valor + e2_iss + e2_irrf + e2_vretpis + e2_vretcof + e2_vretcsl )* 0.01 , 0.00) + e2_iss + E2_IRRF  )),2) SALDO , "
cQuery += CRLF +" e2_naturez , A2_RECPIS ,A2_RECCOFI ,  A2_RECCSLL "
cQuery += CRLF +" from se2010 SE2 , sa2010 sa2 "
cQuery += CRLF +" where e2_filial = '01' and se2.d_E_L_E_T_ = ' ' " 
cQuery += CRLF +" and a2_filial = ' '  and sa2.d_E_L_E_T_ = ' '  "
cQuery += CRLF +" and a2_cod = e2_fornece "
cQuery += CRLF +" and (e2_valor + e2_iss + e2_irrf + e2_vretpis + e2_vretcof + e2_vretcsl )>=215.17 "
cQuery += CRLF +" AND E2_VENCREA >= '20150501' "
cQuery += CRLF +" and (e2_vretpis = 0 AND e2_vretcof = 0 AND  e2_vretcsl =  0)  "
cQuery += CRLF +" AND  (A2_RECPIS = '2' OR A2_RECCOFI = '2' OR  A2_RECCSLL = '2')	"  
cQuery += CRLF +" AND a2_calcirf = 1 AND E2_NATUREZ = '40002002' AND E2_YLIBPLS = 'S' "    
                                                                                           
cQuery += CRLF +" AND E2_PREFIXO in ('HOS')" // --AND E2_NUM = '000013326' "                     
cQuery += CRLF +" and e2_origem = 'PLSMPAG' and e2_tipo IN ('FT' , 'DP') AND E2_CODRET = '1708' and e2_saldo > 0 AND E2_BAIXA = ' ' " 

cQuery += CRLF +"ORDER BY 1,2,3,4 "
/////
	
  If Select(("TMP")) <> 0 
       ("TMP")->(DbCloseArea()) 
    Endif
    
    TCQuery cQuery Alias "TMP" New 
                                                                                           
    dbSelectArea("TMP")
   
    tmp->(dbGoTop())                    
    dbselectarea("SE2")
	SE2->(DbSetOrder(1))
	
    BEGIN Transaction
    
     While !(TMP->(Eof()))
    
    	DBSEEK(TMP->e2_filial+TMP->e2_prefixo+TMP->e2_num+TMP->e2_parcela+TMP->e2_tipo+TMP->E2_FORNECE+TMP->e2_loja)    

        vlrtot:= (TMP->vlrtot+50.00)

        BEGIN Transaction
   
//			{"E2_NATUREZ"  ,(cAliasTmp)->E1_NATUREZ ,Nil}, {"E2_FORNECE"  ,cCodFor                 ,Nil},;      
		  	aDadSe2 :={{"E2_FILIAL"   ,TMP->e2_filial       ,.F.},;
			           {"E2_PREFIXO"  ,TMP->e2_prefixo      ,.F.},;  
   			           {"E2_NUM"      ,TMP->e2_num          ,.F.},;
   			           {"E2_PARCELA"  ,TMP->e2_parcela      ,.F.},; 
   			           {"E2_TIPO"     ,TMP->e2_tipo         ,.F.},;
            		   {"E2_FORNECE"  ,TMP->E2_FORNECE      ,.F.},;
			           {"E2_LOJA"     ,TMP->e2_loja         ,.F.},; 
			           {"E2_VALOR"    ,vlrtot          ,nil} }   
			           
 			lMsErroAuto := .F.
 			MsExecAuto({ |x,y,z| Fina050(x,y,z)},aDadSe2,,4)
			If lMsErroAuto
				MostraErro()  
  		        DisarmTransaction()
   		    Endif
  		         
////////// segunda passada   		    
   		    		  	aDadSe2 :={{"E2_FILIAL"   ,TMP->e2_filial       ,.F.},;
			           {"E2_PREFIXO"  ,TMP->e2_prefixo      ,.F.},;  
   			           {"E2_NUM"      ,TMP->e2_num          ,.F.},;
   			           {"E2_PARCELA"  ,TMP->e2_parcela      ,.F.},; 
   			           {"E2_TIPO"     ,TMP->e2_tipo         ,.F.},;
            		   {"E2_FORNECE"  ,TMP->E2_FORNECE      ,.F.},;
			           {"E2_LOJA"     ,TMP->e2_loja         ,.F.},; 
			           {"E2_VALOR"    ,TMP->vlrtot          ,nil} }   
			           
 			lMsErroAuto := .F.
 			MsExecAuto({ |x,y,z| Fina050(x,y,z)},aDadSe2,,4)

			If lMsErroAuto
				MostraErro()  
  		        DisarmTransaction()
   		    Endif  
   		    
 		End Transaction      
        
///      DBSEEK(TMP->e2_filial+TMP->e2_prefixo+TMP->e2_num+TMP->e2_parcela+TMP->e2_tipo+TMP->E2_FORNECE+TMP->e2_loja)    
   	 	
   		    SE2->(Reclock("SE2",.F.))        
            	 valor:=(TMP->vlrtot-(se2->e2_iss+se2->e2_irrf+se2->e2_vretpis+se2->e2_vretcof+se2->e2_vretcsl) )	           
			      SE2->E2_valor := valor
				  SE2->E2_saldo := valor     
				  se2->e2_vlcruz:= valor
            SE2->(MsUnLock())          

            cMsg:="Tit: "+se2->e2_prefixo+'-'+se2->e2_num+'-'+se2->e2_tipo+ " "
	        
	        Alert(cMsg)
					
		  TMP->(dbSkip())
		EndDo 	  		
	End Transaction

Return(.T.)  
/*
#INCLUDE "RWMAKE.CH" 
#INCLUDE "TBICONN.CH"  
User Function TMata010()
Local aVetor := {}
private lMsErroAuto := .F. 
PREPARE ENVIRONMENT EMPRESA "99" FILIAL "01" MODULO "EST"//--- Exemplo: Inclusao --- //
aVetor:= {{"B1_COD"         ,"9994" 	     ,NIL},;                     
          {"B1_DESC"        ,"PRODUTO TESTE - ROTINA AUTOMATICA" ,NIL},;                     
          {"B1_TIPO"    	,"PA"            ,Nil},;                   
          {"B1_UM"      	,"UN"            ,Nil},;                   
          {"B1_LOCPAD"  	,"01"            ,Nil},;                   
          {"B1_PICM"    	,0               ,Nil},;                   
          {"B1_IPI"     	,0               ,Nil},;                   
          {"B1_CONTRAT" 	,"N"             ,Nil},;                   
          {"B1_LOCALIZ" 	,"N"             ,Nil}}				 
          MSExecAuto({|x,y| Mata010(x,y)},aVetor,3) 
          
          //--- Exemplo: Alteracao --- //
          
          aVetor:= {{"B1_COD"         ,"9994" 	     ,NIL},;                   
                    {"B1_DESC"        ,"PRODUTO TESTE - ALTERADO" ,NIL}}				
          MSExecAuto({|x,y| Mata010(x,y)},aVetor,4) 
          //--- Exemplo: Exclusao --- //
          
          aVetor:= {{"B1_COD"         ,"9994" 	     ,NIL},;                    
                    {"B1_DESC"        ,"PRODUTO TESTE - ROTINA AUTOMATICA" ,NIL}}				 
                    MSExecAuto({|x,y| Mata010(x,y)},aVetor,5) 
          If lMsErroAuto   
             MostraErro()
          Else   
             Alert("Ok")Endif  Return

/*
Local l_Ret  := .f.   
Local xFornece  := " "
Local a_DadosSE2:= {}
Local _cErro  := ""

//default d_DataEmis  := ""
private  a_Banco  := &(GetMv("MV_XBCOPA"))
         
 //////
cQuery := " SELECT *  " // -- E2_NUM ,  E2_PARCELA, E2_FORNECE , E2_LOJA  ,  e2_inss    "                                              
cQuery += "   FROM SE2020   WHERE R_e_c_n_o_ IN   " //(35930,35932,35924)   "                                       
cQuery += "  (35861,35839,37230,37373,37376,37368,37369,37378,37491,37495,37498,37499,37502,37503,37504,37505,37507,37508,37510,37511 "   
cQuery += "  ,37512,37513,37514,37515,37520,37521,37523,37524,37526,37527,37528,37529,37530,37533,37536,37537,37538,37539,37542,37543   " 
cQuery += "  ,37547,37548,37549,37551,37553,37554,37555,37556,37557,37562,37563,37564,37566,37567,37568,37569,37570,37571,37572,37574   " 
cQuery += "  ,37578,37579,37580,37581,37583,37585,37586,37587,37588,37590,37591,37593,37594,37595,37596,37597,37598,37599,37601,37603   " 
cQuery += "  ,37604,37606,37607,37609,37611,37613,37614,37615,37616,37379,37382,37383,37386,37387,37390,37394,37398,37401,37403,37404   " 
cQuery += "  ,37407,37408,37409,37410,37412,37415,37416,37423,37424,37425,37426,37427,37428,37430,37431,37432,37433,37436,37437,37438   " 
cQuery += "  ,37442,37444,37447,37448,37449,37451,37452,37453,37454,37457,37459,37461,37463,37466,37467,37468,37469,37471,37472,37473   " 
cQuery += "  ,37474,37478,37479,37480,37481,37485,37486,37489,37621,37417,37622,37620,37624,37626,37477,37627,37628,37629,37630,37633   " 
cQuery += "  ,37634,37635,37631,37636,37637,37638,37639,37623,38516)    " 
//////
If Select("YTMP") > 0
	dbSelectArea("YTMP")
	dbclosearea()
Endif

TCQuery cQuery Alias "YTMP" New
dbSelectArea("YTMP")
Ytmp->(dbGoTop())

While Ytmp->(!EOF())   
if Ytmp->e2_inss > 0.00
////////////  
     dbselectArea("SE2")
     dbSetOrder(1)
If !( dbSeek(xFilial("SE2") + YTMP->E2_PREFIXO   + alltrim( YTMP->E2_NUM )+Ytmp->E2_PARCELA+'PA ') )
                                                                     
 aadd(a_DadosSE2, {'E2_PREFIXO'      , YTMP->E2_PREFIXO    , NIL})
 aadd(a_DadosSE2, {'E2_NUM'            , YTmp->e2_NUM            , NIL})
 aadd(a_DadosSE2, {'E2_PARCELA'    , Ytmp->E2_PARCELA    , NIL})
 aadd(a_DadosSE2, {'E2_TIPO'            , 'PA '                           , NIL})
 aadd(a_DadosSE2, {'E2_FORNECE'   , Ytmp->E2_FORNECE   , NIL})
 aadd(a_DadosSE2, {'AUTBANCO'       , a_Banco[1]  , NIL})
 aadd(a_DadosSE2, {'AUTAGENCIA' , a_Banco[2]   , NIL})
 aadd(a_DadosSE2, {'AUTCONTA' , a_Banco[3]   , NIL})
 aadd(a_DadosSE2, {'E2_LOJA'    , Ytmp->E2_LOJA   , NIL})
 aadd(a_DadosSE2, {'E2_NATUREZ' , '12602'  , NIL})
 aadd(a_DadosSE2, {'E2_EMISSAO' , stod('20110826') , NIL})
 aadd(a_DadosSE2, {'E2_VENCTO'  , stod('20110826' )   , NIL})
 aadd(a_DadosSE2, {'E2_VENCREA' , stod('20110826')   , NIL})
 aadd(a_DadosSE2, {'E2_HIST'    , 'Acerto inss Comp 07/2011' , NIL})
 aadd(a_DadosSE2, {'E2_VALOR'   , Ytmp->e2_inss , NIL})
 aadd(a_DadosSE2, {'E2_VLCRUZ'   , Ytmp->e2_inss , NIL})
 aadd(a_DadosSE2, {'E2_CCD'   , '99999'  , NIL})
 aadd(a_DadosSE2, {'E2_YMECPPA'  , '09'   , NIL})    
 aadd(a_DadosSE2, {'E2_YANCPPA'  , '11'  ,NIL})
 
 BEGIN Transaction
    //conout(iIf(PA0->PA0_TPTITU=="6","ADIANTAMENTO A CONVENIADO","ADIANTAMENTO A CREDENCIADO"))
 _lRet  := .T.
 lMsErroAuto := .F.
 MSExecAuto({|x,y,z| Fina050(x,y,z)},a_DadosSE2,,3)
 
// dDataBase := d_DataAnt
 
 IF lMsErroAuto
  conout( "E R R O    N O    E X E C A U T O" )

  lMsHelpAuto := .T.
  DisarmTransaction()
  _cErro := MostraErro(NIL, "C:\erro_exec.GER") // Para gravar o erro
  memowrite("C:\erro_exec.GER", _cErro)

  conout( _cErro )

  _lRet := .F.
 
 ENDIF
 
 
 END Transaction
 
 DbCommitAll()

EndIf      
endif      
  a_DadosSE2 := {}
 YTMP->(DbSkip())
enddo

Return _cErro
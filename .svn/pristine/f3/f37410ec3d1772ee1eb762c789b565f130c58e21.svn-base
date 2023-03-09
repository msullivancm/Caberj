#Include "protheus.ch"
#Include "rwmake.ch"
#Include "topconn.ch"
#INCLUDE "plsmcon.ch"                            
**'-----------------------------------------------------------------------'**                                                                            
**'--Rotina para geração de SE2-------------------------------------------'**                                                                            
**'-----------------------------------------------------------------------'**     



user Function acertabbu(cEmpr)
	
	Local n_QtdNew  := 0
	Local n_QtdOld  := 0
	Local n_QtdBtn  := 0
	Local n_QtdPla  := 0
	local C_COD_EMP := cEmpr
	
	
	// Verifico quantos planos existem em uma família


c_Qry := "  select  DISTINCT ba1_filial     bbu_filial  , "
c_Qry += "           ba1_codemp    bbu_codemp , "
c_Qry += "           ba1_matric    bbu_matric , "
c_Qry += "           btn_codfor    bbu_codfor , "
c_Qry += "           btn_codfai    bbu_codfai , "
c_Qry += "           ' '           bbu_tabvld , "   
c_Qry += "           ' '           bbu_tipusr , "  
c_Qry += "           ' '           bbu_graupa , "   
c_Qry += "           btn_sexo      bbu_sexo   , "
c_Qry += "           btn_idaini    bbu_idaini , "
c_Qry += "           btn_idafin    bbu_idafin , "
c_Qry += "           btn_valfai    bbu_valfai , "
c_Qry += "           '0'           bbu_faifam , "
c_Qry += "           btn_qtdmin    bbu_qtdmin , "
c_Qry += "           btn_qtdmax    bbu_qtdmax , "
c_Qry += "           '0'           bbu_rejapl , "
c_Qry += "           '0'           bbu_automa , "
c_Qry += "           btn_anomes    bbu_anomes , "
c_Qry += "           BTN_VLRANT    bbu_vlrant   "  
c_Qry += "     from " + retsqlname("BTN") + " BTN , " + retsqlname("BA1") + " BA1 "
c_Qry += "   where btn_filial = ' ' and btn.d_E_L_E_T_ = ' ' "
c_Qry += "     and ba1_filial = ' ' and ba1.d_E_L_E_T_ = ' ' " 
c_Qry += "     and ba1_codemp = '"+C_COD_EMP+"'" 
c_Qry += "     and btn_codigo = '0001'||ba1_codemp "
c_Qry += "     and ba1_codpla = btn_codpro "
c_Qry += "     and ba1_conemp = btn_numcon "
c_Qry += "     and ba1_subcon = btn_subcon "
// especifico para a empresa 0356 
//c_Qry += "     AND (BA1_CODPLA = '0043' AND btn_codfai <> '001' OR BA1_CODPLA = '0044' AND btn_codfai <> '002')
c_Qry += "     order by ba1_matric "


	If Select("TMPNEW") > 0
		
		TMPNEW->(DbCloseArea())
		
	Endif
	
	TcQuery c_Qry ALIAS "TMPNEW" NEW
	
	TMPNEW->(dbGoTop())     


	DbSelectArea("BBU")
  	DbSetOrder(2)//BDK_FILIAL+BDK_CODINT+BDK_CODEMP+BDK_MATRIC+BDK_TIPREG

    While !(TMPNEW->(Eof()))
 
	    	BBU->(RecLock("BBU",.T.))
				
				BBU->BBU_FILIAL 	:= xFilial("BDK")
                BBU->BAU_CODOPE     := '0001'
				BBU->BBU_CODFAI 	:= TMPNEW->BBU_CODFAI
				BBU->BBU_IDAINI 	:= TMPNEW->BBU_IDAINI
				BBU->BBU_IDAFIN 	:= TMPNEW->BBU_IDAFIN
				BBU->BBU_VALFAI		:= TMPNEW->BBU_VALFAI
				BBU->BBU_CODOPE 	:= TMPNEW->BBU_CODOPE
				BBU->BBU_CODEMP 	:= TMPNEW->BBU_CODEMP
				BBU->BBU_MATRIC 	:= TMPNEW->BBU_MATRIC
				BBU->BBU_ANOMES 	:= TMPNEW->BBU_ANOMES 
				BBU->BBU_VLRANT 	:= TMPNEW->BTN_VLRANT
				BBU->BBU_AUTOMA     := '1'
				BBU->BBU_CODFOR     := '101'
				
    		BBU->(MsUnlock())
			
		TMPNEW->(DbSkip())
			
	Enddo	
		
Return







/*

  
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
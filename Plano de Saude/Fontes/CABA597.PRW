#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'RWMAKE.CH'
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'      
#include "TBICONN.CH"   
#include "topconn.ch"                           
#Include "TbiCode.ch"
#INCLUDE "ap5mail.ch"

#define c_Eol chr(13)+chr(10)   


/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…ÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕª±±
±±∫Programa  ≥CABA597   ∫Autor  ≥Marcela Coimbra     ∫ Data ≥  08/29/18   ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Desc.     ≥  Rotina de envio de email de inadimplÍncia                 ∫±±
±±∫          ≥                                                            ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Uso       ≥ AP                                                         ∫±±
±±»ÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ
*/


User Function CABA597()         

	// Seleciona devedores
	
	Local c_Qry 		:= "" 
	Local c_Assunto 	:= "InformaÁ„o importante sobre seu boleto"
	Local c_Body		:= "<BR>"  
	Local a_Relatorio 	:= {}
	Local a_Titulos 	:= {}     
	
	Private	c_Email := ""
	Private	c_Nome  := ""
	Private	c_CobNiv:= ""
	Private	n_Total := ""		
	
	QOut( ":-) CABA597" )
	
	aadd(a_Titulos, { 	"Enviado"				,;    
						"Regra"				,;	
						"Quantidade de dias",;
						"CPF"			,; 
						"Nome"		,;
						"Email"		,;
						"Titulo"		,;
						"Vencimento"	,;
						"Dias"		,;
						"BO"		,;  
						"Codigo"	,; 
						"Ano Base"	,;
						"Mes base"	,;
						"Valor"		,;
						"Saldo"} )
	
			 /*
			If FindFunction("WfPrepEnv")
				
				WFPrepEnv("01","01", , , "PLS")
				
			Else
				
				PREPARE ENVIRONMENT EMPRESA "01" FILIAL "01"  MODULO "PLS"
				
			EndIf    
			*/
	PREPARE ENVIRONMENT EMPRESA "01" FILIAL "01"  MODULO "PLS"   
	
   	//ddatabase := stod('20180208')
	
	QOut( ":-) " )		
							
   //	c_Qry:= " SELECT  (TO_DATE('20180208','YYYYMMDD') - TO_DATE(E1_VENCREA,'YYYYMMDD')) DIAS, " + c_Eol
   	c_Qry:= " SELECT  DISTINCT ROUND( (SYSDATE ) - TO_DATE(E1_VENCREA,'YYYYMMDD')) DIAS, " + c_Eol
	c_Qry+= "         nvl(BO.NUM_BO, 0) NUM_BO  , " + c_Eol
	c_Qry+= "         nvl(ZG_CODIGO , ' ') ZG_CODIGO , " + c_Eol
	c_Qry+= "         DECODE( TRIM(E1_MATRIC), '', A1_NOME, BA1_NOMUSR ) NOME, " + c_Eol
	c_Qry+= "         DECODE( TRIM(E1_MATRIC), '', A1_CGC, BA1_CPFUSR) CPF,    " + c_Eol
	c_Qry+= "         DECODE( TRIM(E1_MATRIC), '', A1_EMAIL, DECODE(TRIM(BA1_EMAIL), '', BTS_EMAIL, BA1_EMAIL )) EMAIL, " + c_Eol
//	c_Qry+= "         BA1_EMAIL EMAIL, " + c_Eol
	c_Qry+= "         E1_NUM NUM_TIT,  " + c_Eol
	c_Qry+= "         TO_DATE( E1_VENCREA, 'YYYYMMDD' ) VENCIMENTO, " + c_Eol
	c_Qry+= "         E1_ANOBASE ANO_BASE, " + c_Eol
	c_Qry+= "         E1_MESBASE MES_BASE, " + c_Eol
	c_Qry+= "         E1_VALOR VALOR,  " + c_Eol
	c_Qry+= "         BA3_COBNIV COBNIV,  " + c_Eol
	c_Qry+= "         E1_SALDO,  " + c_Eol
	c_Qry+= "         E1_FORMREC  " + c_Eol
	      
	c_Qry+= "FROM " + RETSQLNAME("SE1") + " SE1 INNER JOIN " + RETSQLNAME("BM1") + " BM1 ON " + c_Eol
	c_Qry+= "                              BM1_FILIAL = '" + XFILIAL("BM1") + "' " + c_Eol
	c_Qry+= "                              AND BM1_PREFIX = E1_PREFIXO " + c_Eol
	c_Qry+= "                              AND BM1_NUMTIT = E1_NUM " + c_Eol
	c_Qry+= "                              AND BM1_PARCEL = E1_PARCELA " + c_Eol
	c_Qry+= "                              AND BM1.D_E_L_E_T_ = ' ' " + c_Eol
	                              
	c_Qry+= "            INNER JOIN " + RETSQLNAME("BA1") + " BA1 ON " + c_Eol
	c_Qry+= "                              BA1_FILIAL = '" + XFILIAL("BA1") + "' " + c_Eol
	c_Qry+= "                              AND BA1_CODINT = BM1_CODINT " + c_Eol
	c_Qry+= "                              AND BA1_CODEMP = BM1_CODEMP " + c_Eol
	c_Qry+= "                              AND BA1_MATRIC = BM1_MATRIC " + c_Eol
	c_Qry+= "                              AND BA1_TIPREG = BM1_TIPREG " + c_Eol
	c_Qry+= "                              AND BA1_TIPUSU = 'T'        " + c_Eol
	c_Qry+= "                              AND BA1.D_E_L_E_T_ = ' '    " + c_Eol
	                        
	c_Qry+= "            INNER JOIN " + RETSQLNAME("BA3") + " BA3 ON " + c_Eol
	c_Qry+= "                              BA3_FILIAL = '" + XFILIAL("BA3") + "' " + c_Eol
	c_Qry+= "                              AND BA3_CODINT = BA1_CODINT " + c_Eol
	c_Qry+= "                              AND BA3_CODEMP = BA1_CODEMP " + c_Eol
	c_Qry+= "                              AND BA3_MATRIC = BA1_MATRIC " + c_Eol
	c_Qry+= "                              AND BA3.D_E_L_E_T_ = ' ' " + c_Eol  
	
	c_Qry+= "            INNER JOIN " + RETSQLNAME("SA1") + " SA1 ON "
	c_Qry+= "                                          A1_FILIAL = '" + XFILIAL("SA1") + "'"
	c_Qry+= "                                          AND A1_COD = E1_CLIENTE "
	c_Qry+= "                                          AND SA1.D_E_L_E_T_ = ' '"   
	c_Qry+= "            INNER JOIN " + RETSQLNAME("BTS") + " BTS ON  "
	c_Qry+= "                              BTS_FILIAL = '" + XFILIAL("BTS") + "' "
	c_Qry+= "                              AND BTS_MATVID = BA1_MATVID    "
	c_Qry+= "                              AND BTS.D_E_L_E_T_ = ' ' "
	

	                              
	c_Qry+= "           LEFT JOIN SAUDE.BOLETIM_DE_OCORRENCIA@PROD BO ON " + c_Eol
	c_Qry+= "                              NOSSO_NUMERO_MS = trim(E1_PREFIXO||E1_NUM||E1_PARCELA||E1_TIPO) " + c_Eol
	                             
	c_Qry+= "           LEFT JOIN SAUDE.HISTORICO_BO@PROD HB ON BO.NUM_BO = HB.NUM_BO  " + c_Eol
	c_Qry+= "                              AND  BO.TIPO_VINCULO = 'A' " + c_Eol
	c_Qry+= "                              AND SAUDE.BO_CLASS_SIT_TERMINAL@PROD(HB.COD_CLASSIFICACAO,HB.COD_SITUACAO) = 0 " + c_Eol
	                              
	c_Qry+= "           LEFT JOIN " + RETSQLNAME("SZG") + " SZG ON " + c_Eol
	c_Qry+= "                              ZG_FILIAL = '01' " + c_Eol
	c_Qry+= "                              AND ZG_CLIENTE = E1_CLIENTE " + c_Eol
	c_Qry+= "                              AND ZG_STATUS <> 'C' " + c_Eol
	c_Qry+= "                              AND SZG.D_E_L_E_T_ = ' ' " + c_Eol
	                            
	c_Qry+= "WHERE E1_FILIAL = '" + XFILIAL("SE1") + "' " + c_Eol 
	c_Qry+= "      AND E1_PREFIXO = 'PLS' " + c_Eol      
	c_Qry+= "      AND BA3_YSITBQ IN (' ', '6' ) " + c_Eol
	c_Qry+= "      AND BA1_CPFUSR <> ' ' " + c_Eol
	c_Qry+= "      AND BA3_DATBLO = ' ' " + c_Eol
	c_Qry+= "      AND E1_VENCREA >= '20160101' " + c_Eol
	c_Qry+= "      AND TO_DATE( E1_VENCREA, 'YYYYMMDD') <= SYSDATE " + c_Eol
    //	c_Qry+= "      AND BA1_EMAIL <> ' ' " + c_Eol
  //  c_Qry+= "      and ba1_cpfusr  in ( '02930196734') "
    //c_Qry+= "      and e1_cliente  = '000004' "
	c_Qry+= "      AND E1_SALDO > 0 " + c_Eol
	c_Qry+= "      AND E1_CODEMP NOT IN ('0003') " + c_Eol
	c_Qry+= "      AND E1_TIPO = 'DP' " + c_Eol
    //	c_Qry+= "      AND   ( ROUND( (to_date('20170612','YYYYMMDD') ) - TO_DATE(E1_VENCREA,'YYYYMMDD')) = 10 OR  " + c_Eol
	//c_Qry+= "            ( ROUND( (to_date('20170612','YYYYMMDD') ) - TO_DATE(E1_VENCREA,'YYYYMMDD')) >10 AND MOD(ROUND( (to_date('20170612','YYYYMMDD')) -TO_DATE(E1_VENCREA,'YYYYMMDD')), 5) = 0   )) " + c_Eol
	c_Qry+= "      AND SE1.D_E_L_E_T_ = ' ' " + c_Eol
   // 	c_Qry+= "  and e1_formrec not in ('01','08') " + c_Eol // COMENTADO EM 26/11/18 - MATEUS MEDEIROS - PARA ATENDER AO GLPI - 54298
	c_Qry+= "      AND E1_CODEMP NOT IN ('0024', '0025', '0027', '0028', '0004') " + c_Eol
	      
	c_Qry+= "      ORDER BY 5, 1 desc " + c_Eol
		
	If Select("QRYBLOQ") <> 0     
	
		("QRYBLOQ")->(DbCloseArea())  
		
	Endif  
	
	DbUseArea(.T.,"TopConn",TcGenQry(,,c_Qry),"QRYCEL",.T.,.T.)   
	
	Primeira 	:= .T.    
	c_Cpf 		:= ""       
	a_Pls 		:= {}    
	n_Total 	:= 0  
	a_Relatorio := {}      
	
	n_Conta 	:= 0        
	l_PriCpf 	:= .T.  
	n_QtdDias   := 1     
	a_VetLog    := {}
	
	While !QRYCEL->( EOf() )   
	
		QOut(":-) QRYCEL") 
	
		If QRYCEL->NUM_BO <> 0 .OR. QRYCEL->ZG_CODIGO <> ' ' .OR. Empty(QRYCEL->EMAIL)     
		
			c_Log := " insert into log_env_inadimp  values ( "
			c_Log += " '" + cEmpAnt      + "', "
			c_Log += " '" + alltrim(QRYCEL->CPF)   + "', "
			c_Log += " '" + alltrim( dtos( date()))  + "', "
			c_Log += " '" + alltrim(time())        + "', "
			c_Log += " '" + alltrim(QRYCEL->EMAIL) + "', "
			c_Log += " 'NAO'                  , "   
			
			If QRYCEL->NUM_BO <> 0
			            
		   		c_Log += " 'BO NUMERO:" + alltrim(str( QRYCEL->NUM_BO )) + "', "
			
			ElseIf QRYCEL->ZG_CODIGO <> ' '                     
			
				c_Log += " 'TITULO EM NEGOCIA«√O', "
						
			ElseIf Empty(QRYCEL->EMAIL) 

				c_Log += " 'EMAIL EM BRANCO', "
			
			EndIf
			
			c_Log += "            '" + QRYCEL->ANO_BASE + QRYCEL->MES_BASE + "', "
			c_Log += "            '" + alltrim(QRYCEL->NUM_TIT) + "', "
			c_Log += "            " + STR( QRYCEL->E1_SALDO ) +", "
			c_Log += "            '" + dtos(QRYCEL->VENCIMENTO) + "', ' ') " 
			
			TCSqlExec( c_Log )  
		
		
			QRYCEL->( dbSkip() )
		    Loop 
		
		EndIf
	    
	    If c_Cpf <> QRYCEL->CPF .AND. !Primeira
	    
	    	c_Cpf := QRYCEL->CPF  
	    	
	    	If (( QRYCEL->E1_FORMREC $ '08||01' .AND. n_QtdDias < 30 .AND. n_QtdDias >= 25) .OR. ( !(QRYCEL->E1_FORMREC $ '08||01') .AND. n_QtdDias < 30 ));
				.and.  ( n_QtdDias == 10 .or. ( n_QtdDias > 10 .and. mod(n_QtdDias, 5 ) == 0 ))  
	    		    	
	    		n_Conta++     
	    		
	    		c_Processo := fAvisa1(c_Email, a_Pls , n_Total, c_Nome, c_CobNiv )
	    	
		    	If !Empty(  c_Processo )
		    	     
		    		For n_Count := 1 to Len( a_VetLog )  
					
						TCSqlExec( a_VetLog[n_Count] + ", '" + c_Processo + "' )")  
					
					Next
		    	
		    	EndIf  

	    	
	    	ElseIf mod(n_QtdDias, 5 ) == 0 .AND.  n_QtdDias >= 30    
	    	
	    		c_Processo := fAvisa2(c_Email, trim(str(n_QtdDias)), c_Nome, a_Pls, c_CobNiv )  
	    	
	    	   	If  !Empty( c_Processo  )
	    	   	
					For n_Count := 1 to Len( a_VetLog )  
					
							TCSqlExec( a_VetLog[n_Count] + ", '" + c_Processo + "' )" ) 
					
					Next	    	   	
	    	   		
	    	   	EndIf
	    	   	     
	    	   	
	    	   	n_Conta++
	    	
	    	EndIf
	    	
	    	a_Pls 		:= {}      
	    	a_VetLog	:= {}      
	    	c_Email 	:= ""      
	    	n_Total 	:= 0 
	    	n_ContaCpf	:= 0     
	    	n_QtdDias   := 0
	    	l_PriCpf	:= .T.   
	    	
	    EndIF     
	    
	    	If Primeira  
	    	
	    		c_Cpf := QRYCEL->CPF 
	    	
	    	EndIf   
	    	
	    	If l_PriCpf    
	    	
	       		n_QtdDias := QRYCEL->DIAS 
	       		l_PriCpf  := .F.
	    	
	    	EndIf     
	    	
	    	Primeira := .F. 
	    	
	    	If ((QRYCEL->E1_FORMREC $ '08||01'.and. QRYCEL->DIAS >= 25) .OR. !(QRYCEL->E1_FORMREC $ '08||01' ) ) .AND. QRYCEL->DIAS > 10 // previ
			
				c_Log := " insert into log_env_inadimp  values ( "
				c_Log += " '" + cEmpAnt      + "', "
				c_Log += " '" + alltrim(QRYCEL->CPF)   + "', "
				c_Log += " '" + alltrim(dtos( date())) + "', "
				c_Log += " '" + alltrim(time())        + "', "
				c_Log += " '" + alltrim(QRYCEL->EMAIL) + "', "
				c_Log += " 'SIM'                  , "   
			    c_Log += " ' '                    , "			
				c_Log += " '" + QRYCEL->ANO_BASE + QRYCEL->MES_BASE + "', "
				c_Log += " '" + alltrim(QRYCEL->NUM_TIT) 		+ "', "
				c_Log += "  " + STR( QRYCEL->E1_SALDO ) +", "
				c_Log += " '" + dtos(QRYCEL->VENCIMENTO) 		+ "' " 
				
				AADd( a_VetLog, c_Log )
		    	 
		    	aadd( a_Pls, {	QRYCEL->NUM_TIT    	,;
		    	 				QRYCEL->VENCIMENTO 	,;
		    	 				QRYCEL->ANO_BASE 	,;
		    	 				QRYCEL->MES_BASE 	,;
		    	 				QRYCEL->VALOR 		,;
		    	 				QRYCEL->E1_SALDO 	} )  
		    	 				
		    	 c_Email := QRYCEL->EMAIL   
		    	 c_Nome  := QRYCEL->NOME
		    	 c_CobNiv:= QRYCEL->COBNIV
		    	 n_Total += QRYCEL->E1_SALDO     
	    	 
	    	 Else      
	    	 
	    	 	c_Log := " insert into log_env_inadimp  values ( "
				c_Log += " '" + cEmpAnt      + "', "
				c_Log += " '" + alltrim(QRYCEL->CPF)   + "', "
				c_Log += " '" + alltrim(dtos( date())) + "', "
				c_Log += " '" + alltrim(time())        + "', "
				c_Log += " '" + alltrim(QRYCEL->EMAIL) + "', "
				c_Log += " 'NAO'                  , "   
			    c_Log += " 'PREVI'                    , "			
				c_Log += " '" + QRYCEL->ANO_BASE + QRYCEL->MES_BASE + "', "
				c_Log += " '" + alltrim(QRYCEL->NUM_TIT) 		+ "', "
				c_Log += "  " + STR( QRYCEL->E1_SALDO ) +", "
				c_Log += " '" + dtos(QRYCEL->VENCIMENTO) 		+ "' " 
				
				AADd( a_VetLog, c_Log )
		    	
	    	 EndIf

 
 		QRYCEL->( dbSkip() ) 
 		/*
 		If n_Conta >= 30
 		     
 			Exit
 		
 		EndIf
	     */
	EndDo
	
	QRYCEL->( dbSkip()-- )     
	
	If n_QtdDias < 30 .and.  ( n_QtdDias == 10 .or. ( n_QtdDias > 10 .and. mod(n_QtdDias, 5 ) == 0 ))    
	
	    	
		c_Processo := fAvisa1(c_Email, a_Pls , n_Total, c_Nome, c_CobNiv )
		
		If !Empty(  c_Processo )
			
			For n_Count := 1 to Len( a_VetLog )
				
				TCSqlExec( a_VetLog[n_Count] + ", '" + c_Processo + "' )") 
				
			Next
			
		EndIf 
		 
	    	
   	ElseiF mod(n_QtdDias, 5 ) == 0 .AND.  n_QtdDias >= 30          
   	
	    	
  		c_Processo := fAvisa2(c_Email, trim(str(n_QtdDias)), c_Nome, a_Pls, c_CobNiv )  
	    	
   	   	If  !Empty( c_Processo  )
	    	   	
			For n_Count := 1 to Len( a_VetLog )  
					
				TCSqlExec( a_VetLog[n_Count] + ", '" + c_Processo + "' ) " ) 
					
			Next	    	   	
	    	   		
   	   	EndIf
		    	
	EndIf
	
 	RESET ENVIRONMENT   
	
Return   


**'---------------------------------------------------------------------'**
**'-- FunÁ„o respons·vel por enviar e-mails de aviso de mudanÁa de    --'**
**'-- status da SPA.                                                  --'**
**'---------------------------------------------------------------------'**
Static Function fAvisa2(c_To, c_Dias, c_Nome, a_Dados, c_CobNiv )
**'---------------------------------------------------------------------'**
	Local cHtmlModelo  	:= " "                                              
	Local cCodProcesso 	:= "000002"                     
	Local c_Assunto		:= " "   
	Local c_ItGuias		:= " "                                
	Local c_ItApro		:= " "                                       
	Local c_ItFin 		:= " "  
	Local c_Html        := " "    
	
  //	Local c_Cco := "coimbra.marcela@gmail.com;esther_csm@hotmail.com;"  + c_To
	
	QOut(":-) fAvisa2") 
//c_To := "coimbra.marcela@gmail.com;esther_csm@hotmail.com;alanjpl@yahoo.com.br" 
		

	cHtmlModelo  	:= "\HTML\INADIMPLENCIA_02.html"
	c_Assunto		:= "Comunicado Importante"
	
	oProcess := TWFProcess():New(cCodProcesso, c_Assunto) 
	oProcess:NewTask(c_Assunto, cHtmlModelo) 
	 
		If c_CobNiv == '1'
		
			oProcess:oHtml:ValByName( "c_MsgDesti"	, "Prezado(a) Benefici·rio(a) "  + c_Nome )	 
			oProcess:oHtml:ValByName( "c_Central"	, "<p>Pedimos que efetue a quitaÁ„o o mais breve possÌvel ou entre em contato com a nossa central  (021) 3233-8855 para negociaÁ„o a fim de evitar a suspens„o do plano de sa˙de.</p>"  )	
		
		Else 
		
			oProcess:oHtml:ValByName( "c_MsgDesti"	, "Prezado(a)  "  + c_Nome ) 
			oProcess:oHtml:ValByName( "c_Central"	, "<p>Pedimos que efetue a quitaÁ„o o mais breve possÌvel ou entre em contato para negociaÁ„o a fim de evitar a suspens„o do plano de sa˙de.</p>"  )	
		
		EndIf
				
		oProcess:oHtml:ValByName( "c_QtdDias" 	, c_Dias ) 
		
		For n_Cont := 1 to Len( a_Dados )     

				
			c_Html += '<tr>'
   			c_Html += '	<td style=" color: rgb(0, 102, 0); width: 200px; height: 10px;">' + a_Dados[n_Cont][4] + "/" + a_Dados[n_Cont][3]  +  '</td>'   			
			c_Html += ' <td style=" color: rgb(0, 102, 0); width: 900px; height: 30px; align:right">' + Transform( a_Dados[n_Cont][5] ,"@E 9,999,999.99") +'</td> '
			c_Html += ' <td style=" color: rgb(0, 102, 0); width: 900px; height: 30px; align:right">' + Transform( a_Dados[n_Cont][6] ,"@E 9,999,999.99") +'</td> '
   			c_Html += '	<td style=" color: rgb(0, 102, 0); width: 200px; height: 10px;">' + dtoc(a_Dados[n_Cont][2])   +  '</td>'
			c_Html += '</tr>'
		
		Next
		
		oProcess:oHtml:ValByName( "c_TableApro" 	, c_Html )


		oProcess:cSubject := c_Assunto
		oProcess:cTo := c_To
		

		cMailID := oProcess:Start("\workflow\inadimp_02")   
		
		oProcess:Finish() 
		
	   //	C:= 1 + AAAA

Return cMailID    

**'---------------------------------------------------------------------'**
**'-- FunÁ„o respons·vel por enviar e-mails de aviso de mudanÁa de    --'**
**'-- status da SPA.                           '                       --'**
**'---------------------------------------------------------------------'**
Static Function fAvisa1(c_To, a_Dados, n_Total, c_Nome, c_CobNiv )
**'---------------------------------------------------------------------'**
	Local cHtmlModelo  	:= " "                                              
	Local cCodProcesso 	:= "000002"                     
	Local c_Assunto		:= " "   
	Local c_ItGuias		:= " "                                
	Local c_ItApro		:= " "   
	Local c_ItFin 		:= " "  
	Local c_Html        := " "   
	Local c_Processo    := " "  
   //	Local c_Cco := "coimbra.marcela@gmail.com;esther_csm@hotmail.com;"  + c_To 
	
	QOut(":-) fAvisa1") 
	
	
	
	//	c_To := "coimbra.marcela@gmail.com;" 
		

	cHtmlModelo  	:= "\HTML\INADIMPLENCIA_01.html"
	c_Assunto		:= "Comunicado Importante"
	
	oProcess := TWFProcess():New(cCodProcesso, c_Assunto) 
	oProcess:NewTask(c_Assunto, cHtmlModelo)  
	    
	    If c_CobNiv == '1'
		
			oProcess:oHtml:ValByName( "c_MsgDesti"	, "Prezado(a) Benefici·rio(a) "  + c_Nome )     
			oProcess:oHtml:ValByName( "c_MsgPS"		, "<p>O Grupo Caberj  trabalha incansavelmente para que vocÍ tenha acesso a um plano de assistÍncia ‡ sa˙de abrangente, de excelÍncia e com atendimento humanizado. A garantia de seu atendimento È muito importante para nÛs.</p>" )
			oProcess:oHtml:ValByName( "c_Central"	, "<p>A segunda via dos boletos tambÈm pode ser obtida por meio do telefone (021) 3233-8855 ou pelo nosso aplicativo Caberj. </p>"   )
		
		Else 
		
			oProcess:oHtml:ValByName( "c_MsgDesti"	, "Prezado(a)  "  + c_Nome )   
			oProcess:oHtml:ValByName( "c_MsgPS"		, " "   )
			oProcess:oHtml:ValByName( "c_Central"	, " "  )
		
		
		EndIf
		
		For n_Cont := 1 to Len( a_Dados )     

				
			c_Html += '<tr>'
   			c_Html += '	<td style=" color: rgb(0, 102, 0); width: 200px; height: 10px;">' + a_Dados[n_Cont][4] + "/" + a_Dados[n_Cont][3]  +  '</td>'
			c_Html += ' <td style=" color: rgb(0, 102, 0); width: 900px; height: 30px; align:right">' + Transform( a_Dados[n_Cont][5] ,"@E 9,999,999.99") +'</td> '
			c_Html += ' <td style=" color: rgb(0, 102, 0); width: 900px; height: 30px; align:right">' + Transform( a_Dados[n_Cont][6] ,"@E 9,999,999.99") +'</td> '
   			c_Html += '	<td style=" color: rgb(0, 102, 0); width: 200px; height: 10px;">' + dtoc(a_Dados[n_Cont][2])   +  '</td>'
			c_Html += '</tr>'
		
		Next
		
		oProcess:oHtml:ValByName( "c_TableApro" 	, c_Html )

		oProcess:cSubject := c_Assunto
		oProcess:cTo := c_To

		cMailID := oProcess:Start("\workflow\inadimp_" + cEmpAnt)  

		
		oProcess:Finish() 
		
	  // 	C:= 1 + AAAA

Return cMailID    



User Function fTesteMail(c_Dias, c_Nome, a_Dados, c_CobNiv )
**'---------------------------------------------------------------------'**
	Local cHtmlModelo  	:= " "                                              
	Local cCodProcesso 	:= "000001"                     
	Local c_Assunto		:= " "   
	Local c_ItGuias		:= " "                                
	Local c_ItApro		:= " "                                       
	Local c_ItFin 		:= " "  
	Local c_Html        := " " 
	
   	//Prepare Environment Empresa "02" Filial "01" 
	
 //	c_To := "coimbra.marcela@gmail.com;"//;esther_csm@hotmail.com;alanjpl@yahoo.com.br" 
//	c_To := "coimbra.marcela@gmail.com"//;esther_csm@hotmail.com;alanjpl@yahoo.com.br" 
	//c_To := "coimbra.marcela@gmail.com;esther_csm@hotmail.com;alanjpl@yahoo.com.br" 
		

	cHtmlModelo  	:= "\HTML\INADIMPLENCIA_02.html"
	c_Assunto		:= "Comunicado Importante_"    + cEmpAnt
	
	oProcess := TWFProcess():New(cCodProcesso, c_Assunto) 
	oProcess:NewTask(c_Assunto, cHtmlModelo)  
	
		If c_CobNiv == '1'
		
			oProcess:oHtml:ValByName( "c_MsgDesti"	, "Prezado(a) Benefici·rio(a) "  + c_Nome )	 
			oProcess:oHtml:ValByName( "c_Central"	, "<p>Pedimos que efetue a quitaÁ„o o mais breve possÌvel ou entre em contato com a nossa central  (021) 3233-8855 para negociaÁ„o a fim de evitar a suspens„o do plano de sa˙de.</p>"  )	
		
		Else 
		
			oProcess:oHtml:ValByName( "c_MsgDesti"	, "Prezado(a)  "  + c_Nome ) 
			oProcess:oHtml:ValByName( "c_Central"	, "<p>Pedimos que efetue a quitaÁ„o o mais breve possÌvel ou entre em contato para negociaÁ„o a fim de evitar a suspens„o do plano de sa˙de.</p>"  )	
		
		EndIf
				
		oProcess:oHtml:ValByName( "c_QtdDias" 	, '3' ) 		

		oProcess:cSubject := c_Assunto
		oProcess:cTo := c_To

		cMailID := oProcess:Start("\workflow\inadimp_02")   
		
		//c_Processo    := oProcess:fProcessID 
		
		oProcess:Finish() 
		
  	   //	RESET ENVIRONMENT
		
	   //	C:= 1 + AAAA

Return cMailID  

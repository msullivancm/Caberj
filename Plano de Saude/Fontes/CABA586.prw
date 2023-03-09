#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#include "TBICONN.CH"    

#DEFINE c_ent CHR(13) + CHR(10)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³CABR155      ºAutor  ³ Marcela Coimbra    º Data ³ 28/08/2015  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³  GERA PLANILHA DE FATURAMENTO TRIBINAL   					 º±± 
±±º          ³  		                                                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Projeto CABERJ                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function CABA586()   
      
Processa({||PCABA586()},'Processando...')

Return

Static Function PCABA586

	Local c_Lin     := Space(1)+CHR(13)+CHR(10)   
	Local c_Qry 	:= ""
	
	Private c_Perg 	:= "CABA586"
	Private	c_DirExp:= GETNEWPAR("MV_YFTTRIB","\interface\EXPORTA\FATURA TRIBUNAL\") 
	Private c_NomeArq := " "
	private nHdl    := ""   
	private c_Subcon := ""     
	Private A_TIPO := {}
	 
	AjustaSX1(c_Perg)
		
	If Pergunte(c_Perg,.T.)  
	
		c_Emp	:= Mv_Par01  
		c_Ano	:= Mv_Par02  
	    c_Mes	:= Mv_Par03
	   
	else
	    Return	
	EndIf        
	

//	c_Qry += " SELECT   BA12.BA1_CODINT||BA12.BA1_CODEMP||BA12.BA1_MATRIC||BA12.BA1_TIPREG||BA12.BA1_DIGITO MATRICULA, "
	c_Qry += " SELECT   substr(trim(BA12.BA1_MATEMP), 1, 9) MATRICULA, "
	c_Qry += "          BA12.Ba1_Nomusr NOME_TITULAR, "
	c_Qry += "          BA11.BA1_CPFUSR CPF_USUARIO, "
	c_Qry += "          Ba11.Ba1_Nomusr NOME_USUARIO, "
	c_Qry += "          Ba11.Ba1_SUBCON SUBCON, "
	c_Qry += "          substr(BA11.BA1_DATNAS,7,2)||'/'||substr(BA11.BA1_DATNAS,5,2)||'/'||substr(BA11.BA1_DATNAS,1,4)  DATA_NASCIMENT, "
	c_Qry += "          BA11.BA1_GRAUPA DEPENDECIA,   "
	c_Qry += "          substr(BA11.BA1_DATINC,7,2)||'/'||substr(BA11.BA1_DATINC,5,2)||'/'||substr(BA11.BA1_DATINC,1,4)  DATA_INCLUSAO,"
	c_Qry += "          BM1_CODFAI FAIXA_ETARIA,      "
//	c_Qry += "          BM1_IDAINI || '-' || BM1_IDAFIN FAIXA_ETARIA,      "
	c_Qry += "          BA11.BA1_CODPLA  TIPO_DE_PLANO,  "
	//c_Qry += "          RETORNA_DESC_PLANO_MS('I', BA11.BA1_CODINT, BA11.BA1_CODEMP,BA11.BA1_MATRIC,BA11.BA1_TIPREG)  TIPO_DE_PLANO,  "
	c_Qry += "          SUM (DECODE ( BM1_TIPO , 1 ,BM1_VALOR, (BM1_VALOR*-1))) VALOR    "
                 
	c_Qry += "   FROM   " + retsqlname("BA1") +  "  BA11 INNER JOIN  " + retsqlname("BM1") +  " BM1 ON    "
	c_Qry += "              BM1_FILIAL = '" + xfilial("BM1") + "'  "           
	c_Qry += "              AND BM1_CODINT = BA1_CODINT  "
	c_Qry += "              AND BM1_CODEMP = BA1_CODEMP " 
	c_Qry += "              AND BM1_MATRIC = BA1_MATRIC " 
	c_Qry += "              AND BM1_TIPREG = BA1_TIPREG  "
	c_Qry += "              AND BM1.D_E_L_E_T_ = ' '   "
             
	c_Qry += "              INNER JOIN  " + retsqlname("BA1") +  " BA12 ON  "
	c_Qry += "              BA12.BA1_FILIAL = '" + xfilial("BA1") + "'     "        
	c_Qry += "              AND BA12.BA1_CODINT = BA11.BA1_CODINT " 
	c_Qry += "              AND BA12.BA1_CODEMP = BA11.BA1_CODEMP " 
	c_Qry += "              AND BA12.BA1_MATRIC = BA11.BA1_MATRIC " 
	c_Qry += "              AND BA12.BA1_TIPUSU = 'T' "
	c_Qry += "              AND BA12.D_E_L_E_T_ = ' ' "
	
	c_Qry += "   WHERE BA11.BA1_FILIAL = '" + xfilial("BA1") + "'     "
	c_Qry += "        AND BA11.BA1_CODINT = '0001'  "
	c_Qry += "        AND BA11.BA1_CODEMP = '" + c_Emp + "' "
	c_Qry += "        AND BM1_ANO = '" + c_Ano + "'   "
	c_Qry += "        AND BM1_MES = '" + c_Mes + "'   "
	c_Qry += "        AND BM1_CODTIP in( '101' ) " 
	c_Qry += "        and BA11.D_E_L_E_T_ = ' '"  "
	
//	c_Qry += " 	GROUP BY BA12.BA1_CODINT||BA12.BA1_CODEMP||BA12.BA1_MATRIC||BA12.BA1_TIPREG||BA12.BA1_DIGITO , "
	c_Qry += " 	GROUP BY substr(trim(BA12.BA1_MATEMP), 1, 9) , "
	c_Qry += "          BA12.Ba1_Nomusr , "
	c_Qry += "          BA11.BA1_CPFUSR , "
	c_Qry += "          Ba11.Ba1_Nomusr , "
	c_Qry += "          Ba11.Ba1_SUBCON , "
	c_Qry += "          substr(BA11.BA1_DATNAS,7,2)||'/'||substr(BA11.BA1_DATNAS,5,2)||'/'||substr(BA11.BA1_DATNAS,1,4)  , "
	c_Qry += "          BA11.BA1_GRAUPA ,   "
	c_Qry += "          substr(BA11.BA1_DATINC,7,2)||'/'||substr(BA11.BA1_DATINC,5,2)||'/'||substr(BA11.BA1_DATINC,1,4)  ,"
	c_Qry += "          BM1_CODFAI ,      "
	c_Qry += "          BA11.BA1_CODPLA   "
//	c_Qry += "          RETORNA_DESC_PLANO_MS('I', BA11.BA1_CODINT, BA11.BA1_CODEMP,BA11.BA1_MATRIC,BA11.BA1_TIPREG)   "
	c_Qry += " order by  5 "
   
   
	c_Qry := ChangeQuery( c_Qry )
	DbUseArea(.T.,"TOPCONN",TcGenQry(,,c_Qry),"CBA586",.T.,.T.)         
		
		While ! CBA586->(Eof()) 
	    
		If c_Subcon <> CBA586->SUBCON 
                                          
			If !empty(c_Subcon)
			
				U_Fecha_TXT()
			
			EndIf
			
			c_Subcon 	:= CBA586->SUBCON		
			
			c_NomeArq 	:= CBA586->SUBCON + '_TR_' + c_Emp + "_" + DTOS(DATE()) + '.txt'
		
			// Monta Cabecalho "Fixo"
			If !U_Cria_TXT(c_DirExp + c_NomeArq)       
			
				Alert("Arquivo do subcontrato " + CBA586->SUBCON + " não pode ser criado.")
				
			EndIf
		
		EndIf
			
			IncProc()  
						
			AADD(A_TIPO, {'01','0'})
			AADD(A_TIPO, {'02','C'})
			AADD(A_TIPO, {'03','H'})
			AADD(A_TIPO, {'04','C'})
			AADD(A_TIPO, {'05','F'})
			AADD(A_TIPO, {'06','F'})
			AADD(A_TIPO, {'07','P'})
			AADD(A_TIPO, {'08','M'})
			AADD(A_TIPO, {'11','O'})
			AADD(A_TIPO, {'23','G'})
			AADD(A_TIPO, {'24','E'})
			
		   	n_Pos :=  aScan(A_TIPO,{|x| x[1] == CBA586->DEPENDECIA})  
		   	
		   	c_Depend := ""
		   	
		   	If n_Pos <> 0
		   	     
			   	c_Depend := A_TIPO[n_Pos][02]
		   	
		   	EndIf
						
			c_Cpo := ALLTRIM(allTRIM(STR(VAL(CBA586->MATRICULA)))) + ";"
			c_Cpo += ALLTRIM(CBA586->NOME_TITULAR) + ";"
			c_Cpo += ALLTRIM(CBA586->CPF_USUARIO )+ ";"
			c_Cpo += ALLTRIM(CBA586->NOME_USUARIO)+ ";"
			c_Cpo += ALLTRIM(CBA586->DATA_NASCIMENT )+ ";"
			c_Cpo += c_Depend + ";"//ALLTRIM(CBA586->DEPENDECIA )+ ";"
			c_Cpo += ALLTRIM(CBA586->DATA_INCLUSAO)+ ";"
			c_Cpo += ALLTRIM(allTRIM(STR(VAL(CBA586->FAIXA_ETARIA)))) + ";"
			c_Cpo += ALLTRIM(CBA586->TIPO_DE_PLANO )+ ";"
			c_Cpo += ALLTRIM(Transform(CBA586->VALOR,"999999.99")) + ";"
			
			U_GrLinha_TXT(c_Cpo,c_Lin)
				
			CBA586->(DbSkip())       
			
		EndDo
		
		U_Fecha_TXT()
		
If Select("CBA586") > 0
	dbSelectArea("CBA586")
	dbCloseArea()
EndIf      
      

Return 
*************************************************************************************************************************
//AJUSTAR "COPPRO"
Static Function AjustaSX1      

 
Local aHelpPor := {}
//Monta Help

PutSx1(c_Perg,"01","Empresa:  "  ,"","","mv_ch01","C",04,0,0,"C","","","","","mv_par01","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(c_Perg,"02","Ano:  "  	,"","","mv_ch02","C",04,0,0,"C","","","","","mv_par02","","","","","","","","","","","","","","","","",{},{},{})
PutSx1(c_Perg,"03","Mes:  "  	,"","","mv_ch03","C",02,0,0,"C","","","","","mv_par03","","","","","","","","","","","","","","","","",{},{},{})

Return	
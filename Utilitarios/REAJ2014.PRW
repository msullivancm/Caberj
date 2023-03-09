#INCLUDE "rwmake.ch"
#INCLUDE "protheus.ch"
#INCLUDE "TopConn.ch"
#include "TBICONN.CH"    

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณREAJ2014  บAutor  ณMarcela Coimbra     บ Data ณ  06/08/18   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Distribui็ใo de indices                                    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/


User Function REAJCBRJ()
	      
	Private c_MesRea := ""
	Private c_Perg   := "REAJMES"

	ValidPerg( c_Perg )
	
	If !Pergunte( c_Perg )
		
		Return
	
	EndIf           
	
	c_MesRea := "'" + mv_par01 + "'"
	
	fPontFam( c_MesRea )  
	
	Aviso("Aten็ใo","Processo de atualiza็ใo das familias finalizado",{"OK"})       

Return

Static Function fPontFam( c_MesRea )        

	Local c_Qry := ""

	c_Qry := " SELECT R_E_C_N_O_ RECBA3, BA3010.* "
	c_Qry += " FROM BA3010 "

	c_Qry += " WHERE BA3_FILIAL = ' ' "
	c_Qry += "       AND BA3_CODINT = '0001' "
	c_Qry += "       AND BA3_CODEMP IN ('0001', '0002', '0005') "
	c_Qry += "       AND BA3_MESREA in (" + c_MesRea + ") "
	//c_Qry += "       AND (BA3_DATBLO = ' ' OR ( BA3_DATBLO <> ' ' AND BA3_MOTBLO = '028' ) ) "
	c_Qry += "       AND BA3010.D_E_L_E_T_ = ' ' "
	c_Qry += "       ORDER BY BA3_CODEMP, BA3_MATRIC  "
	
	TcQuery c_Qry New Alias "QRYFAM"    
	
	While !QRYFAM->( EOF() )     
	
		c_IndRea := fPontUsu( QRYFAM->BA3_CODEMP, QRYFAM->BA3_MATRIC )    
		
		dbSelectArea("BA3")
		dbGoTo( QRYFAM->RECBA3 )
		Reclock("BA3", .f. )
		
			BA3->BA3_INDREA := c_IndRea
		
		MsUnlock()

	**'Verifica se tem '**
	     
		QRYFAM->( dbSkip() )
	
	EndDo  
	
	QRYFAM->( dbCloseArea() )


Return        

Static Function fPontUsu( c_CodEmp, c_Matric )  

	Local c_Qry 		:= ""    
	Local n_QtdAnt 		:= 0
	Local c_NivelAnt	:= "N"
	Local n_Qtd 		:= 0
	Local c_Nivel		:= "N"
	Local l_Primeira	:= .F. 
	Local c_Ret			:= "NAOENC"

	c_Qry := " SELECT * "
	c_Qry += " FROM BA3010 INNER JOIN BA1010 ON "
	c_Qry += "                   BA3_FILIAL = ' ' "
	c_Qry += "                   AND BA3_CODINT = BA1_CODINT "
	c_Qry += "                   AND BA3_CODEMP = BA1_CODEMP "
	c_Qry += "                   AND BA3_MATRIC = BA1_MATRIC "

	c_Qry += " WHERE BA3_FILIAL = ' ' "
	c_Qry += "       AND BA3_CODINT = '0001' "
	c_Qry += "       AND BA3_CODEMP = '" + c_CodEmp + "' "
	c_Qry += "       AND BA3_MATRIC = '" + c_Matric + "' "
//	c_Qry += "       AND (BA1_DATBLO = ' ' OR ( BA1_DATBLO <> ' ' AND BA1_MOTBLO = '028' ) ) "
	c_Qry += "       AND BA3010.D_E_L_E_T_ = ' ' "
	c_Qry += "       AND BA1010.D_E_L_E_T_ = ' ' "
	c_Qry += "       ORDER BY BA1_CODEMP, BA1_MATRIC  "

	TcQuery c_Qry New Alias "QRYUSU" 
	
	While !( QRYUSU->( EOF() ) )   
	
		VerificaTab(QRYUSU->BA1_CODEMP, QRYUSU->BA1_MATRIC, QRYUSU->BA1_TIPREG, @n_Qtd , @c_Nivel)    
		
		c_Ret := "NAOENT"
		
		If l_Primeira .AND. (n_Qtd <> n_QtdAnt .OR. c_Nivel <> c_NivelAnt) 
		
			l_Primeira  := .T.

			c_Ret		:=	"FORPAD"           
			
			Exit
		
		EndIf
		
		
		If QRYUSU->BA1_CODEMP == '0001' //.AND. n_Qtd == 7     
		
			//c_Ret := '000047'  
			c_Ret := '000050'
			
		Else                   
		
			//c_Ret := '000048'
			c_Ret := '000051'  
		            /*
		ElseIf QRYUSU->BA1_CODEMP <> '0001' .AND. n_Qtd == 7  
		
			c_Ret := '000043'                                 
			
		ElseIf n_Qtd == 10  
		
			c_Ret := '000044'                                 					
		
		ElseIf n_Qtd == 8 
		
			c_Ret := '000045'		
        */
		EndIf
		              
		QRYUSU->( dbSkip() )
	
	endDo	
	
	QRYUSU->( dbCloseArea() )

Return  c_Ret

Static Function VerificaTab( c_CodEmp, c_Matric, c_TipReg , n_Qtd , c_Nivel ) 
      
	Local c_Qry 		:= ""     
	
	c_Qry := " SELECT COUNT(*) QUANTIDADE "
	c_Qry += " FROM BDK010 "
	c_Qry += " WHERE BDK_FILIAL = ' ' "
	c_Qry += "       AND BDK_CODINT = '0001' "
	c_Qry += "       AND BDK_CODEMP = '" + c_CodEmp + "' "
	c_Qry += "       AND BDK_MATRIC = '" + c_Matric + "' "
	c_Qry += "       AND BDK_TIPREG = '" + c_TipReg + "' "    
	c_Qry += "       AND D_E_L_E_T_ = ' ' "    
	
	TcQuery c_Qry New Alias "QRYBDK"
	
	If QRYBDK->QUANTIDADE > 0    
	
		n_Qtd 	:= QRYBDK->QUANTIDADE
		c_Nivel := "U"
	
	Else    
	
		c_Qry := " SELECT COUNT(*) QUANTIDADE "        
		c_Qry += " FROM BBU010 "
		c_Qry += " WHERE BBU_FILIAL = ' ' "
		c_Qry += "       AND BBU_CODOPE = '0001' "
		c_Qry += "       AND BBU_CODEMP = '" + c_CodEmp + "' "
		c_Qry += "       AND BBU_MATRIC = '" + c_Matric + "' "
		c_Qry += "       AND BBU_TABVLD = ' ' "
		c_Qry += "       AND D_E_L_E_T_ = ' ' "    
		
		TcQuery c_Qry New Alias "QRYBBU"     
		                
			If QRYBBU->QUANTIDADE > 0     
			
				n_Qtd 	:= QRYBBU->QUANTIDADE
				c_Nivel := "F"
			
			Else
			
				n_Qtd 	:= 0
				c_Nivel := "N"
				
			
			Endif
		
		QRYBBU->( dbCloseArea() )
					
	EndIf  
	
	QRYBDK->( dbCloseArea() )
	

Return



Static Function ValidPerg( c_Perg )                                                                             
      
aHelp := {}
aAdd(aHelp, "Informe o mes do reajuste")         
PutSX1(c_Perg , "01" , "Mes: " 	,"","","mv_ch1","C",4							,0,0,"G",""	,""			,"","","mv_par01","","","","","","","","","","","","","","","","",aHelp,aHelp,aHelp)

Return


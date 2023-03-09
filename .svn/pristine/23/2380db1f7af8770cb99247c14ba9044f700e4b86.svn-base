#Define CRLF Chr(13)+Chr(10)
#include "rwmake.ch"
#include "TopConn.ch"

#Include "Colors.ch"
#xtranslate bSetGet(<uVar>) => {|u| If(PCount()== 0, <uVar>,<uVar> := u)}

****************************
User Function AjD_6000()
****************************   

PRIVATE cChaveE5 := " "   
private aContr   := {}
private x      := 1
cPerg := "Dirf09"
aSx1  := {}
Aadd(aSx1,{"GRUPO","ORDEM","PERGUNT"             ,"VARIAVL","TIPO","TAMANHO","DECIMAL","GSC","VALID","VAR01"   ,"F3","DEF01","DEF02"     ,"DEF03" ,"DEF04"  ,"DEF05"})
Aadd(aSx1,{cPerg  ,"01"   ,"Data de Baixa De......?","mv_ch1" ,"D"   ,08       ,0        ,"G"  ,""     ,"mv_par01",""  ,""     ,""          ,""      ,""       ,""     })
Aadd(aSx1,{cPerg  ,"02"   ,"Data de Baixa Ate.....?","mv_ch2" ,"D"   ,08       ,0        ,"G"  ,""     ,"mv_par02",""  ,""     ,""          ,""      ,""       ,""     })
Aadd(aSx1,{cPerg  ,"03"   ,"Tipo Fornecedor........?","mv_ch3" ,"N"   ,01       ,0        ,"C"  ,""     ,"mv_par03",""  ,"Fisico"  ,"Juridico","" ,""       ,""     })

fCriaSX1(cPerg,aSX1)

If !Pergunte(cPerg,.T.)
	Return
Endif

If mv_par03 == 1
	cTpFornec := "F"
Else
	cTpFornec := "J"
Endif

fSelecao()

Return


***************************
Static Function fSelecao()
***************************
Local cQry := " "

cQry += " SELECT Sum( E2_VALOR+E2_irrf+E2_INSS+E2_VRETPIS+E2_VRETCOF+E2_VRETCSL+E2_ISS ) E2BASE , "
cQry += "  Sum(E2_IRRF) E2IRRF , Sum(E2_INSS) E2INSS , "
cQry += "  Sum(E2_VRETPIS) E2PIS , Sum(E2_VRETCOF) E2COFINS , Sum(E2_VRETCSL) E2CSLL , A2_CGC , SubStr(E2_BAIXA,5,2) MES "

cQry += " , E2_FILIAL , E2_PREFIXO , E2_NUM , E2_PARCELA , E2_TIPO , E2_FORNECE , E2_LOJA, A2_NOME "

cQry += "  FROM " + RetSqlName("SE2") + " SE2 , "  +  RetSqlName("SA2")  + " SA2 "
cQry += "  WHERE  SE2.E2_FILIAL = '01' AND SA2.A2_FILIAL = ' ' AND SA2.A2_COD  = SE2.E2_FORNECE "
cQry += "           AND SA2.A2_LOJA = SE2.E2_LOJA "
cQry += "           AND SA2.A2_TIPO =  '" + cTpFornec + "' "
cQry += "           AND SE2.E2_SALDO = 0 "        

//tratamento no ano de 2009 / 2010 para os fornecedores pessoa juridica 
cQry += "           AND e2_fornece IN ( '120620' , '001256' , '123624' , '120562' , '121607' , '123385' , '001260' , '124945' , '122703' , '123384' , '120610') "
/////

cQry += "           AND SE2.E2_BAIXA BETWEEN '" + dTos(mv_par01) + "'  AND '" + dTos(mv_par02) + "'"
cQry += "           AND SE2.E2_TIPO NOT IN ('TX','INS','ISS', 'PA' , 'DEV', 'AXF', 'OPE','FGT', 'TXA', 'REM', 'IRF', 'FOL', 'NDF','FER','RES','PEN','131','132') "
cQry += "           AND (SA2.A2_CGC <> '              ' AND  SA2.A2_CGC <>  '00000000000000') "      
cQry += "           AND SE2.D_E_L_E_T_ = ' '   "
cQry += "           AND SA2.D_E_L_E_T_ = ' '   "
//cQry += "         AND SE2.E2_CODRET <> ' ' "   

cQry += "   AND not EXISTS (select NULL FROM " + RetSqlName("SE2") + " SE21 , "  +  RetSqlName("SA2")  + " SA21 "
cQry += "   WHERE  SE21.E2_FILIAL = '01' AND SA21.A2_FILIAL = ' '  AND Se2.e2_fornece = SE21.E2_FORNECE AND SA21.A2_COD  = SE21.E2_FORNECE "
cQry += "   AND SA21.A2_LOJA = SE21.E2_LOJA "
cQry += "   AND SA2.A2_TIPO =  '" + cTpFornec + "' "
cQry += "   AND SE21.E2_SALDO = 0   "
cQry += "   AND SE21.E2_BAIXA BETWEEN '" + dTos(mv_par01) + "'  AND '" + dTos(mv_par02) + "'"
cQry += "   AND ( SE21.E2_IRRF > 0 OR SE21.E2_VRETPIS > 0 OR SE21.E2_VRETCOF > 0 OR SE21.E2_VRETCSL  > 0 OR SE21.E2_INSS > 0 ) "
cQry += "   AND SE21.D_E_L_E_T_ = ' '   "
cQry += "   AND SA21.D_E_L_E_T_ = ' '   )"
cQry += "           GROUP BY A2_CGC,SubStr(SE2.E2_BAIXA,5,2) , E2_FILIAL , E2_PREFIXO , E2_NUM , E2_PARCELA , E2_TIPO , E2_FORNECE , E2_LOJA , A2_NOME "
cQry += " ORDER BY 14,8" 
MemoWrit("c:\"+cPerg+".Sql",cQry)

If TcSqlExec(cQry) < 0
	MsgInfo("Erro na seleção de Registros !!!")
	lContinua := .F.
	Return
Endif

If Select("TMP") > 0 ; TMP->(DbCloseArea()) ; Endif
DbUseArea(.T., "TOPCONN", TCGenQry(,,cQry), 'TMP', .F., .T.)
SE5->(dbSetOrder(7))

RptStatus({|| fProcessa()},"Aguarde , Atualizando Base de dados...")

Return

**********************************
Static FuncTion fProcessa()
**********************************

Local x := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
Local y := 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

LOCAL nInd:=3                       

DbSelectArea("TMP")
DbGoTop()
ProcRegua(RecCount())

While !Eof()
	IncProc()
	
    //cCodRet := fCodRet(cTpFornec)
	//cChave := fGravaRL(xFilial("SRL"),SM0->M0_CGC,cCodRet,cTpFornec,TMP->A2_CGC,TMP->MES)
	//fGravaDirf("A",cChave,cCodRet,TMP->E2BASE)
	  
		// Pula os títulos de baixados por cancelamento (can), dação (dac) e baixa nao financeiro (bnf)
	//////filtar motivo de baixa    
	nInd:=3   
	                                                         
	SE5->(dbSetOrder(7))
	If fVldBaixa(TMP->(E2_FILIAL+E2_PREFIXO+E2_NUM+E2_PARCELA+E2_TIPO+E2_FORNECE+E2_LOJA)) $ "DAC|CAN|BNF"      
       TMP->(DbSkip()) ; Loop
    EndIf   
   	cCodRet :=  fCodRet(cTpFornec)
  	If (nPos := Ascan(aContr, {|x| x[2] == TMP->A2_CGC} )) == 0 
     
  	    if Tmp->MES = '01'
	       Aadd(aContr, {tmp->A2_NOME,TMP->A2_CGC, cCodRet ,Tmp->E2BASE,0,0,0,0,0,0,0,0,0,0,0,Tmp->E2BASE, tmp->E2_FORNECE})      
	    Elseif Tmp->MES = '02'
	       Aadd(aContr, {tmp->A2_NOME,TMP->A2_CGC, cCodRet ,0,Tmp->E2BASE,0,0,0,0,0,0,0,0,0,0,Tmp->E2BASE, tmp->E2_FORNECE}) 
	    Elseif Tmp->MES = '03'
	       Aadd(aContr, {tmp->A2_NOME,TMP->A2_CGC, cCodRet ,0,0,Tmp->E2BASE,0,0,0,0,0,0,0,0,0,Tmp->E2BASE, tmp->E2_FORNECE})   
        Elseif Tmp->MES = '04'
	       Aadd(aContr, {tmp->A2_NOME,TMP->A2_CGC, cCodRet ,0,0,0,Tmp->E2BASE,0,0,0,0,0,0,0,0,Tmp->E2BASE, tmp->E2_FORNECE})   
        Elseif Tmp->MES = '05'
	       Aadd(aContr, {tmp->A2_NOME,TMP->A2_CGC, cCodRet ,0,0,0,0,Tmp->E2BASE,0,0,0,0,0,0,0,Tmp->E2BASE, tmp->E2_FORNECE})   
        Elseif Tmp->MES = '06'
	       Aadd(aContr, {tmp->A2_NOME,TMP->A2_CGC, cCodRet ,0,0,0,0,0,Tmp->E2BASE,0,0,0,0,0,0,Tmp->E2BASE, tmp->E2_FORNECE})   
        Elseif Tmp->MES = '07'
	       Aadd(aContr, {tmp->A2_NOME,TMP->A2_CGC, cCodRet ,0,0,0,0,0,0,Tmp->E2BASE,0,0,0,0,0,Tmp->E2BASE, tmp->E2_FORNECE})   
        Elseif Tmp->MES = '08'
	       Aadd(aContr, {tmp->A2_NOME,TMP->A2_CGC, cCodRet ,0,0,0,0,0,0,0,Tmp->E2BASE,0,0,0,0,Tmp->E2BASE, tmp->E2_FORNECE})   
        Elseif Tmp->MES = '09'
           Aadd(aContr, {tmp->A2_NOME,TMP->A2_CGC, cCodRet ,0,0,0,0,0,0,0,0,Tmp->E2BASE,0,0,0,Tmp->E2BASE, tmp->E2_FORNECE})   
	    Elseif Tmp->MES = '10'
	       Aadd(aContr, {tmp->A2_NOME,TMP->A2_CGC, cCodRet ,0,0,0,0,0,0,0,0,0,Tmp->E2BASE,0,0,Tmp->E2BASE, tmp->E2_FORNECE})      
        Elseif Tmp->MES = '11'
	       Aadd(aContr, {tmp->A2_NOME,TMP->A2_CGC, cCodRet ,0,0,0,0,0,0,0,0,0,0,Tmp->E2BASE,0,Tmp->E2BASE, tmp->E2_FORNECE})      
        Elseif Tmp->MES = '12'
	       Aadd(aContr, {tmp->A2_NOME,TMP->A2_CGC, cCodRet ,0,0,0,0,0,0,0,0,0,0,0,Tmp->E2BASE,Tmp->E2BASE, tmp->E2_FORNECE})        
	    EndIf 
	    nUltInd:= (aContr, {|x| x[2] == TMP->A2_CGC})          
    Else				              
        nInd += val(tmp->mes)
        aContr[nPos][nInd]  += Tmp->E2BASE 
    	aContr[nPos][16]    += Tmp->E2BASE
	Endif  
 TMP->(DbSkip())	
 enddo     
 DlgToExcel({{"ARRAY","","",aContr}}) 
 
 for x:=1 to len(aContr)                                   
     IncProc()
     if	aContr[x][16]  > 5999.99  
	    cCodRet :=  Iif (cTpFornec= "F" ,"0588", "1708" )
	     for y:=4 to 15                                                                              
	        If y = 4
	            xMes := "01"   
	        ElseIf y = 5
	            xMes := "02"   
	        ElseIf y = 6
	            xMes := "03"  
	        ElseIf y = 7
	            xMes := "04"  
	        ElseIf y = 8
	            xMes := "05"           
	        ElseIf y = 9
	            xMes := "06"                   
	        ElseIf y = 10
	            xMes := "07"  
	        ElseIf y = 11
	            xMes := "08"          
	        ElseIf y = 12
	            xMes := "09"         
	        ElseIf y = 13
	            xMes := "10"         
	        ElseIf y = 14
	            xMes := "11"          
	        ElseIf y = 15
	            xMes := "12"             
	        EndIf                   
	        if aContr[x][y]  > 0    
	           cChave  := fGravaRL(xFilial("SRL"),SM0->M0_CGC, cCodRet, cTpFornec,aContr[x][2] , xMes)
            
               fGravaDirf("A",cChave,cCodRet,aContr[x][y],aContr[x][2],xMes)    
            EndIf 
         next y    
	 EndIf
 next x
	
     

Return

********************************************************************************
Static FuncTion fGravaRL (xFil,xEmpresa,xCodret,xTipo,xCgc,xMes)
********************************************************************************
Local cRaMat := " "
Local lRet       := .T.
Local cChaveR4 := " "

DbSelectArea("SRL")
DbSetOrder(2)

If !SRL->(MsSeek(xFil+xEmpresa+xCodRet+Str(mv_Par03,1)+xCgc))
	
	DbSelectArea("SA2")
	DbSetOrder(3)
	If DbSeek(xFilial("SA2")+xCgc)
		
		Reclock("SRL", .T.)
		cRaMat := GetSxENum("SRL", "RL_MAT")
		
		SRL->RL_FILIAL  := xFilial("SRL")
		SRL->RL_MAT     := cRaMat
		SRL->RL_CODRET  := xCodRet
		SRL->RL_TIPOFJ  := Str(mv_Par03,1)
		SRL->RL_CPFCGC  := xCgc
		SRL->RL_BENEFIC := SubStr(SA2->A2_NOME,1,60)
		SRL->RL_ENDBENE := Alltrim(SA2->A2_END) + Alltrim(SA2->A2_NR_END)
		SRL->RL_UFBENEF := SA2->A2_EST
		SRL->RL_COMPLEM := SA2->A2_BAIRRO
		SRL->RL_CGCFONT := SM0->M0_CGC
		SRL->RL_NOMFONT := SM0->M0_NOMECOM
		
		If SRL->(FieldPos("RL_ORIGEM")) > 0
			SRL->RL_ORIGEM := "2"
		Endif
		
		MsUnlock()
	Endif
	
Endif

Return cChaveR4 := xFilial("SR4")+SRL->RL_MAT+xCgc+xCodRet+"2009"+xMes

************************************************************************
Static Function fGravaDirf(xTipoRen,cChave,xCodRet,xnValor, xCgc,xMes)
************************************************************************

DbSelectArea("SR4")
DbSetOrder(1)

If !SR4->( MsSeek( cChave + xTipoRen ))
	
	Reclock("SR4", .T.)
	
	SR4->R4_FILIAL       := xFilial("SR4")
	SR4->R4_MAT          := SRL->RL_MAT
	SR4->R4_CPFCGC       := xCgc
	SR4->R4_MES          := xMes
	SR4->R4_TIPOREN      := xTipoRen
	SR4->R4_CODRET       := xCodRet
	SR4->R4_ANO          := "2009"
	SR4->R4_VALOR        := xnValor
Else
	Reclock("SR4", .F.)
	SR4->R4_VALOR   += xnValor
Endif

MsUnlock()

Return

**************************
Static Function fCriaSx1()
**************************

Local z 	:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS
Local X1 	:= 0//Leonardo Portella - 07/11/14 - Virada TISS 3 - Compilacao TDS

SX1->(DbSetOrder(1))

If !SX1->(DbSeek(cPerg+aSx1[Len(aSx1),2]))
	SX1->(DbSeek(cPerg))
	While SX1->(!Eof()) .And. Alltrim(SX1->X1_GRUPO) == cPerg
		SX1->(Reclock("SX1",.F.,.F.))
		SX1->(DbDelete())
		SX1->(MsunLock())
		SX1->(DbSkip())
	End
	For X1:=2 To Len(aSX1)
		SX1->(RecLock("SX1",.T.))
		For Z:=1 To Len(aSX1[1])
			cCampo := "X1_"+aSX1[1,Z]
			SX1->(FieldPut(FieldPos(cCampo),aSx1[X1,Z] ))
		Next
		SX1->(MsunLock())
	Next
Endif

Return
***************************************************************
Static Function fVldBaixa(cChaveE5)
***************************************************************
local cMotBx:= " "	

    	If  SE5->( MsSeek(cChaveE5) )

		While ! SE5->(eof()) .and. SE5->(E5_FILIAL+E5_PREFIXO+E5_NUMERO+E5_PARCELA+E5_TIPO+E5_CLIFOR+E5_LOJA) == cChaveE5

             cMotBx:=SE5->E5_MOTBX	

	   		 SE5->(dbSkip())	
				
	   enddo	
	else
	  cMotBx:=" "
	EndIf     
return ( cMotBx ) 		

***********************************
Static Function fCodRet(xTipo)
**********************************
If xTipo == "J"
	cCodRet := "1708"
Else
	cCodRet := "0588"
Endif

Return cCodRet

